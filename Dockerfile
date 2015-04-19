# Dockerizing Couchdb 1.6
FROM quay.io/inok/baseimage

#install h2o  
# http://www.ubuntuupdates.org/package/core/utopic/universe/base/couchdb
# RUN apt-get update && \
#     apt-get install -y couchdb && \
#     apt-get clean && \
#      rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/data"]

WORKDIR /tmp 
# WORKDIR /tmp/h2o

RUN apt-get update && \
    apt-get install -y libuv-dev libyaml-dev libssl-dev cmake git build-essential  && \
    git clone https://github.com/kazuho/h2o.git
    cd /tmp/h2o
    git submodule update --init --recursive && \
    cmake . && \
    make h2o  && \
    mv /tmp/h2o/h2o /usr/sbin/h2o && \
    mv /tmp/h2o/examples /etc/h2o && \
    mkdir /var/www && \
    sed -ri 's/examples\/doc_root/\/var\/www/g' /etc/h2o/h2o.conf && \
    sed -ri 's/8080/80/g' /etc/h2o/h2o.conf && \
    rm -rf /tmp/h2o && \
    apt-get clean

# Define mountable directories.
VOLUME ["/etc/h2o", "/var/www"]

CMD ["h2o","-c","/etc/h2o/h2o.conf"]

