FROM alpine:3.6

ARG FRP_VERSION=0.13.0

RUN apk add --no-cache curl \
    && curl -sfSL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz | tar --strip-components=1 -xvz -C /usr/bin/ frp_${FRP_VERSION}_linux_amd64/frpc frp_${FRP_VERSION}_linux_amd64/frps \
    && mkdir -p /etc/frp

COPY frpc.ini frps.ini /etc/frp/

CMD ["frps", "-c", "/etc/frp/frps.ini"]
