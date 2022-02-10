#!/bin/sh

DOMAIN=${DOMAIN:-youya.org}

sed -i "s/youya.org/${DOMAIN}/g" /etc/postfix/main.cf /etc/opendkim/KeyTable /etc/opendkim/opendkim.conf /etc/opendkim/SigningTable

if [ ! -f /etc/opendkim/keys/mail.private ]; then
    echo
    echo "please put private key to /etc/opendkim/keys/mail.private"
    echo
    exit 1
fi
