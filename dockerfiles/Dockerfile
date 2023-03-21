FROM chrissx/llvm:latest                                                            

RUN apt-get update && apt-get install -y --no-install-recommends \
        ocl-icd-libopencl1 \
        clinfo  
        
# https://gitlab.com/nvidia/container-images/opencl/-/blob/ubuntu18.04/runtime/Dockerfile

# RUN apt-get update && apt-get install -y --no-install-recommends \
#        ocl-icd-opencl-dev && \
#    rm -rf /var/lib/apt/lists/*

#         nvidia-opencl-dev


RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
                                                                              
ENV TZ=Asia/Shanghai                                                          
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

      
RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        git \
        wget \
        cmake \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-numpy \
        python3-scipy \
        python3-imageio \
        python3-pybind11 \
        doxygen \
        ninja-build \
        ca-certificates    
        
        
RUN apt-get update && apt-get install -y --no-install-recommends \
        clang-tools-10 \
        lld-10 \
        llvm-10-dev \
        libclang-10-dev \
        liblld-10-dev \
        libpng-dev \
        libjpeg-dev \
        libgl-dev \
        libopenblas-dev \
        libeigen3-dev \
        libatlas-base-dev
          
RUN rm -rf /var/lib/apt/lists/* && ln -s /usr/bin/python3 /usr/bin/python 

RUN pip3 install --upgrade cmake pip jupyter

WORKDIR /workspace
RUN git clone --branch v10.0.0 https://github.com/halide/Halide.git && \
    cd Halide && \
    mkdir halide-build && \
    cd halide-build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10/cmake .. && \
    make -j$(nproc) install
RUN git clone --branch tengine-lite https://github.com/OAID/Tengine.git && \
    cd Tengine && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install -j$(nproc)
ENV PYTHONPATH "${PYTHONPATH}:/workspace/Halide/halide-build/python_bindings/src"
ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:/usr/local/lib:/workspace/Tengine/build/install/lib"
