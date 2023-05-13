ARG CUDA_VERSION_FULL=11.6.1
FROM nvidia/cuda:$CUDA_VERSION_FULL-base-ubuntu20.04

ENV TZ=America/New_York DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y g++ wget \
 && apt-get clean

WORKDIR ..

ENV d=/opt/conda
ENV PATH="$d/bin:$PATH"
ARG CONDA=23.3.1-0
RUN wget -q "https://repo.anaconda.com/miniconda/Miniconda3-py39_${CONDA}-Linux-x86_64.sh" -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p "$d" \
 && rm ~/miniconda.sh \
 && ln -s "$d/etc/profile.d/conda.sh" /etc/profile.d/conda.sh \
 && echo ". $d/etc/profile.d/conda.sh" >> ~/.bashrc \
 && echo "conda activate base" >> ~/.bashrc
