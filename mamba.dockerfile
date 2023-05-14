FROM nvidia/cuda:11.6.1-base-ubuntu20.04

ENV TZ=America/New_York DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y g++ time wget \
 && apt-get clean

ENV d=/opt/conda
ENV PATH="$d/bin:$PATH"
RUN wget -q "https://repo.anaconda.com/miniconda/Miniconda3-py39_23.3.1-0-Linux-x86_64.sh" -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p "$d" \
 && rm ~/miniconda.sh \
 && ln -s "$d/etc/profile.d/conda.sh" /etc/profile.d/conda.sh \
 && echo ". $d/etc/profile.d/conda.sh" >> ~/.bashrc \
 && echo "conda activate base" >> ~/.bashrc

RUN time conda install -q -y -n base -c conda-forge conda==23.3.1 python==3.9.12 mamba \
 && conda clean -afy

COPY environment.yml environment.yml
RUN time mamba env update -q -v -n base
