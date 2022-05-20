FROM mariadb:10.7
LABEL author="andrevs@gmail.com"
LABEL version="1.0"
RUN apt update \
  && apt install curl openjdk-8-jdk -y \
  && export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
  && curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup \
  && bash mariadb_repo_setup --mariadb-server-version=10.7 \
  && apt update && apt upgrade -y \
  && apt-get install mariadb-plugin-connect -y  

#COPY ./jars/wrapper/* /usr/lib/mysql/plugin/
#COPY ./jars/jdbc/* /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/ext/
COPY ./connect.cnf /etc/mysql/mariadb.conf.d/connect.cnf
RUN chmod 0444 /etc/mysql/mariadb.conf.d/connect.cnf
VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["mysqld"]
