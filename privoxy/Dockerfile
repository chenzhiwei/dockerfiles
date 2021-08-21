FROM docker.io/library/alpine:latest

RUN apk add --no-cache privoxy
RUN echo 'listen-address 0.0.0.0:8118' > /etc/privoxy/config

CMD ["privoxy", "--no-daemon", "--user", "privoxy", "/etc/privoxy/config"]
