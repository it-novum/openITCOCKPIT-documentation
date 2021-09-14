## Grafana

openITCOCKPIT bietet eine Integration von Grafana, die über das Modul GrafanaModule installierbar ist.

Grafana ist ein Tool, dass automatisiert Graphen von Services in openITCOCKPIT erstellt und die möglichkeit bietet, 
eigene Graphen Dashboards zu erstellen.

### Konfiguration

Damit die erstellung von Graphen funktioniert, muss die Schnittstelle konfiguriert sein.

#### Lokales Grafana (Docker Container)

| Feld | Wert (Default) |
| --- | --- |
| Grafana URL | grafana.docker |
| Grafana API Schlüssel | hier muss ein API Key von Grafana eingefügt werden. Diesen kann man über die Grafana oberfläche erzeugen |
| Grafana Präfix | openitcockpit |
| Verbindung über HTTPS herstellen | 1   |
| Benutze Proxy | 0   |
| SSL-Zertifikate ignorieren | 1   |
| Dashboard Stil | hell |
| Hostgruppe |     |
| Hostgruppe (ausgeschlossen) |     |

### Benutzerdefiniertes Dashboard erstellen

Um ein benutzerdefiniertes Grafana Dashboard zu erstellen, öffnen Sie im Hauptmenü unter Berichte → Grafana die Benutzerdefinierte Grafana Dashboard Übersicht.

Anschließend klicken Sie auf die Schaltfläche "Neu".

Danach wählen Sie einen Container aus und vergeben einen Namen für das Dashboard.

Im nächsten Schritt konfigurieren Sie die Metriken, die Sie anzeigen wollen und klicken danach auf die Schaltfläche "Synchronisiere mit Grafana".

Danach können Sie zurück zur Übersicht wechseln und dann im Menü des Dashboards auf "Anzeigen" klicken.

Benutzerdefinierte Grafana Dashboards können auch als widget im Dashboard der openITCOCKPIT Startseite angezeigt werden.