FROM gitpod/workspace-full
USER gitpod

RUN sudo apt-get install -y python3-pip git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev
RUN brew install haskell-stack
RUN stack install brittany hlint
RUN git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules \
    && cd haskell-ide-engine  \
    && stack install haskell-ide-engine \
    && cd .. \
    && rm -rf haskell-ide-engine
RUN git clone https://github.com/gibiansky/IHaskell \
    && cd IHaskell \
    && pip3 install -r requirements.txt
RUN ihaskell install --stack
RUN jupyter labextension install jupyterlab-ihaskell

ENV PATH=/home/gitpod/.local/bin:$PATH 
