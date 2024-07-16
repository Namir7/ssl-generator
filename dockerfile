# FROM alpine:3.20
FROM ubuntu:22.04

# RUN set -xe && \
#     apk update && \
#     apk upgrade && \
#     apk add bash certbot && \
#     rm -rf /var/cache/apk/*

# RUN apk add --no-cache su-exec
# RUN set -ex && apk --no-cache add sudo

RUN apt-get update
RUN apt-get -y install certbot

WORKDIR /

COPY scripts/generate-cert.sh scripts/generate-cert.sh
COPY scripts/renew-cert.sh scripts/renew-cert.sh
