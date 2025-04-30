# Upgrade openITCOCKPIT 4 to openITCOCKPIT 5

![Road to openITCOCKPIT 5](/images/openitcockpit5/oitc5_autobahn.png)

These instructions describe how to update your current installation of openITCOCKPIT 4.8.7 (or newer) to openITCOCKPIT 5.

!!! info
    Before beginning the upgrade, please be sure to create a backup of your system! We recommend testing both your backup and update processes in a test environment before using them on a live system.

### Prerequisites

-	Make sure that:
-	Your openITCOCKPIT installation is up to date
-	openITCOCKPIT >= 4.8.7
-	All operating system updates have been installed
-	A working backup of your openITCOCKPIT installation is available (in case something goes wrong)
-	You have at least **20 GB** free hard disk space
-	Execute all commands as `root` user

### Docker setup?

For Docker (or any other container runtime) based installations of openITCOCKPIT no manually upgrade process is required.
All you have to do is stop the containers, pull the new images and start the containers again.

Please see the [container update instructions](/installation/docker/#update-containers) for more information.

### Supported operating systems:

openITCOCKPIT 5 can be installed on the following operating systems:

| Ubuntu Noble (24.04) | Ubuntu Jammy (22.04) | Debian Bookworm (12) | Enterprise Linux* 8 | Enterprise Linux* 9 |
|---|---|---|---|---|
|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|

_*Enterprise Linux includes  Red Hat Enterprise Linux and RHEL based distributions such as: CentOS, Rocky Linux AlmaLinux or Oracle Linux._

### Unsupported operating systems:

!!! warning
    Older releases of Ubuntu or Debian (e.g. Ubuntu Focal or Debian Bullseye)
    are **not supported by openITCOCKPIT 5**
    Please update your operating system first, before you continue.

- Update [Ubuntu Bionic to Focal](/update/ubuntu-bionic-to-focal/)
- Update [Ubuntu Focal to Jammy](/update/ubuntu-focal-to-jammy/)
- Update [Debian Buster to Bullseye](/update/debian-buster-to-bullseye/)
- Update [Debian Bullseye to Bookworm](/update/debian-bullseye-to-bookworm/)


### Preparing the system

#### Step 1 - Enable non-free repositories

By default, the `non-free` repositories are enabled an all installations of openITCOCKPIT.
It's recommended check if your system is configured to access `contrib` and `non-free` packages.

##### Ubuntu users

Make sure the universe repositories have been activated on your system.

```bash
add-apt-repository universe
```

##### Debian users

Make sure that the non-free repositories have been activated on your system.
Ensure you have enabled `contrib` and `non-free` repositories in `/etc/apt/sources.list.d/debian.sources`

```bash
Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian.list
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware

Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian-security.list
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
```

#### Step 2 - Update the operating system

```bash
apt-get update
apt-get dist-upgrade
```

#### Step 3 - Back up the database

!!! warning
    Make sure that there is sufficient free hard disk space before you attempt to create a backup!

```bash
mysqldump --defaults-extra-file=/opt/openitc/etc/mysql/dump.cnf --databases openitcockpit --flush-privileges --triggers --routines --no-tablespaces --events --hex-blob \
  --ignore-table=openitcockpit.nagios_externalcommands \
  --ignore-table=openitcockpit.nagios_hostchecks \
  --ignore-table=openitcockpit.nagios_logentries \
  --ignore-table=openitcockpit.nagios_servicechecks \
  --ignore-table=openitcockpit.nagios_systemcommands \
  --ignore-table=openitcockpit.nagios_timedeventqueue \
  --ignore-table=openitcockpit.nagios_timedevents \
  --ignore-table=openitcockpit.statusengine_dbversion \
  --ignore-table=openitcockpit.statusengine_host_acknowledgements \
  --ignore-table=openitcockpit.statusengine_host_downtimehistory \
  --ignore-table=openitcockpit.statusengine_host_notifications \
  --ignore-table=openitcockpit.statusengine_host_notifications_log \
  --ignore-table=openitcockpit.statusengine_host_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_host_statehistory \
  --ignore-table=openitcockpit.statusengine_hostchecks \
  --ignore-table=openitcockpit.statusengine_hoststatus \
  --ignore-table=openitcockpit.statusengine_logentries \
  --ignore-table=openitcockpit.statusengine_nodes \
  --ignore-table=openitcockpit.statusengine_perfdata \
  --ignore-table=openitcockpit.statusengine_service_acknowledgements \
  --ignore-table=openitcockpit.statusengine_service_downtimehistory \
  --ignore-table=openitcockpit.statusengine_service_notifications \
  --ignore-table=openitcockpit.statusengine_service_notifications_log \
  --ignore-table=openitcockpit.statusengine_service_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_service_statehistory \
  --ignore-table=openitcockpit.statusengine_servicechecks \
  --ignore-table=openitcockpit.statusengine_servicestatus \
  --ignore-table=openitcockpit.statusengine_tasks \
  --ignore-table=openitcockpit.statusengine_users \
  --ignore-table=openitcockpit.customalerts \
  --ignore-table=openitcockpit.customalert_statehistory \
  --ignore-table=openitcockpit.sla_availability_status_hosts_log \
  --ignore-table=openitcockpit.sla_availability_status_services_log \
  --ignore-table=openitcockpit.sla_host_outages \
  --ignore-table=openitcockpit.sla_service_outages \
  >/root/openitcockpit_dump_v4_upgrade.sql
```


#### Step 4 - Carry out the openITCOCKPIT 5 compatibility check

To ensure that your system is capable of being updated to openITCOCKPIT 5.x, we provide a compatibility script for checking your system(s).

Execute the following script on your openITCOCKPIT instance:

```bash
curl -s https://raw.githubusercontent.com/it-novum/openITCOCKPIT/development/bin/scripts/oitc4to5.sh | sudo /bin/bash
```

![oitc4to5 successful compatibility check](/images/openitcockpit5/oitc4to5_success.png)


**No changes have been made to your system at this point!**

!!! danger
    Do not continue with the update if you receive any errors or warnings after carrying out the compatibility check!


First resolve the issues that have been highlighted and run the script again. Once you have resolved all errors, you can continue with the update.


### Breaking Changes

While we tried to keep the openITCOCKPIT 5 as compatible as possible, a large update like this comes with some breaking changes.

!!! danger
    **During the update, all stored filters will be deleted.**
    
    We recommend to export the MySQL table `openitcockpit.filter_bookmarks` before the update, so you can use the information to recreate the filters after the update.


![Truncate of current stored filters](/images/openitcockpit5/filter_bookmarks.png)


### Upgrade openITCOCKPIT

Your system is now prepared and ready to upgrade to openITCOCKPIT 5.

#### Step 1 – Sign out from openITCOCKPIT

openITCOCKPIT 5 ships with an entirely new frontend. For a soothe upgrade experience, it is recommended to sign out from from openITCOCKPIT first.

You can find the `sign out` button in the top right corner.

![Sign out from openITCOCKPIT](/images/openitcockpit5/upgrade_4_to_5_sign_out.png)

#### Step 2 - Change Repository

openITCOCKPIT 5 uses a different repository address than openITCOCKPIT 4 does. 
This is to prevent unexpected system upgrades.

The new address ist: `packages5.openitcockpit.io`.

!!! warning
    Currently openITCOCKPIT 5 is in **beta**. Please do not use this repository for production systems.
    The repository is automatically configured to use the `nightly` branch.

##### Ubuntu users

```bash
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list

apt-get update
```

##### Debian users

```bash
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list

apt-get update
```

##### RHEL8 users

!!! warning
    Make sure to add your openITCOCKPIT license key to the end of the repository configuration file:
    ```
    username=secret
    password=e5aef99e-817b-0ff5-3f0e-140c1f342792
    ```

```bash
cat <<EOT > /etc/yum.repos.d/openitcockpit.repo
[openitcockpit]
name=openITCOCKPIT Monitoring System
baseurl=https://packages5.openitcockpit.io/openitcockpit/RHEL8/nightly/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://packages5.openitcockpit.io/repokey.txt
EOT

dnf --refresh check-update
```

##### RHEL9 users

!!! warning
    Make sure to add your openITCOCKPIT license key to the end of the repository configuration file:
    ```
    username=secret
    password=e5aef99e-817b-0ff5-3f0e-140c1f342792
    ```

```bash
cat <<EOT > /etc/yum.repos.d/openitcockpit.repo
[openitcockpit]
name=openITCOCKPIT Monitoring System
baseurl=https://packages5.openitcockpit.io/openitcockpit/RHEL8/nightly/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://packages5.openitcockpit.io/repokey.txt
EOT

dnf --refresh check-update
```

#### Step 3 - Migrate license

Users of the openITCOCKPIT Community Edition and Enterprise Edition can continue to use their existing license key. It is important to change the repository address to `packages5.openitcockpit.io` in the file `/etc/apt/auth.conf.d/openitcockpit.conf` before you continue with the update.

The file should look like this:
```
machine packages5.openitcockpit.io login secret password e5aef99e-817b-0ff5-3f0e-140c1f342792
```

To apply the changes, run the following command:

```bash
apt-get update
```


#### Step 4 -  Updating openITCOCKPIT

!!! warning
    Stable SSH connection is required! The update process may take a while. To prevent SSH connection problems, we recommend using `tmux` or `screen`.

During the update you may be asked if you want to overwrite some configuration files with newer versions. These configuration files belong to the operating system, so you can choose whether you want to keep your current versions or update to the newer versions. This will have no impact on the openITCOCKPIT update.

To start the update, execute:

```bash
apt-get dist-upgrade
```

#### Step 5 - Clear browser cache

Before logging into your new openITCOCKPIT interface, you should clear your browser cache

Mozilla Firefox: <https://support.mozilla.org/en-US/kb/how-clear-firefox-cache>

Google Chrome: <https://support.google.com/accounts/answer/32050?co=GENIE.Platform%3DDesktop&hl=en>

#### Step 6 - Reboot the system

A system restart is recommended, but not required.

The update to openITCOCKPIT 5 is now completed 🎉.

### Updating the openITCOCKPIT satellite systems (only applies to distributed monitoring)

The Update process for openITCOCKPIT Satellite Systems is straight forward.
openITCOCKPIT 5 can also communicate with openITCOCKPIT 4 satellites.
While an upgrade is **recommended**, it is not required (at least for now)

#### Step 1 - Update the operating system

```bash
apt-get update
apt-get dist-upgrade
```

#### Step 2 - Change Repository

openITCOCKPIT 5 uses a different repository address than openITCOCKPIT 4 does. 
This is to prevent unexpected system upgrades.

The new address ist: `packages5.openitcockpit.io`.

#### Step 3 - Carry out the openITCOCKPIT Satellite 5 compatibility check

To ensure that your system is capable of being updated to openITCOCKPIT 5.x, we provide a compatibility script for checking your system(s).

Execute the following script on your openITCOCKPIT Satellite instance:

```bash
curl -s https://raw.githubusercontent.com/it-novum/openITCOCKPIT/refs/heads/development/bin/scripts/oitcSat4to5.sh | sudo /bin/bash
```

#### Step 4 -  Updating openITCOCKPIT Satellite

```bash
apt-get update
apt-get dist-upgrade
```



### Known problems

#### PHP 8.0 on RHEL
openITCOCKPIT **requires** PHP in version 8.1 or newer. 
Some Enterprise Linux installations still use PHP 8.0, in this case you need to upgrade your PHP version first.

Due to the amount of support complexity with Enterprise Linux systems, only the [openITCOCKPIT Enterprise Edition](https://openitcockpit.io/editions/) is avaiable for
Red Hat Enterprise Linux and RHEL based distributions such as: CentOS, Rocky Linux AlmaLinux or Oracle Linux.

Please get in [touch with us](https://it-services.it-novum.com/en/) if you need assistants upgrading your installation of openITCOCKPIT.


Before you start, make sure you have installed the latest updates for your system:
```bash
dnf --refresh check-update

dnf update
```

This document assumes that you have installed PHP from [Remi's RPM repository](https://rpms.remirepo.net/).

To upgrade your PHP version, please run the following command:

```
dnf module switch-to php:remi-8.1
```

This will switch your system to the latest version of PHP 8.1. You can also go with PHP 8.2 or 8.3.

To finish the upgrade, please run the following command:

```bash
openitcockpit-update
```



### Troubleshooting

#### Network error

If you find you are having connectivity errors with your system, you can try to repair the installation. To do this, use the following command:

```bash
apt-get install -f
```

#### If your openITCOCKPIT version is < 4.8.7

For the update process to complete successfully, you must be using at least version 4.8.7 of openITCOCKPIT.


#### What if I use Ubuntu Bionic, Debian Buster or openITCOCKPIT 3?

Please get in [touch with us](https://it-services.it-novum.com/en/).
