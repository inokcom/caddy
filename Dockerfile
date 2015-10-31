# Dockerizing Caddy hhtp2 server
# https://github.com/mholt/caddy
# https://github.com/Zenithar/nano-caddy
FROM alpine:edge

ENV GOPATH /go
ENV CADDY_TAG v0.7.5

RUN apk add --update musl \
    && apk add -t build-tools go mercurial git \
    && mkdir /go \
    && cd /go \
    && go get -tags=$CADDY_TAG github.com/mholt/caddy \
    && mv $GOPATH/bin/caddy /bin \
    && mkdir /caddy \
    && apk del --purge build-tools \
    && rm -rf /go /var/cache/apk/*

VOLUME     [ "/caddy" ]
WORKDIR    [ "/caddy" ]
ENTRYPOINT [ "/bin/caddy" ]
CMD        [ "-conf='/caddy/inok_web.cfg" ]
