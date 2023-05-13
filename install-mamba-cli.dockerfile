FROM continuumio/miniconda3:23.3.1-0

RUN conda install -q -y -c conda-forge conda=23.3.1 python=3.9.12 pip mamba \
 && conda clean -afy
