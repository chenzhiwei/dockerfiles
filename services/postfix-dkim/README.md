# Postfix

A simple SMTP Server build with Postfix + OpenDKIM + SASL authentication support.


## Configuration

* DOMAIN, the right part of `@` in email address.
* USERNAME, the SMTP server username.
* PASSWORD, the SMTP server password.
* SELECTOR, the DKIM selector which used in DKIM DNS TXT record, default value is `mail`.
* TLS_KEY_FILE, the SMTP server tls key file, default to `smtp.{DOMAIN}.key`
* TLS_CERT_FILE, the SMTP server tls certificate file, default to `smtp.{DOMAIN}.crt`
* DKIM_KEY_FILE, the DKIM private key file, default to `{SELECTOR}.private`


## Generate DKIM private file

```
DOMAIN=youya.org
SELECTOR=mail

docker run --rm -v $(pwd):/data docker.io/siji/postfix:latest --restrict --bits=2048 --domain=${DOMAIN} --selector=${SELECTOR} --directory=/data
```

After this command, you will get two files `mail.private` and `mail.txt` in your current directory.

`mail.txt` contains something like `mail._domainkey IN      TXT     ( "v=DKIM1; k=rsa; s=email; "xxx" )`, go to your authoritative DNS server provider dashboard(such as cloudflare) to add a TXT record, the key is `mail._domainkey` and the value is in side the brackets.

`mail.private` will be used in the create container part.


## Generate TLS key and certificate

Suppose your domain is `youya.org` and you want to host the SMTP server under `smtp.youya.org`, then you need to apply a certificate with DNS name `smtp.youya.org`.

* smtp.youya.org.key
* smtp.youya.org.crt

## Simple Use

### Setup DNS records

* Setup SPF record

    key: `@`, value: `v=spf1 a:smtp.youya.org ~all`, record type TXT

* Setup DKIM record

    key: `mail._domainkey`, value: `"v=DKIM1; k=rsa; s=email; "<REPLACE WITH YOUR OWN IN mail.txt>"`, record type TXT

### Start the Postfix container

```
mkdir -p /etc/postfix/secret
cp mail.private /etc/postfix/secret/mail.private
cp smtp.youya.org.key /etc/postfix/secret/smtp.youya.org.key
cp smtp.youya.org.crt /etc/postfix/secret/smtp.youya.org.crt

docker run -d --name postfix -p 587:587 \
    -v /etc/postfix/secret:/etc/postfix/secret \
    -e DOMAIN=youya.org \
    -e USERNAME=your-name \
    -e PASSWORD=your-pass \
    docker.io/siji/postfix:latest
```

### Send the email

Create a file named `email.txt` with following content:

```
From: user@youya.org
To: check-auth@verifier.port25.com
Subject: an example email

Dear Joe,
Welcome to this example email. What a lovely day.
```

Send it:

```
curl -v --ssl --url smtp://smtp.youya.org --mail-from user@youya.org --mail-rcpt check-auth@verifier.port25.com --upload-file email.txt
```

A few seconds later, you will receive an email with title `Authentication Report` and it shows your SMTP server result.
