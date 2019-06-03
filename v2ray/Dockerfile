FROM alpine

RUN apk add --no-cache ca-certificates \
    && mkdir -p v2ray /etc/v2ray \
    && wget -P v2ray https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip -o -d v2ray v2ray/v2ray-linux-64.zip \
    && \cp v2ray/v2ray v2ray/v2ctl /usr/bin/ \
    && \cp v2ray/config.json /etc/v2ray/ \
    && rm -rf v2ray

COPY v2ray.sh /usr/local/bin/v2ray.sh

CMD ["v2ray.sh"]
