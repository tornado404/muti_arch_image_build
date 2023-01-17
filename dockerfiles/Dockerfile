FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
#RUN sed -i "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list && sed -i "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y libfuse-dev fuse gcc automake autoconf libtool make tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime