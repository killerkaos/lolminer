#!/bin/bash
conda init bash > /proc/1/fd/1
source ~/.bashrc

# Make non-activate conda commands available.
export PATH=/root/miniconda/bin:$PATH
export use_venv=0

if [ ! -d /home/abc/vicuna ]; then
echo "=========================================" > /proc/1/fd/1
echo "CONDA CREATE vicuna" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    conda create -p /home/abc/vicuna python=3.11 -y > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "CONDA ACTIVATE vicuna" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    conda activate /home/abc/vicuna > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING DEPENDENCIES: Torch, cudatoolkit & protobuf (WILL TAKE A LONG TIME)" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 > /proc/1/fd/1
    conda install -y -c "nvidia/label/cuda-12.1.1" cuda-runtime -y > /proc/1/fd/1
    pip install protobuf==3.20 > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "DEPENDENCIES ALL INSTALLED" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "SETUP CUDA HOME & REACTIVATE vicuna" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
conda env config vars set CUDA_HOME="/home/abc/vicuna" > /proc/1/fd/1
conda deactivate > /proc/1/fd/1
conda activate /home/abc/vicuna > /proc/1/fd/1

if [ ! -d /home/abc/text-generation-webui ]; then
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING & Downloading text-GUI" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /home/abc/
git clone https://github.com/oobabooga/text-generation-webui.git > /proc/1/fd/1
cd text-generation-webui
pip install -r requirements.txt > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "FINISH INSTALLATION" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /home/abc/
touch installed
