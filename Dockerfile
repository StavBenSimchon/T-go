FROM golang:rc-alpine3.13
# FROM alpine:edge
WORKDIR /app
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
apk add glibc-2.32-r0.apk && rm -f glibc-2.32-r0.apk ca-certificates && \
apk add --no-cache --virtual .build-deps bash gcc gnupg go musl-dev openssl git && \
apk update && apk upgrade && \
CGO_ENABLED=0 go get -ldflags '-s -w -extldflags -static' github.com/go-delve/delve/cmd/dlv

COPY src .
