#!/bin/sh

PASSWORD=${PASSWORD:-admin}
ORG=${ORG:-org}

SLAPD_CONF=/etc/openldap/slapd.d

basedn="dc=$(echo $ORG | sed 's/^\.//; s/\.$//; s/\./,dc=/g')"
dc="$(echo $ORG | sed 's/^\.//; s/\..*$//')"
organization=${ORG}
adminpass=$(slappasswd -s $PASSWORD)

function init_ldif() {
    local initldif=$(mktemp -t slapadd.XXXXXX)
    cat /etc/openldap/slapd.ldif > ${initldif}

    sed -i -e "s|dc=my-domain,dc=com|$basedn|g" ${initldif}
    sed -i -e "s|cn=Manager|cn=admin|g" ${initldif}
    sed -i -e "s|secret|$adminpass|g" ${initldif}

    slapadd -F "${SLAPD_CONF}" -l ${initldif} -b "cn=config"

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

init_ldif
init_base

slapd -d 0 -u ldap -g ldap
