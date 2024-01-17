#!/bin/bash

echo "Conda init bash " > /proc/1/fd/1

conda init bash
source ~/.bashrc

echo "Conda create & activate vicuna" > /proc/1/fd/1
conda create -n vicuna python=3.9 -y > /proc/1/fd/1
conda activate vicuna

echo "Conda vicuna install all dependencies and cudatoolkit" > /proc/1/fd/1
pip3 install protobuf==3.20 torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117 -y > /proc/1/fd/1
conda install -c conda-forge cudatoolkit-dev -y > /proc/1/fd/1

echo "=========================================" > /proc/1/fd/1
echo "DEPENDENCIES INSTALLED" > /proc/1/fd/1

echo "installing requirements for Fastchat" > /proc/1/fd/1
cd /root/Fastchat
pip install -r requirements.txt -y > /proc/1/fd/1

echo "Creating repositories and downloading GPTQ for LLaMa" > /proc/1/fd/1
mkdir repositories
cd repositories
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda > /proc/1/fd/1
cd GPTQ-for-LLaMa
echo "Compiling" > /proc/1/fd/1
python setup_cuda.py install > /proc/1/fd/1

sleep 900
exec "$@"
