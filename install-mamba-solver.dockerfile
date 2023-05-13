ARG TAG=latest
FROM install-conda:$TAG

RUN conda install -q -y -n base -c conda-forge conda=23.3.1 python=3.9.12 pip conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda config --set channel_priority flexible  # https://github.com/rapidsai/cuml/issues/4016 \
 && conda clean -afy
