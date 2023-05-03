FROM mariadb:latest

RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/IliyanID/WebHook-CI-CD-Server.git
# Copy the SQL file to the container's /docker-entrypoint-initdb.d directory
RUN mv /WebHook-CI-CD-Server/database/*.sql /docker-entrypoint-initdb.d

EXPOSE 3306
