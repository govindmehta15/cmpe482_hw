#!/bin/bash

videos=("a.y4m" "b.y4m")
qps=(10 20 30 40 50)

echo "video,QP,bitrate,PSNR,SSIM" > results/qp_results.csv

for vid in "${videos[@]}"; do
  base=$(basename $vid .y4m)
  for qp in "${qps[@]}"; do
    mp4="data/encoded/${base}_qp${qp}.mp4"
    original="data/${base}.y4m"
    size=$(stat -f%z "$mp4")
    psnr=$(ffmpeg -i "$mp4" -i "$original" -an -filter_complex psnr -f null NUL 2>&1 | grep average | awk '{print $6}')
    ssim=$(ffmpeg -i "$mp4" -i "$original" -an -filter_complex ssim -f null NUL 2>&1 | grep All | awk '{print $7}')
    echo "$base.y4m,$qp,$size,$psnr,$ssim" >> results/qp_results.csv
  done
done