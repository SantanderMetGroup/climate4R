FROM jupyter/base-notebook:latest

USER root 
RUN apt-get update && apt-get install -y xorg git && ln -s /bin/tar /bin/gtar

USER $NB_USER
RUN conda install -y -c defaults -c conda-forge -c santandermetgroup python=3.6 climate4r=1.4.0 \
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
RUN R --vanilla -e 'IRkernel::installspec(user = FALSE)'
USER $NB_USER

# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
