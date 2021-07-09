## Export
### Was ist ein Export?

openITCOCKPIT und die Monitoring Engine (Naemon) haben zwei voneinander getrennte Konfigurationen. Dies führt dazu dass neu eingetragen Objekte in openITCOCKPIT nicht automatisch überwacht werden beziehungsweise der Monitoring Engine (vorerst) nicht bekannt sind.

- Naemon speichert seine Objekte als `.cfg` Dateien unter `/opt/openitc/nagios/etc/config/`.
- openITCOCKPIT speichert seine Objekte in der Datenbank ab.

Wenn Sie beispielsweise einen neuen Host oder einen Service in openITCOCKPIT angelegt haben, so wird dieser nicht in der Liste der Überwachten Objekte geführt und hat den blauen Status `Not in monitoring`. 

Damit die Monitoring Engine mit den Objekten in openITCOCKPIT Synchronisiert wird, müssen also alle relevanten Daten der openITCOCKPIT Datenbank in die `.cfg` Dateien für Naemon geschrieben werden. 

Dies Erledigt der Export für uns. Der Export erledigt allerdings nicht nur das. Es werden einige weitere Aufgaben abgearbeitet:

- Backup der aktuellen Naemon Konfigurationsdateien
- Backup der openITCOCKPIT Datenbank
- (OPTIONAL) Backup der Prometheus Konfiguration
- Ausführen von pre export Aufgaben
- Schreiben der neuen Naemon Konfigurationsdateien
- (OPTIONAL) erstellen der neuen Prometheus Konfiguration
- Ausführen von post export Aufgaben
- Verifizieren der neuen Naemon Konfiguration
- Naemon anweisen seine Konfiguration neu einzulesen
- (OPTIONAL) Neue Konfiguration auf Satellitensysteme übertragen
- After Export Aufgaben ausführen
- (OPTIONAL) Prometheus Konfiguration verifizieren
- (OPTIONAL) Prometheus neu starten


Nicht alles was in openITCOCKPIT erstellt und / oder konfiguriert werden kann ist ein für die Monitoring Engine relevantes Objekt. Beispiele dafür sind Benutzer, Berechtigungen, Container, Karten und noch viel mehr. Diese können erstellt werden und existieren nur in openITCOCKPIT. Für die Monitoring Engine relevante Objekte sind:

- Kommandos
- Kontakte
- Kontaktgruppen
- Zeitabschnitte
- Hosts
- Hostvorlagen
- Hostgruppen
- Hostabhängigkeiten
- Hosteskalationen
- Services
- Servicevorlagen
- Servicegruppen
- Serviceabhängigkeiten
- Serviceeskalationen
