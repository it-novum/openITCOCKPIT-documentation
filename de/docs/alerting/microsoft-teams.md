# Microsoft Teams <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Was kann ich mit dem Microsoft Teams Modul tun?

Ähnlich zum [Slack module](/alerting/slack), wird diese Integration es ermöglichen, Benachrichtigungen aus openITCOCKPIT
an einen Kanal in Microsoft Teams zu schicken.

![](/images/microsoft-teams/title.png)

## Was kann ich konfigurieren?

Die Einstellungen für dieses Modul können unter "Systemkonfiguration → APIs → Teams" gefunden werden.

| Feld Name        | Erforderliches Feld | Beschreibung                                                                                                                                                                           |
|------------------|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Webhook URL      | :warning:           | Legt die Webhook-URL fest, die openITCOCKPIT verwendet, um Benachrichtigungen zu senden. <br/>Wird angezeigt, wenn man in Microsoft Teams den Connector "Incoming Webhook" einrichtet. |
| Use Proxy Server |                     | Gibt an, ob der konfigurierte Proxy verwendet werden soll                                                                                                                              |

## Abhängigkeiten

Damit dieses Modul ordnungsgemäß funktioniert, muss in einem Microsoft Teams Channel der Connector "Incoming Webhooks"
installiert und konfiguriert werden.

## Einrichtung

OpenITCOCKPIT nutzt die konfigurierte "Webhook URL", um eine Benachrichtigung an MS Teams zu senden.

1. Optional kann ein neuer Channel in einem Team angelegt werden.
    - ![](/images/microsoft-teams/channel-create.png)
2. Auf dem Channel muss der Connector "Incoming Webhook" installiert werden.
    - ![](/images/microsoft-teams/channel-setup.png)
    - ![](/images/microsoft-teams/connectors.png)
    - ![](/images/microsoft-teams/webhook-install.png)
3. Der angelegte Connector muss konfiguriert werden.
    - ![](/images/microsoft-teams/webhook-setup.png)
4. In der openITCOCKPIT Installation müssen ebenso Konfigurationen erfolgen.
    - ![](/images/microsoft-teams/oitc-configure.png)
    - ![](/images/microsoft-teams/oitc-menu.png)
    - ![](/images/microsoft-teams/oitc-setup.png)
5. Das Benachrichtigungs-Kommando muss für einen oder mehrere Kontatke hinzugefügt werden.
    - ![](/images/microsoft-teams/oitc-contact.png)

Wenn alle Konfigurationsschritte abgeschlossen sind, sendet openITCOCKPIT jetzt anfallende Benachrichtigungen auch an
Microsoft Teams.

## Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

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
