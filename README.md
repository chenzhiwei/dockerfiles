# Dockerfiles

Choose bases images:

1. debian:stable-slim
1. alpine:latest

## Build Multi-Arch image

```
podman build --platform linux/amd64,linux/arm64 --manifest docker.io/siji/ubuntu .

podman manifest push docker.io/siji/ubuntu quay.io/siji/ubuntu
podman manifest push docker.io/siji/ubuntu docker.io/siji/ubuntu
```

## Registry URL

* https://quay.io/siji
* https://hub.docker.com/u/siji
