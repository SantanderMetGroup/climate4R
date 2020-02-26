FROM jupyter/base-notebook:latest

RUN conda install -c conda-forge -c santandermetgroup -c r r-irkernel climate4r=0.3
# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
