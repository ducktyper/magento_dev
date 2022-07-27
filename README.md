# Community Magento 2.4.4 for integration developers

Goal: Easily start a new Magento instance with a customized setup and reset

## Setup
Create authentication keys based on https://devdocs.magento.com/guides/v2.4/install-gde/prereq/connect-auth.html
and create auth.json file at the root folder of this repo.

## Run Magento
docker compose up -d

## Reset all
docker compose down -v

## Details
* URL: http://localhost:3010
* Admin URL: http://localhost:3010/admin (username: "magento2", password: "magento2")
* DB: mysql://magento2:magento2@localhost:3301/magento2

## Customize
Add custom `*.sql` and `*.sh` files to the folder `post_install` that run after the Magento installation. For example:
* A bash file contains commands installing new Magento packages
* A SQL file creating an API access key with limited permissions

## Customizing tips
Some setups the developer wants might not be supported by bin/magento command. In this case, suggest creating a SQL file with following steps:
* Login to the running db container `docker compose exec db sh`
* Dump db `MYSQL_PWD=magento2 mysqldump --extended-insert=FALSE --databases magento2 --user magento2 > before.sql`
* Make some changes on the admin UI
* Dump db `MYSQL_PWD=magento2 mysqldump --extended-insert=FALSE --databases magento2 --user magento2 > after.sql`
* Check the changes `diff before.sql after.sql`
* Create the sql file making these changes
