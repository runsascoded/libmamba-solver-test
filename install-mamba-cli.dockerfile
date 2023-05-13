ARG TAG=latest
FROM install-conda:$TAG

ARG CONDA=23.3.1
ARG PYTHON=3.9.12
RUN conda install -q -c conda-forge -y "conda=${CONDA}" "python=${PYTHON}" mamba pip
