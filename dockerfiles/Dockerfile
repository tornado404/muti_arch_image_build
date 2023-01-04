FROM ubuntu:latest
#RUN sed -i "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list && sed -i "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y libfuse-dev fuse  tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime