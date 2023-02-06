FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /tini

#RUN apt-get update && apt-get install -y tini && ln /usr/bin/tini /sbin/tini
 
RUN apt-get update && apt-get install -y libfuse-dev fuse gcc automake autoconf libtool make 
RUN apt-get update && apt-get install -y tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


