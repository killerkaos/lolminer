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
	curl \
	tar \
	ca-certificates \
	&& apt-get clean

# add install bash script
COPY custom-cont-init.d /custom-cont-init.d/

# make executable and run bash scripts to install app
RUN chmod +x /custom-cont-init.d/init-d.sh
    
# global environment settings
ENV XDG_CONFIG_HOME=/home/abc
ENV HOME=/home/abc
RUN mkdir /home/abc && mkdir /home/abc/lolminer \
    chown -R abc:abc /home/abc

RUN cd /home/abc/lolminer \
    && wget -O lolminer.tar.gz https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.83/lolMiner_v1.83_Lin64.tar.gz \
    && tar xvf lolminer.tar.gz --strip-components 1 -C /lolminer

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 7862/tcp
VOLUME /config
