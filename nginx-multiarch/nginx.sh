#!/bin/sh

index_html=/var/lib/nginx/html/index.html
if grep -q 'Welcome to nginx' $index_html &>/dev/null; then
    echo "Hello Nginx version ${NGINX_VERSION}, hostname $(hostname)" > $index_html
fi

if [[ "$1" == "" ]]; then
    nginx -g "daemon off;"
else
    ${@}
fi
