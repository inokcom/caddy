# Dockerizing Couchdb 1.6
FROM quay.io/inok/baseimage

#install CouchDB  
# http://www.ubuntuupdates.org/package/core/utopic/universe/base/couchdb
RUN apt-get update && \
    apt-get install -y couchdb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/couchdb    
# Define mountable directories.
VOLUME ["/data"]

CMD ["couchdb","-a","/data/couchdb.ini"]
