FROM ubuntu:20.04

RUN apt-get update \
 && apt-get install -y g++ time wget \
 && apt-get clean

# Install Conda
ENV CONDA_HOME=/opt/conda
ENV PATH="$CONDA_HOME/bin:$PATH"
RUN wget -q "https://repo.anaconda.com/miniconda/Miniconda3-py39_23.3.1-0-Linux-x86_64.sh" -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p "$CONDA_HOME" \
 && rm ~/miniconda.sh \
 && echo ". $CONDA_HOME/etc/profile.d/conda.sh" >> ~/.bashrc

# Install+Configure conda-libmamba-solver
RUN time conda install -q -y -n base conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda clean -afy

ARG ENV_YML=environment.yml
ENV ENV_YML=$ENV_YML
COPY $ENV_YML $ENV_YML
RUN conda env create -n my-env -f $ENV_YML \
 && conda clean -afy \
 && echo "conda activate my-env" >> ~/.bashrc

SHELL ["conda", "run", "-n", "my-env", "/bin/bash", "-c"]
# Computed by running `env` before and after a `conda activate my-env`
ENV CONDA_PREFIX=$CONDA_HOME/envs/my-env CONDA_PROMPT_MODIFIER=(my-env) CONDA_SHLVL=2 CONDA_DEFAULT_ENV=my-env PATH=$CONDA_HOME/envs/my-env/bin:$PATH CONDA_PREFIX_1=$CONDA_HOME

RUN pip install plotly  # test that the correct `pip` gets picked up

ENTRYPOINT [ "python" ]
CMD [ "-c", "import sys; print(sys.executable); import plotly; print(plotly)" ]
