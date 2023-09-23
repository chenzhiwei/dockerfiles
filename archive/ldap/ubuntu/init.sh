#!/bin/bash

PASSWORD=${PASSWORD:-admin}
DOMAIN=${DOMAIN:-org}

SLAPD_CONF=/etc/ldap/slapd.d

backend=mdb
backendoptions="olcDbMaxSize: 1073741824"
backendobjectclass="olcMdbConfig"

basedn="dc=$(echo $DOMAIN | sed 's/^\.//; s/\.$//; s/\./,dc=/g')"
dc="$(echo $DOMAIN | sed 's/^\.//; s/\..*$//')"
organization="${ORGANIZATION:-$DOMAIN}"
adminpass=$(slappasswd -s $PASSWORD)

function init_ldif() {
    local initldif=$(mktemp -t slapadd.XXXXXX)
    cat /usr/share/slapd/slapd.init.ldif > ${initldif}

    sed -i -e "s|@BACKEND@|$backend|g" ${initldif}
    sed -i -e "s|@BACKENDOBJECTCLASS@|$backendobjectclass|g" ${initldif}
    sed -i -e "s|@BACKENDOPTIONS@|$backendoptions|g" ${initldif}
    sed -i -e "s|@SUFFIX@|$basedn|g" ${initldif}
    sed -i -e "s|@PASSWORD@|$adminpass|g" ${initldif}

    slapadd -F "${SLAPD_CONF}" -l ${initldif} -b "cn=config"

    rm -f ${initldif}
}

function init_base() {
    local initldif=`mktemp -t slapadd.XXXXXX`
    cat <<-EOF > "${initldif}"
		dn: $basedn
		objectClass: top
		objectClass: dcObject
		objectClass: organization
		o: $organization
		dc: $dc

		dn: cn=admin,$basedn
		objectClass: simpleSecurityObject
		objectClass: organizationalRole
		cn: admin
		description: LDAP administrator
		userPassword: $adminpass
	EOF

    slapadd -F "${SLAPD_CONF}" -b "${basedn}" -l ${initldif}

    rm -f ${initldif}
}

function initialize_ldap() {
    mkdir -p ${SLAPD_CONF} /var/lib/ldap /var/run/slapd
    if ! [[ -e ${SLAPD_CONF}/ldap.lock ]]; then
        rm -rf /var/lib/ldap/* /var/run/slapd/* ${SLAPD_CONF}/*
        init_ldif
        init_base
        touch ${SLAPD_CONF}/ldap.lock
    fi

    chown -R openldap:openldap /var/lib/ldap /var/run/slapd ${SLAPD_CONF}

    service slapd start
}

function client_config() {
    if ! [[ -e /etc/apache2/apache.lock ]]; then
        touch /etc/apache2/apache.lock
        sed -i 's/dc=example,dc=com/'$basedn'/g' /etc/phpldapadmin/config.php
        sed -i 's/80/9580/g' /etc/apache2/ports.conf
    fi
    service apache2 start
}

initialize_ldap
client_config

while true; do
    tail -f /dev/null
done
