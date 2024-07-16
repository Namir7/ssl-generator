FROM alpine:3.20

RUN set -xe && \
    apk update && \
    apk upgrade && \
    apk add bash certbot && \
    rm -rf /var/cache/apk/*

