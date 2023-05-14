FROM continuumio/miniconda3:23.3.1-0

RUN apt-get update \
 && apt-get install -y time \
 && apt-get clean

RUN conda install -q -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda clean -afy

COPY environment.yml environment.yml
ARG ENV=my-env
ENV ENV=$ENV
RUN time conda env update -q -v -n $ENV
