# Creating an openITCOCKPIT development environment

## Creating a virtual machine

It is recommended you create a new virtual machine (e.g. with [VirtualBox](https://www.virtualbox.org/)) that meets the following minimum requirements:

| OS | Hard disk | RAM | CPU cores |
|---|---|---|---|
| Ubuntu Focal 20.04 (64 Bit) | 20 GB | 2048 MB | 2 |

To be able to reach the machine via the network, select the `Bridged Network` option under the network settings for the virtual machine.

If you do not want to use a bridged network, we recommend setting up two network cards for the virtual machine. One network card should be in NAT mode to ensure access to the internet and the other in a `host-only` network to allow the VM to be accessed by your local computer.

For more information on networking with VirtualBox, click on the following link
<https://www.virtualbox.org/manual/ch06.html>

If desired, you can also use "Ubuntu Desktop" to access a graphical user interface.

## Preparing the operating system

First make sure that the latest updates are installed on your system.

```bash
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get dist-upgrade
```

### Installing the required packages for the development environment

```bash
sudo apt-get dist-upgrade vim git tmux screen mc htop curl wget ca-certificates sysstat nfs-kernel-server samba-common samba gnupg2 apt-transport-https
```

### Enable "root" user

By default, the `root` user is disabled under Ubuntu.

Use *sudo* to change to the root user.

```bash
sudo su
```

Set a new password for the root user using the command *passwd*

```bash
passwd
```

### Enable the root user to log in via SSH (optional)

Open the file `/etc/ssh/sshd_config` and change the following line:
```
PermitRootLogin yes
```

Enable the change:

```bash
systemctl restart sshd
```

You can now log onto the system as `root` via SSH.

## Installing openITCOCKPIT

Since you are wanting to install an openITCOCKPIT development environment, we assume that you are familiar with the openITCOCKPIT setup process. For more information on the setup process, please click on the following link: <https://openitcockpit.io/download_server/>

```bash
curl https://packages.openitcockpit.io/repokey.txt | sudo apt-key add -
 
echo "deb https://packages.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openitcockpit.list
sudo apt-get update
 
sudo apt-get install openitcockpit
```

### Setup openITCOCKPIT
Run the openITCOCKPIT Setup Wizard to create a user for the web interface. An actual email address is **not** required.

```bash
sudo /opt/openitc/frontend/SETUP.sh
```

![setup.sh example](/images/SETUPsh-example.png)

### Setup phpMyAdmin (optional)

phpMyAdmin is a web-based MySQL database management tool. After installation, it can be accessed via `https://xxx.xxx.xxx.xxx/phpmyadmin` erreichbar. The MySQL access data can be found in the file `/opt/openitc/etc/mysql/mysql.cnf`.

```bash
sudo apt-get install phpmyadmin
```

mysql.cnf Example:
```bash
dziegler@oitc-dev:~$ sudo cat /opt/openitc/etc/mysql/mysql.cnf
; Automatically generated for openITCOCKPIT scripts. DO NOT TOUCH!
[client]
database = openitcockpit
host = localhost
user = openitcockpit
password = zw8upknsKte2pGvn
port = 3306
dziegler@oitc-dev:~$
```

### Installing PHP Composer

Composer is a package manager for PHP libraries and a prerequisite for an openITCOCKPIT development environment.

```bash
curl -o composer-setup.php https://getcomposer.org/installer
php composer-setup.php
sudo cp composer.phar /usr/local/bin/composer
```

## Cloning the GitHub source code 
openITCOCKPIT uses git as a version control system. The repository is publicly hosted on GitHub.

### Forking the openITCOCKPIT repository
Although not strictly necessary, it is strongly recommended that you create a personal fork of the official openITCOCKPIT repository.

However, if you want to contribute to the openITCOCKPIT project, this is a **prerequisite**. If you only intend to look at the source code or you don't have a GitHub account, you can simply clone the official openITCOCKPIT repository.

![fork repo](/images/forking.png)

### Cloning your personal repository (recommended)

Delete the files that were installed by apt
```bash
sudo su
rm -rf /opt/openitc/frontend
```

Clone the repository (replace YOUR_ACCOUNT_NAME with your GitHub username).
```bash 
cd /opt/openitc/
git clone -b development https://github.com/YOUR_ACCOUNT_NAME/openITCOCKPIT frontend
```

### Cloning the official openITCOCKPIT repository (only recommended if you do NOT have a GitHub account)

Delete the files that were installed by apt
```bash
sudo su
rm -rf /opt/openitc/frontend
```

```bash
cd /opt/openitc/
git clone -b development https://github.com/it-novum/openITCOCKPIT frontend
```


### Installing dependencies

Make sure that you execute all commands as the `root` user (`sudo su`).

#### Installing the PHP dependencies
```bash
cd /opt/openitc/frontend
 
composer install
 
rm -f /opt/openitc/frontend/config/app_local.php
```

#### Installing the JavaScript dependencies
```bash
cd /opt/openitc/frontend
 
npm install
```

#### Updating the database and repairing the file permissions
```bash
openitcockpit-update --cc --rights
```

## Activating openITCOCKPIT development mode (permanent)
As a developer, you will want to enable the development features of openITCOCKPIT. This will enable, for example, the output of error messages in the browser, the activation of global PHP methods such as `dd($var)` and `debug($var)` as well as the loading of uncompressed CSS and JavaScript.

Make sure that you execute all commands as the `root` user (`sudo su`).

!!! danger
    Be aware that activating the debug mode can lead to data leaks and the loss of sensitive information.

```bash
echo "OITC_DEBUG=1" >> /etc/environment
export OITC_DEBUG=1
 
sed -i 's/OITC_DEBUG 0/OITC_DEBUG 1/g' /etc/nginx/openitc/master.conf
systemctl restart nginx
```

## Start hacking
### Accessing files via a remote system (IDE) (optional)
Your development environment (e.g. PHPStorm, Visual Studio Code, etc.) will usually not run on the same system as openITCOCKPIT.

There are three common ways to gain access to the source code via your IDE: NFS, SMB and SSH

#### NFS (Linux and macOS clients)
Open the file `/etc/exports` on your openITCOCKPIT server and create a new entry as follows: (You can enable access for a single IP address or for an entire subnet. Make sure you set the correct IP address for your network).

```
/opt/openitc/frontend/ 192.168.56.0/24(rw,no_subtree_check,no_root_squash,all_squash,anonuid=33,anongid=33)
```

```bash
sudo exportfs -a
```
##### Mounting an NFS share on a Linux client
```bash
sudo apt-get install nfs-common
 
mkdir ~/openitcockpit-frontend
mount xxx.xxx.xxx.xxx:/opt/openitc/frontend ~/openitcockpit-frontend
```

Make sure you replace `xxx.xxx.xxx.xxx` with the IP address of your openITCOCKPIT server.

You can now open the folder `~/openitcockpit-frontend` with your IDE.

###### Unmounting an NFS share (Linux client)
If you no longer need the share on your system, you can remove it with the following command:
```bash
umount ~/openitcockpit-frontend
```

##### Mounting an NFS share on a macOS client

```bash
mkdir ~/openitcockpit-frontend
sudo mount_nfs -o resvport xxx.xxx.xxx.xxx:/opt/openitc/frontend ~/openitcockpit-frontend
```
Make sure you replace `xxx.xxx.xxx.xxx` with the IP address of your openITCOCKPIT server.

You can now open the folder `~/openitcockpit-frontend` with your IDE.

###### Unmounting an NFS share (macOS client)
If you no longer need the share on your system, you can remove it with the following command:
```bash
sudo umount ~/openitcockpit-frontend
```

#### SMB (Windows, Linux und macOS clients)

You will first need to set up the SMB daemon on your openITCOCKPIT server.
```bash
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
```

Replace your current smb configuration, which can be found under `/etc/samba/smb.conf`, with the following:
```
[global]
    workgroup = WORKGROUP
    server string = %h server (Samba, Ubuntu)
 
#### Debugging/Accounting ####
    log file = /var/log/samba/log.%m
    max log size = 1000
    logging = file
    panic action = /usr/share/samba/panic-action %d
 
 
####### Authentication #######
    server role = standalone server
    obey pam restrictions = yes
    unix password sync = yes
    passwd program = /usr/bin/passwd %u
    passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    pam password change = yes
 
    security = user
    guest only = yes
    map to guest = bad user
    guest account = nobody
 
############ Misc ############
    usershare allow guests = yes
 
#======================= Share Definitions =======================
[frontend]
    path = /opt/openitc/frontend
    available = yes
    browseable = yes
    guest ok = no
    writeable = yes
    create mask = 0644
    directory mask = 0755
    force user = www-data
    valid users = www-data
```

Set a password for the user `www-data` to gain access to the files via samba.
```bash
smbpasswd -a www-data
```

Enable the changes:
```bash
sudo systemctl restart smbd
```

##### Mounting an SMB share on a Windows client

1. Open Windows Explorer and click on "Connect network drive".

![map network drive](/images/map-network-drive.png)

2. Add your SMB share as a network drive. Make sure you have selected the option "Establish login using other credentials".

![map network drive path](/images/map-network-drive-path.png)

3. Use the `www-data` user and password you just set.

![smb credentials](/images/windows-smb-credentials.png)

4. You can now browse the files.

![browse through files](/images/windows-browse-smb-share.png)


Open `Z:\` with your IDE.

Help: <https://support.microsoft.com/en-us/help/4026635/windows-10-map-a-network-drive>

##### Mounting an SMB share on a macOS client

1. Open "Finder" and press `CMD+k`.

![connect to smb](/images/connect-to-smb.png)


2. Use the `www-data` user and password you just set.

![set username and password](/images/username-and-password.png)

3. 3.	You can now browse the files.

![browse smb](/images/browse-smb.png)

Open `/Volumes/frontend` with your IDE.

#### SSH (platform-independent - depends on the IDE)

Many IDEs support access to remote files via FTP, SFTP or SSH. The setup process will depend on your IDE. Please search the web for the appropriate SSH setup for your IDE.

Setup for PHPStorm: <https://www.jetbrains.com/help/phpstorm/create-new-project-add-remote-server.html>

Setup for Visual Studio Code: <https://code.visualstudio.com/docs/remote/ssh>
