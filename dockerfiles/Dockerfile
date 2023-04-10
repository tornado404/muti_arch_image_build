# zzc932/pytorch:1.13.0-py3.9.12-cuda11.7.1-ubuntu20.04-easymocap
#FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
FROM zzc932/pytorch:1.13.0-py3.9.12-cuda11.7.1-ubuntu20.04-dev
 
 
RUN wget https://mirrors.bfsu.edu.cn/anaconda/archive/Anaconda3-2022.10-Linux-x86_64.sh --no-check-certificate && \
    bash Anaconda3-2022.10-Linux-x86_64.sh -b -p /conda
ENV PATH=/conda/bin:$PATH

RUN conda create -n easymocap python=3.9 -y

RUN conda install -y ffmpeg && \
    python -m pip install  ipdb joblib tqdm opencv-python yacs tabulate termcolor chumpy mediapipe func_timeout pyrender
