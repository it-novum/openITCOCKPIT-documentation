# Update Debian Bullseye (11) to Debian Bookworm (12)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Debian Bullseye System to Debian Bookworm.

##  Requirements
 -  openITCOCKPIT in version 4.x
 -  No packages containing `lxd`


## Removal of all `lxd` packages
If you have `lxd` packages installed on your system, they must be removed first. You can check this with the command
```
apt list --installed | grep lxd
```

If any `lxd` packages where found, remove tham like so
```
apt -y remove lxd*
```

## Installation of all updates
Before you start updating Debian, please make sure that all available updates have been installed.

```
apt update
apt -y full-upgrade
```

## Stop PHP-FPM service
```
systemctl stop php7.4-fpm.service
```

## Detect openITCOCKPIT packages
First all installed packages of openITCOCKPIT are determined and saved in the variable `openitcockpit_upd`.
```
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

## Change package sources
Now the package sources can be changed to the next Debian release
```
echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list

sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list.d/*.list
```

## Upgrade durchführen
Now the actual upgrade from Debian 11 to 12 starts.
```
apt update
apt -y full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml
```

### Update PHP
Now all PHP packages will be updated.
```
systemctl stop php7.4-fpm.service
```

```
dpkg -l | awk '/php7.4/ { print $2}' | xargs apt-get purge -y
rm -rf /etc/php/7.4/
```
### Set timezone in php.ini

```
date.timezone = Europe/Berlin
```

### PHP FPM (re-)start
```
systemctl restart php8.2-fpm.service
```

### Update configuration
In the last step, all configuration files are updated and regenerated if necessary.

#### openITCOCKPIT Master
If you are running the update on an openITCOCKPIT master system, use the following command
```
openitcockpit-update --cc
```

#### openITCOCKPIT Satellite
For openITCOCKPIT Satellite execute
```
/opt/openitc/frontend/UPDATE.sh
```

A restart of the system is recommended to complete the update
```
reboot
```
