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
	aptitude \
	libxml2 \
	gcc-9 \
	g++-9 \
	&& apt-get clean

RUN aptitude install build-essential -y

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9

# add install bash script
COPY custom-cont-init.d ./custom-cont-init.d/
COPY custom-cont-init.d/init-folders ./custom-cont-init.d/init-folders/

# make executable and run bash scripts to install app
RUN chmod +x /custom-cont-init.d/init-d.sh

# Download latest of miniconda3
RUN wget \
	https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
	&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda \
	&& rm -f Miniconda3-latest-Linux-x86_64.sh

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
  HOME="/config"

# Make non-activate conda commands available.
ENV PATH=/root/miniconda/bin:$PATH

# Make conda activate command available from /bin/bash --login shells.
RUN echo "export PATH=/usr/local/cuda/bin/:/root/miniconda/conda/bin:\$PATH" >> ~/.profile 
RUN echo "source /root/miniconda/etc/profile.d/conda.sh" >> ~/.profile

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 7860/tcp
VOLUME /config
