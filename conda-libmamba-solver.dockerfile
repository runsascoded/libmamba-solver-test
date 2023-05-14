FROM continuumio/miniconda3:23.3.1-0

RUN apt-get update \
 && apt-get install -y time \
 && apt-get clean

RUN conda install -q -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda clean -afy

COPY environment.yml environment.yml
RUN time conda env update -q -v -n my-env

SHELL ["conda", "run", "-n", "my-env", "/bin/bash", "-c"]
ENV CONDA_PREFIX=/opt/conda/envs/my-env CONDA_PROMPT_MODIFIER=(my-env) CONDA_SHLVL=2 CONDA_DEFAULT_ENV=my-env PATH=/opt/conda/envs/my-env/bin:$PATH CONDA_PREFIX_1=/opt/conda

RUN conda env list
RUN pip install plotly

RUN python -c "import plotly; print(plotly)"
