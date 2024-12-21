# podman run -d --privileged --network host --device /dev/kvm \
#    -v /run/dbus:/run/dbus -v /sys/fs/cgroup:/sys/fs/cgroup docker.io/siji/libvirt:latest
FROM docker.io/library/golang:latest AS builder

RUN git clone --depth=1 https://github.com/ochinchina/supervisord.git
RUN cd supervisord && go mod tidy && CGO_ENABLED=0 go build -o /tmp/supervisord && strip /tmp/supervisord

FROM docker.io/library/debian:stable-slim

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list.d/debian.sources

RUN apt update

RUN apt install -y --no-install-recommends qemu-system libvirt-clients libvirt-daemon-system vim procps iproute2

COPY default-network.yaml /misc/default-network.yaml
COPY docker-config.sh /usr/libexec/libvirtd/docker-config.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY --from=builder /tmp/supervisord /usr/bin/supervisord

CMD ["supervisord"]
