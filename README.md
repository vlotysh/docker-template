# Docker template for new projects

## Description

In this repository you can see minimum required soft for web dev:

## Features

* PHP 7.1 with modules:

```
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
hash
iconv
imagick
intl
json
libxml
mbstring
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
SPL
sqlite3
standard
tokenizer
xdebug
xml
xmlreader
xmlwriter
Zend OPcache
zlib
Xdebug
Zend OPcache
```

* Nginx
* Mysql 5.7
* Redis
* Node 8.4, npm 5.4
* Elasticsearch
* Customized nginx file
* Customized PHP ini file
* Easy to extend

**Mysql credentials**

```
host: mysql
post: 3306
username: docker
password: docker
databse: docker
```

You can change it in docker.env file

For use Mysql with DB programms such as Mysql Workbench just use 127.0.0.1 as host

## Installation

1. Config docker-images/nginx-extended/default.conf for your's app dir and index file path
2. Run `docker-compose up` 

## Tips

### Laravel DB config example

.env file

```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=docker
DB_USERNAME=docker
DB_PASSWORD=docker
DB_SOCKET = /tmp/mysql.sock
```
### Symfony DB config example

parameters.yml file

```
database_driver: pdo_mysql
database_host: 'mysql'
database_port: 3306
database_name: 'docker'
database_user: 'docker'
database_password: 'docker'
database_path: 'docker'
```

### PHP modules

You can install anything what you wont in php modules, just add needed modules to `docker-template/docker-images/php-extended/Dockerfile` 
and run `docker-compose build` 

### Access to bash

sudo docker exec -i -t <container_id> /bin/bash