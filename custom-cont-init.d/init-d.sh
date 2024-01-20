#!/bin/bash
conda init bash
source ~/.bashrc

echo "=========================================" > /proc/1/fd/1
echo "MAKING THE FOLDERS" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1

if [ ! -d /config/miniconda ]; then
mkdir -p \
    /config/miniconda
fi

if [ ! -d /config/text-generation-webui ]; then
mkdir -p \
    /config/text-generation-webui
fi

RUN wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh
bash installer.sh
rm -f installer.sh

RUN wget https://raw.githubusercontent.com/killerkaos/vicuna/main/startup.sh
bash startup.sh

exec "$@"
