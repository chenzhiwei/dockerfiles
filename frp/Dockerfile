FROM alpine:3.8

ARG FRP_VERSION=0.22.0

RUN apk add --no-cache curl \
    && mkdir -p /etc/frp \
    && curl -sfSL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz | tar --strip-components=1 -xvz -C /usr/bin/ frp_${FRP_VERSION}_linux_amd64/frpc  frp_${FRP_VERSION}_linux_amd64/frps frp_${FRP_VERSION}_linux_amd64/frpc.ini frp_${FRP_VERSION}_linux_amd64/frps.ini \
    && mv /usr/bin/frp*.ini /etc/frp/

CMD ["frps", "-c", "/etc/frp/frps.ini"]
