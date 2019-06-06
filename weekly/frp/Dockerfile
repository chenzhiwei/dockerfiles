FROM alpine

RUN apk add --no-cache jq \
    && FRP_VERSION=$(wget -q -O - https://api.github.com/repos/fatedier/frp/releases/latest | jq -r .name | sed 's/v//g') \
    && mkdir -p /etc/frp \
    && wget -q -O - https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz | tar --strip-components=1 -xvz -C /usr/bin/ frp_${FRP_VERSION}_linux_amd64/frpc  frp_${FRP_VERSION}_linux_amd64/frps frp_${FRP_VERSION}_linux_amd64/frpc.ini frp_${FRP_VERSION}_linux_amd64/frps.ini \
    && mv /usr/bin/frp*.ini /etc/frp/

CMD ["frps", "-c", "/etc/frp/frps.ini"]
