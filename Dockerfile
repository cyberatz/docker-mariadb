FROM mariadb:10.7
LABEL author="andrevs@gmail.com"
LABEL version="1.0"
RUN 
RUN apt update \
  && apt install openjdk-8-jdk -y \
  && export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
  && apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
  && apt install software-properties-common \
  && add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.host.ag/mariadb/repo/10.8/ubuntu focal main' 
  && apt update \
  && apt-get install mariadb-plugin-connect -y 
  

COPY ./jars/wrapper/* /usr/lib/mysql/plugin/
COPY ./jars/jdbc/* /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/ext/
COPY ./connect.cnf /etc/mysql/mariadb.conf.d/connect.cnf
RUN chmod 0444 /etc/mysql/mariadb.conf.d/connect.cnf
VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["mysqld"]
