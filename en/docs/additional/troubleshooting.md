# Troubleshooting

## I've created a host, but I can't find it in the hosts list

A newly created host will not automatically appear in the main host list. Instead, newly created hosts can be found in the host list under the `Not monitored` tab. This means that the host exists in openITCOCKPIT, but is not yet known to the monitoring engine.

You will first need to [export the configuration](../../monitoring/basic-principles/#how-do-i-carry-out-an-export) in order for the newly created host to be monitored.

## sudo_server

**Error message**
  
Englisch:
```
Attention! Lost connection to SudoServer. External commands may not work. Please try to reload this page
```

Deutsch:
```
Achtung! Verbindung zum SudoServer verloren. Externe Befehle funktionieren möglicherweise nicht. Bitte versuche diese Seite neu zu laden.
```



**Problem**

`sudo_server.service` is not running or the web interface has lost the connection.

**Solution**

Reload the web page.
If the problem still exists, restart the sudo_server service.

```
systemctl restart sudo_server.service
```

If the problem persists, you can [contact us for further assistance](../support/#support).

## Debugging/Troubleshooting Page

### Interface information

The interface information provides you with an overview of your openITCOCKPIT server. Information on the version and edition being used will also be displayed here. In addition, information on the monitoring engine being used as well as the paths to the configuration, backups and command interface are also provided here.

![interface info](/images/debugging-interfaceinfo.png)

### Process information

Under `Administration -> System tools -> Debugging` you will find the debugging (troubleshooting) overview. Using process information you can get an overview of the processes required for running openITCOCKPIT.

![process info](/images/debugging-processinfo.png)

### SQL Query Log

The SQL Query Log displays all SQL queries that are executed in the SQL database.

![querylog](/images/debugging-sqlquerylog.png)

!!! tip
    tip For SQL query logging to take place, the option `'log' => true` must be set in the file `/opt/openitc/frontend/config/datasource.php`!

### Server information

The server information contains various basic data about your openITCOCKPIT server. This includes information about the operating system, web server, basic PHP information and the CPU.

### CPU load and RAM/hard disk utilisation of the openITCOCKPIT server

The openITCOCKPIT web interface offers an overview of the current CPU, RAM, SWAP and hard disk utilisation. This can be viewed on the debugging page.

### Queuing engine
You can find an overview of the queuing engine on the debugging page. All the queues for the Gearman job server and their status are displayed here.
![gearman-job-server overview](/images/debugging-queuingengine.png)

### Email configuration
You can get an overview of the current email configuration on the debugging page under "Email configuration". 

### PHP configuration
An overview of the current overall PHP configuration can be found at the end of the debugging page.

## System Health
The System Health display provides information about the overall status of the openITCOCKPIT system. See [System Health display](../../monitoring/user-interface/#system-health) 

## Where can I find the various log files?

### Naemon log

The log file for the Naemon monitoring engine can be found at

```
/opt/openitc/nagios/var/nagios.log
```

It is recommended to view the log file with the `oitc debug --tailf` command, as this replaces the Unix timestamps and UUIDs, which significantly increases the readability of the log file.

### openITCOCKPIT web frontend

```
/opt/openitc/logs/frontend/
```

### Gearman Job Server

```
/var/log/gearman-job-server/gearmand.log
```

### PHP-FPM

```
/var/log/php7.{0,1,2,3,4,...}-fpm.log
```

### NGINX

```
/opt/openitc/logs/nginx/
```

### MySQL

```
/var/log/mysql/error.log
```
