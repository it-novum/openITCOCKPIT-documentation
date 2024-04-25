# Microsoft Teams <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## What can I do with the Microsoft Teams Module?

Similar to the [Slack module](/alerting/slack), this integration will provide communications from openITCOCKPIT into a
Teams chat within MicrosoftTeams.

![](/images/microsoft-teams/title.png)

## How To Configure?

The settings for the Microsoft Teams module can be found under "System configuration → APIs → Teams".

| Field name       | Required field | Description                                                                                                            |
|------------------|----------------|------------------------------------------------------------------------------------------------------------------------|
| Webhook URL      | :warning:      | Defines the URL to the webhook that is called from OITC. <br/>This is received when configuring the "Incoming Webhook" |
| Use Proxy Server |                | Indicates whether to use the configured proxy                                                                          |

## Dependencies

To make this feature work properly, your Microsoft Teams setup requires the "Incoming Webhook" connector in the teams
channel you want to post the notifications.

## Setting Up Notifications For Microsoft Teams

openITCOCKPIT communicates with Microsoft Teams via the Teams WebAPI and sends messages to a a specific webhook that is
configured for a channel.

1. Optionally, create a new team channel in Microsoft Teams.
    - ![](/images/microsoft-teams/channel-create.png)
2. Install the "Incoming Webhook" connector for said channel.
    - ![](/images/microsoft-teams/channel-setup.png)
    - ![](/images/microsoft-teams/connectors.png)
    - ![](/images/microsoft-teams/webhook-install.png)
3. Configure the "Incoming Webhook" connector.
    - ![](/images/microsoft-teams/webhook-setup.png)
4. Configure your openITCOCKPIT installation.
    - ![](/images/microsoft-teams/oitc-configure.png)
    - ![](/images/microsoft-teams/oitc-menu.png)
    - ![](/images/microsoft-teams/oitc-setup.png)
5. Add the MS Teams Notification to a Contact
    - ![](/images/microsoft-teams/oitc-contact.png)

Once this has been done, the alerts will be sent using MS Teams.

## Commands

The following commands must be used for notifications.

Host:

**Host Notification Command - openITCOCKPIT Version 4.7**

```plaintext
/opt/openitc/frontend/bin/cake MSTeamsModule.teams_notification --type Host --notificationtype $NOTIFICATIONTYPE$ --hostuuid "$HOSTNAME$" --state "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.7**

```plaintext
/opt/openitc/frontend/bin/cake MSTeamsModule.teams_notification --type Service --notificationtype $NOTIFICATIONTYPE$ --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --state "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```
