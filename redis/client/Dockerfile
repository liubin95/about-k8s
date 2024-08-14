# docker build -t redis-client:v1.0.0 client
FROM node:20.14.0

# settings  timezone
ENV TZ Asiza/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY . /app
WORKDIR /app
RUN corepack enable && yarn
CMD ["yarn", "start"]
