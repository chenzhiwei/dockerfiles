#!/bin/sh

AUTO_CONFIGURE=${AUTO_CONFIGURE:-true}

function create_config() {
    if [[ "$INTERFACE" == "" ]] || [[ "$VIP" == "" ]]; then
        echo '"INTERFACE" and "VIP" environment variables must be provided'
        exit 1
    fi

    AUTH_PASS=${AUTH_PASS:-1111}
    VRID=$(echo $VIP | awk -F'[./]' '{print $4}')

    sed -i -e 's/HOSTNAME/'$HOSTNAME'/g' -e 's/INTERFACE/'$INTERFACE'/g' -e 's/VRID/'$VRID'/g' -e 's/AUTH_PASS/'$AUTH_PASS'/g' -e 's#VIP#'$VIP'#g' /etc/keepalived/keepalived.conf
}

if [[ "$AUTO_CONFIGURE" == "true" ]]; then
    create_config
fi

keepalived -n -l
