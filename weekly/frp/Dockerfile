FROM alpine as builder

RUN apk add --no-cache jq

RUN FRP_VERSION=$(wget -q -O - https://api.github.com/repos/fatedier/frp/releases/latest | jq -r .name | sed 's/v//g') \
    && wget -q https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar --strip-components=1 -xf frp_${FRP_VERSION}_linux_amd64.tar.gz -C /tmp

FROM alpine

COPY --from=builder /tmp/frpc /tmp/frps /usr/bin/
COPY --from=builder /tmp/*.ini /etc/frp/

CMD ["frps", "-c", "/etc/frp/frps.ini"]
