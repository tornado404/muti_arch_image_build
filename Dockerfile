FROM ubuntu:latest
RUN apt-get update && apt-get install -y libfuse-dev fuse gcc automake autoconf libtool make tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
