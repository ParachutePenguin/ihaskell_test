FROM gitpod/workspace-full
USER gitpod

RUN sudo apt-get install -y python3-pip git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev
RUN curl -sSL https://get.haskellstack.org/ | sh \
    && git clone https://github.com/gibiansky/IHaskell \
    && cd IHaskell \
    && pip3 install -r requirements.txt \
    # stack install gtk2hs-buildtools # Disabled for now because gtk2hs-buildtools doesn't work with lts-13 yet
    && stack install --fast \
    && ihaskell install --stack \
