#!/bin/bash
conda init bash > /proc/1/fd/1
source ~/.bashrc
conda activate vicuna

echo "=========================================" > /proc/1/fd/1
echo "EXECUTING PYTHON SERVER" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /root/text-generation-webui
python server.py --listen --gpu-memory 10 7> /proc/1/fd/1
