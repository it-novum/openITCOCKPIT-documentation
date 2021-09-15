# Graphing

openITCOCKPIT speichert Metriken (auch Performancedaten genannt) um diese als Graphen aufzubereiten. Somit können
Entwicklungen über einen langen Zeitraum betrachtet und Trends erkannt werden.

Wenn Sie mit der Maus über das Graph-Icon in einer der Service-Listen fahren, zeigt das System maximal vier Metriken
als Graph über einen Zeitraum von vier Stunden.

![Hover to display chart](/images/monitoring-hover-graphs.png)

Mehr Informationen und Einstellungsmöglichkeiten biete der Service Graph in der Detailansicht von Services.

Hier kann der Benutzer die Zeitspanne, die Datenquelle (Metrik) und die Art der Aggregation wählen. Wenn die verwendeten Schwellwerte
an bei den Metriken übergeben werden, verfärben sich die Abschnitte im Graph automatisch, sobald die Schwellwerte überschritten wurden.

![Detailed service chart with thresholds](/images/detailed-chart-with-thresholds.png)

Durch Klicken und Ziehen kann auf einen bestimmten Abschnitt des Graphen gezoomt werden.

## Aggregation von Daten

Um viele Datensätze in einem Graphen anzeigen zu können, müssen die Daten in der Regel durch verschiedene aggregations Methoden
zusammengefasst und reduziert werden. Dabei kann es zu Ungenauigkeiten der Graphen kommen.

Bei der Fehlersuche bietet es sich deshalb an, durch die einzelnen Aggregation von Minimum, Durchschnitt und Maximum zu schalten.
So können auch kurze Peaks gefunden werden. Dies ist besonders oft bei der Analyse von Netzwerkproblemen hilfreich.

![Time series data aggregation](/images/chart-aggregation.jpg)

## Skalierung von Einheiten
Graphen sind ein nützliches Mittel bei der Fehlersuche, können aber abhängig von der verwendeten Einheit schnell für Verwirrung sorgen.

So ist ein Graph, welcher eine Arbeitsspeicherauslastung von 1021071360 Bytes anzeigt, als Mensch kaum zu lesen.
openITCOCKPIT versucht die genutzte Einheit zu erkennen und in ein besser zu lesende Einheit umzurechnen, in diesem Fall wird
die Einheit 973 MiB genutzt.

![Smart scaling of chart units in charts](/images/smart-unit-scaling-charts.jpg)

## Grafana

[Grafana](https://grafana.com/) ist ein sehr beliebtes Open-Source Tool zum Erstellen von eigenen Dashboards. Grafana
biete dabei eine Vielzahl von Darstellungsmöglichkeiten neben Graphen.

Grafana wird bei jeder Installation von openITCOCKPIT automatisch über das GrafanaModule mit installiert und steht somit
Out-of-the-box zur Verfügung.

openITCOCKPIT bietet eine Integration von Grafana, die über das Modul GrafanaModule installierbar ist.

### Automatische Dashboards
openITCOCKPIT versucht für alle Hosts automatisiert Dashboards in Grafana zu erstellen. Dabei wird für jeden Service
ein entsprechendes Panel mit den dazugehörigen Metriken und Einheiten erstellt.

Dieser Vorgang wird alle 12 Stunden durch einen [Cronjob](/configuration/cronjobs/) im Hintergrund ausgeführt.
Die so erstellen Dashboards können in der Detailansicht von Hosts betrachtet werden.

![Auto generated Grafana dashboard](/images/auto-generated-grafana-dashboard.png)

Automatisiert erstellte Grafana Dashboards können auch als Widget im [openITCOCKPIT Dashboard](/monitoring/dashboard/) eingebunden werden.


### Benutzerdefinierte Grafana Dashboard erstellen
Um möglichst viel flexibilität zu bieten, können über openITCOCKPIT auch eigene Grafana Dashboards erstellt werden. openITCOCKPIT
bietet dafür einen einfach zu nutzenden Editor unter dem Menüpunkt Berichte → Grafana.

Mit einem Klick auf die Schaltfläche "Neu" gelangen Sie in den Editor.
Im ersten Schritt wählen Sie einen Container und vergeben einen Namen für das Dashboard. Im Anschluss gelangen Sie in den Editor,
welcher an Grafana angelehnt ist.

![User defined Grafana dashboard editor](/images/user-defined-grafana-dashboard-editor.png)

Die Graphen werden dabei in Zeilen (Row) organisiert. Jeder Row können beliebig viele Panels hinzugefügt werden.
Dem Panel können wiederum die Metriken zugewiesen werden. Somit kann der Anwender frei entscheiden, welche Metriken
zusammen dargestellt werden sollen und welche Einheiten und Beschriftungen genutzt werden sollen.

Das Hinzufügen von Metriken erfolgt über die Auswahl der entsprechenden Metrik aus einer Drop-Down-Liste.
![Add metric to dashboard](/images/add-metric-to-dashboard.png)

In diesem Schritt kann auch die gewünschte Farbe der Kurve gewählt werden.

Über die Panel Optionen kann der Titel sowie die Einheit des Graphen definiert werden.

Wenn alle Metriken hinzugefügt wurden, kann über die Schaltfläche "Synchronisiere mit Grafana" das Dashboard gespeichert werden.
Wählen Sie über das Hauptmenü erneut Berichte → Grafana. Mit einem Klick auf das gewünschte Grafana Dashboard, kann dieses
nur angezeigt oder bearbeitet werden.

![Example of userdefined Grafana dashboard](/images/example-of-userdefined-grafana-dashboard.png)


Benutzerdefinierte Grafana Dashboards können auch als Widget im [openITCOCKPIT Dashboard](/monitoring/dashboard/) eingebunden werden.

### Konfiguration

Informationen zu den Konfigurationsmöglichkeiten finden Sie im Bereich [Graphing Backend](/additional/graphing-backend/)
