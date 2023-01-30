FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&apt-get install -y wget gcc automake autoconf libtool make
RUN cd /usr/local/src && wget https://studygolang.com/dl/golang/go1.18.8.linux-amd64.tar.gz && tar -zxvf go1.18.8.linux-amd64.tar.gz -C /usr/local/  
ENV GOROOT=/usr/local/go
ENV GOPATH=/home/gopath
ENV GOBIN=/home/gopath/bin
ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on

