# syntax=docker/dockerfile:1
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chencichen"

USER root

# Download all dependencies
RUN apt-get update \ 
	&& DEBIAN_FRONTEND="noninteractive" \ 
	apt-get install -y \
	wget \
	git \
	sudo \
	screen \
	aptitude \
	gcc-9 \
	g++-9 \
	&& apt-get clean

RUN aptitude install build-essential -y

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9

# add install bash script
ADD /root/*.sh /root/

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh && \
	/bin/bash /root/init-bash.sh

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
  HOME="/config"

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 5175/tcp
VOLUME /config

CMD ["/bin/sh" "-c" "/root/init-bash.sh"]
