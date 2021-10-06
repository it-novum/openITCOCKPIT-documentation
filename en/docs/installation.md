# Installation

The installation of openITCOCKPIT is done via the package manager of the Linux distribution.

## Supported operating systems

- Ubuntu
    - Focal (20.04)
    - Bionic (18.04)
- Debian
    - Buster (10)

## arm64 / Raspberry Pi
openITCOCKPIT and all components are also available for arm64 processors and the Raspberry Pi.

The installation does not differ from a 64-bit system with AMD or Intel processor. If you want to use a Raspberry Pi, the [64-bit version of Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_arm64/images/) must be used.

## Include repository
### Ubuntu

```
add-apt-repository universe
apt-get install apt-transport-https curl gnupg2 ca-certificates
curl https://packages.openitcockpit.io/repokey.txt | apt-key add -

echo "deb https://packages.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

### Debian

```
deb http://deb.debian.org/debian/ buster main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
```

```
apt-get install apt-transport-https curl gnupg2 ca-certificates
curl https://packages.openitcockpit.io/repokey.txt | apt-key add -

echo "deb https://packages.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

## Installing openITCOCKPIT
The actual installation is performed by the following command:
```
apt-get install openitcockpit
```

After this, the basic configuration has to be done. In this step, for example, the first user for the web interface is created. Afterwards the rest of the configuration is done via the openITCOCKPIT web interface.

```
/opt/openitc/frontend/SETUP.sh
```

## Registration of the openITCOCKPIT Community Edition

This step is voluntary and optional. The functionality of openITCOCKPIT can be extended by modules. Some of them are available for free. To get access to the community modules you have to enter the openITCOCKPIT community key first. To do this, call 'System -> Registration' and insert the following key: 'e5aef99e-817b-0ff5-3f0e-140c1f342792'. 

No further information is needed.

![Valid license](/images/openITCOCKPIT-v4-valid-license.png){ align=center }

After successful activation the community modules are available under 'System Tools -> Package Manager'.

## Installation of phpMyAdmin

This step is optional. openITCOCKPIT uses a MySQL database. Normally the end user has no contact points with the database. Experienced users can install the tool `phpMyAdmin` to manage the database.

```
apt-get install phpmyadmin
```

The configuration of the web server will be done automatically. The phpMyAdmin interface can be reached afterwards via `https://xxx.xxx.xxx.xxx/phpmyadmin`.

## System requirements

- Ubuntu Linux 64 bit (20.04 LTS "Focal" and 18.04 LTS "Bionic"), Debian Linux 64 bit (11 "Bullseye") and Debian Linux 64 bit (10 "Buster")
- 2 CPU cores (x86-64 or arm64)
- 2 GB RAM
- 40 GB free hard disk space