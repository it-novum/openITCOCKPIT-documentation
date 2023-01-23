# Service-Level-Agreement Module <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The service level agreement module can be installed via the openITCOCKPIT package manager.
Navigate to `Management -> System Tools -> Package Manager` and install the *SLAModule*

## SLA Configuration

Under the menu item `Administration -> SLA MAnagement -> SLAs` you get to the SLA configuration area.
New SLAs can be created here and SLAs that have already been created are listed.

![SLA Overview](/images/sla/sla_list.png)

The current availability is displayed for all SLAs that have already been evaluated.


To calculate the availability the SLA needs to be defined with an name, a time period, an evaluation period and
guaranteed availability as a percentage. If desired, a value for an early warning can be entered as well.
The warning threshold needs to be higher than the guaranteed availability.

The start date of the SLA calculation is always the first day of the evaluation period. For example for the
evaluation period `MONTH` the start day is the first day of the month. For `WEEK` the start day is monday.
It is also possible to define a custom start date using the `Start date` field.

![SLA configuration](/images/sla/sla_configuration.png)

#### Basic configuration

| Field                   | Required                  | Description                                                                                                                  |
|-------------------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Container               | :fontawesome-solid-xmark: | SLA Container (Object Permissions)                                                                                           |
| Name                    | :fontawesome-solid-xmark: | Name of the SLA                                                                                                              |
| Description             |                           | Description of the SLA                                                                                                       |
| Evaluation period       | :fontawesome-solid-xmark: | Day, Week, Month, Quarter, Year                                                                                              |
| Start date              |                           | Optional start date of the SLA                                                                                               |
| guaranteed availability | :fontawesome-solid-xmark: | Guaranteed availability percentage (90.5% for example).                                                                      |
| Warning threshold       |                           | Show a warning when the SLA availability is below this threshold                                                             |
| Operating time          | :fontawesome-solid-xmark: | Time period which will be used for the SLA calculation. Outages outside of this time period will not be counted.             |
| Consider downtimes      |                           | Determines whether maintenance times  (downtimes) should be taken into account. Outages during maintenance times are ignored |
| Reflection state        | :fontawesome-solid-xmark: | The status type to evaluate. Hard state only or hard and soft state                                                          |

After installing the SLA module, the configuration area of the host template or the host has a new SLA option.
The SLA can always be assigned to either the host template, so all hosts that use this
template are automatically in SLA or to a particular host.

The menu item `Affected hosts` shows a list of all hosts that have been assigned to the SLA, either directly or via the host templates.

![menu Affected hosts](/images/sla/sla_menu_affected_hosts.png)

In this list you can see directly how the SLA was assigned. It is also possible to jump into the object configuration
to change the SLA assignment. For a better overview it is possible to filter by hostname.

![Zugewiesene hosts](/images/sla/sla_affected_hosts.png)


#### SLA Overview

As soon as the SLA is evaluated, the availability of the SLA is displayed in the SLA list.
By clicking on an SLA you get to the detail view. This view can also be reached via the drop down menu item `View details`.

![SLA Oberview](/images/sla/sla_view_details.png)

This page shows the current availability of the entire SLA. The lowest value represents
the current availability of an SLA. In addition to the current availability, all relevant configuration details
and a summary is displayed. In the bar chart, the hosts are listed in ascending order with the lowest availability.

All hosts and their services are listed in the lower area. The order is also ascending so that
hosts with the lowest availability are listed first. The services are also sorted.
To enable searching for specific hosts, filters by hostname or availability have been added.

All hosts that are assigned to an SLA, will display the current availability as a badge in the `Hosts -> Browser` area.

![SLA availability badg for Host](/images/sla/sla_host_browser.png)

By clicking on the badge you can open a detailed overview for the particular host.

![SLA Host details](/images/sla/sla_host_browser_details.png)

The SLA details overview of a host, will also display the availability of the services that are associated with this host.
The `Service -> Browser` page also contains a badge, which displays the service availability.

![SLA Service details](/images/sla/sla_service_browser_details.png)

The SLA service details overview does additionally contain a list of the last 10 days.