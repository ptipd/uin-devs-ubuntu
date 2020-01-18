FROM ptipd/uin-base-ubuntu:18.04

ARG CFG_ID
ARG APP_BUILD

RUN printf "Build of ${APP_BUILD}, date: %s\n" `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \
    #
    # install web server and php:
    apt-get -y update && \
    apt-get -y install --no-install-recommends apache2 software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
        apt-get -y install --no-install-recommends libapache2-mod-php7.3 \
        php7.3 php7.3-intl php7.3-gd php7.3-curl php7.3-ldap php7.3-mysql php7.3-sqlite3 && \
    #
    # prepare custom apache settings:
    groupadd -g ${CFG_ID} cfg && \
    useradd -u ${CFG_ID} -g cfg -s /usr/sbin/nologin -d /opt cfg && \
    sed -i 's/80/0.0.0.0:80/' /etc/apache2/ports.conf && \
    sed -i 's/443/0.0.0.0:443/' /etc/apache2/ports.conf && \
    #
    # cleanup:
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY base/entpoint.sh /app

EXPOSE 80
STOPSIGNAL SIGWINCH

ENTRYPOINT /app
