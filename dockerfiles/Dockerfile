# zzc932/pytorch:1.9.1-py3.9-cuda11.1.1-ubuntu20.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
SHELL ["/bin/bash", "-c"]
# 安装基础包
WORKDIR /temp
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
    echo "conda activate easymocap" >> ~/.bashrc && \
    git clone https://github.com/zju3dv/EasyMocap.git && \
    source /miniconda/etc/profile.d/conda.sh && \
    conda activate easymocap && \
    wget -c https://download.pytorch.org/whl/cu111/torch-1.9.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    wget -c https://download.pytorch.org/whl/cu111/torchvision-0.10.1%2Bcu111-cp39-cp39-linux_x86_64.whl && \
    python -m pip install ./torch-1.9.1+cu111-cp39-cp39-linux_x86_64.whl && \
    python -m pip install ./torchvision-0.10.1+cu111-cp39-cp39-linux_x86_64.whl && \
    rm -f ./torch*.whl && \
    cd EasyMocap && python -m pip install -r requirements.txt && \
    python -m pip install pyrender ffmpeg mediapipe jupyter ninja scikit-image networks open3d==0.14.1 Flask==2.1.0 numpy==1.23.3  && \
    python setup.py develop && \
    pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu111/torch1.9/index.html && \
    git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git --depth 1 && \
    cd openpose && \
    git submodule update --init --recursive --remote && \
    mkdir build && \
    cd build && \
    cmake .. -DBUILD_PYTHON=true && \
    make -j8 && \
    cd .. && \
    mkdir -p data/models && \
    wget -c https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights && \
    mv yolov4.weights data/models


#    conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
#    conda install -c bottler nvidiacub && \
#    conda install pytorch3d -c pytorch3d && \
#    conda install -c conda-forge ninja && \
#    git clone https://github.com/facebookresearch/pytorch3d.git --depth=1 && \
#    cd pytorch3d && pip install -e .

ENV PATH /miniconda/bin:$PATH

WORKDIR /workspace
# export http_proxy=http://127.0.0.1:8000
# export https_proxy=http://127.0.0.1:8000
