FROM continuumio/miniconda3:23.3.1-0

RUN apt-get update \
 && apt-get install -y g++ time wget \
 && apt-get clean

RUN conda install -q -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda clean -afy

COPY environment.yml environment.yml
RUN time conda env update -q -v -n my-env

SHELL ["conda", "run", "-n", "my-env", "/bin/bash", "-c"]
RUN conda env list
RUN pip install plotly
