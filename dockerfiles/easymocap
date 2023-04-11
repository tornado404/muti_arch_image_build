# zzc932/pytorch:1.13.0-py3.9.12-cuda11.7.1-ubuntu20.04-easymocap
#base nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
FROM zzc932/pytorch:1.13.0-py3.9.12-cuda11.7.1-ubuntu20.04-easymocap
# export http_proxy=http://127.0.0.1:8000
# export https_proxy=http://127.0.0.1:8000
RUN rm -f /etc/apt/sources.list.d/cuda.list && \
    apt-get update && \
    apt-get install -y libprotobuf-dev protobuf-compiler libgoogle-glog-dev libopencv-dev libboost-all-dev libhdf5-dev libatlas-base-dev python3-opencv cmake
# openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git --depth 1 && \
    cd openpose && \
    git submodule update --init --recursive --remote && \
    mkdir build && \
    cd build && \
    cmake .. -DBUILD_PYTHON=true && \
    make -j8
# Yolov4+HRNet
RUN cd .. && \
    mkdir -p data/models && \
    wget -c https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights && \
    mv yolov4.weights data/models
