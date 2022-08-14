#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! command -v sd > /dev/null; then
    echo -e '\e[1;91mERROR: "sd" (used for text replacement) is not installed and in PATH: https://github.com/chmln/sd\e[0m'
    exit 1
fi

if ! command -v dssim > /dev/null; then
    echo -e '\e[1;91mERROR: "dssim" (used for perceptual quality calculation) is not installed and in PATH: https://github.com/kornelski/dssim\e[0m'
    exit 1
fi

if ! command -v ffmpeg > /dev/null; then
    echo -e '\e[1;91mERROR: "ffmpeg" (used for AVI frame extraction) is not installed and in PATH.\e[0m'
    exit 1
fi

if ! command -v godot > /dev/null; then
    echo -e '\e[1;91mERROR: "godot" (used for Movie Maker mode) is not installed and in PATH.\e[0m'
    exit 1
fi

rm -rf /tmp/godot-movie-maker-benchmark/
mkdir -p /tmp/godot-movie-maker-benchmark/

for quality in $(seq 0.01 0.01 1.0); do
    # Set MJPEG video quality before running Godot in Movie Maker mode.
    sd "movie_writer/mjpeg_quality=(.+)" "movie_writer/mjpeg_quality=$quality" project.godot
    godot --write-movie "output/movie_$quality.avi"

    # Convert first frame of the created AVI videos to PNG images for use with dssim (see below).
    ffmpeg -i "output/movie_$quality.avi" -frames:v 1 -vf select='eq(n\,1)' "/tmp/godot-movie-maker-benchmark/movie_$quality.png"
done

echo -e "\nTime taken (seconds)"
echo -e "====================\n"

for text_file in output/*.txt; do
    echo -e "$(cat "$text_file")\t$text_file"
done

echo -e "\nFile size (MB)"
echo -e "==============\n"

for video in output/*.avi; do
    wc -c "$video"
done

echo -e "\nPerceptual quality (DSSIM) - Lower is better"
echo -e "============================================\n"

# Calculate perceptual quality relative to the reference lossless image.
dssim output/reference.png /tmp/godot-movie-maker-benchmark/movie_*.png

rm -rf /tmp/godot-movie-maker-benchmark/
