FROM ptipd/uin-base-ubuntu:18.04

RUN printf "Build of ptipd/uin-devs-ubuntu:18.04-apache2-php7, date: %s\n" `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    #
    # install web server and php:
    apt-get -y update && \
    apt-get -y install --no-install-recommends apache2 software-properties-common git curl wput gpg-agent && \
    add-apt-repository ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
        apt-get -y install --no-install-recommends libapache2-mod-php7.3 \
        php7.3 php7.3-intl php7.3-gd php7.3-curl php7.3-ldap php7.3-mysql php7.3-sqlite3 && \
    #
    # prepare apache settings:
    #
    # prepare sample web:
    #
    # cleanup:
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY base/entpoint.sh /app

EXPOSE 80
STOPSIGNAL SIGWINCH

ENTRYPOINT /app
