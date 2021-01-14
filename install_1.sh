  mkdir -p /root/.config/composer
  echo '{
         "http-basic": {
             "repo.magento.com": {
                 "username": "e6662d0a8aa8412026493109d81cb61d",
                 "password": "8eb3fcfb4200d7b713efb86d2944ceeb"
             }
         }
   }' >  /root/.config/composer/auth.json
  
  groupadd clp
  useradd --create-home -g clp test-ssh
  sudo apt-get install vim curl git -y
  #update /etc/php/7.4/fpm/pool.d/www.conf and /etc/nginx/nginx.conf to use test-ssh and clp
  
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
  mysql -u root
  cd /var/www/html
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  composer self-update 1.9.3
  composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2
  echo '{
      "http-basic": {
          "repo.magento.com": {
              "username": "e6662d0a8aa8412026493109d81cb61d",
              "password": "8eb3fcfb4200d7b713efb86d2944ceeb"
          }
      }
  }' >  /root/.config/composer/auth.json
  composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2
  chown -R www-data:www-data /var/www/html/magento2/
  find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
  find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
  chown -R www-data:www-data .
  chmod a+x bin/magento
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
  sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
  find /etc/nginx/
  find /etc/ssl/
  systemctl enable elasticsearch.service
  systemctl enable nginx.service
  systemctl enable redis-server.service
  systemctl enable rabbitmq-server.service
  systemctl enable mysql.service
  systemctl restart elasticsearch.service
  systemctl restart nginx.service
  systemctl restart redis-server.service
  systemctl restart rabbitmq-server.service
  systemctl restart mysql.service
  mysql -u magento -pmagento magento
  cd /var/www/html/magento2
  ls -lrt
  chown -R www-data:www-data /var/www/html/magento2/
  find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
  find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
  chown -R www-data:www-data .
  chmod a+x bin/magento
  systemctl restart php7.4-fpm.service
  systemctl restart nginx.service
  rm /etc/nginx/sites-available/default
  rm /etc/nginx/sites-enabled/default
  vim /etc/nginx/sites-enabled/magento.conf
  vim /etc/nginx/snippets/ssl-params.conf
  ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/
  mv /etc/nginx/sites-enabled/magento.conf /etc/nginx/sites-available/magento.conf
  cd /var/www/html/magento2
  systemctl restart php7.4-fpm.service
  systemctl restart nginx.service
  vim /etc/varnish/default.vcl
  cd /var/www/html/magento2
  chown -R www-data:www-data /var/www/html/magento2/
  find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
  find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
  chown -R www-data:www-data .
  chmod a+x bin/magento
  systemctl restart php7.4-fpm.service
  systemctl restart nginx.service
  bin/magento setup:install --base-url=https://magento.example.com --db-host=localhost --db-name=magento --db-user=magento --db-password=magento --backend-frontname=admin --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone='America/Chicago' --use-rewrites=1
  systemctl restart php7.4-fpm.service
  systemctl restart nginx.service
  systemctl restart varnish.service
  netstat -plant
  apt install net-tools -y
  netstat -plant
  vim /etc/varnish/default.vcl
  vim /etc/hosts
  systemctl restart php7.4-fpm.service
  systemctl restart nginx.service
  systemctl restart varnish.service
  php bin/magento cache:flush
  php bin/magento cache:clean
  curl -k -L -i https://magento.example.com/health_check.php
  curl -k -L -i http://magento.example.com:8080/health_check.php
  curl -k -L -i http://magento.example.com:80/health_check.php
  php bin/magento module:disable Magento_TwoFactorAuth
  bin/magento setup:config:set --amqp-host="localhost" --amqp-port="5672"  --amqp-user="guest" --amqp-password="guest"  --amqp-virtualhost='/'
  bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=0
  bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1
  bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-log-level=4 --session-save-redis-db=2
  mkdir -p /var/www/html/magento2/var/composer_home
  echo '{
    "http-basic": {
        "repo.magento.com": {
            "username": "e6662d0a8aa8412026493109d81cb61d",
            "password": "8eb3fcfb4200d7b713efb86d2944ceeb"
        }
    }
}' > /var/www/html/magento2/var/composer_home/auth.json
  php bin/magento sampledata:deploy
  bin/magento setup:install --base-url=https://magento.example.com --db-host=localhost --db-name=magento --db-user=magento --db-password=magento --backend-frontname=admin --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone='America/Chicago' --use-rewrites=1 --search-engine=elasticsearch7 --elasticsearch-host=localhost --elasticsearch-port=9200
  php bin/magento cache:flush
  systemctl restart nginx.service
  apt-get install kibana
  less /etc/kibana/kibana.yml
  vim /etc/kibana/kibana.yml
  systemctl restart kibana.service
  systemctl status kibana.service
  sudo chmod -R 777 var pub app generated
  sudo php bin/magento indexer:reindex
  sudo php bin/magento setup:upgrade
  sudo php bin/magento setup:di:compile
  sudo php bin/magento setup:static-content:deploy -f
  sudo php bin/magento indexer:reindex
  sudo php bin/magento cache:flush
  sudo php bin/magento cache:clean
  sudo php bin/magento module:disable Magento_TwoFactorAuth
  sudo php bin/magento setup:upgrade
  sudo php bin/magento setup:di:compile
  sudo chmod -R 777 var pub app generated
  php bin/magento sampledata:deploy
  php bin/magento  setup:upgrade
