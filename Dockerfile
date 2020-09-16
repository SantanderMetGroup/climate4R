FROM santandermetgroup/climate4r:latest

COPY --chown=jovyan:users notebooks /home/$NB_USER/notebooks
