#!/bin/bash

input=$1
basename=$(basename $input .y4m)

for QP in 10 20 30 40 50
do
    out=data/encoded/${basename}_qp${QP}.mp4
    echo "$out" >> results/qp_results.csv
    # Bitrate (file size)
    size=$(stat -c %s "$out")
    echo "Bitrate: $size" >> results/qp_results.csv
    # PSNR
    ffmpeg -i "$out" -i "data/$input" -an -filter_complex psnr -f null NUL 2>&1 | grep average | tee -a results/qp_results.csv
    # SSIM
    ffmpeg -i "$out" -i "data/$input" -an -filter_complex ssim -f null NUL 2>&1 | grep All | tee -a results/qp_results.csv
done