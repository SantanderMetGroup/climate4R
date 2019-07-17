FROM jupyter/base-notebook:latest

ENV TAR /bin/tar

USER root

RUN apt update && apt install -y gcc && \
# Install required software using conda available in image
conda install -y r-rjava r-devtools r-rgeos r-udunits2 r-irkernel r-rgdal libgdal pkg-config && \
# R packages
R CMD javareconf && \
R --vanilla -e 'install.packages("Matrix", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("glmnet", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("fields", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("evd", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("magrittr", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("knitr", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("raster", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("scales", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("vioplot", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("data.table", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("ncdf4", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("sp", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("MASS", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("SPEI", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("deepnet", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("gridGraphics", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("gridExtra", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("rmarkdown", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("akima", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("RcppEigen", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("RColorBrewer", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("mapplots", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("SpecsVerification", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("verification", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("padr", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("easyVerification", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("latticeExtra", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("abind ", repos = "https://cloud.r-project.org")'  && \
R --vanilla -e 'install.packages("class", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("nmle", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("spatstat", repos = "http://cran.rediris.es/")'  && \
R --vanilla -e 'install.packages("rpart", repos = "http://cran.rediris.es/")'   && \
R --vanilla -e 'library(devtools);install_version("gridGraphics", version = "0.3-0", repos = "http://cran.us.r-project.org")' && \
R --vanilla -e 'library(devtools);install_version("tree", version = "1.0-39", repos = "http://cran.us.r-project.org")' && \
# SantanderMetGroup
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.java")' && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR@v1.4.14")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.ECOMS")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/transformeR@v1.5.1")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR@v3.1.0")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/visualizeR@v1.4.0")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/convertR")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/geoprocessoR@v0.1.0")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.climdex@v0.2.1")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.indices@v0.0.1")' && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.2nc")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/fireDanger")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/VALUE@v2.1.1")' && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.value@v0.0.1")'  && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/mopa")' && \
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/drought4R")'

USER $NB_USER
