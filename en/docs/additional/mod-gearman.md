# Mod-Gearman

Mod-Gearman allows openITCOCKPIT to distribute monitoring tasks across multiple worker processes or servers using the Gearman job server.
This means that instead of having all monitoring checks executed on a single openITCOCKPIT server, you can distribute the workload
to multiple servers, improving scalability and performance.

!!! info
    All openITCOCKPIT versions > 4.7.1 are shipped with Mod-Gearman by default.


This document is for traditional installations of openITCOCKPIT. If you are using a Docker/Container-based setup, please refer to this [this documentation](../../installation/docker).

## Difference between Mod-Gearman and Distributed Monitoring

The [Distributed Monitoring Module of openITCOCKPIT](../../configuration/distribute-module/) allows setting up self-sufficient monitoring servers called "Satellite Systems".
openITCOCKPIT Satellite Systems provide a web interface and are the best solution for monitoring remote locations or multiple data centers.

In a limited way, Satellite Systems can also be used to offload workload from the openITCOCKPIT Main Server.

Mod-Gearman, on the other hand, distributes the check execution across multiple workers
and acts as a load balancer. If required, more Mod-Gearman Workers can be started to handle a larger load.

Both openITCOCKPIT Main and Satellite Systems are equipped with Mod-Gearman.

![Mod-Gearman Architecture](/images/mod_gearman/mod-gearman_architecture.png)

## Mod-Gearman Worker

Execution of Check plugins can consume a lot of CPU power. Plugins written in Python or Perl are easy to maintain
but need much more resources to execute than plugins written in Go or C.

If you would like to free up some resources on your openITCOCKPIT server, you can set up a new server that will only
run the Mod-Gearman Worker as a workhorse. The workhorse system will establish a connection with the openITCOCKPIT server
and will take over the execution of host and service checks. In case multiple Mod-Gearman Workers are connected, the load gets balanced between all workers.

Notifications and event handler scripts will always be run on the openITCOCKPIT server.

### Local Worker
By default, openITCOCKPIT has a local Mod-Gearman Worker. This service can be controlled via Systemd.
```
systemctl status mod-gearman-worker.service
```

This service is provided by the `openitcockpit-mod-gearman-worker-go-local` package and can be removed.
By uninstalling the `openitcockpit-mod-gearman-worker-go-local` package or by stopping the `mod-gearman-worker.service`,
the openITCOCKPIT server will **not** execute any host and service checks anymore.

!!! warning
    So please make sure to set up external Mod-Gearman Workers upfront!


### Bypass Mod-Gearman

To bypass Mod-Gearman for an entire host, you can set the `WORKER` custom macro with the value `local`.

![Bypass Mod-Gearman](/images/mod_gearman/bypass_mod_gearman.png)

You can also define the macro for a particular service to only exclude this service.


## Embedded Perl

Embedded Perl can speed up the execution of Perl plugins by a lot and will also reduce the amount of required CPU power.
A common example is the popular `check_nwc_health` plugin. Luckily, this plugin is compatible with Embedded Perl out of the box.


This chart show the impact of resource usage Embedded Perl could have.
Without Embedded Perl the system was using 38% CPU on average and simply by enabling Embedded Perl the CPU usage could be reduced to 20%.

Even more impressive is the reduction of the Plugin execution time from 450ms on average to 140ms.

![Resource usage with and without embedded perl](/images/mod_gearman/mod_gearman_chart.png)


### Include / Exclude plugins from Embedded Perl

Not all Monitoring Plugins are compatible with Embedded Perl. If you would like to update your plugin to be compatible, you can [follow this guidelines](https://www.naemon.io/documentation/usersguide/epnplugins.html).

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

Command line arguments that contain one of these characters
```
!$^&*()~[]\|{};<>?`
```
will only be executed via Embedded Perl if the characters are wrapped within single quotes.

For example:

```
/check_files.pl --filename=*.txt     # This will not be executed through Embedded Perl
```

```
/check_files.pl --filename='*.txt'   # Single quotes - will use Embedded Perl
```

## How to disable Mod-Gearman

openITCOCKPIT versions 4.8.0 and above have Mod_Gearman enabled by default. Mod_Gearman can be disabled if you want to bring back the old behavior where all plugins get
executed directly by the Monitoring Engine.

To do so, navigate to `System -> Config file editor` and edit the file `/opt/openitc/nagios/etc/nagios.cfg`.

![Disable Mod_Gearman](/images/mod_gearman/enable_mg.png)

Untick the `enable_mod_gearman` option and press on Save.


## Setup Mod-Gearman Worker
As mentioned, the primary goal of Mod-Gearman is to distribute the workload across multiple servers. openITCOCKPIT provides pre-built packages of the Mod-Gearman Worker for Debian, Ubuntu, and RHEL.

### Expose the Gearman-Job-Server
First of all, you need to expose the `Gearman-Job-Server` to your network. Open the file `/etc/default/gearman-job-server` and change the parameter `--listen=localhost` to `--listen=0.0.0.0`.
To apply the changes, restart the service: `systemctl restart gearman-job-server.service`

You can use `netstat` to validate that the Gearman Job Server is now listening on all interfaces:
```
[Ubuntu]root@openitcockpit~# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
tcp        0      0 0.0.0.0:4730            0.0.0.0:*               LISTEN      112        657506310  677284/gearmand
```

All communication of Mod-Gearman is encrypted with a shared secret. You can find the generated random key on your openITCOCKPIT server in the file `/opt/openitc/etc/mod_gearman/secret.file`.

### Install Mod-Gearman Worker

We recommend starting with a blank VM of the latest Ubuntu LTS release.

1. Load the repository.

    Please make sure to enable the [openITCOCKPIT repository](https://openitcockpit.io/download_server/) on your system.

2. Install dependencies
    ```
    apt-get install openitcockpit-mod-gearman-worker-go
    ```

    !!! warning
        Do not use the `openitcockpit-mod-gearman-worker-go-local` package!

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

    The logfile of the Mod-Gearman Worker is located at `/opt/openitc/logs/mod_gearman/mod_gearman_worker.log`.


### Verify
Execute the command `/opt/openitc/mod_gearman/bin/gearman_top` on your openITCOCKPIT Server to verify that the new Mod-Gearman Worker has connected successfully.

![Gearman_top](/images/mod_gearman/gearman_top.png)

## Routing of checks

Mod-Gearman distributes the execution of checks across all available workers.
This means that service checks from one host can be executed by different Mod-Gearman Workers.
This example will demonstrate this with a Checkplugin that simply outputs the hostname of the Mod-Gearman Worker it got executed by.

![Random routing of checks](/images/mod_gearman/random_routing.png)

As you can see, it is totally random which Mod-Gearman worker will execute which check, even if they are assigned to the same host.

There are situations where it is important to control which checks are getting executed by which Mod-Gearman Worker. You can do this by defining the `WORKER` custom macro
for a particular host, service, host template or service template.

By setting `WORKER=local`, the checks will **always** be executed by the Monitoring Engine on the openITCOCKPIT Server itself and bypass Mod-Gearman entirely.


### Route checks to a specific worker

The `WORKER` custom macro can also be used, to route checks to a specific worker, or a group of specific workers.
In this example we are going to route all checks of the `Worker Test` host (shown in the screenshot above) to a specific worker located in `Fulda` (a town in Germany).

#### Edit the worker.cfg

First of all, you need to define a list of _hostgroup keywords_ in the `/etc/openitcockpit-mod-gearman/worker.cfg`, to define which checks should be handled by this worker.

!!! info
    This list of _hostgroups_ has nothing to do with the Host groups, you can define in the openITCOCKPIT interface!

```
# sets a list of hostgroups which this worker will work
# on. Either specify a comma seperated list or use
# multiple lines.
hostgroups=Fulda
```

You can define multiple _hostgroup keywords_ by using a comma seperated list
```
hostgroups=Fulda,Frankfurt,Berlin
```

Restart the worker to apply the changes

```
systemctl restart mod-gearman-worker.service
```

#### Edit host / service configuration

After you have defined the _hostgroup keywoards_ in your worker configuration, you can run the command
`/opt/openitc/mod_gearman/bin/gearman_top` on your openITCOCKPIT server, to verify that seperate queues for each keyword have appeared.

![Own hostgroup queues for Fulda Frankfurt and Berlin](/images/mod_gearman/mod_gearman_hostgroup_routing.jpg)

To route checks into one of those groups, you need to define the `WORKER` custom macro for a host, a service, a host template or a service template.

Define the macro `WORKER` with the value `hostgroup_Fulda`

![Worker controlled by a macro](/images/mod_gearman/mg_routing_oitc.png)

!!! note
    It is important, that the value of the custom macro is prefixed with `hostgroup_`

To apply the changes, [update the monitoring configuration](../../beginners/create-first-host/#updating-the-monitoring-configuration).

All checks with the `WORKER=hostgroup_Fulda` will now be handled by the defined worker

![All checks get now executed by the forced worker](/images/mod_gearman/mod_gearman_forced_worker.png)


#### What are the `worker_` queues?
These queues are used by Mod-Gearman for internal status messages. Please ignore these.

## Troubleshooting

### Operation not permitted

In case you get an error message like `check_icmp: Failed to obtain ICMP socket: Operation not permitted` you need to set the following file permissions:

```
chown root:root /opt/openitc/nagios/libexec/check_icmp
chown root:root /opt/openitc/nagios/libexec/check_dhcp

chmod u+s /opt/openitc/nagios/libexec/check_icmp
chmod u+s /opt/openitc/nagios/libexec/check_dhcp
```

### Too many open files

When your Gearman Job Server becomes unresponsive or you get error messages like `ERROR 2015-04-14 22:02:54.000000 [ main ] accept(Too many open files) -> libgearman-server/gearmand.cc:788`,
you have reached the limit of open files.
This happens when a few thousand workers try to connect to one Gearman Job Server.
You can resolve this issue by increasing the limit of open files for the Gearman Job Server.

Edit the Systemd service `systemctl edit --full gearman-job-server.service` and insert the following line into the `[Service]` section:
```
LimitNOFILE=16384
```
![Modified systemd service](/images/mod_gearman/mg_modified_service.jpg)

To apply the changes, you have to restart the Gearman Job Server
```
systemctl restart gearman-job-server.service naemon.service statusengine.service
```

You can now connect a few thousand workers to your system
![Many thousand workers](/images/mod_gearman/mod_gearman_many_workers.jpg)


### Orphaned checks
If you have a bunch of error messages like this:
```
(service check orphaned, is the mod-gearman worker on queue 'service' running?)
```
it means that no workers are executing your host or service checks. Please make sure that the Mod-Gearman Workers are running.

```
systemctl restart mod-gearman-worker.service
```

## Temporary files

Some monitoring plugins create temporary files on the disk to compare _counter values_ with the values from the last execution. A well-known plugin that require temporary files is the `check_new_health` plugin, which, unless specified otherwise, creates temporary files under `/var/tmp/check_nwc_health`.

The `check_diskstats` plugin uses the directory `/var/tmp/nagios`.

If you use plugins that rely on temporary files to collect correct values, you must ensure that all workers have access to the same temporary files. This can typically be achieved most easily with an NFS share that is mounted on all Mod-Gearman workers.
