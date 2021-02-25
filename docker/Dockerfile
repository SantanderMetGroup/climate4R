FROM jupyter/base-notebook:latest

USER root 
RUN apt-get update && apt-get install -y xorg git && ln -s /bin/tar /bin/gtar

USER $NB_USER
RUN conda install -y -c defaults -c conda-forge -c santandermetgroup python=3.6 climate4r=1.4.1 \
  jupyter_contrib_nbextensions jupyter_nbextensions_configurator && \
  cp /opt/conda/lib/libgomp.so.1.0.0 /opt/conda/lib/libgomp.so

ENV PROJ_LIB /opt/conda/share/proj
RUN R --vanilla -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/foreign/foreign_0.8-64.tar.gz")' && \
    R --vanilla -e 'install.packages(c("crayon", "pbdZMQ", "classInt", "geojsonio"), repos="https://cloud.r-project.org/")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/repr")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/IRdisplay")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/IRkernel")' && \
	chown -R jovyan:users /home/jovyan && \
	R --vanilla -e 'IRkernel::installspec()'

USER root 
RUN R --vanilla -e 'IRkernel::installspec(user = FALSE)' && \
    mkdir -p /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608 && \
    mkdir -p /home/$NB_USER/shared && \
    chown -R $NB_USER:users /gpfs /home/$NB_USER/shared && \
    ln -s /home/$NB_USER/shared /gpfs/ces/share-7c11c2a4-9d9f-40f5-b95e-396bcbf3f608/HUB
USER $NB_USER
