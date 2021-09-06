## Was sind Hosts und Services?

In openITCOCKPIT dreht sich alles um Hosts und Services. Hosts sind in der Regel physikalische Geräte wie beispielsweise
Server, Switche, Drucker, Workstations etc. mit einer Netzwerkschnittstelle oder aber auch virtuelle Maschinen etc.

Ein Service hingegen ist ein Dienst, welcher auf einem Host ausgeführt wird (bspw. Apache Webserver, MySQL, Postfix
etc.) oder eine andere Art von Metrik, die mit dem Host in Verbindung steht (bspw. Anzahl der eingeloggten User, Freier
Speicherplatz, CPU Auslastung etc.)

## Welche Status gibt es?

Hosts und Services können verschiedene Status annehmen. Welcher Status wann erreicht wird, wird durch das Prüf-Plugin
bzw. durch Schwellwerte, die diesem über das entsprechende [Kommando](../../configuration/commands/) übergeben werden,
entschieden.

Hosts können die folgenden Status annehmen:

| Statuscode | Farbe | Status (English) | Status (Deutsch) |
|---|---|---|---|
| 0 | Grün | OK | OK |
| 1 | Rot | DOWN | NICHT VERFÜGBAR |
| 2 | Grau | UNREACHABLE | NICHT ERREICHBAR |

Services Können folgende Status annehmen:

| Statuscode | Farbe | Status (English) | Status (Deutsch) |
|---|---|---|---|
| 0 | Grün | OK | OK |
| 1 | Gelb | WARNING | WARNUNG |
| 2 | Rot | CRITICAL | KRITISCH |
| 3 | Grau | UNKNOWN | UNBEKANNT |

Neben den Status für Host und Services gibt es noch den blauen Status. Der blaue Status kann sowohl von einem Host als
auch von einem Service angenommen werden und signalisiert, dass das Objekt in openITCOCKPIT angelegt wurde, aber noch
nicht von der Monitoring Engine überwacht wird. Um dies zu ändern, muss ein [Export](#export) erfolgen. 

## Export

### Was ist ein Export?

openITCOCKPIT und die Monitoring Engine (Naemon) haben zwei voneinander getrennte Konfigurationen. Dies führt dazu, dass
neu eingetragen Objekte in openITCOCKPIT nicht automatisch überwacht werden beziehungsweise der Monitoring Engine
(vorerst) nicht bekannt sind.

- Naemon speichert seine Objekte als `.cfg` Dateien unter `/opt/openitc/nagios/etc/config/`.
- openITCOCKPIT speichert seine Objekte in der Datenbank ab.

Wenn Sie beispielsweise einen neuen Host oder einen Service in openITCOCKPIT angelegt haben, so wird dieser nicht in der
Liste der überwachten Objekte geführt und hat den blauen Status `Not in monitoring`.

Damit die Monitoring Engine mit den Objekten in openITCOCKPIT Synchronisiert wird, müssen also alle relevanten Daten der
openITCOCKPIT Datenbank in die `.cfg` Dateien für Naemon geschrieben werden.

Dies erledigt der Export für uns. Der Export erledigt allerdings nicht nur das. Es werden einige weitere Aufgaben
abgearbeitet:

- Backup der aktuellen Naemon Konfigurationsdateien
- Backup der openITCOCKPIT Datenbank
- (OPTIONAL) Backup der Prometheus Konfiguration
- Ausführen von `pre export` Aufgaben
- Schreiben der neuen Naemon Konfigurationsdateien
- (OPTIONAL) erstellen der neuen Prometheus Konfiguration
- Ausführen von post export Aufgaben
- Verifizieren der neuen Naemon Konfiguration
- Naemon anweisen seine Konfiguration neu einzulesen
- (OPTIONAL) neue Konfiguration auf Satellitensysteme übertragen
- `after Export` Aufgaben ausführen
- (OPTIONAL) Prometheus Konfiguration verifizieren
- (OPTIONAL) Prometheus neu starten

Nicht alles was in openITCOCKPIT erstellt und / oder konfiguriert werden kann, ist ein für die Monitoring Engine
relevantes Objekt. Beispiele dafür sind Benutzer, Berechtigungen, Container, Karten und noch viel mehr. Diese können
erstellt werden und existieren nur in openITCOCKPIT. Für die Monitoring Engine relevante Objekte sind:

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

### Wie führe ich einen Export aus?

Einen Export auszuführen in openITCOCKPIT ist eine sehr leichte Aufgabe. Dazu klicken Sie im Kopfzeilenbereich von
openITCOCKPIT auf die Schaltfläche :fontawesome-solid-retweet:

![Export Header Button](/images/layout-header-export.png)

In der sich darauf öffnenden Seite klicken Sie anschließend auf :fontawesome-solid-rocket: `Starte Aktualisierung`

![Export before launch](/images/export-beforeexport.png)

Ist der Export erfolgreich durchgelaufen, sehen Sie folgende Ausgabe:

![Export successful](/images/export-afterexport.png)
