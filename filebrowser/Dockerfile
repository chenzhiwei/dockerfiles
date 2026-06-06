FROM docker.io/library/ubuntu:latest AS builder

RUN apt update && apt install -y curl

RUN curl -LO https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser.tar.gz \
    && tar xf linux-amd64-filebrowser.tar.gz

FROM docker.io/library/ubuntu:latest


LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt -y --no-install-recommends install ca-certificates iproute2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /filebrowser /usr/bin/filebrowser

CMD ["filebrowser", "-c", "/etc/filebrowser/settings.json"]
