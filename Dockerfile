FROM jupyter/base-notebook:latest

USER root
RUN apt-get update && apt-get install -y xorg git

USER $NB_USER
RUN conda install mamba -y -n base -c conda-forge && \
    conda create -n climate4R && \
    source /opt/conda/bin/activate climate4R && \
    mamba install -y -n climate4R -c conda-forge -c r -c defaults -c santandermetgroup \
                  r-climate4r=2.5.3 \
                  jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    R --vanilla -e 'IRkernel::installspec()'
