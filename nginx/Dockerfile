FROM docker.io/library/alpine

RUN apk add --no-cache nginx ca-certificates curl \
    && sed -i 's@#include /etc/nginx/conf.d@include /etc/nginx/conf.d@g' /etc/nginx/nginx.conf \
    && mkdir -p /run/nginx \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
