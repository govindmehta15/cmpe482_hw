#!/bin/bash

videos=("a" "b")
gops=(1 5 10 15 30 60 100 300 600)

echo "video,GOP,bitrate,PSNR,SSIM" > results/gop_results.csv

for vid in "${videos[@]}"; do
  for gop in "${gops[@]}"; do
    mp4="data/encoded/${vid}_gop${gop}.mp4"
    original="data/${vid}.y4m"
    # File size in bytes
    size=$(stat -f%z "$mp4")
    # PSNR average
    psnr=$(ffmpeg -i "$mp4" -i "$original" -an -filter_complex psnr -f null NUL 2>&1 | grep average | awk '{print $6}')
    # SSIM All
    ssim=$(ffmpeg -i "$mp4" -i "$original" -an -filter_complex ssim -f null NUL 2>&1 | grep All | awk '{print $7}')
    echo "${vid}.y4m,${gop},${size},${psnr},${ssim}" >> results/gop_results.csv
  done
done