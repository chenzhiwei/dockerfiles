FROM alpine:3.6

ENV NGINX_VERSION 1.12.2-r0

RUN apk add --no-cache nginx=$NGINX_VERSION \
    && mkdir -p /run/nginx \
    && ln -s /var/lib/nginx /usr/share/nginx \
    && ln -s /var/lib/nginx/html /var/www/html \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.sh /usr/bin/nginx.sh
COPY default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx.sh"]
