# Bestimmung des Hoststatus

## Pull-Modus
Im Pull-Modus wird openITCOCKPIT aktiv den Status vom Zielgerät abfragen. Standardmäßig wird dies durch den `OITC_AGENT_ACTIVE` Service-Check durchgeführt. Dieser Service wird automatisch auf jedem Host, der im Pull-Modus überwacht wird, bereitgestellt.
Standardmäßig verwendet openITCOCKPIT den standardmäßigen ICMP/Ping (check-host-alive) Check, um den Zustand des Hosts zu bestimmen.

Sie können auch den openITCOCKPIT Monitoring Agent als Host-Check verwenden. Deaktivieren Sie dazu den `OITC_AGENT_ACTIVE` auf dem entsprechenden Host. **Löschen Sie den Service nicht**! Deaktivieren Sie ihn nur.

![Service deaktivieren](/images/agent/disable_service.png)

Ändern Sie dann die Host-Vorlage des Hosts auf `openITCOCKPIT Agent - Pull` und aktualisieren Sie Ihre Überwachungskonfiguration.

openITCOCKPIT wird nun den Host-Check verwenden, um die Daten vom Monitoring Agent abzufragen. Sobald der Agent nicht antwortet oder nicht erreichbar ist, wechselt der Host in den "Down"-Zustand.

### Host-Vorlage oder Befehl fehlt

Falls die Standardvorlagen auf Ihrem System fehlen, müssen Sie diese manuell erstellen.

#### Befehl

| Feld         | Wert                                                                                                                   |
|--------------|------------------------------------------------------------------------------------------------------------------------|
| Befehlstyp   | `Host-Check-Befehl`                                                                                                    |
| Name         | `check-host-alive-oitc-agent-pull`                                                                                     |
| Befehlszeile | `/opt/openitc/receiver/bin/poller.php poller -H "$HOSTNAME$" -c /opt/openitc/receiver/etc/production.json --host-check` |

#### Host-Vorlage

| Feld                          | Wert                                                                               |
|-------------------------------|------------------------------------------------------------------------------------|
| Vorlagenname                  | `openITCOCKPIT Agent - Pull`                                                       |
| Vorlagentyp                   | `Generische Vorlage`                                                               |
| Beschreibung                  | `Aktive Überwachung eines Hosts über den openITCOCKPIT Monitoring Agent im Pull-Modus` |
| Prüfungszeitraum              | `24x7`                                                                             |
| Aktive Prüfungen aktivieren   | `Ja`                                                                               |
| Prüfungsbefehl                | `check-host-alive-oitc-agent-pull`                                                 |
| Prüfungsintervall             | `60`                                                                               |
| Wiederholungsintervall        | `60`                                                                               |
| Maximale Anzahl der Prüfungsversuche | `1`                                                                         |


## Push-Modus

Im Push-Modus kann openITCOCKPIT den Hoststatus nicht aktiv vom Zielgerät abfragen. Aus diesem Grund überprüft openITCOCKPIT den Zeitstempel der letzten Datenübertragung vom Monitoring Agent. Wenn der Agent länger als X Minuten keine Daten übermittelt hat, wechselt der Host in den "Down"-Zustand.

Um dies zu aktivieren, bearbeiten Sie den Host und wählen Sie `openITCOCKPIT Agent - Push` als Host-Vorlage und aktualisieren Sie Ihre Überwachungskonfiguration.
openITCOCKPIT wird nun den Zeitstempel der letzten Übertragung auswerten, um den Hoststatus zu bestimmen.

### Host-Vorlage oder Befehl fehlt

Falls die Standardvorlagen auf Ihrem System fehlen, müssen Sie diese manuell erstellen.

#### Befehl

| Feld         | Wert                                                                                       |
|--------------|--------------------------------------------------------------------------------------------|
| Befehlstyp   | `Host-Check-Befehl`                                                                        |
| Name         | `check-host-alive-oitc-agent-push`                                                         |
| Befehlszeile | `/opt/openitc/frontend/bin/cake agent --check -H --hostuuid "$HOSTNAME$" --critical $ARG1$` |
| ARG1         | `Alter in Sekunden`                                                                        |

#### Host-Vorlage

| Feld                                 | Wert                                                                               |
|--------------------------------------|------------------------------------------------------------------------------------|
| Vorlagenname                         | `openITCOCKPIT Agent - Push`                                                       |
| Vorlagentyp                          | `Generische Vorlage`                                                               |
| Beschreibung                         | `Host überwacht über den openITCOCKPIT Monitoring Agent im Push-Modus`             |
| Prüfungszeitraum                     | `24x7`                                                                             |
| Aktive Prüfungen aktivieren          | `Ja`                                                                               |
| Prüfungsbefehl                       | `check-host-alive-oitc-agent-push`                                                 |
| ARG1                                 | `120`                                                                              |
| Prüfungsintervall                    | `60`                                                                               |
| Wiederholungsintervall               | `60`                                                                               |
| Maximale Anzahl der Prüfungsversuche | `1`                                                                                |
