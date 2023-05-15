#!/usr/bin/python
# -*- coding: UTF-8 -*-

import json
import os
import random
import time

import pymysql
import requests as requests

with open("data.json", mode='r', encoding="utf-8") as file:
    data = json.loads(file.read())
with open("title.json", mode='r', encoding="utf-8") as file:
    title_list = json.loads(file.read())
famous = data["famous"]  # a 代表前面垫话，b代表后面垫话
before = data["before"]  # 在名人名言前面弄点废话
after = data['after']  # 在名人名言后面弄点废话
bosh = data['bosh']  # 代表文章主要废话来源

repeatability = 2


def shuffle_traversal(list_a):
    global repeatability
    pool = list(list_a) * repeatability
    while True:
        random.shuffle(pool)
        for item in pool:
            yield item


next_bosh = shuffle_traversal(bosh)
next_famous = shuffle_traversal(famous)


def get_famous():
    global next_famous
    xx = next(next_famous)
    xx = xx.replace("a", random.choice(before))
    xx = xx.replace("b", random.choice(after))
    return xx


def next_part():
    return ". \r\n    "


def write_article(title):
    res = ''
    for x in title:
        tmp = str()
        while len(tmp) < 6000:
            random_int = random.randint(0, 100)
            if random_int < 5:
                tmp += next_part()
            elif random_int < 20:
                tmp += get_famous()
            else:
                tmp += next(next_bosh)
        tmp = tmp.replace("x", title)
        res = res + tmp
    return res


if __name__ == "__main__":
    db = pymysql.connect(host=os.environ.get('MYSQL_HOST'),
                         user="big_three",
                         port=3306,
                         password="big_three",
                         database="big_three")
    cursor = db.cursor()
    id_article = time.time()
    for title in title_list:
        article = write_article(title)
        cursor.execute(f"""
        INSERT INTO big_three.article_info
        (id, title, author_id, release_time, type_id, visit_num, comment_num, pay_kiss, cream, stick, is_done, markdown_content, html_content, state, create_time, create_user, update_time, update_user)
        VALUES
        (%s, %s, 1, %s, %s, %s, 0, 0, 0, 0, 1, %s, %s, 0, %s, 1, NULL, NULL);
        """, (
            id_article,
            title,
            time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
            random.randint(1, 4),
            random.randint(50, 400),
            article,
            article,
            time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        ))
        print(cursor._last_executed)
        id_article = id_article + 1
        if os.environ.get('ES_HOST'):
            res = requests.post(f"http://{os.environ.get('ES_HOST')}:9200/article-search/_doc", json={
                "id": id_article,
                "title": title,
                "htmlContent": article
            })
            print(res)
    db.commit()
    db.close()
