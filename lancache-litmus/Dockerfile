FROM lancachenet/ubuntu-nginx:latest
MAINTAINER LanCache.Net Team <team@lancache.net>

ENV WEBUSER www-data
ENV LITMUS_HOSTNAME lancache.lan
ENV CACHE_DOMAINS_REPO https://github.com/uklans/cache-domains.git
ENV CACHE_DOMAINS_BRANCH master
ENV NGINX_WORKER_PROCESSES 16

RUN apt-get update            ;\
    apt-get install -y jq git

COPY overlay/ /

RUN rm /etc/nginx/sites-enabled/*                                           ;\
    rm /etc/nginx/conf.d/gzip.conf /etc/nginx/conf.d/openshift_logging.conf ;\
    chmod 754  /var/log/tallylog                                            ;\
    id -u ${WEBUSER} &> /dev/null || adduser --system --home /var/www/ --no-create-home --shell /bin/false --group --disabled-login ${WEBUSER} ;\
    chown -R ${WEBUSER}:${WEBUSER} /var/www/                                ;\
    mkdir -p /etc/nginx/sites-enabled	                                    ;\
    ln -s /etc/nginx/sites-available/10_litmus.conf /etc/nginx/sites-enabled/10_litmus.conf

VOLUME ["/var/www/litmus"]

EXPOSE 80

WORKDIR /scripts
