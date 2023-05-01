#!/bin/bash

#Exit when a command fails
set -o errexit
#Exit upon attempt to use undeclared vars
set -o nounset
#Causes a non-zero exit code in a piped stream to be returned
set -o pipefail
#Uncomment for tracing
#set -o xtrace

NAME=$(echo "$1" | tr / _)

ffmpeg -re -stream_loop -1 -i videos/${NAME}fps.mp4 -c copy -f rtsp rtsp://localhost:8554/$1
