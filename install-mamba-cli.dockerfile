ARG TAG=latest
FROM install-conda:$TAG

RUN conda install -q -c conda-forge -y conda=23.3.1 python=3.9.12 mamba pip
