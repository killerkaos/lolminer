#!/bin/bash

echo "Conda init bash " > /proc/1/fd/1

conda init bash
source ~/.bashrc

echo "Conda activate " > /proc/1/fd/1

conda activate vicuna

exec "$@"
