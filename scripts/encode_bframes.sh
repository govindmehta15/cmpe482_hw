#!/bin/bash

input=$1
basename=$(basename $input .y4m)
QP=20
GOP=250
for B in 0 2 4 8
do
    ffmpeg -y -i data/$input -c:v libx264 -pix_fmt yuv420p -an -qp $QP -g $GOP -keyint_min $GOP -bf $B data/encoded/${basename}_bf${B}.mp4
done