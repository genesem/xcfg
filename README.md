xcfg
====

Simple shell scripts to manage ~nginx virtual hosts~ under debian/ubuntu platforms.

####Install:
*First you need to download it and set permission to run under the linux box:*
```
wget https://raw.githubusercontent.com/genesem/xcfg/master/mksite.sh
chmod 766 mksite.sh
```
*or in single line:*
```wget https://raw.githubusercontent.com/genesem/xcfg/master/mksite.sh && chmod 766 mksite.sh
```


####Usage:
Run the script with the domain name as single parameter.
Nginx should be installed properly.

```
./mksite.sh your-domain-name.tld

```
*exampe:* ```./mksite.sh realblog.org```




