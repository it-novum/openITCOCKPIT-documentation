# Installation

openITCOCKPIT is installed via the package manager of your respective Linux distribution.

## Supported operating systems

- Ubuntu
    - Focal (20.04)
    - Bionic (18.04)
- Debian
    - Bullseye (11)
    - Buster (10)
- Enterprise Linux
    - Red Hat 8

## arm64 / Raspberry Pi
openITCOCKPIT and all components are also available for arm64 processors and the Raspberry Pi.

The installation is the same as for a 64-bit system with an AMD or Intel processor. If you want to use a Raspberry Pi system, the [64-Bit Version von Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_arm64/images/) must be used.

## Adding the repository
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
The actual installation is carried out by executing the following command:
```
apt-get install openitcockpit
```

You will now need to perform  the basic configuration. During this process, for example, the first user for the web interface will be created. The rest of the configuration is then carried out via the openITCOCKPIT web interface.

```
/opt/openitc/frontend/SETUP.sh
```

## Registering the openITCOCKPIT Community Edition

This step is optional and voluntary. You can expand your openITCOCKPIT installation's range of functions through the addition of modules. Several are available for free. In order to gain access to the community modules, you must first enter the openITCOCKPIT community key. To do this, click on `System -> Registration` and insert the following key: `e5aef99e-817b-0ff5-3f0e-140c1f342792`. 

No further information is required.

![Valid license](/images/openITCOCKPIT-v4-valid-license.png){ align=center }

After being successfully activated, the community modules will be available under `System Tools -> Package Manager`.

## Installing phpMyAdmin

This step is optional and voluntary. The openITCOCKPIT system uses a MySQL database. Generally speaking, end users will not directly interact with the database. Experienced users, however, can install the `phpMyAdmin` tool for managing the database.

```
apt-get install phpmyadmin
```

The web server will be configured automatically. The phpMyAdmin interface can then be reached via `https://xxx.xxx.xxx.xxx/phpmyadmin`.

## System requirements

- Ubuntu Linux 64 bit (20.04 LTS “Focal” and 18.04 LTS “Bionic”), Debian Linux 64 bit (11 “Bullseye”) and Debian Linux 64 bit (10 “Buster”)
- 2 CPU cores (x86-64 or arm64)
- 2 GB RAM
- 40 GB of free hard disk space
