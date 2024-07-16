# FROM alpine:3.20
FROM ubuntu:22.04
# FROM certbot/certbot

RUN set -xe && \
    apk update && \
    apk upgrade && \
    apk add bash certbot && \
    rm -rf /var/cache/apk/*

WORKDIR /

COPY scripts/generate-cert.sh scripts/generate-cert.sh
COPY scripts/renew-cert.sh scripts/renew-cert.sh

# CMD certbot certonly --standalone --email $DOMAIN_EMAIL -d $DOMAIN_URL --cert-name=certfolder --key-type rsa --agree-tos --dry-run