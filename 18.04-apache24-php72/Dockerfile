ARG OWN_BASE
FROM ${OWN_BASE}

ARG CFG_ID
ARG APP_BUILD

RUN printf "Build of ${APP_BUILD}, date: %s\n" `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    #
    # install web server and php:
    apt-get -y update && \
    apt-get -y install --no-install-recommends apache2 software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
        apt-get -y install --no-install-recommends libapache2-mod-php7.2 \
        php7.2 php7.2-intl php7.2-gd php7.2-curl php7.2-ldap php7.2-mysql php7.2-sqlite3 \
        php7.2-xml php7.2-xsl php7.2-soap php7.2-xmlrpc php7.2-pspell php7.2-recode \
        php7.2-readline php7.2-json php7.2-zip php7.2-bz2 php7.2-mbstring php7.2-imap && \
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
