#!/bin/bash
conda init bash
source ~/.bashrc

# make the folders

if [ ! -d /config/miniconda ]; then
mkdir -p \
    /config/miniconda
fi

if [ ! -d /config/text-generation-webui ]; then
mkdir -p \
    /config/text-generation-webui
fi

RUN wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh -P
bash installer.sh
rm -f installer.sh

RUN wget
bash startup.sh

exec "$@"
