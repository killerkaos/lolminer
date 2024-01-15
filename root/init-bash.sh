#!/bin/bash

echo "Conda init bash " > /proc/1/fd/1

conda init bash

echo "Conda activate " > /proc/1/fd/1

conda activate vicuna

echo "Conda install dependencies " > /proc/1/fd/1

conda install pytorch torchvision torchaudio pytorch-cuda=11.7 cuda-toolkit -c 'nvidia/label/cuda-11.7.0' -c pytorch -c nvidia -y > /proc/1/fd/1
