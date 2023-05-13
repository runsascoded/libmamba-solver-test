ARG TAG=latest
FROM install-conda:$TAG

ARG CONDA=23.3.1
ARG PYTHON=3.9.12
RUN conda install -y -n base -c conda-forge -y "conda=${CONDA}" "python=${PYTHON}" pip conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda config --set channel_priority flexible  # https://github.com/rapidsai/cuml/issues/4016 \
 && conda clean -afy
