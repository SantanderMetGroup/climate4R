FROM jupyter/base-notebook:latest

USER root
RUN apt-get update && apt-get install -y xorg git

USER $NB_USER
RUN conda install mamba -y -n base -c conda-forge && \
    mamba install -y -c conda-forge -c r -c defaults -c santandermetgroup \
                  r-climate4r=2.5.3 \
                  xarray pandas matplotlib cartopy netcdf4 cftime dask iris \
                  jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    chown -R jovyan:users /home/jovyan && \
    R --vanilla -e 'IRkernel::installspec()'
