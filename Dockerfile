FROM markoshust/magento-php:8.1-fpm
COPY ./auth.json /var/www/.composer/auth.json

RUN cd /var/www && composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.5 /var/www/html
COPY ./install.sh /var/www/install.sh
CMD ["/var/www/install.sh"]
