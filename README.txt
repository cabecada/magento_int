
assignment:
Magento 2 Installation and Configuration
-Create a new free account in AWS to use AWS services
-Launch an Amazon EC2 instance Debian Buster and install the following components (PHP 7.4, Mysql 8, NGINX)
-Install latest Magento 2 via composer with Sample Data and Elasticsearch under the domain "test.mgt.com"
-Install Redis-Server and configure Magento to store the cache files and the sessions into Redis instead of the file system
-Change the ownership of all files to user "test-ssh" and group "clp"
-Configure NGINX to run as user "test-ssh"
-Create a PHP-FPM pool that runs as user "test-ssh" and group "clp" and use this pool in your NGINX vhost
-Configure PHPMyAdmin
-Redirect in nginx HTTP to HTTPS and set up all store urls to HTTPS with a self-signed certificate.
-Install varnish and configure varnish with Magento.
