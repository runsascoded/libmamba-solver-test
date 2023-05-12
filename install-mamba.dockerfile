ARG TAG=latest
FROM install-conda:$TAG

ARG CONDA=4.12.0
ARG PYTHON=3.9.13
ARG MAMBA=0.24.0
RUN "$conda" install -c conda-forge -y "conda=${CONDA}" "python=${PYTHON}" "mamba=${MAMBA}" pip

ARG ENV_YML=environment.yml
ARG ENV=base
ENV ENV_YML=$ENV_YML ENV=$ENV
COPY $ENV_YML $ENV_YML

RUN time mamba env update -n $ENV -f $ENV_YML \
 && mamba clean -afy
