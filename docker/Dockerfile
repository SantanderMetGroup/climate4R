FROM jupyter/base-notebook:latest

USER root

# Need to include libjvm.so into ld path
COPY java.conf /etc/ld.conf.d/java.conf
RUN apt update && apt install -y build-essential openjdk-8-jre openjdk-8-source unzip && \
    ln -s /bin/tar /bin/gtar && \
    ldconfig

USER $NB_USER

RUN conda install -y -c r -c conda-forge r-irkernel libnetcdf r-rjava r-git2r r-udunits2 r-devtools r-rgdal r-rgeos r-rcurl

RUN R CMD javareconf &&\
    R --vanilla -e 'install.packages("lattice", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("Matrix", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("glmnet", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("fields", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("evd", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("magrittr", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("knitr", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("raster", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("scales", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("vioplot", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("data.table", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("ncdf4", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("sp", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("MASS", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("SPEI", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("deepnet", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("gridGraphics", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("gridExtra", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("rmarkdown", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("akima", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("RcppEigen", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("RColorBrewer", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("mapplots", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("SpecsVerification", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("verification", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("padr", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("easyVerification", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("latticeExtra", repos = "http://cran.rediris.es/")' && \
    R --vanilla -e 'install.packages("abind ", repos = "https://cloud.r-project.org")' && \
# SantanderMetGroup
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.java")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.ECOMS")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/transformeR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/visualizeR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/convertR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/geoprocessoR")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.climdex")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.2nc")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/fireDanger")' && \
#   R --vanilla -e 'install.packages("class", repos = "http://cran.rediris.es/")' && \
#   R --vanilla -e 'install.packages("nmle", repos = "http://cran.rediris.es/")' && \
#   R --vanilla -e 'install.packages("spatstat", repos = "http://cran.rediris.es/")' && \
#   R --vanilla -e 'install.packages("rpart", repos = "http://cran.rediris.es/")'  && \
#   R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/mopa")' && \
    R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/drought4R")'

# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
COPY --chown=jovyan:users jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py 
