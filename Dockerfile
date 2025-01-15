FROM mariadb:latest
LABEL author="andrevs@gmail.com"
LABEL version="1.0"
RUN apt update \
  && apt install curl locales openjdk-8-jdk -y \
  && export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
  && curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup \
  && bash mariadb_repo_setup --mariadb-server-version=10.7 \
  && apt update \
  && apt-get install mariadb-plugin-connect -y \
  && echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale \
  && locale-gen "en_US.UTF-8" \
  && curl -O https://packages.microsoft.com/debian/11/prod/pool/main/m/msodbcsql18/msodbcsql18_18.0.1.1-1_amd64.deb \
  && ACCEPT_EULA=Y dpkg -i msodbcsql18_18.0.1.1-1_amd64.deb \
  && rm msodbcsql18_18.0.1.1-1_amd64.deb \
  && apt-get -qq clean
  #&& apt upgrade -y
  
#COPY ./jars/wrapper/* /usr/lib/mysql/plugin/
#COPY ./jars/jdbc/* /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/ext/
COPY ./connect.cnf /etc/mysql/mariadb.conf.d/connect.cnf
RUN chmod 0444 /etc/mysql/mariadb.conf.d/connect.cnf
VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["mysqld"]
