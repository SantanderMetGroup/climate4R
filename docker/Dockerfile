FROM jupyter/base-notebook:latest

USER root
RUN apt-get update && apt-get install -y xorg git && \
    mkdir -p /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608 /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS && \
    chown -R $NB_USER:users /gpfs /home/$NB_USER/shared && \
    ln -s /home/$NB_USER/shared /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608/HUB && \
    ln -s /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS/hub

USER $NB_USER
RUN conda install mamba -y -n base -c conda-forge && \
    mamba install -y -c santandermetgroup -c conda-forge -c r -c defaults \
                  climate4r=1.5.0 \
                  xarray pandas matplotlib cartopy netcdf4 cftime dask iris \
                  jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    chown -R jovyan:users /home/jovyan && \
    R --vanilla -e 'IRkernel::installspec()'
