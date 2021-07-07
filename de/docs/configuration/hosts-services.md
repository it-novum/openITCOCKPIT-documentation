## Hostvorlagen

Hostvorlagen sind ein essenzieller Bestandteil in openITCOCKPIT. Sie bilden die Vorlage für Hosts und sind eine der Grundvoraussetzung zum erstellen dafür. 

Ein Host leitet sich immer von einer Hostvorlage ab, kann aber die Werte, die in der Vorlage definiert wurden, überschreiben. 

### Hostvorlage erstellen

Um eine Hostvorlage zu erstellen, klicken Sie zunächst in der Hostvorlagen Übersicht auf die Schaltfläche “Neu”.

Anschließend wählen Sie einen Container aus, in dem die Vorlage verfügbar sein soll und vergibt einen Namen. 

Nun gibt man einen Vorlagen typen an.

#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Hostvorlagen typen. Diese unterscheiden eine Vorlage ob sie entweder für einen Generischen Host oder zum Beispiel für einen Ereigniskorrelations Host sind. 

Ein normaler Host wird i.d.R. immer als Generischer Host angelegt. 

Ein Prüfzeitraum ist ebenfalls eine Pflichtangabe ebenso wie ein Prüfungskommando. Ein Standardprüfungskommando für einen Host ist beispielsweise “check-host-alive”. Für dieses Kommando können hier auch direkt Argumente übergeben werden. 

anschließend werden verschiedene Prüfungsintervalle gesetzt.

#### Intervalle

Damit Benachrichtigung zu einem Host status gesendet werden können, wird in der Hostkonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein Prüfungsintervall von 1 Stunden, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 1 Stunden und 2 Minuten eine Benachrichtigung gesendet wird. 

Ebenso wie bei dem Püfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden sowie mindestens ein Kontakt oder mindestens eine Kontaktgruppe.

#### Prometheus Exporters

– Folgt –



## Servicevorlagen

Servicevorlagen sind ein essenzieller Bestandteil in openITCOCKPIT. Sie bilden die Vorlage für Services und sind eine der Grundvoraussetzung zum erstellen dafür. 

Ein Service leitet sich immer von einer Servicevorlage ab, kann aber die Werte, die in der Vorlage defniert wurden, überschreiben. 

### Servicevorlage erstellen

Um eine Servicevorlage zu erstellen, klicken Sie zunächst in der Servicevorlagen Übersicht auf die Schaltfläche “Neu”.

Anschließend wählen Sie einen Container aus, in dem die Vorlage verfügbar sein soll und vergibt einen Namen. 

Nun gibt man einen Vorlagen typen an.

#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Servicevorlagen typen. Diese unterscheiden eine Vorlage ob sie entweder für einen Generischen Service oder zum Beispiel für einen Ereigniskorrelations Service sind. 

Services, welche über ein Modul oder den Agent erzeugt werden sind immer von dem entsprechendem Vorlagentyp.

##### Generische Vorlagen

Vorlage für einen Normalen Service. Dies ist der Standard Service typ in openITCOCKPIT

##### EVK Vorlagen

Vorlage für einen Service der Ereigniskorrelation. Verfügbar über EventcorrelationModule

##### Checkmk Vorlagen

Vorlage für einen Checkmk Service. Verfügbar über CheckmkModule

##### Prometheus Vorlagen

Vorlage für einen Prometheus Service. Verfügbar über PrometheusModule

##### Agent Vorlagen

Vorlage für einen openITCOCKPIT Agent Service. 

Ein Prüfzeitraum ist ebenfalls eine Pflichtangabe ebenso wie ein Prüfungskommando.

anschließend werden verschiedene Prüfungsintervalle gesetzt.

#### Intervalle

Damit Benachrichtigung zu einem Service status gesendet werden können, wird in der Servicekonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein Prüfungsintervall von 1 Minute, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass nach 3 Minuten eine Benachrichtigung gesendet wird. 




Ebenso wie bei dem Püfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden. Im gegensatz zu den Hostvorlagen muss hier kein Kontakt oder Kontaktgruppe hinterlegt werden.