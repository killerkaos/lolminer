#!/bin/bash
echo "=========================================" > /proc/1/fd/1
echo "DOWNLOAD LATEST MINICONDA" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda
rm -f Miniconda3-latest-Linux-x86_64.sh

# Make conda activate command available from /bin/bash --login shells
source /root/miniconda/etc/profile.d/conda.sh >> ~/.profile

if [ ! -d /root/miniconda/envs/vicuna ]; then
echo "=========================================" > /proc/1/fd/1
echo "CONDA CREATE vicuna" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
conda create -n vicuna python=3.11 -y > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "CONDA ACTIVATE vicuna" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
conda activate vicuna
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
conda env config vars set CUDA_HOME="/root/miniconda/envs/vicuna" > /proc/1/fd/1
conda deactivate > /proc/1/fd/1
conda activate vicuna > /proc/1/fd/1

if [ ! -d /root/text-generation-webui ]; then
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING & Downloading text-GUI" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /root/
git clone https://github.com/oobabooga/text-generation-webui.git > /proc/1/fd/1
cd text-generation-webui
pip install -r requirements.txt > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "FINISH INSTALLATION" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
rm -r /config/.cache
cd /root/
touch installed
