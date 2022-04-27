# Basic principles

## What are hosts and services?

In openITCOCKPIT everything revolves around hosts and services. Hosts are usually physical devices such as servers, switches, printers, workstations, etc. containing a network interface or virtual machines.

A service, on the other hand, is a process that runs on a host (e.g. Apache web server, MySQL, Postfix, etc.) or some type of metric connected to the host (such as the number of users logged in, free disk space, CPU utilisation, etc.).

## What statuses are available?

Hosts and services can assume different statuses. Which status is reached and when is decided by the checking plugin or by threshold values that are passed to the plugin via the corresponding [command](../../configuration/commands/).

Hosts can assume the following statuses:

| Status code | Colour | Status (English) | Status (German) |
|---|---|---|---|
| 0 | Green | UP | REACHABLE |
| 1 | Red | DOWN | NOT AVAILABLE |
| 2 | Grey | UNREACHABLE | CANNOT BE REACHED |

Services can assume the following statuses:

| Status code | Colour | Status (English) | Status (German) |
|---|---|---|---|
| 0 | Green | OK | OK |
| 1 | Yellow | WARNING | WARNING |
| 2 | Red | CRITICAL | CRITICAL |
| 3 | Grey | UNKNOWN | UNKNOWN |

In addition to the statuses for hosts and services, there is also the blue status. The blue status applies to both a host and a service and signals that the object was created in openITCOCKPIT, but is not yet monitored by the monitoring engine. To update this, an [export](#export) must be performed. 

## Export

### What is an export?

openITCOCKPIT and the monitoring engine (Naemon) have two separate configurations. This means that newly added objects in openITCOCKPIT are not automatically monitored or are not known to the monitoring engine (at least not initially).

-	Naemon stores its objects as `.cfg` files under `/opt/openitc/nagios/etc/config/`
-	openITCOCKPIT stores its objects in the database

For example, if you have created a new host or service in openITCOCKPIT, it will not be included in the list of monitored objects and will have the blue status Not in `monitoring`.

In order for the objects in openITCOCKPIT to be synchronised with the monitoring engine, all relevant data from the openITCOCKPIT database must be written into the `.cfg` files for Naemon.

Performing an export will take care of this for us. This, however, isn't the only thing an export does. It also processes a few other tasks:

-	Performing a backup of the current Naemon configuration files
-	Performing a backup of the openITCOCKPIT database
-	(OPTIONAL) performing a backup of the Prometheus configuration
-	Performing `pre export` tasks
-	Writing the new Naemon configuration files
-	(OPTIONAL) Creating the new Prometheus configuration
-	Performing `post-export tasks`
-	Verifying the new Naemon configuration
-	Instructing Naemon to re-read its configuration
-	(OPTIONAL) Transfering the new configuration to the satellite systems
-	Performing `after-export tasks`
-	(OPTIONAL) Verifying the Prometheus configuration
-	(OPTIONAL) Restarting Prometheus

Not everything that can be created and / or configured in openITCOCKPIT is an object that is relevant to the monitoring engine. Examples include users, permissions, containers, maps and much more. These can be created in and only exist in openITCOCKPIT. Objects that are relevant for the monitoring engine are:

-	Commands
-	Contacts
-	Contact groups
-	Time periods
-	Hosts
-	Host templates
-	Host groups
-	Host dependencies
-	Host escalations
-	Services
-	Service templates
-	Service groups
-	Service dependencies
-	Service escalations

### How do I carry out an export?

Performing an export in openITCOCKPIT is very easy. To do this, click on the :fontawesome-solid-retweet: button in the header area of openITCOCKPIT.

![Export Header Button](/images/layout-header-export.png)

In the page that opens, click on :fontawesome-solid-rocket: `Start update`.

![Export before launch](/images/export-beforeexport.png)

If the export is successful, you will see the following output:

![Export successful](/images/export-afterexport.png)
