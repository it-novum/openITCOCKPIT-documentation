# Custom Alert Module <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The Custom Alert Module of openITCOCKPIT could be used as an simpel ticketing solution. Instead of defining contacts or contact groups directly in the configuration of an host or service,
the Custom Alert Module uses a rule based system. Every host or service matching the defined conditions will automatically create custom alerts.

Every alert could be annotated by an user.

## Installing the module

Navigate to `Management -> System Tools -> Package Manager` and install the *CustomalertModule*

The Custom Alert Module in one of the few modules, which require manual configuration changes.
Navigate to `System -> Config file editor` and open the file `/opt/openitc/nagios/etc/nagios.cfg`

Enable the checkbox of `statusengine_enable_ocsp` and save the configuration file.

![statusengine_enable_ocsp option](/images/alerting/custom_alerts/statusengine_enable_ocsp.png)

!!! danger
    It is important to use the **Configuration file editor** of the openITCOCKPIT web interface. **Do not** modify any configuration files manually!

Navigate to `Administration -> User Management -> Manage User Roles` and select your user role. Please make sure to enable all CustomalertModule related user permissions.

![CustomAlertModule user permissions](/images/alerting/custom_alerts/customalertmodule_user_permissions.png)

## Custom alerts overview
![Custom Alerts overview](/images/alerting/custom_alerts/custom_alerts.png)

All custom alerts, which have no annotation message, will be marked as "new alert". In addition, the system displays a count how often the particular alert occurred in the last 24 hours.
Users could add an annotation for one particular alert, or select multiple alerts and add a annotation for all selected alerts at once.

As soon as a user has added an annotation, the alert message will be marked as "in progress".

If you plan to use a wall mounted screen, we recommend to enable the automatically refresh option.

## Alerthistory
![Custom Alerts history](/images/alerting/custom_alerts/custom_alerts_history.png)

Every custom alert has an own history log. The history starts when a custom alert get's created, will contain all annotations and also when a alert was closed.

## When will alerts be created

The custom alert module will use the output of the check plugin to create one or multiple alerts. Every new line (`\n`) in the output will create a new custom alert.
For example, let's assume the check plugin of a network switch is outputting the following error:
```
Switch Port 1 is down
Switch Port 2 is down
Switch Port 3 is down
```
openITCOCKPIT and the custom alert module, will create 3 different alerts. One for each new line.
In case one of the ports is changing into an up state again, and is therefore absent from the plugin output, the alert will be marked as closed automatically.

For example: New output
```
Switch Port 1 is down
Switch Port 3 is down
```

The custom alert of `Switch Port 2 is down` will be closed automatically by the system because the error has been resolved.
If the services changes into a Ok state - all custom alerts related to this services will be closed automatically.

In addition, the service needs to be in a hard state.

## Handling of downtimes and acknowledgements
When the service is in a scheduled downtime, openITCOCKPIT will **not** create any custom alerts for this service.

If the services was already acknowledged in the monitoring system, openITCOCKPIT **will still create** custom alerts for this service, but sets the acknowledgement
comment automatically as annotation message and the alert will be marked as "in progress".

## Defining alert rules

Unlike the _classic_ notifications, custom alerts will be defined by alert rules, instead of an object based configuration. To define which services should be handled by
the custom alert module, host tags, service tags or a regular expression could be used.

When the `Recursive` option is enabled, the alert rule will also be used for all elements in child containers.

To apply changes to the alert rules, a `Refresh of the monitoring configuration` is required.


![Defining custom alert rules](/images/alerting/custom_alerts/custom_alerts_rules.png)

## Integration as dashboard widget

The **Custom Alerts Counter** is a configurable widget that allows you to maintain an overview in the dashboards. The status of the alerts that are to be counted can be selected. Optionally, you can also define that only alerts older than x days are counted.

![Custom Alert Widget](/images/alerting/custom_alerts/custom_alerts_widget.png)

## Monitoring and notification of alerts

A configurable plugin in openITCOCKPIT can be used to monitor and notify existing alerts. With the command **check_customalerts_by_stage_and_age** and the service template **CHECK_CUSTOMALERTS_BY_STATE_AND_AGE**, templates are already predefined so that monitoring can be started directly. The plugin offers a wide range of configuration options, which can be seen in the following graphic. As this is represented as a service check, it can be used as usual in event correlations, notifications, reports and all other areas.

![Custom Alert Plugin](/images/alerting/custom_alerts/custom_alerts_plugin.png)

## Background daemon
The custom alerts are handled by a dedicated background daemon. The service can be controlled through systemd `systemctl status customalert_worker.service`

### Foreground mode

For debugging purpose, this daemon could also be started in foreground mode: `oitc CustomalertModule.custom_alert_worker -v`

The output will be similar to:
```
$ oitc CustomalertModule.custom_alert_worker -v
I'm subscribed to 120 services
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/74fd8f59-1348-4e16-85f0-4a5c57c7dd62. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/3844e17d-669f-4c37-9d0f-b41cc7a98730. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/b6e2faa5-ad53-4293-a9ff-057a00aad4bd. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/1d91b0eb-3e70-4984-82a3-e034eb7906d6. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/8b496afa-d1d4-4d19-8acc-790d5c7a087a. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/606ea810-b682-41ae-93d3-125c8d5b2ff0. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/8c387276-dc25-4bd4-8668-de7fe0422778. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/6fe3af81-6717-4842-a22b-7aa8dec146b1. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/2f0d2a18-dd05-4b32-bf94-b548ab53a3cc. Process record: Yes
Created 1 alerts. Closed 1 alerts.
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/87adaf1c-dce4-45c6-bdde-b7387409f538. Process record: Yes
Received servicecheck for 3c7fd6ce-f61b-4a67-853a-46c252d5439d/a817e7fd-e840-483c-8360-9a4f6d628508. Process record: Yes
Received servicecheck for 4703dc23-5a0d-41e6-a32b-13c0f97f8daa/fc6b84cf-42f5-4221-9cb4-7d210345da6d. Process record: Yes
Received servicecheck for bc593b86-7bc3-4ab5-a588-9acc6d0f4f61/d2ded165-27aa-4406-90c9-d71011ac9bd7. Process record: Yes
Received servicecheck for fc2342f7-f440-4099-92af-676c68d5f47a/9a29188b-340c-49e6-acd0-6749d123a4e6. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 58620809-3a69-452b-bc3f-876cf96132fa/1e909caa-97a8-4900-9f05-04d4d1144c24. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 3fd68d5f-306c-42d4-b9ee-7ff0432e55b6/25a4df9e-7ace-4171-8edc-c5f877a29b17. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/1b69c940-5d9a-4bb5-948c-eef3645cf3ce. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 6f397150-8fe8-46bb-8489-a014b1a9aad0/57318050-e049-4b25-a320-64f7ef9415bc. Process record: Yes
Received servicecheck for ad278e43-1280-4f21-a56b-218b8778a993/e3899e4c-21b9-4219-ace1-6b8f75dad7d0. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Created 0 alerts. Closed 0 alerts.
```
