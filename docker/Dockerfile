FROM jupyter/base-notebook:latest

USER root 
RUN apt-get update && apt-get install -y xorg git && ln -s /bin/tar /bin/gtar

USER $NB_USER
RUN conda install -y -c conda-forge -c santandermetgroup -c defaults climate4r=1.2.0 \
  geojsonio proj4 pkg-config \
  jupyter_contrib_nbextensions jupyter_nbextensions_configurator

ENV PROJ_LIB /opt/conda/share/proj
RUN R --vanilla -e 'install.packages(c("crayon", "pbdZMQ", "classInt", "geojsonio"), repos="https://cloud.r-project.org/")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/repr")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/IRdisplay")' && \
	R --vanilla -e 'library(devtools);install_github("IRkernel/IRkernel")' && \
	chown -R jovyan:users /home/jovyan && \
	R --vanilla -e 'IRkernel::installspec(); IRkernel::installspec(user = FALSE)'

# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
