FROM aler9/rtsp-simple-server AS rtsp
FROM alpine:latest
RUN apk add --no-cache ffmpeg
RUN apk add bash
COPY --from=rtsp /rtsp-simple-server /
COPY dist/ /
RUN mkdir videos
COPY all_videos/ /videos
RUN chmod +x stream.sh
ENTRYPOINT [ "/rtsp-simple-server" ]
