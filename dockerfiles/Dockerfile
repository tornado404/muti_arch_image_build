FROM cnstark/pytorch:1.13.0-py3.9.12-cuda11.7.1-ubuntu20.04
# gcc & g++ ≥ 5.4 are required. ninja 
RUN pip install ninja
RUN cd /tmp && apt-get install -y git && git clone https://github.com/facebookresearch/detectron2.git && python -m pip install -e detectron2
