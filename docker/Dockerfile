FROM jupyter/base-notebook:latest

USER root 
RUN apt-get update && apt-get install -y xorg && ln -s /bin/tar /bin/gtar
USER $NB_USER

RUN conda install -c defaults -c r -c conda-forge -c santandermetgroup climate4r=1.1.0 r-irkernel
# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
