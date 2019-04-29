FROM jupyter/base-notebook:latest

RUN conda install -c santandermetgroup climate4r
# $NB_USER not supported in chown, see https://github.com/moby/moby/issues/35018
COPY --chown=jovyan:users examples /home/$NB_USER/examples
COPY --chown=jovyan:users jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py 
