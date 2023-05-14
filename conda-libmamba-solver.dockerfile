FROM ubuntu:20.04

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

RUN time conda install -q -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda clean -afy

# Debug commands requested by the https://github.com/conda/conda-libmamba-solver/issues/new?assignees=&labels=type%3A%3Abug&projects=&template=0_bug.yml issue template
RUN conda info
RUN conda config --show-sources
RUN conda list --show-channel-urls

COPY environment.yml environment.yml
RUN time conda env update -q -v -n base
