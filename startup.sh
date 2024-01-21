#!/bin/bash
conda init bash > /proc/1/fd/1
source ~/.bashrc
conda activate vicuna

if [ ! -f /root/text-generation-webui/models/anon8231489123_vicuna-13b-GPTQ-4bit-128g ]; then
  echo "=========================================" > /proc/1/fd/1
  echo "DOWNLOADING anon8231489123/vicuna-13b-GPTQ-4bit-128g" > /proc/1/fd/1
  echo "=========================================" > /proc/1/fd/1
  cd /root/text-generation-webui/
  python download-model.py anon8231489123/vicuna-13b-GPTQ-4bit-128g > /proc/1/fd/1
else
  echo "anon8231489123/vicuna-13b-GPTQ-4bit-128g already downloaded"
fi

echo "=========================================" > /proc/1/fd/1
echo "EXECUTING PYTHON SERVER" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /root/text-generation-webui
python server.py --listen > /proc/1/fd/1
