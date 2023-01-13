FROM paddleflow/ubuntu:latest
USER root
# python
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y python3.8
# failed to install libstdc++-static glibc-static mesa-libGL.x86_64
RUN apt-get update && apt-get install -y vim wget && cd /usr/local/src && wget https://go.dev/dl/go1.18.7.linux-amd64.tar.gz && tar -zxvf go1.18.7.linux-amd64.tar.gz -C /usr/local/ && python -m pip install --upgrade pip && python -m pip install pytest  pytest-html wheel six click setuptools urllib3
ENV GO111MODULE=on
ENV GOROOT=/usr/local/go
ENV GOPATH=/home/gopath
ENV GOBIN=/home/gopath/bin
ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on
ENV PATH=$PATH:$GOROOT/bin
ENV PATH=$GOPATH/bin/:$PATH
RUN mkdir -p /home/gopath
WORKDIR /paddleflow
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go version
RUN python -m pip install paddlepaddle==2.3.1
RUN python -m pip install matplotlib prettytable ujson opencv-python==4.4.0.46 pillow tqdm PyYAML scipy visualdl scikit-learn gast faiss-cpu