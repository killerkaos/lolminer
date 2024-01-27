#!/usr/bin/with-contenv bash

conda activate /home/abc/vicuna

echo "=========================================" > /proc/1/fd/1
echo "EXECUTING PYTHON SERVER" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /home/abc/text-generation-webui
python server.py --listen > /proc/1/fd/1
