# Check by SSH

SSH provides an easy and secure way to run monitoring plugins on a remote host.

## Creating an SSH key on the openITCOCKPIT server

If you don't already have an SSH key for the user `nagios` ,you will need to create one.

```
su nagios
mkdir /var/lib/nagios/.ssh
ssh-keygen
```

After this process completes you should import the SSH host key into your target system: `ssh <target-host>` and confirm this choice with `yes`.

## Import the SSH key into the target system

For this example you need the packages `nagios-plugins` or `monitoring-plugins` installed on the target host.

```
apt-get install nagios-plugins
```

We now need to create a new user `monitoring`, that will be used to run checks via SSH.

```
addgroup --system monitoring
adduser --system --shell /bin/bash monitoring
adduser monitoring monitoring

mkdir -p /home/monitoring/.ssh/
chown monitoring:monitoring /home/monitoring -R

touch /home/monitoring/.ssh/authorized_keys
chmod 644 /home/monitoring/.ssh/authorized_keys
```

Now copy your **public key** to the file `/home/monitoring/.ssh/authorized_keys`.

## Creating checks

Navigate to `Monitoring -> Objects -> Commands` and make sure the `check_by_ssh` command exists. This is a standard openITCOCKPIT command. If the command is not available, click the `+ New` button and create it.

| Command definition       |                                                                 |
|--------------------------|-----------------------------------------------------------------|
| Command type             | Service check command                                           |
| Command name             | `check_by_ssh`                                                  |
| Command line             | `$USER1$/check_by_ssh -H $HOSTADDRESS$ -l "$ARG1$" -C "$ARG2$"` |
| Command argument ($ARG1) | `Username`                                                      |
| Command argument ($ARG2) | `Command`                                                       |

![check by ssh command](/images/check_by_ssh_command.png)

The `check_by_ssh` plugin can be used to execute all types of commands on the remote host. For check plugins to run you must set the absolute path to the plugin. Also, by creating a macro with the plugin path you will save yourself a lot of work.

Navigate to `Monitoring -> Objects -> Custom Macros` and click the `+ New` button.

| Macro definition       |                                                                  |
|------------------------|------------------------------------------------------------------|
| Makro name             | `$USER2$` (or any other)                                         |
| Value                  | `/usr/lib/nagios/plugins`                                        |
| Description (optional) | `Path of monitoring-plugins on remote host used by check_by_ssh` |

![user defined macro](/images/user-defined-macro.png)

Navigate to `Monitoring -> Services` and click the `+ New` button.

Select your host and the predefined service template `CHECK_BY_SSH`.

| Service templates definition |                                             |
|------------------------------|---------------------------------------------|
| Service name                 | `CHECK_BY_SSH`                              |
| Service name                 | `CPU load`                                  |
| Check period                 | `24x7`                                      |
| Check command                | `check_by_ssh`                              |
| Username ($ARG1)             | `monitoring`                                |
| Command ($ARG1)              | `$USER2$/check_load -w 15,10,5 -c 30,25,20` |

To continue click `Create Service`.

`$USER2$` is automatically replaced with the value stored in the previous macro.

![cpu load by ssh](/images/cpu-load-by-ssh.png)

Repeat this step for all the services you need.

For the new changes to take effect, you must [update the monitoring configuration](../create-first-host/#updating-the-monitoring-configuration).

The new services will now be monitored by the system.

![services monitored via SSH](/images/services-monitored-via-ssh.png)
