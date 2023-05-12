ARG CUDA_VERSION_FULL=11.6.1
FROM nvidia/cuda:$CUDA_VERSION_FULL-base-ubuntu20.04

ENV TZ=America/New_York DEBIAN_FRONTEND=noninteractive

ARG CUDA_VERSION_MINOR=11.6
ARG CUDA_VERSION_FULL=11.6.1
ENV CUDA_VERSION_MINOR=$CUDA_VERSION_MINOR CUDA_VERSION_FULL=$CUDA_VERSION_FULL

ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-$CUDA_VERSION_MINOR/compat"

RUN apt-get update \
 && apt-get install -y \
    g++ \
    libgl-dev \
    libglib2.0-0 \
    unzip \
    wget \
 && apt-get clean

WORKDIR ..

ENV d=/opt/conda
ENV conda="$d/bin/conda"
ARG CONDA_VERSION
RUN wget -q "https://repo.anaconda.com/miniconda/Miniconda3-py39_${CONDA_VERSION}-Linux-x86_64.sh" -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p "$d" \
 && rm ~/miniconda.sh \
 && ln -s "$d/etc/profile.d/conda.sh" /etc/profile.d/conda.sh \
 && echo ". $d/etc/profile.d/conda.sh" >> ~/.bashrc \
 && echo "conda activate base" >> ~/.bashrc
