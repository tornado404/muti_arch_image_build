# zzc932/pytorch:1.9.1-py3.9-cuda11.1.1-ubuntu20.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
SHELL ["/bin/bash", "-c"]
# 安装基础包
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai apt-get -y install tzdata && \
    apt install -y \
        build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev ffmpeg   \
        libprotobuf-dev protobuf-compiler libgoogle-glog-dev libopencv-dev \
        libboost-all-dev libhdf5-dev libatlas-base-dev python3-opencv cmake \
        git wget curl zip unzip vim lrzsz tar sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh && \
    bash Miniconda3-py39_23.1.0-1-Linux-x86_64.sh -b -p /miniconda && \
    rm -f Miniconda3-py39_23.1.0-1-Linux-x86_64.sh && \
    echo 'export PATH="/miniconda/bin:$PATH"'  >> ~/.bashrc && \
    source ~/.bashrc && \
    /miniconda/bin/conda init bash && \
    /miniconda/bin/conda create -n easymocap python=3.9 -y && \
    echo "conda activate easymocap" >> ~/.bashrc

ENV PATH /miniconda/bin:$PATH
WORKDIR /temp

# 下载python
#pip3 install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
# easyMocap
RUN git clone https://github.com/zju3dv/EasyMocap.git && \
    source /miniconda/etc/profile.d/conda.sh && \
    conda activate easymocap && \
    wget -c https://download.pytorch.org/whl/cu111/torch-1.9.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    wget -c https://download.pytorch.org/whl/cu111/torchvision-0.10.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    python -m pip install ./torch-1.9.1+cu111-cp39-cp39-linux_x86_64.whl && \
    python -m pip install ./torchvision-0.10.1+cu111-cp39-cp39-linux_x86_64.whl && \
    cd EasyMocap && python -m pip install -r requirements.txt && \
    python -m pip install pyrender ffmpeg mediapipe jupyter ninja && \
    python setup.py develop && \
    pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu111/torch1.9/index.html
#or git clone https://github.com/facebookresearch/detectron2.git && \
#python -m pip install -e detectron2 jupyter

# openpose
#RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git --depth 1 && \
#    cd openpose && \
#    git submodule update --init --recursive --remote && \
#    mkdir build && \
#    cd build && \
#    cmake .. -DBUILD_PYTHON=true && \
#    make -j8
# Yolov4+HRNet
#RUN cd .. && \
#    mkdir -p data/models && \
#    wget -c https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights && \
#    mv yolov4.weights data/models

WORKDIR /workspace
# export http_proxy=http://127.0.0.1:8000
# export https_proxy=http://127.0.0.1:8000
