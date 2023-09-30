# https://hub.docker.com/_/ubuntu
FROM ubuntu:22.04

LABEL maintainer=""

ENV PACKER_VERSION=1.8.4
ENV PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip

RUN apt update -y && apt upgrade -y \
    && apt install -y unzip \
    && apt install -y wget \
    && apt install -y curl \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Download and install Packer
RUN wget ${PACKER_URL} \ 
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && rm packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin/

RUN echo "packer version: $(packer version)" \
    && echo "wget version: $(wget --version | head -n 1)" \
    && echo "unzip version: $(unzip -v | head -n 1)"

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
