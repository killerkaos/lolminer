#!/bin/bash

echo "-------------------------------------"
# permissions
echo "chown'ing directory to ensure correct permissions."
chown -R abc:abc /home/abc
chown -R abc:abc /config
echo "Done!"
echo -e "-------------------------------------\n"

# Execute installer script
echo "=========================================" > /proc/1/fd/1
echo "INSTALLER script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
if [ ! -f /config/installed ]; then
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
