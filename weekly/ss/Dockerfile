FROM shadowsocks/shadowsocks-libev as shadowsocks

USER root

RUN apk add --no-cache binutils

RUN strip /usr/bin/ss-*; true

FROM alpine as v2ray

RUN apk add --no-cache jq

RUN V2RAY_PLUGIN_VERSION=$(wget -q -O - https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | jq -r .name) \
    && wget -P /tmp https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar xf /tmp/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz -C /tmp/

FROM alpine

COPY --from=shadowsocks /usr/bin/ss-* /usr/bin/
COPY --from=v2ray /tmp/v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin

RUN apk add --no-cache rng-tools $(scanelf --needed --nobanner /usr/bin/ss-* | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' | sort -u)
