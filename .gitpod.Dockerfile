FROM crosscompass/ihaskell-notebook:62631e7176e8
USER root
RUN pip install nbgitpuller

USER $NB_UID


ENV JUPYTER_ENABLE_LAB=yes
