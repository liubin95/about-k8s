# 基础镜像
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 复制应用程序代码到工作目录
COPY . /app

# 安装 pipenv
RUN pip install pipenv

# 安装项目依赖
RUN pipenv install --system --deploy

# 运行应用程序
CMD ["python", "main.py"]
