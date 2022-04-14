# Mobile Webseite  <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Installation

The Mobile Website is designed to run on its own server.

To create an instance of the Mobile Website you need an openITCOCKPIT Enterprise License, which entitles you to install
the Mobile Website. Please contact us via our [sales contact form](https://it-services.it-novum.com/)

Once the requirements are met, you will need Docker on your new system.

### Authentifizierung und herunterladen des Images
Before you can download the Docker image, you must register with our Docker Registry:

```bash
docker login https://cr.openitcockpit.io
```

The command prompts you to enter a username as well as a password.
As username please enter the e-mail address which is registered with your openITCOCKPIT Enterprise license key. As 
password enter your license key.

After successful authentication you can download the Docker image:

```bash
docker pull cr.openitcockpit.io/openitcockpit-mobile
```

### Docker container starten
You can start the container with the following command:

```bash
docker run --rm -it -p 4443:443 -p 8898:80 --name mobile cr.openitcockpit.io/openitcockpit-mobile
```

After that you can open the page with your mobile device:

```text
https://<hostname oder IP adresse>:4443
```

## Usage

![login](/images/mobile-website/login-screen.png){ width="300" }

### Login

After the successful installation you are able to open the website with your smartphone or tablet. You will be 
redirected to the login page.

You are now being asked to enter the server URL or IP-Address of your openITCOCKPIT System in the field 
`Your server-url or ip`

#### API Key creation

To be able to log in into the mobile website it is required to [crate an API key](../../development/api/#api-keys) first.
For easier transfer of the API key to the mobile device you can scan the QR-Code which is displayed in the API key 
creation overlay in openITCOCKPIT. Copy the displayed key and paste it in the field `Your api-key`.

After the successful login you will be redirected to the dashboard.

### Dashboard

![dashboard](/images/mobile-website/dashboard.png){ width="300" }

The dashboard enables you to get a quick overview of the condition of your infrastructure. Unhandled hosts and services 
will be displayed first in their panels. With a click on a status you will be redirected to the corresponding filtered
host or service list.

### Functions

#### Reset Check time <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the 
`Reset check time` button. The action will be executed immediately and does not require any further information.

More information regarding [Reset check time](../../monitoring/user-interface/#prufzeitraum-zurucksetzen)

![host details actions](/images/mobile-website/hosts-details-actions.png){ width="250" }


#### Schedule Maintenance <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Schedule Maintenance` button.

After that proceed as it is described in [Create downtime](#create-downtime) 

In this action you are not able to create recurring downtimes. Crating recurring downtimes is described in the
[Create recurring downtime](#create-recurring-downtime) section

More information regarding [Schedule Maintenance](../../monitoring/user-interface/#plane-wartung)

#### Acknowledgement state <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Acknowledge` button. If the selected object is already acknowledged you will see a `Remove Acknowledgement` button. 

If you selected a host you have the possibility to acknowledge the state not only for the host but for the services
too.

More information regarding [acknowledge state](../../monitoring/user-interface/#bestatige-hoststatus)

#### Enable/Disable Flapping <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Enable Flap detection` button. If you see a `Disable Flap detection` button, the flap detection is already enabled  

More information regarding [flap detection](../../configuration/hosts-services/#flap-detection)

#### Enable/Disable Notifications <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Enable Notifications` button.

With this option you can temporarily enable or disable notifications for the host, service or host including its 
services

#### Passive transfer check result <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Passive transfer check result` button.

More information regarding [passive transfer check result for services](../../monitoring/user-interface/#passive-ubertragung-eines-prufergebnisses_1)

#### Send custom service notification <span class="badge badge-info badge-outlined" title="Host">Service</span>
Select the desired host or service from the list and click on the `Actions` tab. After that click on the
`Send custom service notification` button.

More information regarding [send custom service notification](../../monitoring/user-interface/#benutzerdefinierte-servicebenachrichtigung-senden)

#### Massactions
Massactions are available for nearly all functions. To execute an action simultaneously on multiple hosts and / or 
services, you will need to navigate to the respective host or service list and click on the `Select` button. There will
be checkboxes displayed for every list item. Now you can select the desired objects and click on the `Actions` button.
The selected action will be executed for all selected objects.

#### Host and Service downtimes
Downtimes and recurring downtimes are also displayed in the mobile website. For a downtime
overview please navigate in the menu to `Host downtimes` or `Service downtimes`.

![downtimes host current filled](/images/mobile-website/downtimes-host-current-filled.png){ width="300" }

##### Create downtime

Creating downtimes for a host or a service nearly the same. Host downtimes have the additional possibility to set 
downtimes for its services too.

=== "Downtime"

    ###### Create downtime

    To create a downtime, navigate in the menu to `Host downtimes` or `Service downtimes`. After that click on the button
    `New`.

    Now select the desired hosts or services from the selectbox. The field `Downtime type` is only available for host
    downtimes. This option allows you to crate a downtime not only for the host but its services with the same 
    parameters too. The `Comment` field can describe the downtime.
    
    The option `Recurring downtime` allows you to [create recurring downtimes](#create-recurring-downtime)

    `Start` and `End` defines the start and end time of the downtime

    ![downtimes host add downtime](/images/mobile-website/downtimes-host-add.png){ width="250" }

=== "Recurring downtime"

    ###### Create recurring downtime

    To create a recurring downtime navigate in the menu `Host downtimes` or `Service downtimes`. After that click on the
    button `New`. 

    Now select the desired hosts or services from the selectbox. The field `Downtime type` is only available for host
    downtimes. This option allows you to crate a downtime not only for the host but its services with the same 
    parameters too. The `Comment` field can describe the downtime.
    
    Select the option `Recurring downtime`. The following form fields are changing now.

    First you have to set a `Start` time and `Duration`. The `Duration` can be chosen from the predefined buttons or you
    can enter a custom value in the field below. This value needs to be entered in minutes.

    After that you can select Weekdays, Days of month or both.

    Weekdays define the days of a week, where the downtime will be executed at the given `Start` time and `Duration` 
    
    Days of month pursuant to the given days of a month

    Is Weekdays and Days of month selected, the downtime will be extexuted on the weekdays and the day of month. In 
    example: Monday, Wednesday and the 3rd of month

    ![downtimes host add recurring downtime](/images/mobile-website/downtime-host-add-recurring-downtime.png){ width="250" }


##### Cancel downtime

Downtimes can also be cancelled with the mobile website. Therefor you need to select the desired downtime from the list
 and click on the bin icon.

![downtime service select cancel](/images/mobile-website/downtimes-host-select-cancel.png){ width="300" }

A popup which prompt you to confirm the cancellation will be displayed.

![downtime service cancel overlay](/images/mobile-website/downtime-host-cancel.png){ width="300" }

Recurring downtimes can be cancelled if you select the desired recurring downtime from the `recurring` tab and click 
on `Cancel downtime` in the information popup.

![downtime service cancel recurring overlay](/images/mobile-website/downtime-host-cancel-recurring-downtime.png){ width="300" }

## Customization

The mobile website is able to adapt to the identity of the respective company. This affects the login logo, header logo
(top menu bar), favicon, systemname (top menu bar) and the website title. 

To do this, a directory must be created on the host system in which the corresponding files are stored on **the same** 
level.

- `CustomConfigDir/`
    * `HeaderLogo.png`
    * `LoginLogo.png`
    * `interface.yml`
    * `favicon.png`

The file `interface.yml` is the corresponding configuration file, which contains all configurable parameters. You will 
an example of the file in the repository [interface.example.yml](https://github.com/it-novum/openITCOCKPIT-Mobile/blob/development/interface/interface.example.yml).  

In order to take effect you will need to add the following parameter with your custom directory to the docker 
commandline:

```bash
-v /my/path/to/CustomConfigDir:/var/www/localhost/htdocs/interface
```

It should be noted, that the internal path:

`:/var/www/localhost/htdocs/interface` stays the same in every case!

Changes can be done during the runtime in the `CustomConfigDir/interface.yml` file. No restart of the docker container 
required.

### Example configuration

This is an example configuration to illustrate how a configuration of the `interface.yml` file affects the mobile 
website.

For this example we used the images of the [Halloween theme](https://github.com/it-novum/oitc-halloween-theme) from 
openITCOCKPIT.

![ci-login](/images/mobile-website/ci-login.png){ width="300"; align=center }


Configuration of the `interface.yml`:

```yaml
############
# CUSTOM INTERFACE CONFIGURATION
# All attributes are optional.
# Custom images needs to be placed in the same directory as this configuration file
############

# System name displayed in the website header
systemname: Mobile Monitoring

# Title of the Website
title: Mobile Monitoring title

# Logo used on the Login Screen
# filename only! - the complete path will be set automatically
login_logo: openitcockpit_login_logo.png

# Logo used on the main manu
# filename only! - the complete path will be set automatically
header_logo: openitcockpit_halloween_header.png

# favicon logo
# filename only - the complete path will be set automatically
favicon: openitcockpit_halloween_header.png
```