FROM ubuntu:18.04
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&apt-get install -y wget gcc automake autoconf libtool make git libffi-dev
RUN cd /usr/local/src && wget https://studygolang.com/dl/golang/go1.18.8.linux-amd64.tar.gz && tar -zxvf go1.18.8.linux-amd64.tar.gz -C /usr/local/  
ENV GOROOT=/usr/local/go
ENV GOPATH=/home/gopath
ENV GOBIN=/home/gopath/bin
ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on
ENV PATH=$PATH:$GOROOT/bin
ENV PATH=$GOPATH/bin/:$PATH
WORKDIR /paddleflow
ENV CGO_ENABLED=1
ENV GOOS=linux

wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar -xvf Python-3.7.3.tgz
cd Python-3.7.3
./configure --enable-loadable-sqlite-extensions
make
make install
