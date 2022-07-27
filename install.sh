#!/bin/bash

mysql -h db -u magento2 -pmagento2 -e "select count(*) from magento2.customer_entity"

if [ "$?" -ne "0" ]; then
  cd /var/www/html && /var/www/html/bin/magento setup:install \
    --admin-firstname=magento2 \
    --admin-lastname=magento2 \
    --admin-email=magento2@example.com \
    --admin-user=magento2 \
    --admin-password='magento2' \
    --base-url=http://localhost:3010 \
    --backend-frontname=admin \
    --db-host=db \
    --db-name=magento2 \
    --db-user=magento2 \
    --db-password=magento2 \
    --use-rewrites=1 \
    --language=en_US \
    --currency=USD \
    --timezone=America/New_York \
    --use-secure-admin=1 \
    --admin-use-security-key=1 \
    --session-save=files \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-index-prefix=magento2 \
    --key=ef65b71662d62f23a297cc03990a77c8

  bin/magento module:disable Magento_TwoFactorAuth
  bin/magento setup:di:compile
  bin/magento config:set oauth/consumer/enable_integration_as_bearer 1

  for BASH_FILE in /post_install/*.sh; do
    if [ -f "$BASH_FILE" ]; then
      bash "$BASH_FILE"
    fi
  done

  for SQL_FILE in /post_install/*.sql; do
    if [ -f "$SQL_FILE" ]; then
      mysql --host="db" --user="magento2" --database="magento2" --password="magento2" < "$SQL_FILE"
    fi
  done
fi

php-fpm
