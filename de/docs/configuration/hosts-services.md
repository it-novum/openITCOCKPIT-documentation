## Hostvorlagen

Hostvorlagen sind ein essenzieller Bestandteil in openITCOCKPIT. Sie bilden die Vorlage für Hosts und sind eine der Grundvoraussetzung zum erstellen dafür. 

Ein Host leitet sich immer von einer Hostvorlage ab, kann aber die Werte, die in der Vorlage definiert wurden, überschreiben. 

### Hostvorlage erstellen

Um eine Hostvorlage zu erstellen, klicken Sie zunächst in der Hostvorlagen Übersicht auf die Schaltfläche “Neu”.

Anschließend wählen Sie einen Container aus, in dem die Vorlage verfügbar sein soll und vergibt einen Namen. 

Nun gibt man einen Vorlagen typen an.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Vorlagenname | :fontawesome-solid-times: | Name der Vorlage |
| Vorlagentyp | :fontawesome-solid-times: | Bestimmt den [Typ](#vorlagentypen) der Vorlage |
| Beschreibung |  | Beschreibung der Hostvorlage. Wird als Beschreibung des Hosts weitervererbt |
| Hostgruppen |  | Zuweisung ein oder mehrerer [Hostgruppen](#hostgruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-times: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob ein Host Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-times: | Das [Kommando](../commands/), welches zur Überprüfung des Hosts ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-times: | Definiert in welchem Intervall Prüfungen stattfinden sollen |
| Wiederholungsintervall | :fontawesome-solid-times: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-times: | Bestimmt die Anzahl der Prüfversuche, bevor ein Host in einen Hard State über geht |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-times: | Besteimmt den Zeitraum in dem für einen Host Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-times: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Host versendet werden |
| Kontakte | :fontawesome-solid-times: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Host erhalten |
| Kontaktgruppen | :fontawesome-solid-times: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Host erhalten |
| Optionen zu Hostbenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Host URL |  | Host URL |
| Notizen |  | Notizen zur Hostvorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Host status in kurzer Zeit oft ändert |
| Host-Makro-Konfiguration | | |
| Prometheus-Exporters |
| Exporters | | [Prometheus Exporter](#prometheus-exporters) |




#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Hostvorlagen typen. Diese unterscheiden eine Vorlage ob sie entweder für einen Generischen Host oder zum Beispiel für einen Ereigniskorrelations Host sind. 

Ein normaler Host wird i.d.R. immer als Generischer Host angelegt. 

Ein Prüfzeitraum ist ebenfalls eine Pflichtangabe ebenso wie ein Prüfungskommando. Ein Standardprüfungskommando für einen Host ist beispielsweise “check-host-alive”. Für dieses Kommando können hier auch direkt Argumente übergeben werden. 

anschließend werden verschiedene Prüfungsintervalle gesetzt.


#### Intervalle

Damit Benachrichtigung zu einem Host status gesendet werden können, wird in der Hostkonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein Prüfungsintervall von 1 Stunden, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 1 Stunden und 2 Minuten eine Benachrichtigung gesendet wird. 

Ebenso wie bei dem Püfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden sowie mindestens ein Kontakt oder mindestens eine Kontaktgruppe.

#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. Ist diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine "flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.


#### Prometheus Exporters

Zur [Überwachung des Hosts mit Prometheus](../../monitoring/prometheus/#uberwachen-eines-hosts-mit-prometheus-in-openitcockpit), wählen Sie hier Ihren Prometheus Exporter aus.


## Servicevorlagen

Servicevorlagen sind ein essenzieller Bestandteil in openITCOCKPIT. Sie bilden die Vorlage für Services und sind eine der Grundvoraussetzung zum erstellen dafür. 

Ein Service leitet sich immer von einer Servicevorlage ab, kann aber die Werte, die in der Vorlage definiert wurden, überschreiben. 

### Servicevorlage erstellen

Um eine Servicevorlage zu erstellen, klicken Sie zunächst in der Servicevorlagen Übersicht auf die Schaltfläche “Neu”.

Anschließend wählen Sie einen Container aus, in dem die Vorlage verfügbar sein soll und vergibt einen Namen. 

Nun gibt man einen Vorlagen typen an.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Vorlagenname | :fontawesome-solid-times: | Name der Vorlage |
| Vorlagentyp | :fontawesome-solid-times: | Bestimmt den [Typ](#vorlagentypen) der Vorlage |
| Servicename | :fontawesome-solid-times: | Standardname des Services wenn aus der Vorlage ein Service erstellt wird |
| Beschreibung |  | Beschreibung der Servicevorlage. Wird als Beschreibung des Services weitervererbt |
| Servicegruppen |  | Zuweisung ein oder mehrerer [Servicegruppen](#servicegruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-times: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob der Service Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-times: | Das [Kommando](../commands/), welches zur Überprüfung des Services ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-times: | Definiert in welchem Intervall Prüfungen stattfinden sollen |
| Wiederholungsintervall | :fontawesome-solid-times: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-times: | Bestimmt die Anzahl der Prüfversuche, bevor ein Service in einen Hard State über geht |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-times: | Besteimmt den Zeitraum in dem für einen Service Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-times: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Service versendet werden |
| Kontakte | :fontawesome-solid-times: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Service erhalten |
| Kontaktgruppen | :fontawesome-solid-times: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Service erhalten |
| Optionen zu Servicebenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Service URL |  | Service URL |
| Notizen |  | Notizen zur Servicevorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Service status in kurzer Zeit oft ändert |
| Status flüchtig |  | Erzwingt Benachrichtigungen für jedes Nicht-OK Prüfergebnis |
| Event Handler Konfiguration |
| Ereignishandler | | Eventhandler Konfiguration des Service |
| Service-Makro-Konfiguration | | |


#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Servicevorlagen typen. Diese unterscheiden eine Vorlage ob sie entweder für einen Generischen Service, Ereigniskorrelationen, Checkmk, Prometheus oder den openITCOCKPIT Agenten sind. 

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

Damit Benachrichtigung zu einem Service status gesendet werden können, wird in der Servicekonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein Prüfungsintervall von 1 Minute, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass nach 3 Minuten eine Benachrichtigung gesendet wird. 


Ebenso wie bei dem Püfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden. Im gegensatz zu den Hostvorlagen muss hier kein Kontakt oder Kontaktgruppe hinterlegt werden.


## Servicevorlagengruppen

Servicevorlagengruppen sind Sammlungen von Servicevorlagen, die entweder selbst erstellt werden können oder aber über installierbare Module verfügbar sind. Über Module verfügbare Servicevorlagengruppen sind zum jeweiligen Themengebiet passend zusammengefasste Servicevorlagen. 

Servicevorlagengruppen können zu einem Host oder einer Hostgruppe zugewiesen werden. Das bedeutet, dass für alle Servicevorlagen einer Servicevorlagengruppe die entsprechenden Services auf dem zugewiesenen Host oder Hostgruppe erstellt wird.

### Servicevoelagengruppe erstellen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Servicevorlagengruppe erstellt werden soll  |
| Name | :fontawesome-solid-times: | Name der Servicevorlagengruppe |
| Beschreibung |  | Beschreibung der Servicevorlagengruppe |
| Servicevorlage | :fontawesome-solid-times: | Die [Servicevorlagen](#servicevorlagen) die zur Servicevorlagengruppe hinzugefügt werden sollen |

### Servicevorlagengruppen zuweisen

Es gibt in openITCOCKPIT drei verschiedene Möglichkeiten Servicevorlagengruppen zuzuweisen. 

![](/images/servicetemplategroups-allocate.png)

#### Zuweisen zu Host

Hier wird die aktuelle Servicevorlagengruppe zu einem einzelnen Host zugewiesen. Beim auswählen des Hosts werden alle zu erstellenden Services aufgelistet und können auch über die Auswahlbox abgewählt werden. 

Sollte ein Service dieser Servicevorlagengruppe bereits auf dem Zielhost existieren, so wird dieser standardmäßig nicht zusätzlich erstellt, es sei denn man markiert diesen wieder in der Liste.

![](/images/servicetemplategroups-allocatetohost.png)

#### Einer Hostgruppe zuweisen 

Hier wird die aktuelle Servicevorlage zu den Hosts einer Hostgruppe zugewiesen. Beim auswählen der Hostgruppe werden alle zugehörigen Hosts sowie die zu erstellenden Services für jeden einzelnen Host aufgelistet. Es besteht ebenso die möglichkeit einzelnen Services abzuwählen.

Sollte ein Service dieser Servicevorlagengruppe bereits auf einem der Hosts existieren, so wird dieser standardmäßig nicht zusätzlich erstellt, es sei denn man markiert diesen wieder in der Liste.

#### Zuordnen zur passenden Hostgruppe

"Zuordnen zur passenden Hostgruppe" erstellt Services auf den Hosts einer Hostgruppe die den selben Namen trägt. Der Name der Hostgruppe muss gleich der Name der Servicevorlagengruppe sein. Hier hat man nicht mehr die Möglichkeit die Services an und abzuwählen wie bei den anderen zwei Methoden.


## Hosts

### Host erstellen

Um einen Host zu erstellen wählen Sie zunächst einen Container aus, in dem der Host erstellt werden soll. Bitte beachten Sie dass ein nachträgliches ändern des Containers für einen Host **_nicht möglich_** ist!

Danach wählen Sie eine Hostvorlage aus, von dem der neue Host abgeleitet werden soll. 

Sie können anschließend einen Host Namen und eine Host Adresse vergeben, oder aber Sie vergeben eine Host Adresse und lassen den Hostnamen über die DNS-Suche automatisch vervollständigen.

Beim Abspeichern haben Sie die möglichkeit direkt neue Services zum Host anzulegen. Diese können entweder über den openITCOCKPIT Agent, Checkmk oder den Klassischen weg des Manuellen erstellens erzeugt werden.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Geteilte Container |  | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Hostvorlage | :fontawesome-solid-times: | [Hostvorlage](#hostvorlagen) von der der Host abgeleitet werden soll |
| Host Name | :fontawesome-solid-times: | Name des Hosts |
| DNS-Suche |  | Falls aktiviert, wird versucht den Host Namen oder Host Adresse aufzulösen |
| Host Adresse | :fontawesome-solid-times: | IP Adresse oder FQDN des Hosts |
| Beschreibung |  | Beschreibung der Hostvorlage. Wird als Beschreibung des Hosts weitervererbt |
| Hostgruppen |  | Zuweisung ein oder mehrerer [Hostgruppen](#hostgruppen) |
| Eltern-Host |  | Parent Host Beziehung |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Satellit |  | Verfügbar wenn DistributeModule installiert ist. Auswahl des Satelliten |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-times: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob ein Host Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-times: | Das [Kommando](../commands/), welches zur Überprüfung des Hosts ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-times: | Definiert in welchem Intervall Prüfungen stattfinden sollen. Siehe [Intervalle](#intervalle) |
| Wiederholungsintervall | :fontawesome-solid-times: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde. Siehe [Intervalle](#intervalle) |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-times: | Bestimmt die Anzahl der Prüfversuche, bevor ein Host in einen Hard State über geht. Siehe [Intervalle](#intervalle) |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-times: | Besteimmt den Zeitraum in dem für einen Host Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-times: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Host versendet werden |
| Kontakte | :fontawesome-solid-times: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Host erhalten |
| Kontaktgruppen | :fontawesome-solid-times: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Host erhalten |
| Optionen zu Hostbenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Host URL |  | Host URL |
| Notizen |  | Notizen zur Hostvorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Host status in kurzer Zeit oft ändert |
| Host-Makro-Konfiguration | | |
| Prometheus-Exporters |
| Exporters | | [Prometheus Exporter](#prometheus-exporters) |


#### Geteilte Container

Über die Geteilten Container ist es möglich Hosts in anderen Containern "sichtbar" zu machen. Dies ist nützlich um Benutzern welche keine Berechtigung auf den ursprünglichen Container des Hosts haben, trotzdem zugang zum Host zu geben. Diese Option steht zudem auch in der Hostübersicht unter der Host bearbeitungsoption “Teilen” zur verfügung. 

#### Intervalle

Damit eine Benachrichtigung zu einem Host status gesendet werden kann, wird in der Hostkonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist bei der default host vorlage ein Prüfungsintervall von 2 Stunden, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 2 Stunden und 2 Minuten eine Benachrichtigung gesendet wird. 


#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. Ist diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine "flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.


#### Prometheus Exporters

Zur [Überwachung des Hosts mit Prometheus](../monitoring/prometheus/#uberwachen-eines-hosts-mit-prometheus-in-openitcockpit), wählen Sie hier Ihren Prometheus Exporter aus.



## Services

### Service erstellen

Um einen Service zu erstellen klicken Sie in der Serviceübersicht zunächst auf die schaltfläche “Neu”. Im sich öffnenden Formular wählen Sie als erstes den Ziel Host aus, auf dem der Service erstellt werden soll. Anschließend wählen Sie eine Servicevorlage aus. Wenn nötig können Sie dem Service, abweichend vom Servicetemplate, einen Namen sowie eine Beschreibung geben. 


| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Host | :fontawesome-solid-times: | Der [Host](#hosts) auf dem der Service angelegt werden soll |
| Servicevorlage | :fontawesome-solid-times: | Die [Servicevorlage](#servicevorlagen) von dem der Service abgeleitet werden soll |
| Servicename | :fontawesome-solid-times: | Name des anzulegenden Service |
| Beschreibung |  | Beschreibung des Services |
| Servicegruppen |  | Zuweisung ein oder mehrerer [Servicegruppen](#servicegruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-times: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob der Service Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-times: | Das [Kommando](../commands/), welches zur Überprüfung des Services ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-times: | Definiert in welchem Intervall Prüfungen stattfinden sollen. Siehe [Intervalle](#intervalle) |
| Wiederholungsintervall | :fontawesome-solid-times: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde. Siehe [Intervalle](#intervalle) |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-times: | Bestimmt die Anzahl der Prüfversuche, bevor ein Service in einen Hard State über geht. Siehe [Intervalle](#intervalle) |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-times: | Bestimmt den [Zeitraum](../timeperiods/) in dem für einen Service Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-times: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Service versendet werden |
| Vererbung deaktivieren |  | Deaktiviert die vererbung von Kontakten und Kontaktgruppen. Diese können dann für diesen Service einzeln gesetzt werden |
| Kontakte | :fontawesome-solid-times: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Service erhalten |
| Kontaktgruppen | :fontawesome-solid-times: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Service erhalten |
| Optionen zu Servicebenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Service URL |  | Service URL |
| Notizen |  | Notizen zur Servicevorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Service status in kurzer Zeit oft ändert |
| Status flüchtig |  | Erzwingt Benachrichtigungen für jedes Nicht-OK Prüfergebnis |
| Event Handler Konfiguration |
| Ereignishandler | | Eventhandler Konfiguration des Service |
| Service-Makro-Konfiguration | | |

#### Intervalle

Damit eine Benachrichtigung zu einem Service status gesendet werden kann, wird in der Servicekonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist bei der `CHECK_PING` vorlage ein Prüfungsintervall von 5 Minuten, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 7 Minuten eine Benachrichtigung gesendet wird. 

#### Benachrichtigungen

Die Benachrichtigungen für einen Service verhalten Sich genau wie die Benachrichtigungen für einen Host


#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. Ist diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine "flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.


## Host und Service erstellung über Import Modul

### Host-Standardeinstellungen

Host Standardeinstellungen definieren beispielsweise welcher Container und Dienste den Importierten Hosts zugewiesen werden sollen. Dies ist abhängig von der Import Quelle.

![](/images/importmodule-hostdefaults.png)

Zunächst muss ein Container ausgewählt werden, in den die Daten Importiert werden sollen und vergeben einen Namen für die Standardeinstellung.

Anschließend setzen Sie die Einstellungen, die den Importierten Hosts automatisch zugewiesen werden sollen. 

Dies betrifft die Hostvorlage, Geteilte Container und ob die Hosts auf dem Mastersystem oder auf einem Satelliten erstellt werden sollen. 

Zusätzlich haben Sie die Möglichkeit Servicevorlagengruppen-Übereinstimmungen zu tätigen. 

Dazu wählen Sie zuerst das Feld zu Übereinstimmung aus. Dort können Sie zwischen Host Name, Beschreibung, Adresse und Software auswählen.

Danach geben Sie den Regulären Ausdruck an, der mit dem Zuvor ausgewählten Feld übereinstimmen muss. 

Anschließend geben Sie die gewünschte Servicevorlagengruppe an.

### Importer

Ein Importer stellt die Grundlage für das Importieren von Hosts. Hier wird die Datenquelle sowie die Konfiguration der Datenquellenzuordnung definiert. Die Voraussetzung für einen Importer sind Host-Standardeinstellungen. Diese müssen vor dem Erstellen des Importers erstellt werden. 

Als Datenquelle folgende zur verfügung:

###### CSV mit Header

Hier hat die CSV Datei, die man Importieren möchte einen Header. Das bedeutet, dass die Spalten in der Tabelle mit Überschriften gekennzeichnet ist. Pflichtvoraussetzung für den Import ist hier ein Trennzeichen, Eindeutige Kennung, Hostname und Host Adresse. 

![](/images/importmopdule-csvwithheader.png)

###### CSV ohne Header

Der Unterschied zwischen einer CSV mit Header und einer ohne Header besteht darin, dass die Spalten bei einer CSV ohne Header nicht mit überschriften versehen sind. Hier muss also mit der Nummerierung der Spalten gearbeitet werden.

![](/images/importmodule-csvwithoutheader.png)

A = 0, B = 1, C = 2, D = 3

##### Zuweisung von Host-Standardeinstellungen

Die Host-Standardeinstellungen müssen bei der Erstellung des Importers gesetzt werden. Dies Sorgt dafür, dass den Importierten Hosts Standardeinstellungen zugewiesen werden.

![](/images/importmodule-editimporter.png)

### Importierte Host 

![](/images/importmodule-importhostoverview.png)

In der Liste werden alle neuen oder bereits in das Monitoring aufgenommenen Host angezeigt. Alle bevorstehende Änderungen für Services, falls welche vorhanden sind, werden entsprechend angezeigt. Die Vollständigkeit der Eintragen werden mit verschiedenen Wettersymbolen angezeigt. Die Daten können über das Editieren des zu importierenden Hosts können jederzeit ergänzt werden. Falls bestimmt Host nicht in das Monitoring aufgenommen werden sollen, können manuell gelöscht werden. Beim der Synchronisierung mit dem Monitoring werden alle Host, die alle benötigen Felder besitzen, inclusive dazu gehörigen Services in die Konfigurationstabelle aufgenommen. Nun muss nur noch exportiert werden und alle Konfigurationsobjekte werden überwacht.

Im oberen Bereich unter dem Punkt "Import Starten" werden alle auf dem System verfügbaren Importer aufgelistet. Nach dem Klicken auf einen dieser Importers öffnet sich das passende Modal. Im unteren Beispiel ist das ein CSV Importer.

![](/images/importmodule-uploadcsv.png)


## Hostgruppen

### Hostgruppe erstellen

Um eine Hostgruppe zu erstellen, klicken Sie zunächst auf die Schaltfläche “Neu” in der Hostgruppen Übersicht.

Dort wählen Sie einen Container aus und vergeben einen Namen für die Hostgruppe.

Um Hosts einer Hostgruppe hinzuzufügen, haben Sie in diesem Formular zwei möglichkeiten.

Die erste ist das gezielte hinzufügen von einzelnen Hosts. Dazu wählen Sie die entsprechenden Hosts aus der Liste “Hosts” aus. 

Die zweite möglichkeit besteht darin, Hosts über ihr Hostvorlage hinzuzufügen. Dabei werden alle Hosts die von den gewählten Hostvorlagen abgeleitet sind automatisch in die Hostgruppe hinzugefügt. 

Danach Speichert man und die Hostgruppe ist fertig erstellt.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Hostgruppe erstellt werden soll  |
| Name | :fontawesome-solid-times: | Name der Hostgruppe |
| Beschreibung |  | Beschreibung der Hostgruppe |
| Hostgruppen URL |  | URL der Hostgruppe |
| Hosts |  | [Hosts](#hosts) die zur Hostgruppe hinzugefügt werden sollen |
| Hostvorlagen | :fontawesome-solid-times: | Die [Hostvorlagen](#hostvorlagen) die zur Hostgruppe hinzugefügt werden sollen |

### Erweiterte Ansicht

Um zur erweiterten Ansicht einer Hostgruppe zu kommen, klicken Sie in der Hostübersicht auf den Pfeil nach unten neben dem Zahnradsymbol. Dort wählen Sie die “Erweiterte Ansicht”.

Danach erscheint eine Übersichtsseite, die alle Hosts der gewählten Hostgruppe enthält. 

Sie haben dort die möglichkeit verschiedene Aktionen zu tätigen wie zum beispiel die Prüfzeit zurückzusetzen, Geplante Wartungszeiten zu erstellen, Hoststatus zu bestätigen oder Benachrichtigungen zu aktivieren / deaktivieren.

Beim klick auf das “+” Symbol eines Hosts in der Liste öffnet sich eine erweitere Ansicht, die die Services des Hosts, sowie die Gesamtstatus derer enthält.


## Servicegruppen

### Servicegruppe erstellen

Analog zu den Hostgruppen werden Servicegruppen über die Schaltfläche “Neu” in der Servicegruppen übersicht erstellt.

Dort wählt man einen Container aus und vergibt einen Namen für die Servicegruppe.

Um Services einer Servicegruppe hinzuzufügen, haben Sie in diesem Formular zwei möglichkeiten:

Die erste ist das gezielte hinzufügen von einzelnen Services. Dazu wählen Sie die entsprechenden Hosts aus der Liste “Services” aus. 

Die zweite Möglichkeit besteht darin, Services über ihr Servicevorlage hinzuzufügen. Dabei werden alle Services die von den gewählten Servicevorlagen abgeleitet sind automatisch in die Servicegruppe hinzugefügt. 

Danach Speichert man und die Servicegruppe ist fertig erstellt.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | [Container](../container/#container) in dem die Servicegruppe erstellt werden soll  |
| Name | :fontawesome-solid-times: | Name der Servicegruppe |
| Beschreibung |  | Beschreibung der Servicegruppe |
| Servicegruppen URL |  | URL der Servicegruppe |
| Services |  | [Services](#services) die zur Hostgruppe hinzugefügt werden sollen |
| Servicevorlage | :fontawesome-solid-times: | Die [Servicevorlagen](#servicevorlagen) die zur Servicegruppe hinzugefügt werden sollen |

### Erweiterte Ansicht

Um zur erweiterten Ansicht einer Servicegruppe zu kommen, klicken Sie in der Serviceübersicht auf den Pfeil nach unten neben dem Zahnradsymbol. Dort wählen Sie die “Erweiterte Ansicht”.

Danach erscheint eine Übersichtsseite, die alle Hosts der gewählten Hostgruppe enthält. 

Sie haben dort die möglichkeit verschiedene Aktionen zu tätigen wie zum beispiel die Prüfzeit zurückzusetzen, Geplante Wartungszeiten zu erstellen, Servicestatus zu bestätigen oder Benachrichtigungen zu aktivieren / deaktivieren.