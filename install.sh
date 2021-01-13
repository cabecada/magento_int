mkdir -p /root/.config/composer
echo '{
    "http-basic": {
        "repo.magento.com": {
            "username": "e6662d0a8aa8412026493109d81cb61d",
            "password": "8eb3fcfb4200d7b713efb86d2944ceeb"
        }
    }
}' >  /root/.config/composer/auth.json



sudo apt-get install vim curl git -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo add-apt-repository ppa:chris-lea/redis-server -y


curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt install elasticsearch nginx mysql-server mysql-client varnish redis-server rabbitmq-server -y
sudo apt install -y php7.4-fpm php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip php7.4-soap php7.4-bcmath
sudo apt install -y php7.4-bcmath php7.4-ctype php7.4-curl php7.4-dom php7.4-gd php7.4-iconv php7.4-intl php7.4-mbstring php7.4-simplexml php7.4-soap php7.4-xsl php7.4-zip php7.4-sockets


systemctl restart elasticsearch.service
systemctl restart nginx.service
systemctl restart redis-server.service
systemctl restart rabbitmq-server.service
systemctl restart mysql.service

systemctl enable elasticsearch.service
systemctl enable nginx.service
systemctl enable redis-server.service
systemctl enable rabbitmq-server.service
systemctl enable mysql.service

mysql -u root < files/magento.sql

cat files/magento.sql

create database magento;
create user 'magento'@'localhost' IDENTIFIED BY 'magento';
GRANT ALL ON magento.* TO 'magento'@'localhost';
flush privileges;



cd /var/www/html
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer self-update 1.9.3
composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2

systemctl restart php7.4-fpm.service

cd /var/www/html/magento2
chown -R www-data:www-data /var/www/html/magento2/
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +

chown -R www-data:www-data .
chmod a+x bin/magento
systemctl restart php7.4-fpm.service
systemctl restart nginx.service



sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048



root@magento:/var/www/html/magento2# cat /etc/nginx/snippets/ssl-params.conf
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
ssl_dhparam /etc/ssl/certs/dhparam.pem;


ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/

systemctl restart php7.4-fpm.service
systemctl restart nginx.service

cd /var/www/html/magento2

bin/magento setup:install \
--base-url=https://magento.example.com \
--db-host=localhost \
--db-name=magento \
--db-user=magento \
--db-password=magento \
--backend-frontname=admin \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD \
--timezone='America/Chicago' \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=localhost \
--elasticsearch-port=9200

rabbitmq
bin/magento setup:config:set --amqp-host="localhost" --amqp-port="5672"  --amqp-user="guest" --amqp-password="guest"  --amqp-virtualhost='/' 

Run the following command for setting up Redis as the default cache:
bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=0

 Run the following command for setting up Redis as the page cache
bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1

Run the following command for setting up Redis as the session cache
bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-log-level=4 --session-save-redis-db=2

echo '{
    "http-basic": {
        "repo.magento.com": {
            "username": "e6662d0a8aa8412026493109d81cb61d",
            "password": "8eb3fcfb4200d7b713efb86d2944ceeb"
        }
    }
}' > /var/www/html/magento2/var/composer_home/auth.json


php bin/magento sampledata:deploy
php bin/magento setup:upgrade



