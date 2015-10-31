# Dockerizing Caddy hhtp2 server
# https://github.com/mholt/caddy
# https://github.com/Zenithar/nano-caddy
FROM alpine:latest

RUN apk add --update openssh-client git tar

RUN mkdir /caddysrc \
&& curl -sL -o /caddysrc/caddy_linux_amd64.tar.gz "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git" \
&& tar -xf /caddysrc/caddy_linux_amd64.tar.gz -C /caddysrc \
&& mv /caddysrc/caddy /usr/bin/caddy \
&& chmod 755 /usr/bin/caddy \
&& rm -rf /caddysrc

VOLUME     [ "/caddy" ]
WORKDIR    [ "/caddy" ]
ENTRYPOINT [ "/bin/caddy" ]
CMD        [ "-conf='/caddy/inok_web.cfg" ]
