## Kontakte

Kontakte werden in openITCOCKPIT genutzt um Benachrichtigungen zu versenden. Diese Benachrichtigungen können je nach im Kontakt konfiguriertem Kommando beispielsweise per E-Mail, Browser Push Benachrichtigung oder mit Erweiterungen auch über SMS, Chat Benachrichtigung oder ähnlichem versendet werden. 

### Neuen Kontakt erstellen

Um einen neuen Kontakt zu erstellen, klicken Sie zunächst auf die Schaltfläche “Neu”.

Danach wählen Sie im Formular einen oder mehrere Container aus in dem der Kontakt verfügbar sein soll und vergeben einen Namen sowie entweder eine E-Mail Adresse oder eine Telefonnummer.

Anschließend wählen Sie die Benachrichtigungsmethode für den Host aus. Dazu wählen Sie die Zeitspanne und mindestens ein Kommando aus. 

Damit die Benachrichtigungen für den Kontakt auch versendet werden, muss die Option “Hostbenachrichtigung aktiviert” aktiv sein.

mit den “Optionen zu Hostbenachrichtigungen” können Sie noch auswählen wann eine Benachrichtigung erfolgen soll.

Die Konfiguration zur Servicebenachrichtigung erfolgt nach demselben Schema.


## Kontaktgruppen


## Eskalationen


## Mattermost Modul

### Was kann ich mit dem Mattermost Modul tun?

Dieses Modul bietet die Möglichkeit einer Zwei-Wege-Integration von Mattermost in openITCOCKPIT. Alarme können an Mattermost gesendet werden und Bestätigungen (Acknowledgements) können von Mattermost an openITCOCKPIT geschickt werden.

![](/images/mattermost-chat.png)

### Was kann ich konfigurieren?

Unter "API Mattermost" können Sie die Konfiguration finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning: | Definiert die Adresse des Mattermost Servers, welcher genutzt werden soll. **Example**: [http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte) |
| Enable Two-Way Integration |     | Über die Zwei-Wege-Integration kann Mattermost Acknowledgements an openITCOCKPIT Senden. Ohne werden nur Alarma an Mattermost geschickt. |
| openITCOCKPIT API Key |     | Dieser API-Key wird von Mattermost genutzt um die Acknowledgements an openITCOCKPIT zu schicken. Zuerst muss ein [benutzerdefinierter API-Key](https://docs.it-novum.com/display/ODD/Grundlegende+Verwendung) mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Ob der konfigurierte HTTP Proxy genutzt werden soll oder nicht. |

### Mattermost Konfiguration

Erstellen Sie einen neuen [Bot Account](https://docs.mattermost.com/developer/bot-accounts.html) (oder normalen Benutzer) für openITCOCKPIT in Ihrer Mattermost Umgebung.

Anschließend erstellen Sie einen neuen [Incoming Webhook.](https://docs.mattermost.com/developer/webhooks-incoming.html)

![](/images/mattermost-webhooks.png)

Sobald Sie auf "Save" klicken, wird Mattermost Ihnen eine Webhook URL anzeigen. For Example: [*http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte*](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte). Kopieren Sie diese in eine Textdatei. Sie wird später noch benötigt.  
 

#### Selbst signierte Zertifikate oder private IP-Adressen

Wenn Sie private IP-Adressen verwenden, müssen Sie zuerst das Netzwerk oder die IP-Adresse Ihres openITCOCKPIT Servers in den Konfigurationsschlüssel *AllowedUntrustedInternalConnections* in Ihrer Mattermost's *config.json* hinzufügen.

```plaintext
"AllowedUntrustedInternalConnections": "192.168.122.32",
```

Lesen Sie auch: [Allow untrusted internal connections to](https://docs.mattermost.com/administration/config-settings.html#allow-untrusted-internal-connections-to)

Bei der Verwendung von Selbst signierten Zertifikaten müssen Sie die Option*EnableInsecureOutgoingConnections* in Ihrer Mattermost's *config.json aktivieren.*  
 

```plaintext
"EnableInsecureOutgoingConnections": true,
```

Lesen Sie auch: [Enable Insecure Outgoing Connections](https://docs.mattermost.com/administration/config-settings.html#enable-insecure-outgoing-connections)

### openITCOCKPIT Konfiguration

Öffnen Sie die Mattermost Module Konfiguration und füllen Sie die erforderlichen Felder aus.

![](/images/mattermost-config.png)

### Kommandos

Für die Benachrichtigung müssen die folgendes Kommandos genutzt werden.

Diese sollten bei der Installation des Moduls automatisch erstellt werden sein.

Host:

**Host Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake MattermostModule.mattermost_notification --type Host --notificationtype "$NOTIFICATIONTYPE$" --hostuuid "$HOSTNAME$" --state "$HOSTSTATEID$" --output "$HOSTOUTPUT$" --ackauthor "$NOTIFICATIONAUTHOR$" --ackcomment "$NOTIFICATIONCOMMENT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake MattermostModule.mattermost_notification --type Service --notificationtype "$NOTIFICATIONTYPE$" --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --state "$SERVICESTATEID$" --output "$SERVICEOUTPUT$" --ackauthor "$NOTIFICATIONAUTHOR$" --ackcomment "$NOTIFICATIONCOMMENT$"
```


## Slack

### Was kann ich mit dem Slack Modul tun?

Mit Hilfe des Slack Moduls kannst du Benachrichtigungen von openITCOCKPIT direkt in einen Channel deines Slack Workspace bekommen.

![](/images/slack-chatnotification.png)

### Was kann ich konfigurieren?

Unter "Systemkonfiguration → APIs → Slack" sind die Einstellungen für das Slack Modul zu finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning:  | Definiert die Adresse des Slack-Servers, an den das Modul die Benachrichtigungen senden soll **Example**: [https://hooks.slack.com/services/](https://hooks.slack.com/services/)[...](http://10.10.10.20/osm_tiles/%7Bz%7D/%7Bx%7D/%7By%7D.png) |
| OAuth Access Token | :warning: | Das Token erhält man von Slack für seinen Workspace Wird nur benötigt, wenn die Zwei-Wege Integration aktiviert ist |
| Enable Two-Way Integration |     | Über die Zwei-Wege Integration ist es Slack möglich Acknowledgements für Host und Services an openITCOCKPIT zu senden Für diese Option ist es erforderlich, dass der openITCOCKPIT Server über das Internet erreichbar ist |
| Request URL |     | Wird von openITCOCKPIT generiert und gibt die Webhook URL für Slack an Zuerst muss ein benutzerdefinierter API-Key) mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Gibt an, ob der konfigurierte Proxy verwendet werden soll |

### Einrichtung

openITCOCKPIT kommuniziert mit Slack über die Slack WebAPI und sendet als App Nachrichten in einen bestimmten Channel.

Gehe zum Erstellen der App auf die Webseite [https://api.slack.com/apps?new\_app=1](https://api.slack.com/apps?new_app=1)

Bestimme einen eigenen App Name und wähle deinen eigenen Slack Workspace aus.

![](/images/slack-createapp.png)

Wähle im linken Menü "Incoming Webhooks", aktiviere die Option oben rechts und füge deinem Workspace den Webhook mit Klick auf den unten stehenden Button hinzu.

![](/images/slack-webhooks.png)

Wähle einen Channel, in welchen die Nachrichten von openITCOCKPIT gepostet werden sollen.

![](/images/slack-identity.png)

Kopiere die eben erstellte Webhook URL und füge diese im openITCOCKPIT -> Administration -> Slack ein.

![](/images/slack-copywebhookurl.png)

![](/images/slack-configempty.png)

#### **Zwei-Wege-Integration**

Um Acknowledgements für Hosts und Services im Slack durchführen zu können, aktiviere die "Two-Way Integration".

openITCOCKPIT muss in diesem Fall von extern erreichbar sein.

Gehe dazu auf der Webseite der Slack API links im Menü auf "OAuth & Permissions", füge unten auf der Seite das Recht "users:read" hinzu und speichere die Änderungen.

Gegebenfalls muss der Webhook neu installiert werden. Folge dazu den Anweisungen am oberen Rand der Slack API Webseite.

Ist dies der Fall, muss ebenfalls die neue Webhook URL im openITCOCKPIT aktualisiert werden.

![](/images/slack-scopes.png)

Kopiere danach das generierte OAuth Access Token und füge es im openITCOCKPIT ein.

![](/images/slack-oauth.png)

Um die "Two-Way-Integration" zu aktivieren sollten die Slack Einstellungen wie folgt aussehen.

Optional kann die ausgehende Verbindung über den eingestellten Proxy aufgebaut werden.

Speichere deine Einstellungen und kopiere im nächsten Schritt die "Request URL".

![](/images/slack-configfilled.png)

Aktiviere "Interactive Messages" und füge die zuvor kopierte "Request URL" ein.

![](/images/slack-interactivemessages.png)

![](/images/slack-interactivemessages2.png)

#### **Aktiviere Slack Benachrichtigung**

Füge deinem Kontakt, die bei der Modulinstallation automatisch erstellten Kommandos hinzu, oder ersetze die Alten.

Danach speichern und exportieren.

![](/images/contacts-slacknotifications.png)

### Kommandos

Für die Benachrichtigung müssen die folgendes Kommandos genutzt werden.

Host:

**Host Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake SlackModule.SlackNotification --type Host --notificationtype $NOTIFICATIONTYPE$ --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake SlackModule.SlackNotification --type Service --notificationtype $NOTIFICATIONTYPE$ --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```