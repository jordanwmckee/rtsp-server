FROM alpine:latest
RUN apk add --no-cache bash && \
apk add --no-cache ffmpeg
COPY --from=aler9/rtsp-simple-server:v0.22.2 /mediamtx /
COPY dist/* /
COPY all_videos/ /videos/
RUN chmod +x /stream.sh
ENTRYPOINT ["/mediamtx"]
