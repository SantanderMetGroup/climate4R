FROM jupyter/base-notebook:latest

ARG ENVNAME=climate4r

USER root
RUN apt-get update && apt-get install -y xorg git wget && \
    mkdir -p /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608 /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS && \
    chown -R $NB_USER:users /gpfs /home/$NB_USER/shared && \
    ln -s /home/$NB_USER/shared /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608/HUB && \
    ln -s /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS/hub

# create custom conda env: r-climate4r requires python=3.7.11
# oceanis for FAO users requires: r-sf r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop
USER $NB_USER
RUN conda install mamba -y -n base -c conda-forge && \
    conda create -n $ENVNAME && \
    source /opt/conda/bin/activate $ENVNAME && \
    mamba install -y -n $ENVNAME -c conda-forge -c r -c defaults -c santandermetgroup \
                  python=3.7.11 r-climate4r=2.5.3 \
                  r-sf r-rgeos r-rgdal r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop \
                  nco cdo \
                  jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    R --vanilla -e 'install.packages("oceanis", repos="http://cran.us.r-project.org")' && \
    R --vanilla -e 'IRkernel::installspec()' && \
    conda activate base && \
    mamba install -y -n base xarray pandas matplotlib cartopy netcdf4 cftime dask iris zarr s3fs h5py nco cdo jupyter_contrib_nbextensions jupyter_nbextensions_configurator
