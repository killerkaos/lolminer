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
	sudo \
	screen \
	&& apt-get clean

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive"
HOME="/config"

# Download latest of miniconda3
RUN cd config \ 
	&& wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 5175/tcp
VOLUME /config
