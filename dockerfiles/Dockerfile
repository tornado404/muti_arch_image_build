# zzc932/pytorch:1.9.1-py3.9-cuda11.1.1-ubuntu20.04
FROM zzc932/pytorch:1.9.1-py3.9-cuda11.1.1-ubuntu20.04
SHELL ["/bin/bash", "-c"]
RUN cd /tmp && \
    source /miniconda/etc/profile.d/conda.sh && \
    conda activate easymocap && \
    wget https://storage.googleapis.com/open3d-releases-master/python-wheels/open3d-0.17.0+a5be78c-cp39-cp39-manylinux_2_27_x86_64.whl  && \
    pip install open3d-0.17.0+a5be78c-cp39-cp39-manylinux_2_27_x86_64.whl && \
    pip install Flask==2.1.0

