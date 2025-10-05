#!/bin/bash

# Usage: bash encode_qp.sh a.y4m
input=$1
basename=$(basename $input .y4m)
for QP in 10 20 30 40 50
do
    ffmpeg -y -i data/$input -c:v libx264 -pix_fmt yuv420p -an -qp $QP data/encoded/${basename}_qp${QP}.mp4
done