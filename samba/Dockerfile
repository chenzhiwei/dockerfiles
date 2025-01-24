FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt -y install --no-install-recommends samba \
    && mkdir -p /samba-share \
    && rm -rf /usr/lib/python* /usr/bin/py* /usr/share/python* \
    && rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

CMD ["smbd", "--foreground", "--no-process-group"]
