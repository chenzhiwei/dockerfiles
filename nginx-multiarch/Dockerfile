FROM alpine:3.6

ENV NGINX_VERSION 1.12.1-r0

RUN apk add --no-cache nginx=$NGINX_VERSION \
    && mkdir -p /run/nginx

COPY nginx.sh /usr/bin/nginx.sh
COPY default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx.sh"]
