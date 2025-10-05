#!/bin/bash

input=data/a.y4m
basename=a
gops=(1 5 10 15 30 60 100 300 600)
for gop in "${gops[@]}"; do
    ffmpeg -i $input -c:v libx264 -pix_fmt yuv420p -an -qp 20 -g $gop -keyint_min $gop data/encoded/${basename}_gop${gop}.mp4
done

input=data/b.y4m
basename=b
for gop in "${gops[@]}"; do
    ffmpeg -i $input -c:v libx264 -pix_fmt yuv420p -an -qp 20 -g $gop -keyint_min $gop data/encoded/${basename}_gop${gop}.mp4
done