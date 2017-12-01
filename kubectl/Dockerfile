FROM alpine:3.6

ARG KUBE_VERSION=v1.8.3

RUN apk add --no-cache curl \
    && curl -ksSL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl \
    && chmod +x /usr/bin/kubectl
