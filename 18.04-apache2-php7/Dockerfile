FROM ptipd/uin-base-ubuntu:18.04

MAINTAINER luxmile <luxmile@gmail.com>

RUN printf "Build of ptipd/uin-base-ubuntu:18.04, date: %s\n" `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    #
    # install web server and php:
    apt-get install -y apache2 software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get install -y libapache2-mod-php7.3 php7.3 php7.3-intl php7.3-gd php7.3-curl php7.3-ldap php7.3-mysql php7.3-sqlite3 && \
    #
    # prepare apache settings:
    #
    # prepare sample web:
    true

COPY base/entpoint.sh /app

EXPOSE 80

ENTRYPOINT /app
