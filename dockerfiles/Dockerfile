FROM ubuntu:18.04
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&apt-get install -y wget gcc automake autoconf libtool make git
RUN cd /usr/local/src && wget https://studygolang.com/dl/golang/go1.18.8.linux-amd64.tar.gz && tar -zxvf go1.18.8.linux-amd64.tar.gz -C /usr/local/  
ENV GOROOT=/usr/local/go
ENV GOPATH=/home/gopath
ENV GOBIN=/home/gopath/bin
ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on
ENV PATH=$PATH:$GOROOT/bin
ENV PATH=$GOPATH/bin/:$PATH
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
WORKDIR /paddleflow
ENV CGO_ENABLED=1
ENV GOOS=linux
RUN apt-get update && apt-get install -y software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.8 python3-distutils python3-pip python3-apt
RUN ln -s /usr/bin/python3.8 /usr/bin/python
