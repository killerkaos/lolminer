#!/bin/bash
# Execute installer script
echo "=========================================" > /proc/1/fd/1
echo "INSTALLER script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
if [ ! -f /root/installed ]; then
    wget https://raw.githubusercontent.com/killerkaos/vicuna/main/installer.sh > /proc/1/fd/1
    bash installer.sh
    rm -f installer.sh
else
    echo "Vicuna installed, skip installer" > /proc/1/fd/1
fi

# Execute Startup script
echo "=========================================" > /proc/1/fd/1
echo "STARTUP python server script" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
wget https://raw.githubusercontent.com/killerkaos/vicuna/main/startup.sh > /proc/1/fd/1
bash startup.sh

exec "$@"
