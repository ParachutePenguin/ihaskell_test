FROM python:3.7
RUN apt update -y && apt upgrade -y
RUN sudo apt install haskell-stack
RUN stack upgrade --binary-only
