FROM shadowsocks/shadowsocks-libev

RUN apk add --no-cache curl \
    && V2RAY_PLUGIN_VERSION=$(curl -sI https://github.com/shadowsocks/v2ray-plugin/releases/latest | awk -F'/' '/^Location/ {print $NF}') \
    && wget -P /tmp https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar xf /tmp/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz -C /tmp/ \
    && mv /tmp/v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin \
    && rm -rf /tmp/*
