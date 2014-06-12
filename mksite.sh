#!/bin/bash

##
## Make website for nginx by genesem
##
## For more information please visit: https://github.com/genesem/xcfg
##

if [ -z "$1" ]
then
cat <<-ENDX
	 Make website for nginx by genesem.
	 Usage: `basename $0` domain_name.tld
	 see: https://github.com/genesem/xcfg
ENDX
	exit 85
fi  

echo "mk dir's"
mkdir -p -v /var/www/$1/{htdocs,logs}

echo "create stub file"
cat > /var/www/$1/htdocs/index.html <<-ENDX

<html lang="en">
<head><title>Welcome to the $1 website</title>
<style>
body {
padding-top: 50px;
padding:20px;
background-image: url(data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/wAALCABAAEABAREA/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/9oACAEBAAA/APrWV48i2t327cZ2jpTNY1O308QpGnmzucKo70tu1zIhlu05x8q4plqt0lr5lyQjMcAZqvDaBLpr6/k3LH/q09Pf61buLiG505xGWh3jGTxioNLg06ysRHZsrkgFpf7x9c1Hd2kl1c25M7CBfmZQepq/G8NvGWljAkYAH1qNXtFu9zQN5ijduYVW/tO9uNRKrYt9lXgyMcD/ADxToUa/1F7qV2EMXyonb3q6ypJJvYfIOfaoo4xfyNG0e2JDj61DqP2C38uzjKxjptXinzFltY7ayiJJ4LHtSWUMqwtealKvmkZwp4H0qGTzL6RZomHlA9u9XJw1zEltA3lRj/WMOCRTQ8UqvaWUqkjhiDmmX11DplittIxeU9gOTTNCurq5t3kmtzAh+7k8mqdvp6prD3dzL5sznEanoozW1cyPbWZeJQ8v8I/rVLUHiSeK1kcF3GSo9Kt3xitdPBIEagcgVFC4urVY4RtVx8z+oplsLPTwy2m07eGPU59zUNlbXN3fPeXRCqBhV9KtXd5HDakoN2DgAdKZpsBmnF1OmHx8oz0pl3K73DQwEM+cYJ4Bp1vZwyF7tzukPO72qC/hfWP9FjnZEBG9l9PSrHmQRXCadali6IAT2A+tOt44LdJFZVPzZY9cVB9o/tBntrYttBKucdKMC1IsYI97gZJPOKuLm1iOW/eMKqpFaadEbiWTErtlmc9SelV9Q1Kea+Gl6db4jAxLIeAo9B/n/EW5rq10XTC5HOM8cljVLQYLiRJ9RvP3UkvzbPQdv0q/ZRRPbyFTuJ6k+lOs5IYUZYArMe49apabOIvtMk8T+ZuJ561ahaOY/b5ZGWJV4T/61UY7cazeLd3aFLWI4ijP8RHc1oWMXnr5iNtVupxziqd9d211rMNlDGJfJ+Z2ByFP+f51ZnSS5mNvHHtj/iNJqc8Fjo8sMbbGKFRjrk1DoX+iaWCIyz4zgnn9adpguGnku7zCBz8qEdB/9ep7tojIA7BU9D3NLI7iAyuBHBGvB6ZpiKJ18uFikQ4JHHFQRraWVwY7cFpX6tgZPFXJpWttNeVAGl7A9yapaba3V8qvfxrGc5Kg5q5cSRWdyBlT8pAWmWaXF073F5tijB+RQe3vUXk2V/d5jm3+S3QHgGpr+2e4AWWUJaoMsPWv/9k=);
background-color: #0094d0;
}  
</style>
<meta charset="utf-8">
</head><body>
<h1>Welcome to the $1 website</h1>
<hr/>
<h2>$1 website is working.</h2>
<hr/>
<p>This is stub page with standard "lorem ipsum" stub.</p>
<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
<hr/>
<p>&copy; 2014 <a href="http://jetstat.com/">jetstat.com</a></p>
</body>
</html>

ENDX

echo "change ownership for $1"
chown -R www-data:www-data /var/www/$1


echo "make site config: /etc/nginx/sites-a*/$1"
cat > /etc/nginx/sites-available/$1 <<-ENDX

server {
    listen 80;
    server_name www.$1 $1;
    root /var/www/$1/htdocs;
    index index.html index.php;
    client_max_body_size 6M;
    access_log  off;
    error_log  /var/www/$1/logs/error.log notice;


#This is catch all to /index.php and used in most php cms like codeigniter.
#location / {
#	try_files $uri $uri/ /index.php;
#        include /etc/nginx/proxy_params;
#	}

#This block is used to process php via php5-fpm.sock
#location ~ \.php$ {
#  try_files $uri =404;
#  fastcgi_split_path_info ^(.+.php)(/.+)$;
#  fastcgi_pass unix:/var/run/php5-fpm.sock;  
#  fastcgi_index index.php; include fastcgi_params;
#  fastcgi_read_timeout 120;
#}


#Exatra configs
#include /etc/nginx/security; 
#include /etc/nginx/main_rules;

}

ENDX

echo "make link to the site: /etc/nginx-sites-e*/"
ln -s /etc/nginx/sites-a*/$1 /etc/nginx/sites-e*/

service nginx reload

echo ""
echo "$1 website was created, don't forget to set DNS records. And read the docs at:"
echo ""


cat <<-ENDX

 $1 website was created.
 Don't forget to set DNS records for your new website.
 Please read the docs at:
 https://github.com/genesem/xcfg

ENDX
