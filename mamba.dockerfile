FROM continuumio/miniconda3:23.3.1-0

RUN apt-get update \
 && apt-get install -y time \
 && apt-get clean

RUN conda install -q -y -n base -c conda-forge mamba \
 && conda clean -afy

COPY environment.yml environment.yml
ARG ENV=my-env
ENV ENV=$ENV
RUN time mamba env update -q -v -n $ENV

SHELL ["conda", "run", "-n", "$ENV", "/bin/bash", "-c"]
# Computed by running `env` before and after a `conda activate $ENV`
ENV CONDA_PREFIX=/opt/conda/envs/$ENV CONDA_PROMPT_MODIFIER=($ENV) CONDA_SHLVL=2 CONDA_DEFAULT_ENV=$ENV PATH=/opt/conda/envs/$ENV/bin:$PATH CONDA_PREFIX_1=/opt/conda
