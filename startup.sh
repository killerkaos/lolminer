#!/bin/bash
echo "=========================================" > /proc/1/fd/1
echo "EXECUTING PYTHON SERVER" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /root/text-generation-webui
python server.py --listen > /proc/1/fd/1
