# podman build --platform linux/amd64,linux/arm64 --manifest docker.io/siji/ubuntu:systemd .
# podman run -d --privileged --name systemd docker.io/siji/ubuntu:systemd

FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt -y --no-install-recommends install ca-certificates curl nftables iproute2 iptables iputils-ping systemd vim \
    && rm -rf /var/lib/apt/lists/* /etc/systemd/system/*.target.wants/*

CMD ["/usr/lib/systemd/systemd"]
