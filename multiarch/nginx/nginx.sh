#!/bin/sh

index_html=/var/lib/nginx/html/index.html
if ! [[ -e $index_html ]] || grep -q 'Welcome to nginx' $index_html &>/dev/null; then
    echo "Hello Nginx version ${NGINX_VERSION}, arch $(uname -m) and hostname $(hostname)" > $index_html
fi

if [[ "$1" == "" ]]; then
    nginx -g "daemon off;"
else
    ${@}
fi
