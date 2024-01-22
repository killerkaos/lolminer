#!/bin/bash

echo "-------------------------------------"
# permissions
echo "chown'ing directory to ensure correct permissions."
chown -R abc:abc /home/abc
chown -R abc:abc /config
echo "Done!"
echo -e "-------------------------------------\n"

echo "=========================================" > /proc/1/fd/1
echo "MAKING THE FOLDERS AND LINKING THEM" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1

if [ ! -d /config/miniconda ]; then
    echo "No miniconda folder detected, will create" > /proc/1/fd/1
    ln -s /root/miniconda /config/miniconda/
    else
    echo "Miniconda folder detected, skip" > /proc/1/fd/1
fi

if [ ! -d /config/text-generation-webui ]; then
    echo "No text-generation-webui folder detected, will create" > /proc/1/fd/1
    ln -s /root/text-generation-webui /config/text-generation-webui/ > /proc/1/fd/1
else
    echo "Text-generation-webui folder detected, skip" > /proc/1/fd/1
fi

# Execute installer script
echo "=========================================" > /proc/1/fd/1
echo "INSTALLER script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
if [ ! -f /root/installed ]; then
    wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh
    bash installer.sh
    rm -f installer.sh
else
    echo "Vicuna installed, skip installer" > /proc/1/fd/1
fi

# Execute Startup script
echo "=========================================" > /proc/1/fd/1
echo "STARTUP python server script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
wget https://raw.githubusercontent.com/killerkaos/vicuna/main/startup.sh
bash startup.sh

exec "$@"
