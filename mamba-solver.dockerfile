ARG TAG=latest
FROM install-conda:$TAG

RUN conda install -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda config --set channel_priority flexible  # https://github.com/rapidsai/cuml/issues/4016 \
 && conda clean -afy

ARG ENV_YML=environment.yml
ARG ENV=base
ENV ENV_YML=$ENV_YML ENV=$ENV
COPY $ENV_YML $ENV_YML

ENTRYPOINT [ "time", "conda", "env", "update", "-n", "$ENV", "-f", "$ENV_YML" ]
