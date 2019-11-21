xcfg
====

Simple shell scripts to manage nginx virtual hosts under debian/ubuntu platforms.

#### Install:
*First you need to download it and set permission to run under the linux box:*
```
wget https://raw.githubusercontent.com/genesem/xcfg/master/mksite.sh
chmod 766 mksite.sh
```

or in single line:

```
wget https://raw.githubusercontent.com/genesem/xcfg/master/mksite.sh && chmod 766 mksite.sh
```


#### Usage:
Run the script with the domain name as single parameter.
Nginx should be installed properly.

```
./mksite.sh your-domain-name.tld

```
*exampe:* ```./mksite.sh realblog.org```

-----
#### What it does and how:
1. It creates directory structure for your new website in the `/var/www` as base folder.
It uses command: `mkdir -p -v /var/www/$1/{htdocs,logs}`.
So you having www root of your site in the `/var/www/sitename.tld/htdocs/` and error log file in the `/var/www/sitename.ext/logs/`.
1. It makes stub `index.html` file in the www root of this new web site.
1. Change ownership of that: `chown -R www-data:www-data` 
1. New site config is placed to `/etc/nginx/sites-available/sitename.ext` file. Your can review this config by command:`nano /etc/nginx/sites-available/sitename.ext`.
