# Dockerizing Couchdb 1.6
FROM quay.io/inok/baseimage

#install CouchDB  
# http://www.ubuntuupdates.org/package/core/utopic/universe/base/couchdb
RUN apt-get update && \
    apt-get install -y couchdb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Define mountable directories.
VOLUME ["/var/lib/couchdb"]

CMD ["couchdb"]
