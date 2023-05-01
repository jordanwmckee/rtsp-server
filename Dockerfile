FROM alpine:latest
RUN apk add --no-cache bash && \
apk add --no-cache ffmpeg
COPY --from=aler9/rtsp-simple-server /mediamtx /
COPY dist/* /
COPY all_videos/ /videos/
RUN chmod +x /stream.sh
ENTRYPOINT ["/mediamtx"]