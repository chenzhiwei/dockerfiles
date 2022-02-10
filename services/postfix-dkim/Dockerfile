FROM docker.io/library/alpine:3.15

RUN apk add --no-cache postfix opendkim opendkim-utils ca-certificates

COPY supervisord.conf /etc/supervisord/supervisord.conf
COPY --from=docker.io/ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/bin/supervisord

COPY mail-docker-config.sh /usr/libexec/mail-docker-config.sh
COPY opendkim/* /etc/opendkim/
COPY postfix/main.cf /etc/postfix/main.cf

CMD ["supervisord", "-c", "/etc/supervisord/supervisord.conf"]
