#!/usr/bin/env bash

INTERVAL=${INTERVAL:-120}
DOMAIN=${DOMAIN:-example.com}
API_TOKEN=${CF_API_TOKEN:-token}
ZONE_ID=${CF_ZONE_ID:-zone_id}
DNS_RECORD_ID=${CF_DNS_RECORD_ID:-record_id}

function get_dns_ip() {
    curl -s https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
        -H "Authorization: Bearer $API_TOKEN" | jq -r .result.content
}

function get_my_ip() {
    local ip=$(curl -s cip.cc | awk '{print $NF;exit}')
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi

    ip=$(curl -s ip.sb)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi

    ip=$(curl -s ip.sg)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi

    ip=$(curl -s ipinfo.io/ip)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi

    ip=$(curl -s ipecho.net/plain)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi

    ip=$(curl -s icanhazip.com)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $ip
        return
    fi
}

function cloudflare_update_ip() {
    local ip=$1
    curl -s https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
        -X PATCH \
        -H "Authorization: Bearer $API_TOKEN" \
        -d '{
          "content": "'$ip'",
          "name": "'$DOMAIN'",
          "type": "A"
        }'
    echo
}

while :; do
    sleep $INTERVAL
    myip=$(get_my_ip)
    dnsip=$(get_dns_ip)
    if [[ "$myip" != "$dnsip" ]] && [[ "$myip" != "" ]]; then
        echo "$(date --rfc-3339=seconds) Update $DOMAIN to $myip"
        cloudflare_update_ip $myip
    fi
done
