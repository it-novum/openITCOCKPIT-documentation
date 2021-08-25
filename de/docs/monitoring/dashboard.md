## Dashboards

Das Dashboard ist die Startseite in openITCOCKPIT. 

Nach der Installation findet man hier ein Default Dashboard, dass verschiedene Widgets anzeigt. 

### Dashboard Hinzufügen

Um ein neues Dashboard hinzuzufügen, klickt man auf das “+” Symbol im oberen rechten Rand des Dashboards

![](/images/dashboards-newdashboard.png)

Danach öffnet sich ein Popup fenster in dem man die Wahl hat ein neues Dashboard, oder aus den geteilten Dashboards ein neues zu erstellen. 

![](/images/dashboards-newdashboardpopup.png)

### Dashboard Teilen

Es gibt in openITCOCKPIT die möglichkeit Dashboards zu teilen. Dazu klickt man zu erst auf den nach unten zeigenden Pfeil (1) an einem Dashboard Tab und danach auf “Starte Teilen”. 

Die geteilten Dashboards stehen dann anderen Benutzern in openITCOCKPIT zur Verfügung.

![](/images/dashboards-sharing.png)

Wenn ein Dashboard bereits geteilt ist, dann steht in der Auswahlliste “Stoppe Teilen”. Darüber kann das Teilen des Dashboard Tabs wieder gestoppt werden.

### Dashboard Rotation

Eine Dashboard Rotation bewirkt, dass alle vorhandenen Dashboard Tabs in einem vom Benutzer, zwischen 10 Sekunden und 15 minuten, festgelegten Intervall nacheinander angezeigt werden.

Im zusammenspiel mit der Vollbildansicht der Dashboards kann dies nützlich sein um openITCOCKPIT beispielsweise auf einem TV anzuzeigen.

### Dashboard Löschen

Um ein Dashboard zu löschen, klicken Sie  zu erst auf den nach unten zeigenden Pfeil (1) an einem Dashboard Tab und danach auf Löschen (2).

![](/images/dashboards-delete.png)

### Widget Hinzufügen 

Um ein neues Widget auf einem Dashboard hinzuzufügen, klicken Sie auf die Schaltfläche “Widget hinzufügen”

![](/images/dashboards-addwidget.png)

Anschließend öffnet sich eine Auswahlliste mit allen verfügbaren Widgets. 

Nach dem man das entsprechende Widget hinzugefügt hat, muss dies gegebenenfalls noch Konfigurieren.

![](/images/dashboard-widgetconfig.png)

Nach dem Speichern der Widget Konfiguration wird das Widget mit Inhalt angezeigt. 

#### Widgets

##### Willkommen
![welcome widget](/images/dashboard-welcomewidget.png)

- Beschreibung

Zeigt eine eine die Gesamtanzahl, der für einen Benutzer sichtbaren, überwachten Hosts und Services an. Zudem wird die Benutzer Zeitzone, openITCOCKPIT Version und die Edition angezeigt.

- Konfiguration


##### Übergeordnete Ausfälle
![parent outages widget](/images/dashboard-parentoutageswidget.png)

- Beschreibung

Zeigt eine Liste aller nicht erreichbaren verknüpften Eltern Objekte.

- Konfiguration


##### Host/Service Kreisdiagramm (180)
![hosts services piecharts](/images/dashboard-host-services-piecharts.png)

- Beschreibung

Zeigt (je nach auswahl) halbes oder ganzes Tortendiagramm aller Hosts oder Services und deren Status. Beim Klick auf die Statusfarbe unter dem Diagramm öffnet sich eine Liste mit den Hosts oder Services im ausgewählten Status.

- Konfiguration

##### Ampel
![traffic light widget](/images/dashboard-trafficlightwidget.png)

- Beschreibung

Zeigt die Statusfarbe eines Services an

- Konfiguration

Es muss ein Service ausgewählt werden, dessen Status angezeigt werden soll. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Geschwindigkeitsmesser (Tacho Widget)
![Tacho widget](/images/dashboard-tachowidget.png)

- Beschreibung

Zeigt den wert eines Performance Datensatzes eines Services an. Schwellwerte werden zusätzlich farblich markiert.

- Konfiguration

Es muss ein Service, sowie ein Performance Datensatz ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


##### Notiz
![notice widget](/images/dashboard-noticewidget.png)

- Beschreibung

Das Notiz Widget kann Text, HTML oder Markdown anzeigen.

- Konfiguration

Es kann Text, HTML oder Markdown in das Textfeld eingefügt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Host/Service in Wartungszeit
![host service downtime widget](/images/dashboard-hostservicedowntimewidget.png)

- Beschreibung 

Das Host bzw. Service in Wartungszeit Widget zeigt Host bzw. Services an, die sich in einer Wartungszeit befinden. 

- Konfiguration

Über die Konfiguration besteht die möglichkeit nach Hosts bzw. Services und dem Wartungszeit Kommentar zu Filtern. Darüberhinaus können die anzuzeigenden Wartungszeiten über verschiedene Optionen ein oder ausgeblendet werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


##### Hoststatus/Servicestatus Liste
![host service status lists](/images/dashboard-hostservicestatuslists.png)

- Beschreibung

Zeigt eine Filterbare Liste mit Hosts bzw. Services an. Diese Listen enthalten den Status, aktuelle Wartungszeiten, Bestätigungen, sowie den Status seit und den Host bzw. Service Output. Die Liste kann in einem Benutzerdefinierten Intervall automatisch scrollen.

- Konfiguration

Host bzw. Service Status Listen können nach Hostname bzw Host und Servicename sowie nach Output gefiltert werden. Darüberhinaus stehen verschiedene Optionen, bspw. um nach dem Status, Wartungszeiten oder Status Bestätigungen zu Filtern, zur verfügung. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


##### Hoststatus/Servicestatus Übersicht
![host servicestatus overview](/images/dashboard-hostservicestatusoverview.png)

- Beschreibung

Das Host bzw. Servicestatus Übersichts Widget zeigt die Anzahl der Hosts bzw. Services in einem bestimmten Status (bspw. OK/UP) an.

- Konfiguration

Die Host bzw. Servicestatus Übersicht zeigt immer nur die Anzahl der Hosts bzw. Services in dem gewählten Status an. Diese auswahl kann über die Konfiguration des Widgets getroffen werden. Zudem kann auch nach dem Host bzw. Host und Servicenamen gefiltert werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Automatische Karte
![autmap widget](/images/dashboard-automapwidget.png)

- Beschreibung

Das Automatische Karte Widget zeigt Karten der [Automatischen Karte](../maps/#automatische-karte) an

- Konfiguration

Die Automatische Karte muss voher über die [Automatischen Karten](../maps/#automatische-karte) erstellt werden. Danach kann eine Karte in der Widget Konfiguration ausgewählt werden. Zusätzlich hat man die möglichkeit auszuwählen, wieviele Elemente auf einer "Seite" im Widget dargestellt werden sollen. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Autoreport Übersicht
![Autoreport overview widget](/images/dashboard-autoreportoverviewwidget.png)

- Beschreibung

Das Autoreport Übersicht Widget zeigt eine Verfügbarkeits anzeige eines zuvor erstellen [Autoreports](../../reporting/#autoreports) an. 

- Konfiguration

Das Autoreport Übersicht Widget setzt einen zuvor erstellten [Autoreports](../../reporting/#autoreports) voraus. Dieser Report kann anschließend in der Konfigurationsoberfläche des Widgets ausgewählt werden. Zudem sind Optionen zur Anzeige der Verfügbarkeit, Log daten sowie die Dynamische Farbgestaltung verfügbar. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Grafana (automatisch generiert)
- Beschreibung

Grafana Automasch generiert zeigt automatisch generierte Grafana Dashboards an.

- Konfiguration

Benutzerdefiniert Grafana Dashboards können über die Konfigurationsfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Grafana (benutzerdefiniert)
![grafana userdefined](/images/dashboard-grafanauserdefinedwidget.png)

- Beschreibung

Das Grafana (benutzerdefiniert) widget zeigt benutzerdefinierte [Grafana Dashboards](../graphing/#grafana) an.

- Konfiguration

Benutzerdefinierte Grafana Dashboards müssen vorher über das [Grafana Modul](../graphing/#grafana) erstellt werden. Anschließend kann ein Dashboard über die Widget Konfigurationsoberfläche aufgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Karte (MapModul)
![Map module widget](/images/dashboard-mapmodulewidget.png)

- Beschreibung

Das Karten Widget zeigt eine Karte die über das [MapModul](../maps/#map-modul) erstellt wurde an. 

- Konfiguration

Eine Karte muss voher über das [MapModul](../maps/#map-modul) erstellt werden. Anschließend kann die Karte über die Konfigurationsoberfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Ereigniskorrelation
![evk widget](/images/dashboard-evkwidget.png)

- Beschreibung

Das Ereigniskorrelations Widget zeigt eine zuvor erstelle [Ereigniskorrelation](../eventcorrelation/#ereigniskorrelationsmodul-eventcorrelation) an.

- Konfiguration

Eine Ereigniskorrelation muss voher über das [EventcorrelationModule](../eventcorrelation/#ereigniskorrelationsmodul-eventcorrelation) erstellt werden. Anschließend kann die Ereiginskorrelation über die Konfigurationsoberfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


### Widget Löschen

Im ein widget zu löschen, klicken Sie einfach auf das “x” Symbol des entsprechenden Widgets. 

![delete widget](/images/dashboards-widgetdelete.png)


### Standard wiederherstellen

Um den Standard eines Dashboard tabs wiederherzustellen, klicken Sie in der Liste zum hinzufügen von Dashboard Widgets auf die Schaltfläche `Standard wiederherstellen`.

![restore default](/images/dashboard-restoredefault.png)
