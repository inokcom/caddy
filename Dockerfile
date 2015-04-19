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

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y libuv-dev libyaml-dev libssl-dev cmake git build-essential

WORKDIR /tmp
RUN git clone https://github.com/kazuho/h2o.git
WORKDIR /tmp/h2o
RUN git submodule update --init --recursive
RUN cmake .
RUN make h2o 
RUN mv /tmp/h2o/h2o /usr/sbin/h2o
RUN mv /tmp/h2o/examples /etc/h2o
RUN mkdir /var/www
RUN sed -ri 's/examples\/doc_root/\/var\/www/g' /etc/h2o/h2o.conf
RUN sed -ri 's/8080/80/g' /etc/h2o/h2o.conf

RUN rm -rf /tmp/h2o

# Define mountable directories.
VOLUME ["/etc/h2o", "/var/www"]

CMD ["h2o","-c","/etc/h2o/h2o.conf"]

