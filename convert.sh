#!/bin/bash

#Exit when a command fails
set -o errexit
#Exit upon attempt to use undeclared vars
set -o nounset
#Causes a non-zero exit code in a piped stream to be returned
set -o pipefail
#Uncomment for tracing
#set -o xtrace

VID=${1%.*}
VID=${VID#*/}

ffmpeg -r 5 -i source-videos/${VID}.mp4 -vf scale=1920:-1 
all_videos/${VID}_1920_5fps.mp4
ffmpeg -r 10 -i source-videos/${VID}.mp4 -vf scale=1920:-1 
all_videos/${VID}_1920_10fps.mp4
ffmpeg -r 15 -i source-videos/${VID}.mp4 -vf scale=1920:-1 
all_videos/${VID}_1920_15fps.mp4
ffmpeg -r 30 -i source-videos/${VID}.mp4 -vf scale=1920:-1 
all_videos/${VID}_1920_30fps.mp4

ffmpeg -r 5 -i source-videos/${VID}.mp4 -vf scale=1280:-1 
all_videos/${VID}_1280_5fps.mp4
ffmpeg -r 10 -i source-videos/${VID}.mp4 -vf scale=1280:-1 
all_videos/${VID}_1280_10fps.mp4
ffmpeg -r 15 -i source-videos/${VID}.mp4 -vf scale=1280:-1 
all_videos/${VID}_1280_15fps.mp4
ffmpeg -r 30 -i source-videos/${VID}.mp4 -vf scale=1280:-1 
all_videos/${VID}_1280_30fps.mp4

ffmpeg -r 5 -i source-videos/${VID}.mp4 -vf scale=640:-1 
all_videos/${VID}_640_5fps.mp4
ffmpeg -r 10 -i source-videos/${VID}.mp4 -vf scale=640:-1 
all_videos/${VID}_640_10fps.mp4
ffmpeg -r 15 -i source-videos/${VID}.mp4 -vf scale=640:-1 
all_videos/${VID}_640_15fps.mp4
ffmpeg -r 30 -i source-videos/${VID}.mp4 -vf scale=640:-1 
all_videos/${VID}_640_30fps.mp4
