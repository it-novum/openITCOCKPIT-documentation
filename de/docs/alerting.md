## Kontakte

Kontakte werden in openITCOCKPIT genutzt, um Benachrichtigungen zu versenden. Diese Benachrichtigungen können je nach im Kontakt konfiguriertem Kommando beispielsweise per E-Mail, Browser Push-Benachrichtigung oder mit Erweiterungen auch über SMS, Chat Benachrichtigung oder ähnlichem versendet werden.

### Neuen Kontakt erstellen

Um einen neuen Kontakt zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu".

Danach wählen Sie im Formular einen oder mehrere Container aus in dem der Kontakt verfügbar sein soll und vergeben einen Namen sowie entweder eine E-Mail-Adresse oder eine Telefonnummer.

Anschließend wählen Sie die Benachrichtigungsmethode für den Host aus. Dazu wählen Sie die Zeitspanne und mindestens ein Kommando aus.

Damit die Benachrichtigungen für den Kontakt auch versendet werden, muss die Option "Hostbenachrichtigung aktiviert" aktiv sein.

mit den "Optionen zu Hostbenachrichtigungen" können Sie noch auswählen, wann eine Benachrichtigung erfolgen soll.

Die Konfiguration zur Servicebenachrichtigung erfolgt nach demselben Schema.


## Kontaktgruppen
Kontaktgruppen sind Sammlungen von Kontakten. Sie dienen zur Vereinfachung der massenhaften Zuweisung von Kontakten an verschiedenste Objekte. 
Kontaktgruppen können meist anstatt einzelner Kontakte wie zum Beispiel beim Erstellen von Host, Services, Eskalationen, Abhängigkeiten oder Vorlagen ausgewählt werden. 

### Ist meine Kontaktgruppe in verwendung?
mit der Funktion "Verwendet von" (Used By) ist es möglich eine Übersicht über die Verwendung der jeweiligen Kontaktgruppe zu bekommen. 
![contactgroup used by list item](/images/contactgroups-usedbylistitem.png)


## Eskalationen
Benachrichtigungseskalationen können verwendet werden, um eine oder mehrere Benutzergruppen im Notfall zu benachrichtigen. Wenn ein Host oder Dienst eskaliert, werden Kontakte, Kontaktgruppen und Benachrichtigungsoptionen durch die Eskalation überschrieben. Sie funktionieren für Hosts gleichermaßen wie für Services.

### Wann werden Benachrichtigungen eskaliert?
Benachrichtigungen werden nur dann eskaliert, wenn mindestens eine Eskalationsdefinition mit der betreffenden Benachrichtigung übereinstimmt. In einer Eskalation wird ein "Bereich" definiert, ab wann Benachrichtigungen eskaliert werden sollen. Dieser Bereich wird bestimmt durch die Erste Benachrichtigung (Ab der wievielten Benachrichtigung greift die Eskalation) und die letzte Benachrichtigung (Ab der wievielten Benachrichtigung greift wieder die Standardmäßig definierten Benachrichtigungsoptionen des Objekts)
ist ein Eskalationszeitraum definiert, so greift die Eskalationsdefinition nur innerhalb des angegebenem [Zeitabschnittes](../configuration/timeperiods/).
Über die Eskalationsoptionen kann ausgewählt werden für welche Zustände eine Eskalation angestoßen werden soll. Dies sind für Hosts die Zustände:
- Wiederherstellung (Recovery)
- Nicht verfügbar (Down)
- Nicht erreichbar (Unreachable)

und für Services:

- Wiederherstellung (Recovery)
- Warnung (Warning)
- Kritisch (Critical)
- Unbekannt (Unknown)

Die Felder Kontakte und Kontaktgruppen definieren die Kontakte, die im Eskalationsfall Benachrichtigt werden. 




## Host / Service Abhängigkeiten
Abhängigkeiten sind eine Möglichkeit Benachrichtigungen und Überprüfungsausführungen für bestimmte Objekte anhand von Statusinformationen abhängiger Objekte zu unterdrücken. 
In openITCOCKPIT ist es möglich Abhängigkeiten für Hosts und Hostgruppen sowie Services und Servicegruppen zu definieren. 

Dies funktioniert folgendermaßen:
Bevor Naemon einen Servicecheck ausführt oder eine Benachrichtigung sendet, wird der Host oder der Service nach Abhängigkeiten überprüft. Ist keine Abhängigkeit definiert, so wird der Check ausgeführt und die Benachrichtigung ganz normal versendet. Ist eine Abhängigkeit definiert, wird jede Abhängigkeit wie folgt überprüft:

1. Der Status des abhängigen Hosts oder Services wird geholt.
2. Dieser Status wird abgeglichen mit den Ausführungs oder Benachrichtigungsfehlerkriterien (Je nachdem was zu diesem Zeitpunkt relevant ist) 
3. Wenn dieser Status mit einem der ausgewählten Fehlerkriterien übereinstimmt, gilt die Abhängigkeit als fehlgeschlagen und Naemon wird die weitere Überprüfung der Abhängigkeiten abbrechen.
4. Wenn dieser Status nicht mit einer der ausgewählten Fehlerkriterien übereinstimmt, gilt die Abhängigkeit als bestanden und Naemon wird die nächste Abhängigkeit überprüfen

Diese Schleife wird so lange ausgeführt, bis entweder alle Abhängigen Host oder Services die Überprüfung bestanden haben oder eine Abhängigkeit fehlschlägt.  

!!! info
    Solange nicht anders konfiguriert, wird Naemon den aktuellsten hard state der abhängigen Hosts oder Services für die überprüfung nutzen. 

#### Ausführungsfehlerkriterien
Diese Art der Abhängigkeiten werden genutzt, um aktive Überprüfungen (active checks) zu temporär auszusetzen. 
Sollten alle Abhängigkeitsüberprüfungen für einen Host oder Service erfolgreich sein, wird Host oder Services ganz normal überprüft. 
Schlägt eine Abhängigkeitsüberprüfung fehl, so wird Naemon die Überprüfung (Host-/Servicecheck) für den (abhängigen) Host oder Service temporär überspringen. Wenn alle Abhängigkeiten die Überprüfung (zu einem späteren Zeitpunkt) bestehen, wird die Ausführung der Überprüfung (Host-/Servicecheck) ganz normal fortgesetzt.

#### Benachrichtigungsfehlerkriterien
Wenn alle Abhängigkeitsüberprüfungen für einen Host oder Service erfolgreich sind, werden Benachrichtigungen ganz normal versendet. 
Schlägt eine Abhängigkeitsüberprüfung fehl, werden die Benachrichtigungen für den (abhängigen) Host oder Service temporär unterdrückt. Wenn alle Abhängigkeiten die Überprüfung (zu einem späteren Zeitpunkt) bestehen, wird das Senden der Benachrichtigungen für den (abhängigen) Host oder Service ganz normal fortgesetzt.

#### Abhängigkeitsvererbung
Abhängigkeiten werden nicht automatisch vererbt. Dies bedeutet, wenn ein Host oder Service (A) eine Abhängigkeit (B) besitzt und diese Abhängigkeit wiederum auch Abhängigkeiten (C) besitzt, so ist A standardmäßig nicht von C abhängig. Um die Abhängigkeit zu aktivieren, muss die Option "Erbt Elternteil" (inherits parent) aktiviert werden

### Host Abhängigkeiten
Host Abhängigkeiten unterscheiden sich in ihrer Funktion nicht von Service Abhängigkeiten.

1. Ein Host kann Abhängigkeiten zu einem oder mehreren Hosts haben.
2. Host Abhängigkeiten werden Standardmäßig nicht vererbt (Über Option vererbbar).
3. Host Abhängigkeiten können zum Unterdrücken von Benachrichtigungen und Check Ausführungen genutzt werden.
4. Host Abhängigkeiten sind, wenn konfiguriert, nur innerhalb von [Zeitabschnitten](../configuration/timeperiods/) gültig.

### Service Abhängigkeiten
Service Abhängigkeiten unterscheiden sich in ihrer Funktion nicht von Host Abhängigkeiten.

1. Ein Service kann Abhängigkeiten zu einem oder mehreren Services haben.
2. Ein Service kann Abhängigkeiten zu Services haben, die nicht in verbindung mit demselben Host stehen.
3. Service Abhängigkeiten werden Standardmäßig nicht vererbt (über Option vererbbar).
4. Service Abhängigkeiten können zum Unterdrücken von Benachrichtigungen und Check Ausführungen genutzt werden.
5. Service Abhängigkeiten sind, wenn konfiguriert, nur innerhalb von [Zeitabschnitten](../configuration/timeperiods/) gültig.


## Mattermost Modul

### Was kann ich mit dem Mattermost Modul tun?

Dieses Modul bietet die Möglichkeit einer Zwei-Wege-Integration von Mattermost in openITCOCKPIT. Alarme können an Mattermost gesendet werden und Bestätigungen (Acknowledgements) können von Mattermost an openITCOCKPIT geschickt werden.

![](/images/mattermost-chat.png)

### Was kann ich konfigurieren?

Unter "API Mattermost" können Sie die Konfiguration finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning: | Definiert die Adresse des Mattermost Servers, welcher genutzt werden soll. **Example**: [http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte) |
| Enable Two-Way Integration |     | Über die Zwei-Wege-Integration kann Mattermost Acknowledgements an openITCOCKPIT Senden. Ohne werden nur Alarme an Mattermost geschickt. |
| openITCOCKPIT API Key |     | Dieser API-Key wird von Mattermost genutzt um die Acknowledgements an openITCOCKPIT zu schicken. Zuerst muss ein benutzerdefinierter API-Key mit openITCOCKPIT erstellt werden |
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

Bei der Verwendung von Selbst signierten Zertifikaten müssen Sie die Option*EnableInsecureOutgoingConnections* in Ihrer Mattermost's *config.json aktivieren.*  


```plaintext
"EnableInsecureOutgoingConnections": true,
```

Lesen Sie auch: [Enable Insecure Outgoing Connections](https://docs.mattermost.com/administration/config-settings.html#enable-insecure-outgoing-connections)

### openITCOCKPIT Konfiguration

Öffnen Sie die Mattermost Module Konfiguration und füllen Sie die erforderlichen Felder aus.

![](/images/mattermost-config.png)

### Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

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

Mithilfe des Slack Moduls kannst du Benachrichtigungen von openITCOCKPIT direkt in einen Channel deines Slack Workspace bekommen.

![](/images/slack-chatnotification.png)

### Was kann ich konfigurieren?

Unter "Systemkonfiguration → APIs → Slack" sind die Einstellungen für das Slack Modul zu finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning:  | Definiert die Adresse des Slack-Servers, an den das Modul die Benachrichtigungen senden soll **Example**:[https://hooks.slack.com/services/](https://hooks.slack.com/services/)[...](http://10.10.10.20/osm_tiles/%7Bz%7D/%7Bx%7D/%7By%7D.png) |
| OAuth Access Token | :warning: | Das Token erhält man von Slack für seinen Workspace Wird nur benötigt, wenn die Zwei-Wege Integration aktiviert ist |
| Enable Two-Way Integration |     | Über die Zwei-Wege Integration ist es Slack möglich Acknowledgements für Host und Services an openITCOCKPIT zu senden Für diese Option ist es erforderlich, dass der openITCOCKPIT Server über das Internet erreichbar ist |
| Request URL |     | Wird von openITCOCKPIT generiert und gibt die Webhook URL für Slack an Zuerst muss ein benutzerdefinierter API-Key) mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Gibt an, ob der konfigurierte Proxy verwendet werden soll |

### Einrichtung

openITCOCKPIT kommuniziert mit Slack über die Slack WebAPI und sendet als App Nachrichten in einen bestimmten Channel.

Gehe zum Erstellen der App auf die Webseite [https://api.slack.com/apps?new\_app=1](https://api.slack.com/apps?new_app=1)

Bestimme eine eigene App Name und wähle deinen eigenen Slack Workspace aus.

![](/images/slack-createapp.png)

Wähle im linken Menü "Incoming Webhooks", aktiviere die Option oben rechts und füge deinem Workspace den Webhook mit Klick auf den unten stehenden Button hinzu.

![](/images/slack-webhooks.png)

Wähle einen Channel, in welchen die Nachrichten von openITCOCKPIT gepostet werden sollen.

![](/images/slack-identity.png)

Kopiere die eben erstellte Webhook URL und füge diese im `openITCOCKPIT -> Administration -> Slack` ein.

![](/images/slack-copywebhookurl.png)

![](/images/slack-configempty.png)

#### **Zwei-Wege-Integration**

Um Acknowledgements für Hosts und Services im Slack durchführen zu können, aktiviere die "Two-Way Integration".

openITCOCKPIT muss in diesem Fall von extern erreichbar sein.

Gehe dazu auf der Webseite der Slack API links im Menü auf "OAuth & Permissions", füge unten auf der Seite das Recht "users:read" hinzu und speichere die Änderungen.

Gegebenenfalls muss der Webhook neu installiert werden. Folge dazu den Anweisungen am oberen Rand der Slack API Webseite.

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

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

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



## Axios Assyst

Das Axios Assyst Modul bietet eine Schnittstelle zum Axios Assyst Ticketsystem. Diese SOAP Schnittstelle bietet die möglichkeit Tickets in Assyst zu eröffnen und bei einem Grünen Status des entsprechenden Host oder Services, das Ticket automatisiert wieder zu schließen. Zudem können Benachrichtigungen von openITCOCKPIT direkt in Assyst bestätigt werden.



## ServiceNow

### Voraussetzungen

-   openitcockpit-module-servicenow
-   ServiceNow Instanz (London)

### Einrichtung

#### ServiceNow Benutzer anlegen

Um das ServiceNow Modul mit einer ServiceNow (London) Instanz zu verbinden, muss ein ServiceNow Benutzer angelegt werden.

![](/images/servicenow-usersmenu.png)

Die Angabe folgender Parameter ist nötig:

-   User ID: openitcockpit
-   First Name: openITCOCKPIT
-   Time zone: (wie im openITCOCKPIT System)
-   Active: (true)
-   Passwort

Der Benutzer sollte **keinen Nachnamen** haben und die User ID sowie der Vorname sollten keine Leerzeichen (Sonderzeichen) enthalten!

Nachdem der Benutzer gespeichert wurde, muss dieser erneut editiert werden.

Dem Benutzer muss (am Ende der Seite) über Roles → Edit die neue Role 'incident\_manager' hinzugefügt werden.

Danach muss die Role über **Save** gespeichert und der Benutzer über **Update** aktualisiert werden.

![](/images/servicenow-userrolesedit.png)

![](/images/servicenow-userrolesedit2.png)

#### ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren

Um URLs zu Hosts und Services aus openITCOCKPIT im ServiceNow Incident anzeigen zu können, muss eine eigene Incident View erstellt werden.

Dazu öffnet man zuerst ein beliebiges Incident (Menü → Incidents → All → Klick auf Incident ID), drückt auf den Menübutton oben links und navigiert zu dem Punkt Configure → Form Design.

Auf dieser Seite sollten oben links die Tabelle 'Incident' und die Ansicht 'Default view' ausgewählt sein.

![](/images/servicenow-incidentfields.png)

Um die ausgewählte Ansicht zu klonen, öffnet man das Dropdown Menü, welches aktuell 'Default view' anzeigt und klickt auf '**New...**'

![](/images/servicenow-incidentnew.png)

Auch hier sollte der Name 'openITCOCKPIT' gewählt und mit OK bestätigt werden.

![](/images/servicenow-createview.png)

Nun sollte im Dropdown die neue View ausgewählt sein.

Auf der linken Seite gibt man im Tab 'Field Types' den Filter 'URL' ein. Es sollte ein Objekt für ein neues URL-Feld erscheinen.

![](/images/servicenow-newurlfield.png)

**Das URL-Objekt** wird per Drag-and-drop auf die rechte Seite an die gewünschte Stelle in die Boxen gezogen.

Dies muss 2x zum Erstellen der Felder 'Host URL' und 'Service URL' getan werden.

Empfohlene Konfiguration:

(Die Objekte für die Felder 'Host URL' und 'Service URL' in der zweiten Box unter dem Objekt 'Description' anordnen)

![](/images/servicenow-incidentfieldtype.png)

Nach dem Hinzufügen der zwei URL Objekte müssen diese über das Zahnrad auf der rechten Seite editiert werden.

Für das Label 'Host URL' muss der Name 'u\_host\_url' und für das Label 'Service URL' der Name 'u\_service\_url' gewählt werden.

![](/images/servicenow-hosturlproperties.png)

![](/images/servicenow-serviceurlproperties.png)

Danach kann die Konfiguration oben rechts mit 'Save' gespeichert und der Tab geschlossen werden.

Damit die eben angelegte Incident View automatisch für von openITCOCKPIT angelegte Incidents ausgewählt wird, muss eine 'View Rule' erstellt werden.

![](/images/servicenow-viewrules.png)

Die View Rule sollte wie folgt definiert werden:

Als Table muss 'Incident' ausgewählt werden.

Der Wert für View entspricht dem Names der eben selbst definierten Incident View.

Als Condition sollte 'Caller' → 'is' → 'openITCOCKPIT' definiert werden.

Der Wert für Caller entspricht dem Names des für openITCOCKPIT angelegten ServiceNow Benutzers.

Gespeichert wird die Rule mit 'Submit'

![](/images/servicenow-newviewrole.png)

#### Modul Konfiguration speichern

Im openITCOCKPIT den Menüpunkt Systemkonfiguration → APIs → ServiceNow öffnen und User ID / Password des eben erstellten Benutzers eintragen.

Die eigene ServiceNow URL nach dem angegebenen Schema eintragen.

Sollte ein Host/Service den Up/Ok State verlassen, wird ein ServiceNow Incident erstellt.

Soll diesem Incident eine 'Assignment Group' oder ein 'Assigned To' - Benutzer zugeordnet werden, so muss der Name der Gruppe / des Benutzers hier angegeben werden.

Für 'Impact' und 'Urgency' gibt es jeweils 3 verfügbare Optionen (High, Medium, Low) aus denen sich die Incident Priorität zusammensetzt, die in der ServiceNow Incident Liste angezeigt wird.

Details zur Prioritätsberechnung gibt es in der offiziellen [ServiceNow Dokumentation](https://docs.servicenow.com/bundle/london-it-service-management/page/product/incident-management/reference/r_PrioritizationOfIncidents.html?cshalt=yes).

![](/images/servicenow-config.png)

#### Benachrichtigung aktivieren

Den Kontakten, über die ServiceNow benachrichtigt werden soll, muss der Command 'host-notify-by-servicenow' / 'service-notify-by-servicenow' hinzugefügt werden.

Es können auch mehrere Commands oder eine andere Time period ausgewählt sein.

Zur korrekten Funktionsweise muss immer die Benachrichtigung bei Auftreten des 'Recovery' States aktiviert sein!

Da es sich hierbei um Änderungen an der Nagios Konfiguration handelt, muss nach diesem Schritt ein Export durchgeführt werden.

![](/images/contacts-servicenownotifications.png)

### Zwei-Wege-Integration Einrichten

Um Acknowledgements für Hosts und Services über die ServiceNow Incidents durchführen zu können, aktiviere "Two-Way Integration" im openITCOCKPIT Systemkonfiguration → APIs → ServiceNow.

Der openITCOCKPIT Server muss in diesem Fall von extern über http oder https mit einem gültigen und verifizierten SSL Zertifikat erreichbar sein.

**Wichtig: Wenn vorhanden, muss das "full chained" Zertifikat genutzt werden.** (Wird mit LetsEncrypt automatisch erstellt)

Damit Incident Updates automatisch an openITCOCKPIT gesendet werden können, muss eine ServiceNow 'Business Rule' angelegt werden.

Dazu navigiert man im Menü zu 'System Definition' → 'Business Rule'.

Als Name wird 'openITCOCKPIT' empfohlen, dies ist jedoch nicht essenziell.

Es muss für die Rule die Table 'Incident' ausgewählt, sowie die Optionen 'Active' und 'Advanced' aktiviert werden.

Im Tab '**When to run**' müssen folgende Einstellungen getroffen werden:

(Die angegebenen 'Filter Conditions' sind über 'AND' verknüpft)

Der 'Caller' und 'Updated by' Wert entspricht dem Namen des angelegten Benutzers (hier 'openITCOCKPIT').

![](/images/servicenow-businessrule.png)

Im Tab '**Advanced**' muss folgender Quellcode in das 'Script' Feld eingefügt werden (es wird an dieser Stelle keine 'Condition' benötigt):

Der Wert der Variable 'openITCOCKPIT\_url' muss der extern erreichbaren eigenen openITCOCKPIT URL entsprechen.

Der Wert der Variable 'openITCOCKPIT\_apikey' muss einem selbst generierten, gültigen openITCOCKPIT Api Key entsprechen.

**Business Rule Script (Vorlage)**

```plaintext
(function executeRule(current, previous /*null when async*/) {

    try {

        var openITCOCKPIT_url = "https://demo.openitcockpit.io";
        var openITCOCKPIT_apikey = "551ad76bcdb0.....";

        var openITCOCKPIT_servicenow_path = "/servicenow_module/servicenow_acknowledge/submit.json";
        var request = new sn_ws.RESTMessageV2();
        request.setEndpoint(openITCOCKPIT_url + openITCOCKPIT_servicenow_path);
        request.setRequestHeader("Accept","application/json");
        request.setRequestHeader('Content-Type','application/json;charset=UTF-8');
        request.setHttpMethod('POST');
        request.setQueryParameter('apikey', openITCOCKPIT_apikey);

        var data = {};
        data.short_description = current.getValue('short_description');
        data.impact = current.getValue('impact');
        data.urgency = current.getValue('urgency');
        data.state = current.getValue('state');
        data.incident_id = current.getValue('number');
        data.close_notes = current.getValue('close_notes');
        data.close_code = current.getValue('close_code');
        data.sys_resolved_by = current.getValue('resolved_by');
        data.updated_by = current.getValue('sys_updated_by');

        var myJSON = JSON.stringify(data);
        request.setRequestBody(myJSON);

        var response = request.execute();
        gs.log(myJSON);
        gs.log('openITCOCKPIT HTTP Status Code: '+response.getStatusCode());
        gs.log('openITCOCKPIT Error Message:');
        gs.log(response.getErrorMessage());
        gs.log('openITCOCKPIT Response Body:');
        gs.log(response.getBody());

    }catch(err){
        gs.log('openITCOCKPIT Rule Error: '+err);
    }

})(current, previous);
```

### Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

Beim Installieren des Moduls sollten diese automatisch angelegt werden.

**Host Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Host --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

**Service Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Service --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```

### Debugging

Sollte die Two-Way Integration nicht funktionieren, sollte überprüft werden, ob das sog. **"full chained" Zertifikat** genutzt wird. (Wird mit LetsEncrypt automatisch erstellt)

Um in ServiceNow den Debug Output des Business Rule Aufrufs zu erhalten, Beispielsweise beim Ändern von Incidents, muss im Menü zu 'System Diagnostics' → 'Debug Business Rule' navigiert werden.

Zum Aktivieren des Debug Modus muss auf den Link 'available here' und im sich darauf hin öffnenden Tab auf den Button 'Update' geklickt werden.

![](/images/servicenow-debugbusinessrule.png)

![](/images/servicenow-scriptexecutionhistory.png)

Danach kann wieder zum Incident navigiert und dieses aktualisiert werden.

Die Debug Ausgabe sollte nun am Ende der Seite erscheinen.

### Benutzung

Um Hosts / Services an ServiceNow anzubinden, muss dem jeweiligen 'Contact' der Hostcommand'host-notify-by-servicenow' und der Servicecommand 'service-notify-by-servicenow' hinzugefügt werden.

Alles Hosts / Services mit diesem Kontakt werden bei einer neuen Benachrichtigung als Incident an ServiceNow angebunden.

Beim Update des Incidents durch einen beliebigen Benutzer, der nicht openITCOCKPIT ist, wird ein Acknowledgement für den Host / Service erstellt, solange dieser noch nicht wieder im Up / Ok State ist.

Hierbei wird in der Acknowledgementnachricht die ServiceNow Incident Nummer (mit Verlinkung) angezeigt.

Schematische Darstellung möglicher Interaktionen mit ServiceNow:

![](/images/servicenow-schema.png)

Im Hosts - und Services Browser erscheint bei Aktivierung des ServiceNow Moduls der Tab 'ServiceNow'. Dort können von der globalen Konfiguration abweichende Host- bzw. Service-Spezifische Incident Einstellungen getroffen werden.

An dieser Stelle können die globalen Parameter 'Incident', 'Urgency', 'Assignment Group', 'Assigned To' und 'Business Service' überschrieben werden.

Updates eines von openITCOCKPIT erstellten Incidents (über ServiceNow) bewirken bei korrekt konfigurierter Two-Way Integration ein Acknowledgement des Host / Service.

Dabei werden die Incident Felder 'State' und 'Updated By' neben der Incident 'Number' übermittelt.

Beim Ändern des Incident State auf 'Closed' oder 'Resolved' wird zusätzlich der 'Resolution Code', die 'Resolution Notes', sowie die System-ID des 'Resolved By' Benutzers an openITCOCKPIT übertragen.

![](/images/servicenow-schema2.png)


## PagerDuty

### Was kann ich mit dem PagerDuty Modul tun?

Mithilfe des PagerDuty Moduls kannst du Host- und Service-Benachrichtigungen von openITCOCKPIT direkt in einen PagerDuty Account bekommen.

Im Gegensatz zu unserer E-Mail-Integration kann PagerDuty Tickets verschiedener Quellen strukturiert anzeigen und verwalten.

Sobald auf einem Host oder Service ein Fehler auftritt, wird ein PagerDuty Ticket erstellt.  


Bei Verwendung der PagerDuty App können die Benachrichtigungen auch auf dem Smartphone empfangen werden. Mehrere Benachrichtigungen zu einem Host oder Service werden in einem Ticket zusammengefasst.

Nach Konfiguration der Zwei-Wege Integration werden Ticket Acknowledgements(Bestätigungen) auch wieder zurück ins openITCOCKPIT übertragen.

Der Autor und ein Link zum Ticket werden in der Host / Service Acknowledgement Nachricht im openITCOCKPIT angezeigt.

Wenn der Host oder Service den Status Up oder Ok wiedererlangt, wird das PagerDuty Ticket automatisch geschlossen, sofern es noch geöffnet war.

![](/images/pagerduty-incidents.png)

#### Was kann ich konfigurieren?

Unter "Configuration / PagerDuty" sind die Einstellungen für das PagerDuty Modul zu finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Api key | :warning: | API Key von PagerDuty |
| Integration Key | :warning: | Der Integration Key, den du nach dem Erstellen eines Service auf PagerDuty bekommen hast |
| API URL | :warning: | API URL des PagerDuty Service. |
| Enable Two-Way Integration |     | Über die Zwei-Wege Integration ist es Slack möglich Acknowledgements für Host und Services an openITCOCKPIT zu senden Für diese Option ist es erforderlich, dass der openITCOCKPIT Server über das Internet erreichbar ist |
| Webhook URL |     | Wird von openITCOCKPIT generiert und gibt die Webhook URL für PagerDuty an Zuerst muss ein benutzerdefinierter API-Key mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Gibt an, ob der konfigurierte Proxy verwendet werden soll |

### Installation

#### Einfache Integration

Mit der einfachen Integration kann openITCOCKPIT Tickets in PagerDuty öffnen, eine Acknowledgments erstellen und Tickets schließen. Acknowledgments die in PagerDuty erstellt werden, können jedoch nicht ans openITCOCKPIT übertragen werden.

openITCOCKPIT kommuniziert mit PagerDuty über die API Version 2.

Um dies zu tun, musst du zuerst einen API Key erstellen. Dazu navigierst du im PagerDuty Menü zum Punkt Configuration → Api Access.  


Klicke auf den "**Create New Api Key**" Button, gib eine Beschreibung ein, wähle API version 2 aus und bestätige mit "**Create Key**".

![](/images/pagerduty-createapikey.png)

Kopiere im nächsten Dialog den API Key im openITCOCKPIT auf die Seite PagerDuty settings.

![](/images/pagerduty-getapikey.png)

Da der API Key nicht erneut angezeigt werden kann, sollte dieser sofort gespeichert werden.

Anschließend muss ein neuer Service angelegt werden.

Navigiere zum Menüpunkt Configuration → Services und klicke auf "**\+ New Service**".

Hier ist es wichtig, dass als "Integration Type" aus der Auswahlbox ("Select a tool") "**openITCOCKPIT**" ausgewählt wird.

![](/images/pagerduty-addservice.png)

  


Die Option Incident Behavior muss auf "*Create incidents*" eingestellt werden!

Klicke auf "**Add Service**" und kopiere den angezeigten "Integration Key".

#### Zwei-Wege Integration

Mit unserer Zwei-Wege Integration werden in PagerDuty erstellte Acknowledgements auch in dein openITCOCKPIT übertragen.

Für die bidirektionale Integration muss ein Webhook erstellt werden.

Navigiere zum Menüpunkt Configuration →Extensions.

Klicke auf "**\+ New Extension**" und wähle "*Generic V2 Webhook*" aus.

Kopiere die Webhook URL aus den openITCOCKPIT PagerDuty Einstellungen in das URL-Feld und ersetze "*YOUR\_API\_KEY\_HERE*" mit einem neuen API Key.

Wenn dein System hinter einem Proxy ist, musst du den Hostnamen eventuell manuell anpassen.

Um einen openITCOCKPIT API Key zu erstellen, klicke auf dein Benutzerprofil in der linken oberen Ecke im openITCOCKPIT und scrolle bis zum Ende der Seite. Dort kannst du einen neuen API Key erstellen.

![](/images/pagerduty-serviceextensions.png)

Klicke auf "**Save**", um die Erweiterung zu speichern.

#### Aktualisieren der openITCOCKPIT Konfiguration

Schließlich müssen alle noch nicht kopierten Parameter in die Konfiguration des openITCOCKPIT PagerDuty Moduls übertragen werden.

Vergiss nicht deine Änderungen zu speichern.

![](/images/pagerduty-config.png)

Um nach dem Auftreten eines Problems benachrichtigt zu werden, benötigt der Host- / Servicekontakt die PagerDuty Benachrichtigungsbefehle.

Suche im openITCOCKPIT Menü nach "Contacts" oder gehe direkt zu "Monitoring→ Objects → Contacts".

Klicke auf der Kontaktseite auf das Zahnrad auf der rechten Seite.

![](/images/menu-contacts.png)

![](/images/contacts-editcontact.png)

Bearbeite den Kontakt, über den PagerDuty benachrichtigt werden soll, füge den Befehl "*host-notify-by-pagerduty*" zu den Host Commands hinzu und "*service-notify-by-pagerduty*" den Service Commands.

![](/images/contacts-pagerdutynotifications.png)

**Fertig. Die Konfiguration ist abgeschlossen.**  
