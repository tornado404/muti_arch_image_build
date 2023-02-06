FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tini && ln /usr/bin/tini /sbin/tini
 
RUN apt-get update && apt-get install -y libfuse-dev fuse gcc automake autoconf libtool make 
RUN apt-get update && apt-get install -y tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


