# Dockerizing Couchdb 1.6
FROM quay.io/inok/baseimage

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ utopic nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.7.12-1~utopic

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/var/cache/nginx"]
VOLUME ["/data"]

CMD ["nginx","-c","/data/nginx.conf" ,"-g", "daemon off;"]
