# INSTRUCTIONS:

### Table of Contents

- [INSTRUCTIONS:](#instructions)
    - [Table of Contents](#table-of-contents)
  - [Description](#description)
    - [To Begin:](#to-begin)
  - [Pull From Github](#pull-from-github)
  - [Run Image in Container](#run-image-in-container)
    - [Interacting with Running Container](#interacting-with-running-container)
    - [Streaming Videos](#streaming-videos)
  - [Building Locally](#building-locally)
  - [Adding Videos](#adding-videos)
    - [Debugging](#debugging)
    - [Docker Commands](#docker-commands)
  - [FFMPEG Video Manipulation (Framerate and Resolution):](#ffmpeg-video-manipulation-framerate-and-resolution)
  - [Links](#links)

## Description

This tool was created to easily simulate camera connections to a server through
an rtsp stream.

It listens on port 8554 of the host machine for rtsp requests at a predefined
URL, and begins streaming the desired video to that URL upon these requests.

### To Begin:

Make sure docker is installed. If not, download it
[here](https://docs.docker.com/desktop/windows/install/) (Windows)

From the Terminal:

(OpenSUSE)

```bash
sudo zypper install docker-compose

# enable and start
sudo systemctl enable docker
sudo systemctl start docker

# make sure you have a docker group
sudo groupadd docker

# add user to the docker group (to enable non-root access)
sudo gpasswd -a $USER docker
newgrp docker
```

## Pull From Github

Pull the Image from the Package Registry

```bash
docker pull ghcr.io/jordanwmckee/rtsp-server:latest
```

## Run Image in Container

Flags

- "-d" detached mode
- "--restart unless-stopped" keeps container running after reboot etc
- "--rm" removes container automatically upon exit
- "--name" names container
- "-p 80:80" maps ports

```bash
docker run -it --name rtsp -e MTX_PROTOCOLS=tcp -p 8554:8554 -p 1935:1935 -p
8888:8888 ghcr.io/jordanwmckee/rtsp-server
```

<sub>on windows, you need to add `winpty` before "docker"</sub>

### Interacting with Running Container

When referencing a container, you can use either the container name, or the
container id. Using container name is much quicker, but you can find the
container id by running `docker ps -a`

Stop Container (CTRL + D) OR:

```bash
docker stop <name>
```

Remove Container

```bash
docker rm <name>
```

### Streaming Videos

To stream the videos using VLC, go to Media > Open Network Stream and input the
following

```bash
rtsp://<ip_of_computer_running_the_container>:8554/<video_name>/<resolution_width>/<fps>/25

# for example, if was running the container and my ip was 192.168.0.0 and I want
# to stream sample.mp4 with 1920x1080 resolution at 30 fps, I would type
# rtsp://192.168.0.0:8554/sample/1920/30/25
```

The 25 at the end represents the compression on the video, which is currently
static

Video name options are any video in the rtsp-server/source-videos directory

Resolution Width Options:

- 1920
- 1280
- 640

FPS Options:

- 5
- 10
- 15
- 30

Any Combination of those will work

## Building Locally

To build this image locally,

- ensure you have ffmpeg installed
- run the `auto-convert.sh` script
  - This will create a new directory "all_videos" and modify the original videos' framerates and resolution to provide a variety of streaming options from the docker container
- Then just run `docker-compose up` and it will build and run the image

Then you can [run it](#run-image-in-container) by replacing "rtsp-server" in this
command with your image name

## Adding Videos

To add a video to the image and have it automatically converted into each
desired version, just add your video to the source-videos directory.

For simplicity, make sure your video file is one word followed by ".mp4"

### Debugging

To debug a running container:

```bash
docker exec -it <name> bash
```

Or (on Windows)

```bash
winpty docker exec -it <name> bash
```

To debug a stopped container:

```bash
docker commit <name> debug && \
docker run -it --rm --entrypoint sh debug
```

### Docker Commands

Show Ongoing Docker Processes

```bash
docker ps
```

View Local Images

```bash
docker image ls
```

Remove an Image

```bash
docker rm image <name>
```

View Local Containers

```bash
docker container ls
```

Remove All Images and Containers not in use

```bash
docker system prune -a
```

Remove all stopped Containers only

```bash
docker container prune
```

## FFMPEG Video Manipulation (Framerate and Resolution):

    ffmpeg -r <fps> -i <inFile> -vf scale=<resWidth>:-1 <outFile>

## Links

[rtsp-simple-server](https://github.com/aler9/rtsp-simple-server)
