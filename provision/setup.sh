#!/bin/bash

echo "Provisioning virtual machine..."
sudo apt-get install python-software-properties build-essential -y > /dev/null 2>&1
sudo add-apt-repository ppa:ondrej/php5 -y > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1

echo "Installing Nginx"
sudo apt-get install nginx -y > /dev/null 2>&1

echo "Configuring Nginx"
for file in ./provision/config/* ; 
do 
sudo cp /home/vagrant/provision/config/$(basename "$file") /etc/nginx/sites-available/; 
sudo ln -s /etc/nginx/sites-available/$(basename "$file") /etc/nginx/sites-enabled/;
done
sudo rm -rf /etc/nginx/sites-available/default
sudo service nginx restart > /dev/null 2>&1

echo "Installing PHP"
sudo apt-get install php5-cli php5-fpm php5-common php5-dev -y > /dev/null 2>&1

echo "Installing PHP extensions"
sudo apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql php5-sqlite -y > /dev/null 2>&1

echo "Installing MySQL"
sudo apt-get install debconf-utils -y > /dev/null 2>&1
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root" 
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
sudo apt-get install mysql-server -y > /dev/null 2>&1

echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1 
sudo mv composer.phar /usr/local/bin/composer

echo "Installing Git"
sudo apt-get install git -y > /dev/null 2>&1

echo "Installing NodeJS"
sudo apt-get install nodejs -y > /dev/null 2>&1
ln -s /usr/bin/nodejs /usr/bin/node

echo "Installing Node Packaged Modules"
sudo apt-get install npm -y > /dev/null 2>&1

echo "Installing Bower"
sudo npm install -g bower -y > /dev/null 2>&1

echo "Finished provisioning."