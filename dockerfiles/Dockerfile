# zzc932/pytorch:1.9.1-py3.9-cuda11.1.1-ubuntu20.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

RUN apt update && \
    apt install -y \
        build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev ffmpeg   \
        libprotobuf-dev protobuf-compiler libgoogle-glog-dev libopencv-dev \
        libboost-all-dev libhdf5-dev libatlas-base-dev python3-opencv cmake \
        git wget curl zip unzip vim lrzsz tar sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh && bash Miniconda3-py39_23.1.0-1-Linux-x86_64.sh


WORKDIR /temp

RUN wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz && \
    tar -xvf Python-3.9.10.tgz && \
    cd Python-3.9.10 && \
    ./configure --enable-optimizations && \
    make && \
    make install && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3 /usr/local/bin/pip && \
    pip3 install ffmpeg mediapipe jupyter ninja && \
    rm -r /root/.cache/pip

RUN git clone https://github.com/zju3dv/EasyMocap.git && \
    conda create -n easymocap python=3.9 -y && \
    conda activate easymocap && \
    wget -c https://download.pytorch.org/whl/cu111/torch-1.9.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    wget -c https://download.pytorch.org/whl/cu111/torchvision-0.10.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    python3 -m pip install ./torch-1.9.1+cu111-cp39-cp39-linux_x86_64.whl && \
    python3 -m pip install ./torchvision-0.10.1+cu111-cp39-cp39-linux_x86_64.whl && \
    python -m pip install -r requirements.txt && \
    python3 -m pip install pyrender && \
    python setup.py develop

RUN cd /tmp && \
python -m pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu111/torch1.9/index.html

WORKDIR /workspace
