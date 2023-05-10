FROM mysql:8.0.28

HEALTHCHECK CMD mysqladmin ping -h localhost -p$MYSQL_ROOT_PASSWORD | grep alive || exit 1

# settings timezone
ENV TZ Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 3306

# copy init sql
COPY script/init-database.sql /docker-entrypoint-initdb.d/1.sql
COPY script/init-table.sql /docker-entrypoint-initdb.d/2.sql
COPY script/init-table-data.sql /docker-entrypoint-initdb.d/3.sql
