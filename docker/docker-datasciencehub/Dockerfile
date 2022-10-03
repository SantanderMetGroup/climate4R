FROM jupyterhub/singleuser

ARG PY=base
ARG R=r
ARG C4R=climate4r

USER root

RUN apt-get update && \
    apt-get install -y xorg gcc g++ perl python3 python3.10 automake make \
                       wget git curl libdb-dev \
                       zlib1g-dev bzip2 libncurses5-dev \
                       texlive-latex-base \
                       default-jre \
                       python3-dev \
                       gfortran \
                       libpng-dev libpng16-16 \
                       build-essential libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev \
                       libblas-dev gfortran git unzip ftp libzmq3-dev nano ftp fort77 \
                       libcurl4 libcurl4-openssl-dev libx11-dev libxt-dev libxslt-dev \
                       x11-common libcairo2-dev libpng-dev libreadline6-dev libjpeg8-dev pkg-config \
                       libnetcdf-dev libnetcdff-dev \
                       software-properties-common python3-setuptools python3-numpy python3-pymysql && \
    apt-get clean


USER $NB_USER

# python, base environment
RUN conda install mamba -y -n base -c conda-forge && \
    source /opt/conda/bin/activate base && \
    CONDA_OVERRIDE_CUDA=11.2 mamba install -y -n base -c conda-forge -c r -c defaults \
        xarray h5py netCDF4 pandas matplotlib zarr s3fs keras beautifulsoup4 cdo nco pip \
        # this tensorflow is for the climate4R + tensorflow environment
        # installed here due to reticulate looking for python in the default env
        tensorflow \
        jupyter_contrib_nbextensions jupyter_nbextensions_configurator

# R
RUN conda create -n $R && \
    source /opt/conda/bin/activate $R && \
    mamba install -y -n $R -c conda-forge -c r -c bioconda -c defaults \
        jupyter_contrib_nbextensions jupyter_nbextensions_configurator \
        r-irkernel 'r-base<4' \
        r-ggplot2 r-gridextra r-magrittr r-rcolorbrewer r-mclust \
        r-cluster r-kohonen r-gridExtra r-arules r-sp r-ncdf4 r-mclust r-caret && \
    R --vanilla -e 'IRkernel::installspec(name = "ir", displayname = "R")'

# climate4R
RUN conda create -n $C4R && \
    source /opt/conda/bin/activate $C4R && \
    mamba install -y -n $C4R -c conda-forge -c r -c defaults -c santandermetgroup \
                  python=3.7.11 r-climate4r=2.5.3 \
                  r-sf r-rgeos r-rgdal r-systemfonts r-terra r-lwgeom r-svglite r-satellite r-zip r-mapview r-dplyr r-shiny r-leafpop \
                  nco cdo \
                  jupyter_contrib_nbextensions jupyter_nbextensions_configurator r-irkernel && \
    R --vanilla -e 'install.packages("oceanis", repos="http://cran.us.r-project.org")' && \
    R --vanilla -e 'IRkernel::installspec(name = "climate4r", displayname = "climate4R")'

# climate4R + tensorflow
COPY c4r-tf.yml c4r-tf.yml
RUN mamba env create -n climate4tf --file c4r-tf.yml && \
    source /opt/conda/bin/activate climate4tf && \
    R --vanilla -e 'IRkernel::installspec(name = "climate4tf", displayname = "climate4R (deep)")'
