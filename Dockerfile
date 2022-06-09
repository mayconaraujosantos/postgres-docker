FROM postgres:13-alpine 
ADD ./initdb.d /docker-entrypoint-initdb.d/
