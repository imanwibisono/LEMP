#!/bin/bash

# install nginx dan php
sudo apt update 
sudo apt install -y nginx
sudo apt install -y php7.2-fpm php-mysql
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cat <<EOF > /etc/nginx/sites-available/default
server {
	listen 80 default_server;
	listen [::]:80 default_server;
	root /var/www/gawai/sosial-media-master;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		try_files \$uri \$uri/ =404;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}
}
EOF
service nginx restart
