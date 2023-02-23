FROM jupyter/base-notebook:latest

ARG ENVNAME=climate4r

USER root
RUN apt-get update && apt-get install -y xorg git wget && \
    mkdir -p /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608 /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS && \
    chown -R $NB_USER:users /gpfs /home/$NB_USER/shared && \
    ln -s /home/$NB_USER/shared /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608/HUB && \
    ln -s /home/$NB_USER/shared /gpfs/projects/meteo/IPCC/ATLAS/hub

USER $NB_USER
RUN conda install mamba -y -n base -c conda-forge && \
    mamba install -y -n base xarray pandas matplotlib cartopy netcdf4 cftime dask iris zarr s3fs h5py gcsfs \
    nco cdo jupyter_contrib_nbextensions jupyter_nbextensions_configurator jupyter beautifulsoup4 \
    # this tensorflow is for the climate4R + tensorflow environment
    # installed here due to reticulate looking for python in the default env
    tensorflow keras

# generic environment for climate4R
# r-climate4r requires python=3.7.11
RUN conda create -n $ENVNAME && \
    source /opt/conda/bin/activate $ENVNAME && \
    mamba install -y -n $ENVNAME -c conda-forge -c r -c defaults -c santandermetgroup \
        python=3.7.11 r-climate4r=2.5.3 \
        r-sf r-rgeos r-rgdal r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop \
        nco cdo \
        jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    R --vanilla -e 'IRkernel::installspec(name = "climate4r", displayname = "climate4R")'

# create conda env for FAO due to custom packages
# oceanis for FAO users requires: r-sf r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop
RUN conda create -n fao && \
    source /opt/conda/bin/activate fao && \
    mamba install -y -c conda-forge -c r -c defaults -c santandermetgroup \
        nco cdo jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel r-devtools \
        r-downscaleR r-abind r-loadeR r-transformeR r-geoprocessoR r-raster \
        r-leaflet r-htmltools r-furrr r-tidyverse r-sp r-png r-gridExtra \
        r-climate4R.indices r-rnaturalearth r-rnaturalearthdata r-leafsync \
        r-parallelly r-dtplyr r-mapview r-patchwork r-RColorBrewer r-glue \
        r-sf r-rgeos r-rgdal r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop \
        r-plotly r-broom r-loadeR.2nc r-ggnewscale r-shiny && \
    R --vanilla -e 'install.packages("leaflegend", repos="http://cran.us.r-project.org")' && \
    R --vanilla -e 'install.packages("oceanis", repos="http://cran.us.r-project.org")' && \
    R --vanilla -e 'library(devtools); devtools::install_github("ropensci/rnaturalearthhires")' && \
    R --vanilla -e 'IRkernel::installspec(name = "fao", displayname = "FAO")'

# climate4R + tensorflow for deep learning
COPY c4r-tf.yml c4r-tf.yml
RUN mamba env create -n climate4tf --file c4r-tf.yml && \
    source /opt/conda/bin/activate climate4tf && \
    R --vanilla -e 'IRkernel::installspec(name = "climate4tf", displayname = "climate4R (deep)")'
