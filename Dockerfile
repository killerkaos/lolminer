# syntax=docker/dockerfile:1
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chencichen"

# Download all dependencies
RUN apt-get update \ 
	&& DEBIAN_FRONTEND="noninteractive" \ 
	apt-get install -y \
	wget \
	git \
	libxml2 \
	&& apt-get clean

# add install bash script
COPY custom-cont-init.d /custom-cont-init.d/

# make executable and run bash scripts to install app
RUN chmod +x /custom-cont-init.d/init-d.sh

RUN mkdir /home/abc && \
    chown -R abc:abc /home/abc
    
# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
  HOME="/home/abc"
  
# Download latest of miniconda3
RUN wget \
	https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
	&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/abc/miniconda \
	&& rm -f Miniconda3-latest-Linux-x86_64.sh

# Make non-activate conda commands available.
ENV PATH=/home/abc/miniconda/bin:$PATH

# Make conda activate command available from /bin/bash --login shells.
RUN echo "source /home/abc/miniconda/etc/profile.d/conda.sh" >> ~/.profile

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 7860/tcp
VOLUME /config
