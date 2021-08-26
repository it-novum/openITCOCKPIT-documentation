# Hosts auf ENGLISH

In der Hostübersicht findet man alle in openITCOCKPIT bekannten Hosts. Diese sind gegliedert nach

-   Überwachte Hosts
-   Nicht überwachte Hosts
-   Deaktivierte Hosts
-   Gelöschte Hosts

#### Überwacht

Unter dem Reiter “Überwacht” findet man alle aktuell überwachten Hosts die auch der Monitoring Engine bekannt sind.

#### Nicht überwacht

Nicht überwachte Hosts sind im openITPCOCKPIT erstellte Hosts die der Monitoring Engine nicht bekannt sind. Diese Hosts finden sich nach einem Export der Konfiguration unter den Überwachten Hosts

#### Deaktiviert

Deaktivierte Hosts werden beim ausführen von checks ignoriert. Sie können zu einem belibigen zeitpunkt wieder aktiviert werden. Nach einem Export werden diese dann auch wieder überwacht. Einen Host können Sie zum Beispiel über die Host Übersicht deaktivieren.

#### Gelöscht

Hier finden sich alle gelöschten hosts. zusätzlich wird hier angezeigt, ob die Performanche daten zu dem gelöschten Host bereits gelöscht wurden.

## Host optionen

In der Hostübersicht befinden sich zahlreiche optionen um einen Host modifizieren, zu löschen und weitere aktionen zu starten

![](/openitcockpit-v4-dokumentation/attachments/hosts-options.png)

### Teilen

Hier kann der host in andere Container geteilt werden. Die Option entspricht den Geteilten Containern beim Host erstellen / editieren.

### Kopieren

Um einen Host zu kopieren, Klicken sie auf diese Option. Es öffnet sich ein Formular, bei dem anschließend der Hostname, Beschreibung, Adresse sowie die Host URL geändert werden kann. Der Rest der Daten wird vom Quell Host übernommen. Diese option steht auch als Massenaktion zur Verfügung (über die Fußleiste der Tabelle)

### Deaktivieren

Um einen Host zu Deaktivieren wählen Sie diese Option. Diese Option ist auch über Massenaktionen verfügbar.

### Service Liste

Um einen Überblick von Services zum gewählten Host zu bekommen, können Sie die Service Liste anklicken. Dort sehen Sie anschließend alle Aktiven, Nicht berwachten, Deaktivierten und Gelöschten Services zu diesem Host.

### Servicevorlagengruppe zuordnen

Sie können in openITCOCKPIT Servicevorlagengruppen erstellen, die eine Reihe von Servicevorlagen enthalten. Diese Gruppen können dann über diese Option einem Host zugewiesen werden. Imsich öffnenden Formular können Sie die entsprechende Servicevorlagengruppe und zusätzlich die zu erstellenden Services auswählen. Dies hat den Vorteil dass die passenden Services für einen Host sehr schnell erstellt werden können. Damit die änderungen wirksam werden, muss die Konfiguration anschließend Exportiert werden.

### An Hostgruppe anhängen

Über diese Option können Sie einen Host einer vorhandenen Hostgruppe zuweisen oder eine Neue Hostgruppe mit dem gewählten Host erstellen. Diese Option ist auch über Massenaktionen verfügbar

### openITCOCKPIT Agent discovery

Hierüber kann die einrichtung für einen openITCOCKPIT Agent erfolgen. Es wird zum Agent wizard weitergeleitet.

### Von Autoreport verwendeter Host

Mit dieser Option können Sie feststellen ob ein Host in einem Autoreport verwendet wird.

### Checkmk Erkennung

Hierüber kann ein Checkmk discovery gestartet werden.

### Von der Ereigniskorrelation verwendeter Host

Mit dieser Option können Sie feststellen ob ein Host in einem Ereigniskorrelation verwendet wird.

## Host erstellen

Um einen Host zu erstellen wählen Sie zunächst einen Contaner aus, in dem der Host erstellt werden soll. Bitte beachten Sie dass ein nachträgliches ändern des Containers für einen Host **_nicht möglich_** ist!

Danach wählen Sie eine Hostvorlage aus, von dem der neue Host abgeleitet werden soll.

Sie können anschließend einen Host Namen und eine Host Adresse vergeben, oder aber Sie vergeben eine Host Adresse und lassen den Hostnamen über die DNS-Suche automatisch vervollständigen.

Beim Abspeichern haben Sie die möglichkeit direkt neue Services zum Host anzulegen. Diese können entweder über den openITCOCKPIT Agent, Checkmk oder den Klassischen weg des Manuellen erstellens erzeugt werden.

### Geteilte Container

Über die Geteilten Container ist es möglich Hosts in anderen Containern "sichtbar" zu machen. Dies ist nützlich um Benutzern welche keine Berechtigung auf den ursprünglichen Container des Hosts haben, trotzdem zugang zum Host zu geben. Diese Option steht zudem auch in der Hostübersicht unter der Host bearbeitungsoption “Teilen” zur verfügung.

### Benachrichtigungen

Damit eine Benachrichtigung zu einem Host status gesendet werden kann, wird in der Hostkonfiguration mit einem Prüfung und Wiederholungsintervall sowie einer Maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist bei der default host vorlage ein Prüfungsintervall von 2 Stunden, ein Wiederholungsintervall von 1 Minute und eine Maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 2 Stunden und 2 Minuten eine Benachrichtigung gesendet wird.

### Prometheus Exporters

– Folgt –

# Host Browser

Der Host Browser gibt eine Übersicht über den aktuellen Zustand des Host sowie seiner Services. Zudem bekommt man detaillierte Informationen welche Statusinformationen, Geräteinformationen, eine Zeitleiste sowie bei entsprechend installierten Modulen noch mehr informationen bereithält.

## Navigationsleiste

Die Navigationsleiste verlinkt zu verschiedenen Aktionen zu einem Host

![](/openitcockpit-v4-dokumentation/attachments/hosts-browsertopnavbar.png)

### Prüfzeit Zurücksetzen

![](/openitcockpit-v4-dokumentation/attachments/hosts-browserresetchecktime.png)

Hiermit wird die Prüfzeit des Hosts zurückgesetzt. Dies hat den selben effekt wie “Prüfzeitraum zurücksetzen” in den Statusinformationen

### Objekt Dokumentation

![](/openitcockpit-v4-dokumentation/attachments/hosts-browserdocumentation.png)

Hier kann eine Dokumentation zum Host eingetrgen werden

### Benachrichtigungen

![](/openitcockpit-v4-dokumentation/attachments/hosts-browsernotifications.png)

Um eine Übersicht aller gesendeten Benachrichtigungen zum Host zu bekommen klicken Sie auf diese Schaltfläche

### Verlaufshistorie

![](/openitcockpit-v4-dokumentation/attachments/hosts-browsercheckhistory.png)

Die Verlaufshistorie enthält das Ergebnis jeder überprüfung des Hosts mit Datum, Prüfversuch, Statustyp und der Ausgabe.

### Statushistorie

![](/openitcockpit-v4-dokumentation/attachments/hosts-browserstatehistory.png)

Die Statushistorie enthält die Ergebnisse wann der Host seinen Status gewechselt hat

### Bestätigungshistorie

![](/openitcockpit-v4-dokumentation/attachments/hosts-browseracknowledgmenthistory.png)

Die Bestätigungshistorie enthalt alle bestätigungen zum status des Hosts

### Host editieren

![](/openitcockpit-v4-dokumentation/attachments/hosts-browseredit.png)

Hier kann der Host editiert werden

### Mehr Aktionen

![](/openitcockpit-v4-dokumentation/attachments/hosts-browsermoreactions.png)

#### Service Liste

Hier gelangt man zu einer Übersicht aller vorhandenen Services zu dem Host

#### Servicevorlagengruppe zuordnen

Sie können in openITCOCKPIT Servicevorlagengruppen erstellen, die eine Reihe von Servicevorlagen enthalten. Diese Gruppen können dann über diese Option einem Host zugewiesen werden. Imsich öffnenden Formular können Sie die entsprechende Servicevorlagengruppe und zusätzlich die zu erstellenden Services auswählen. Dies hat den Vorteil dass die passenden Services für einen Host sehr schnell erstellt werden können. Damit die änderungen wirksam werden, muss die Konfiguration anschließend Exportiert werden.

#### openITCOCKPIT Agent Discovery

Hierüber kann die einrichtung für einen openITCOCKPIT Agent erfolgen. Es wird zum Agent wizard weitergeleitet.

#### Checkmk Erkennung

Hierüber kann ein Checkmk discovery gestartet werden.

## Statusinformationen

Die Statusinformationen enthalten für den Status relevante Daten. Diese beinhalten neben den Prüfungsparametern und Benachrichtigungseinstellungen eine Leiste die den Status des aktuellen Hosts anzeigt. Diese Leiste ist in der aktuellen Statusfarbe eingefärbt und enthält Informationen, die aufschluss geben seit wann der Host in diesem Status ist, wann die letzte Überprüfung war, wann die nächste Überprüfung ist und den Status typ. Daüberhinaus gibt es hier die Möglichkeit verschiedene aktionen durchzuführen.

### Prüfzeitraum zurücksetzen

Beim Prüfzeitraum zurücksetzen wird die nächste überprüfung zum nächstmöglichen Zeitpunkt ausgeführt (i.d.R. sofort). Dies kann entweder nur für den Host selbst oder aber auch für den Host und seine Services ausgewählt werden.

### Plane Wartung

Über diese Option kann ein Wartungszeitraum für diesen Host eingerichtet werden. Hier gibt man an was genau in dem Wartungszeitraum enthalten sein soll, ein Kommentar zum Wartungszeitraum sowie die Zeitspanne von bis wann die Wartung stattfinden soll

#### Einzelne Hosts

Bei dieser Option wird nur der Host selbst in einen Wartungszeitraum eingetragen.

#### Hosts einschließlich Services

Bei dieser Option wird der Host selbst, sowie seine Services in ein Wartungszeitraum eingetragen

#### Hosts und abhängige Hosts (ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungszeitraum eingetragen

#### Hosts und abhängige Hosts (nicht ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungszeitraum eingetragen

### Bestätige Hoststatus

Je nach Benachrichtigungseinstellungen werden Benachrichtigungen für einen Host in einem Intervall versendet. Diese Benachrichtigungen können unterbunden werden, indem man den Host status bestätigt. Hier besteht auch die Option den Status für den Host sowie dessen Services zu bestätigen. Die option “Sticky” lässt die bestätigung so lange bestehen, bis der Host wieder im Status “UP” ist

### Passive Übertragung eines Prüfergebnisses

Mit dem passiven Übertragen von Prüfergebnissen, erhält der Host den angegebenen Status mit Kommentar. Ist “Auf harten Zustand zwingen” angehakt, so bleibt der Zustand aktiv, bis die nächste Überprüfung ausgeführt wird.

### Deaktiviere Benachrichtigungen

Mit dieser Option können Sie benachrichtigungen für den Host oder den Host und seine Services vorübergehend deaktivieren

### Benutzerdefinierte Hostbenachrichtigung senden

Um eine Benutzerdefinierte Hostbenachrichtigung zu senden wählen Sie diese Option. Hier kann ausgewählt werden ob das senden der nachricht erzwungen werden soll. Hierbei wird der Benachrichtigungszeitraum sowie die deaktivierten Benachrichtigungen für den Host ignoriert. Zudem kann man auswählen ob die Benachrichtigung auch an die Eskalationskontakte gesendet werden soll.

## Geräte informationen

In den Geräte informationen finden Sie eigenschaften zu dem Host. Diese bestehen aus der IP-Adresse / Hostname, die UUID welche den Host im openITCOCKPIT genau identifiziert sowie Berechtigungsinformationen und weitere eigenschaften.

## Zeitleiste

Die Zeitleiste gibt eine genaue Übersicht über den Host, was wann passiert ist. Sie enthält informationen wann ein Host status bestätigt, Wartungszeiten eingetragen, Benachrichtigungen gesendet worden sind und wann der Host welchen Status hatte.

![](/openitcockpit-v4-dokumentation/attachments/hosts-browsertimeline.png)

## Grafana

Unter dem Reiter “Grafana” finden Sie das Grafana dashboard zu diesem Host.

Hier werden alle verfügbaren graphen zu den Services des Hosts dargestellt