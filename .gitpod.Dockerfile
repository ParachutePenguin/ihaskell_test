FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]

# An Ubuntu variant of the iHaskell build instrcutions from https://github.com/gibiansky/IHaskell

LABEL io.toilethill.vendor="ToiletHill.io"
LABEL io.toilethill.name="Heath Robertson"
LABEL io.toilethill.title="We Make Things"
LABEL maintainer="CodeHappens@Toilethill.io"
LABEL version="1.0"
LABEL description="Jupyter Lab with Python and Haskell Kernels"

RUN apt-get update --fix-missing && apt-get install -y \
    python3-pip git libtinfo-dev libzmq3-dev \
    libcairo2-dev libpango1.0-dev libmagic-dev \
    libblas-dev liblapack-dev nodejs
RUN apt-get clean && apt-get purge && apt-get autoremove --purge -y

# systemd systemd-sysv curl wget git xz-utils -y \

ENV PATH="/root/.local/bin:${PATH}"
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN git clone https://github.com/gibiansky/IHaskell

WORKDIR /IHaskell
RUN echo jupyterlab >> requirements.txt
RUN pip3 install -r requirements.txt

RUN # stack install gtk2hs-buildtools # Disabled for now because gtk2hs-buildtools doesn't work with lts-13 yet
RUN stack install --fast
RUN ihaskell install --stack

WORKDIR /home

RUN jupyter notebook --generate-config

# RUN jupyter labextension install jupyterlab-ihaskell

CMD ["jupyter", "lab", "--allow-root", "--ip", "0.0.0.0"]
