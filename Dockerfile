FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

ENV PACKER_VERSION=1.8.4
ENV PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf update -y \
    && microdnf install -y unzip \
    && microdnf install -y wget \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Download and install Packer
RUN wget ${PACKER_URL} \ 
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && rm packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin/

RUN packer version
RUN echo "packer version: $(packer version)" \
    && echo "wget version: $(wget --version | head -n 1)" \
    && echo "unzip version: $(unzip -v | head -n 1)"

USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
