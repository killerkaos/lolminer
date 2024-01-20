#!/bin/bash
conda init bash
source ~/.bashrc

echo "=========================================" > /proc/1/fd/1
echo "MAKING THE FOLDERS AND LINKING THEM" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1

if [ ! -d /config/miniconda ]; then
mkdir -p \
    /config/miniconda/
    cd /config/miniconda
    ln -s /root/miniconda minicondalink > /proc/1/fd/1
fi

if [ ! -d /config/text-generation-webui ]; then
mkdir -p \
    /config/text-generation-webui/
    ln -s /root/text-generation-webui guilink > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "INSTALLER script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
if [ ! -f /root/installed ]; then
RUN wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh
bash installer.sh
rm -f installer.sh
fi

echo "=========================================" > /proc/1/fd/1
echo "STARTUP python server script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
RUN wget https://raw.githubusercontent.com/killerkaos/vicuna/main/startup.sh
bash startup.sh

exec "$@"
