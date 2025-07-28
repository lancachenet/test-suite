# hadolint ignore=DL3007
FROM lancachenet/ubuntu-nginx:latest

LABEL org.opencontainers.image.authors="LanCache.Net Team <team@lancache.net>"

SHELL ["/bin/bash", "-c"]

ENV \
WEBUSER=www-data \
LITMUS_HOSTNAME=lancache.lan \
CACHE_DOMAINS_REPO=https://github.com/uklans/cache-domains.git \
CACHE_DOMAINS_BRANCH=master \
NGINX_WORKER_PROCESSES=16

# hadolint ignore=DL3008
RUN <<EOF
  apt-get update
  apt-get install -y ca-certificates git jq --no-install-recommends
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*
EOF

COPY --link overlay/ /

RUN <<EOF
  id -u ${WEBUSER} &> /dev/null || adduser --system --home /var/www/ --no-create-home --shell /bin/false --group --disabled-login ${WEBUSER}
  mkdir -p /etc/nginx/sites-enabled
  rm /etc/nginx/sites-enabled/* /etc/nginx/conf.d/{gzip,openshift_logging}.conf
  chown -R ${WEBUSER}: /var/www/
  chmod 754  /var/log/tallylog
  file=sites-available/10_litmus.conf
  ln -s "/etc/nginx/${file}" "/etc/nginx/${file/available/enabled}"
EOF

VOLUME ["/var/www/litmus"]
EXPOSE 80
WORKDIR /scripts
