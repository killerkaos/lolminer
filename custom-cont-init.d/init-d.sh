#!/bin/bash
echo "=========================================" > /proc/1/fd/1
echo "MAKING THE FOLDERS AND LINKING THEM" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1

if [ ! -d /config/miniconda ]; then
    ln -s /root/miniconda /config/miniconda > /proc/1/fd/1
fi

if [ ! -d /config/text-generation-webui ]; then
    ln -s /root/text-generation-webui /config/text-generation-webui > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "INSTALLER script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
if [ ! -f /root/installed ]; then
wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh
bash installer.sh
rm -f installer.sh
fi

echo "=========================================" > /proc/1/fd/1
echo "STARTUP python server script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
wget https://raw.githubusercontent.com/killerkaos/vicuna/main/startup.sh
bash startup.sh

exec "$@"
