FROM santandermetgroup/climate4r:1.4.1

COPY --chown=jovyan:users notebooks /home/$NB_USER/notebooks
