FROM ptipd/uin-base-ubuntu:1.5_18.04

ARG CFG_ID
ARG APP_BUILD

RUN printf "Build of ${APP_BUILD}, date: %s\n" `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    #
    # install web server and php:
    apt-get -y update && \
    apt-get -y install --no-install-recommends apache2 software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
        apt-get -y install --no-install-recommends libapache2-mod-php7.4 \
        php7.4 php7.4-intl php7.4-gd php7.4-curl php7.4-ldap php7.4-mysql php7.4-sqlite3 \
        php7.4-xml php7.4-xsl php7.4-soap php7.4-xmlwriter php7.4-xmlrpc php7.4-pspell php7.4-json \
        php7.4-readline php7.4-zip php7.4-bz2 php7.4-mbstring php7.4-imap php7.4-snmp && \
    #
    # prepare custom apache settings:
    groupadd -g ${CFG_ID} cfg && \
    useradd -u ${CFG_ID} -g cfg -s /usr/sbin/nologin -d /opt cfg && \
    sed -i 's/80/0.0.0.0:80/' /etc/apache2/ports.conf && \
    sed -i 's/443/0.0.0.0:443/' /etc/apache2/ports.conf && \
    a2enmod rewrite headers && \
    echo "#!/bin/sh\n\
set -e\n\
rm -f /run/apache2/apache2.pid\n\
exec apache2ctl -DFOREGROUND" > /app && \
    chmod 750 /app && \
    #
    # cleanup:
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc/* /usr/share/man/* && \
    rm -f /var/log/*log /var/log/apache2/*log var/log/apt/*log

EXPOSE 80
STOPSIGNAL SIGWINCH

ENTRYPOINT /app
