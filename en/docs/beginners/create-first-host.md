# Creating your first host

In the openITCOCKPIT world, the most basic element is the "host". Normally, openITCOCKPIT uses an "ICMP Check" when checking your hosts. Each host provides various services, such as email, DHCP, DNS, web server, a load balancer, etc. So in order to set up a sensible monitoring system, you will need to include "Services" in your openITCOCKPIT installation. Because openITCOCKPIT uses Nagios or Naemon running in the background, you have thousands of freely available plugins that you can use for monitoring your critical services and infrastructure.

## Host and service templates

In openITCOCKPIT you have the ability to create your own host and service templates. These define default values, such as host or service groups, contacts, notification options, etc. which you can use as a template whenever you want to create a new host or service.

openITCOCKPIT comes with a ready-made selection of templates.

## Creating the first host - We really mean it this time :)

In this example we will use an *Ubuntu Focal* Linux system with the *NGINX*, *PHP-FPM* and *MySQL* services for monitoring.

To create your first host, navigate to `Monitoring -> Hosts` and click the "+
New" button.

openITCOCKPIT will ask a few basic questions about the new host, such as its name, IP address or FQDN, which contacts should be notified in case of an error, and so on.

To keep things as simple as possible, let's select "/root" as the container so that the new host is visible to all users on the system. We will also select "default host" as our host template. By using the host template we only have to enter the host name and the IP address. The rest is already taken care of for us.

![create host](/images/openITCOCKPIT-Create-Host.png)

Now scroll to the bottom of the page, click :fontawesome-solid-chevron-down: to the right of the `Create Host` button and then select `Save and Create Service`.

![create service](/images/create-host-and-service.png)

Using this shortcut we can directly create the first service on our new host.

!!! info "Did you click Create Host?"
    No problem. Navigate to `Services` and click "+ New".

Select the "Ping" service template and click `Create service`

![crate service](/images/openITCOCKPIT-Create-Service.png)

The newly created service will now appear in the "Not Monitored" list as it has only just been created, but not yet "Exported" to the monitoring engine.

![service not monitored](/images/service-not-monitored.png)

## Updating the monitoring configuration

Whenever you create a new object that you want to include in the monitoring engine - this includes, for example, hosts, services, contacts, contact groups, etc., the monitoring configuration must be updated.

You can find this option in the top right corner as `Refresh monitoring configuration`

![export button](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

openITCOCKPIT will create and validate all necessary configuration files for you in the background and reload the monitoring engine. Click the ":fontawesome-solid-rocket: Start update" button to begin the export.

![export done](/images/openITCOCKPIT-Refresh-Monitoring-Config-Done.png)

After a few seconds, your new host and service will begin to be monitored.

![new host and services](/images/openITCOCKPIT-New-Host-And-Service-Monitoring.png)

Sending a ping request to a host is a good idea, but not really what you call monitoring. In the next step we'll add some basic health checks to your system.
