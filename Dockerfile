FROM postgres:14-alpine 
ADD ./initdb.d /docker-entrypoint-initdb.d/
