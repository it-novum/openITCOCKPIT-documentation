# E-Mail Layouts

Das Versenden von Benachrichtigungen mithilfe von E-Mails wird von fast allen Anwendern genutzt. E-Mail Benachrichtigungen
werden dabei als HTML und Plaintext E-Mails verschickt. Um die Benachrichtigungen besser an die jeweiligen Bedürfnisse anpassen zu können,
können vom Anwender eigene E-Mail Layouts hinterlegt werden. Somit kann das Aussehen und der Inhalt der Benachrichtigungen individuell angepasst werden.

![email layout option](/images/alerting/openitcockpit-4-notifications.png)

## Ein Layout erstellen

Für die Benachrichtigungen von Hosts und Services werden jeweils unterschiedliche Layouts verwendet. Insgesamt sollten vier Dateien erstellt werden.

**Hosts:**

```sh
# Für HTML E-Mails
cp /opt/openitc/frontend/src/Template/email/html/notification_host.php /opt/openitc/frontend/src/Template/email/html/custom_layout_notification_host.php

# Für Plain Text E-Mails
cp /opt/openitc/frontend/src/Template/email/text/notification_host.php /opt/openitc/frontend/src/Template/email/text/custom_layout_notification_host.php
```

**Services**
```sh
# Für HTML E-Mails
cp /opt/openitc/frontend/src/Template/email/html/notification_service.php /opt/openitc/frontend/src/Template/email/html/custom_layout_notification_service.php

# Für Plain Text E-Mails
cp /opt/openitc/frontend/src/Template/email/text/notification_service.php /opt/openitc/frontend/src/Template/email/text/custom_layout_notification_service.php
```

!!! warning
    Wichtig ist, das die Datei mit `_host.php` bzw. `_service.php` enden muss. Der Dateiname darf nur aus Buchstaben, Zahlen, Bindestrichen und Unterstrichen bestehen.

Um eine Test-E-Mail zu versenden, kann der Befehl `oitc` genutzt werden.
```
oitc nagios_notification -v --type Host --notificationtype PROBLEM --hostname c36b8048-93ce-4385-ac19-ab5c90574b77 --hoststate down --hostaddress 127.0.0.1 --hostoutput "Test E-Mail" --contactmail <email address> --layout custom_layout_notification
```

Wichtig ist, dass die Parameter `--hostname`, `--contactmail` und `--layout` entsprechend angepasst werden.

Wenn das System das angegebene Layout nicht finden kann, wird eine Fehlermeldung angezeigt
```
2021-09-10 08:58:59 Error: Notification: HTML or plain text layout "foobar_layout_notification" not found. Using default.
```
Zusätzlich wird der Fehler in der Datei `/opt/openitc/frontend/logs/cli-error.log` protokolliert. 

## Layout verwenden

Nachdem ein eigenes Layout erstellt worden ist, müssen die zwei Kommandos `host-notify-by-email` und `service-notify-by-email`
um den Parameter `--layout custom_layout_notification` erweitert werden.

Im Anschluss nutzt openITCOCKPIT das eigene Layout als Vorlage für E-Mails.

![custom email layout](/images/alerting/openitcockpit-custom-email-layout.png)

## Html und Text E-Mails
Über den Parameter `--format` kann angegeben werden, welche Art von E-Mail verschickt wird.

| Format | Beschreibung |
|------|------------|
| `both`   | Versendet eine Html + Text E-Mail. Der Client kann entscheiden, welches Format angezeigt wird. |
| `html` | Versendet nur eine Html E-Mail         |
| `text`   | Versendet nur eine Text E-Mail         |

Über den Parameter `--no-attachments` können alle E-Mail Anhänge wie Logos und Graphen deaktiviert werden, um Speicherplatz zu sparen.

## E-Mail Logo ändern
Das verwendete Logo kann über das [Design Module](/additional/theming/) geändert werden.




