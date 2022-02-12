#!/bin/sh

DOMAIN=${DOMAIN:-youya.org}
SELECTOR=${SELECTOR:-mail}
USERNAME=${USERNAME:-user}
PASSWORD=${PASSWORD:-pass}
SECRET_PATH=${SECRET_PATH:-/etc/postfix/secret}
TLS_KEY_FILE=${TLS_KEY_FILE:-${SECRET_PATH}/smtp.${DOMAIN}.key}
TLS_CERT_FILE=${TLS_CERT_FILE:-${SECRET_PATH}/smtp.${DOMAIN}.crt}
DKIM_KEY_FILE=${DKIM_KEY_FILE:-${SECRET_PATH}/${SELECTOR}.private}

sed -i -e "s/DOMAIN/${DOMAIN}/g" \
    -e "s/SELECTOR/${SELECTOR}/g" \
    -e "s#DKIM_KEY_FILE#${DKIM_KEY_FILE}#g" \
    /etc/opendkim/KeyTable

sed -i -e "s/DOMAIN/${DOMAIN}/g" \
    -e "s/SELECTOR/${SELECTOR}/g" \
    /etc/opendkim/SigningTable

sed -i -e "s/DOMAIN/${DOMAIN}/g" \
    -e "s#TLS_KEY_FILE#${TLS_KEY_FILE}#g" \
    -e "s#TLS_CERT_FILE#${TLS_CERT_FILE}#g" \
    /etc/postfix/main.cf

## Auo generated files
if [ ! -f /etc/sasl2/sasldb2 ]; then
    echo ${PASSWORD} | saslpasswd2 -c -p -u ${DOMAIN} ${USERNAME}
fi
chown postfix:postfix /etc/sasl2/sasldb2

## User mounted files
STATUS=0
if [ ! -f ${TLS_KEY_FILE} ]; then
    STATUS=1
    echo
    echo "NO TLS_KEY_FILE Found: ${TLS_KEY_FILE}"
    echo
fi

if [ ! -f ${TLS_CERT_FILE} ]; then
    STATUS=1
    echo
    echo "NO TLS_CERT_FILE Found: ${TLS_CERT_FILE}"
    echo
fi

if [ ! -f ${DKIM_KEY_FILE} ]; then
    STATUS=1
    echo
    echo "NO DKIM_KEY_FILE Found: ${DKIM_KEY_FILE}"
    echo
fi
[ ${STATUS} -ne 0 ] && exit 1

chmod 600 ${TLS_KEY_FILE} ${TLS_CERT_FILE}
chown postfix:postfix ${TLS_KEY_FILE} ${TLS_CERT_FILE}

chmod 600 ${DKIM_KEY_FILE}
chown opendkim:opendkim ${DKIM_KEY_FILE}

exit 0
