# Mod-Gearman

Mod-Gearman allows openITCOCKPIT to distribute monitoring tasks across multiple worker processes or servers using the Gearman job server.
This means that instead of having all monitoring checks executed on a single openITCOCKPIT server, you can distribute the workload
to multiple servers, improving scalability and performance.


!!! info
    All openITCOCKPIT versions > 4.7.0 are shipped with Mod-Gearman by default.


This document is for traditional installations of openITCOCKPIT. If you are using a Docker/Container based setup, please refer to [this documentation](/installation/docker).

## Difference between Mod-Gearman and Distributed Monitoring

The [Distributed Monitoring Module of openITCOCKPIT](/configuration/distribute-module/) allows to setup self-sufficient monitoring servers which are called "Satellite Systems".
openITCOCKPIT Satellite Systems provide an Web Interface and are the best solution to monitore remote locations or multiple datacenters.

In a limited way, Satellite Systems can also be used to offload workload from the openITCOCKPIT Main Server.

Mod-Gearman on the other hand distributes the check execution across multiple workers and will act as load balancer.
If required, more Mod-Gearman Workers can be started to handler a larger load.

openITCOCKPIT Main and Satellite Systems are both equip with Mod-Gearman.

![Usage example of RealFaviconGenerator](/images/mod_gearman/mod-gearman_architecture.png)

## Mod-Gearman Worker

Execution of Checkplugins can consume a lot of CPU power. Plugins written in Python or Perl are easy to maintain
but need much more resources to execute than plugins written in Go or C.

In case you like to free up some resources on your openITCOCKPIT server, you can setup a new server, which will only run the Mod-Gearman Worker as a workhorse.
The workhorse system will establish an connection with the openITCOCKPIT server and will takeover the execution of host and service checks. In case multiple Mod-Gearman Worker are connected
the load get's balanced between all workers.

Notifications and event handler scripts will always be run on the openITCOCKPIT server.

### Local Worker
By default, openITCOCKPIT has a local Mod-Gearman Worker. This service can be controlled via Systemd.
```
systemctl status mod-gearman-worker.service
```

This service is provided by the `openitcockpit-mod-gearman-worker-go-local` package and can be removed.
By uninstalling the `openitcockpit-mod-gearman-worker-go-local` package, or by stopping the `mod-gearman-worker.service`
the openITCOCKPIT server will not execute any host and service checks anymore. So please make sure to setup external Mod-Gearman Workers upfront!


### Bypass Mod-Gearman

To bypass Mod-Gearman for an entire host, you can set the `WORKER` custom macro with the value `local`.
![Bypass Mod-Gearman](/images/mod_gearman/bypass_mod_gearman.jpg)

You can also define the macro for a particular service, to only exclude this service.


## Embedded Perl

Embedded Perl can speedup the execution of Perl plugins by a lot and will also reduce the amount of required CPU power.
A common example the the popular `check_nwc_health` plugin. Luckily this plugin is compatible with Embedded Perl out of the box.

### Include / Exclude plugins from Embedded Perl

Not all Monitoring Plugins are compatible with Embedded Perl. In case you like to update your plugin to be compatible, you can [follow this guidelines](https://www.naemon.io/documentation/usersguide/epnplugins.html).

To tell Mod-Gearman to use the Embedded Perl interpreter for a particular check plugin, add this line into the **first 10 lines** of the Perl script:
```
# nagios: +epn
```

To tell Mod-Gearman to **not** use the Embedded Perl interpreter for a particular check plugin, add this line into the **first 10 lines** of the Perl script:
```
# nagios: -epn
```

By setting `use_embedded_perl_implicitly=1` in the `mod_gearman/worker.cfg` - all Perl plugins will get executed via Embedded Perl.

#### Limitations

Command line arguments, which contains one of those characters `!$^&*()~[]\\|{};<>?\`` will only be executed via Embedded Perl, if the the characters are wrapped within single quotes.

For example:

```
/check_files.pl --filename=*.txt     # This will not be executed through Embedded Perl
```

```
/check_files.pl --filename='*.txt'   # Single quotes - will use Embedded Perl
```

## How to disable Mod-Gearman

openITCOCKPIT versions 4.7.2 and above have Mod_Gearman enabled by default. Mod_Gearman can be disabled, if you want to bring back the old behavior where all plugins get
executed directly by the Monitoring Engine.

To do so navigate to `System -> Config file editor` and edit the file `/opt/openitc/nagios/etc/nagios.cfg`.

![Disable Mod_Gearman](/images/mod_gearman/enable_mg.jpg)

Untick the `enable_mod_gearman` option and press on Save.


## Setup Mod-Gearman Worker
As mentioned, the primary goal of Mod-Gearman is, to distribute the workload across multiple servers. openITCOCKPIT proviedes pre-build packages of the Mod-Gearman Worker for Debian, Ubuntu and RHEL.

### Expose the Gearman-Job-Server
First of all, you need to expose the `Gearman-Job-Server` to your network. Open the file `/etc/default/gearman-job-server` and change the parameter `--listen=localhost` to `--listen=0.0.0.0`.
To apply the changes, restart the service: `systemctl restart gearman-job-server.service`

Youu can use `netstat` to validate that the Gearman Job Server is now listening on all interfaces:
```
[Ubuntu]root@openitcockpit~# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
tcp        0      0 0.0.0.0:4730            0.0.0.0:*               LISTEN      112        657506310  677284/gearmand
```

All communication of Mod-Gearman is encrypted with a shared secret. You can find the generated random key on your openITCOCKPIT server in the file `/opt/openitc/etc/mod_gearman/secret.file`

### Install Mod-Gearman Worker

We recommend to start with a blank VM of the latest Ubuntu LTS release.

1. Load the repository.

    Please make sure to enable the [openITCOCKPIT repository](https://openitcockpit.io/download_server/) on your system.

2. Install dependencies
    ```
    apt-get install openitcockpit-mod-gearman-worker-go
    ```

    All check plugins are located at `/opt/openitc/nagios/libexec`. You can add any custom plugin you need to this (or any other) location.

3. Connect worker to openITCOCKPIT Server

    Open the file `/etc/openitcockpit-mod-gearman/worker.cfg` and set the hostname or IP-Address of your openITCOCKPIT Server.
    ```cfg
    server=openitcockpit.example.org:4730

    # Also make sure to set same encryption parameters
    # The key can be found in the file /opt/openitc/etc/mod_gearman/secret.file on your openITCOCKPIT Server
    encryption=yes
    key=870b2ba934d9992b30298cb98726825e
    ```

    To apply the settings, restart the service: `systemctl restart mod-gearman-worker.service`

    The Mod-Gearman Worker is now ready and will connect to your openITCOCKPIT Server.

    The Logfile of the Mod-Gearman Worker is located at `/opt/openitc/logs/mod_gearman/mod_gearman_worker.log`.

### Verify
Execute the command `/opt/openitc/mod_gearman/bin/gearman_top` on your openITCOCKPIT Server, to verify that the new Mod-Gearman Worker has connected successfully.

![Gearman_top](/images/mod_gearman/gearman_top.png)

## Route checks
`WORKER=workhorse1`

## To many open files

## freshness wenn keine worker laufen