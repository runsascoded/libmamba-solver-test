ARG TAG=latest
FROM install-conda:$TAG

RUN conda install -q -y -c conda-forge conda=23.3.1 python=3.9.12 pip mamba \
 && conda clean -afy
