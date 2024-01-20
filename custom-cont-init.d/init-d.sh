#!/bin/bash
conda init bash
source ~/.bashrc

# make the folders
mkdir -p \
    /config/text-generation-webui
    /config/miniconda


exec "$@"
