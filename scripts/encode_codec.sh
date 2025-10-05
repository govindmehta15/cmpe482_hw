#!/bin/bash

input=$1
basename=$(basename $input .y4m)
for QP in 30 40 50
do
    # H.264
    ffmpeg -y -i data/$input -c:v libx264 -pix_fmt yuv420p -an -qp $QP data/encoded/${basename}_h264_qp${QP}.mp4
    # H.265
    ffmpeg -y -i data/$input -c:v libx265 -pix_fmt yuv420p -an -x265-params qp=$QP data/encoded/${basename}_h265_qp${QP}.mp4
done