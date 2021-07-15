## User Interface

### Das Interface im Überblick
Das Layout des User Interface Teilt sich in zwei Bereiche auf. Den Navigationsbereich (1. Blau) und den Inhaltsbereich (2. Rot)
Der Navigationsbereich von openITCOCKPIT bleibt immer gleich, wohingegen der Inhalt der Ausgewählten Seite immer im Inhaltsbereich (2) Angezeigt wird.

![user-interface](/images/user-interface.png)

### Der Navigationsbereich im Detail

#### Obere Navigationsleiste
![top nav bar](/images/layout-header-explaination.png)

Die Obere Navigationsleiste beinhaltet neben einer Suche (2) und der Uhrzeit (7) weitere kurz links zu verschiedenen Aktionen

1. Schaltfläche zum Ein-/Ausklappen des Hauptmenüs
2. Suchleiste mit der Möglichkeit nach Hosts, Services, UUIDs und IP Adressen zu suchen.
3. Subscription Badge - Nur sichtbar bei unregistrieren und Community Editionen.
4. [Systemzustand (System Health)](#system-health) 
5. [Export](../basic-principles/#export) Schaltfläche
6. Zeigt an ob eine neue openITCOCKPIT Version verfügbar ist. Nur sichtbar wenn dies der Fall ist.
7. Aktuelle Serveruhrzeit
8. Sprach auswahl Box
9. Log-out


##### System health
Die System health Anzeige gibt einen schnellen Überblick auf den Zustand des openITCOCKPIT Servers. 
Hier werden Warnungen und kritische Zustände, wie beispielsweise mangelnder Festplattenspeicher, kritische Arbeitsspeicherauslastung sowie nicht laufenden Dienste, angezeigt.
Ist die Anzeige Leer und in der Farbe Grün dargestellt, ist mit dem Server alles in Ordnung (siehe screenshot). 

![system health](/images/system-health.png)

##### System Uhrzeiten
das User Interface ist in der Lage zwei verschiedene Uhrzeiten anzuzeigen. 

![user server time](/images/user-servertime.png)

Dies geschieht Automatisch, sobald sich die Lokalen Benutzerzeit (1) von der Serverzeit (2) unterscheidet. 
Anpassungen der Benutzer Zeitzone können im [Profil](#profil-informationen) vorgenommen werden. 

#### Hauptmenü
![main menu](/images/main-menu.png)

Das Hauptmenü in openITCOCKPIT bietet neben der Liste mit allen Menüeinträgen auch die Möglichkeit das Menü zu durchsuchen (1). Dazu muss nur einmal auf die Schaltfläche :fontawesome-solid-angle-down: Dies erleichtert das finden von Einträgen im Menü enorm.

Darunter befindet sich die Anzeige Ihres Benutzernamens. Die Goldene Krone signalisiert dass Administrator Rechte zu diesem Benutzer vorhanden sind. Durch einen klick auf den Benutzernamen gelangt man in das [Benutzerprofil](#profil).

Unterhalb des Hauptmenüs befinden sich weitere Schaltflächen (3):

- :fontawesome-solid-chart-line: verlinkt zu einer Übersicht, welche das Senden von Anonymisierten Statistiken an die Entwickler von openITCOCKPIT ermöglicht.
- :fontawesome-solid-bug: führt zur Support Übersichtsseite. Dort haben Sie die möglichkeit Fehler zu melden sowie Kommerziellen Support zu erhalten.
- :fontawesome-solid-life-ring: verlinkt auf die Übersicht der verfügbaren Subskriptionen um Kommerziellen support sowie Enterprise Module zu erhalten.
- :fontawesome-solid-book: verlinkt zu einer Übersichtsseite die weitere Links zu verschiedenen Dokumentationen enthält.


### Profil
In der Profil Übersicht haben Sie die möglichkeit anpassungen an Ihrem eigenen Benutzerprofil zu tätigen. 

#### Profil Informationen

Neben den Änderungsmöglichkeiten Ihres Namens, E-Mail Adresse und Telefonnummer, können Sie verschiedene Einstellungen treffen die die Darstellung von Listen, Browser Darstellungen und weiteres verändern.

![Profil Information edit](/images/profile-information.png)

1. Zeigt Statusinformationen zu den Überwachten Objekten in der Oberen Navigationsleiste an.
2. Rekursiver Browser berücksichtigt im [Browser](#browser) die Elemente in verschachtelten, unterhalb des aktuell gewählten Containers. 
3. Länge der Listen beeinflusst die auf einer seite angezeigten Listenelemente. Diese Einstellung wirkt sich global auf alle Listen aus.
4. Sprache - Hier kann die Anzeigesprache für den Benutzer geändert werden.
5. Gewünschtes Datumsformat des Benutzers
6. Zeitzone des Benutzers.


![Header stats](/images/layout-header-with-stats.png)
Bild zu 1.

#### Profilbild

Um ein Profilbild hochzuladen, können Sie das gewünschte Bild einfach per Drag and Drop in das dafür vorgesehene Feld Ziehen. Das Hochladen und Speichern geschieht anschließend automatisch.

![Profile picture](/images/profile-image.png)

#### Passwort ändern

!!! info
    Diese Option steht nur bei Lokalen Benutzern zur verfügung. Benutzer die über LDAP hinzugefügt wurden, müssen Ihr Passwort über das Betriebssystem oder ein LDAP-Account-Manager-Tool ändern.

Um ihr Passwort zu ändern können Sie dieses Formular nutzen Dazu müssen Sie Ihr altes Passwort bereithalten und ein Neues Passwort vergeben. Die Voraussetzungen für das neue Passwort sind mindestens 6 alphanumerische Zeichen sowie mindestens eine Ziffer.

![Profile change password](/images/profile-changepassword.png)

#### API-Keys
Über Ihre Profil können Sie API-Keys erstellen, welche zur Authentifizierung mit der openITCOCKPIT API genutzt werden. Wie sie einen API-Key erstellen erfahren sie in einem [gesonderten Artikel](../../development/api/#api-keys)



## Browser

Der Browser bietet eine, für einen Benutzer sichtbare, Übersicht aller Container, deren Hosts sowie den Status der Host und Services.

Die Darstellung des Host und Servicestatus zeigt im Standard nur den Status der host und Services an, die in dem aktuell gewählten Container liegen. 

Mit der einstellung “Rekursiver Browser” in den Profileinstellungen wird der Gesamtstatus aller, für einen Benutzer, sichtbaren Host und Services angezeigt.

## Host Browser

Der Host Browser gibt eine Übersicht über den aktuellen Zustand des Host sowie seiner Services. Zudem bekommt man detaillierte Informationen welche Statusinformationen, Geräteinformationen, eine Zeitleiste sowie bei entsprechend installierten Modulen noch mehr informationen bereithält.

### Navigationsleiste

Die Navigationsleiste verlinkt zu verschiedenen Aktionen zu einem Host

![](/images/hosts-browsertopnavbar.png)

#### Prüfzeit Zurücksetzen

![](/images/hosts-browserresetchecktime.png)

 Hiermit wird die Prüfzeit des Hosts zurückgesetzt. Dies hat den selben effekt wie “Prüfzeitraum zurücksetzen” in den Statusinformationen

#### Objekt Dokumentation

![](/images/hosts-browserdocumentation.png)

 Hier kann eine Dokumentation zum Host eingetrgen werden 

#### Benachrichtigungen

![](/images/hosts-browsernotifications.png)

 Um eine Übersicht aller gesendeten Benachrichtigungen zum Host zu bekommen klicken Sie auf diese Schaltfläche 

#### Verlaufshistorie

![](/iamges/hosts-browsercheckhistory.png)

 Die Verlaufshistorie enthält das Ergebnis jeder überprüfung des Hosts mit Datum, Prüfversuch, Statustyp und der Ausgabe.

#### Statushistorie

![](/images/hosts-browserstatehistory.png)

 Die Statushistorie enthält die Ergebnisse wann der Host seinen Status gewechselt hat

#### Bestätigungshistorie

![](/images/hosts-browseracknowledgmenthistory.png)

 Die Bestätigungshistorie enthalt alle bestätigungen zum status des Hosts

#### Host editieren

![](/images/hosts-browseredit.png)

 Hier kann der Host editiert werden

#### Mehr Aktionen

![](/images/hosts-browsermoreactions.png)

##### Service Liste

Hier gelangt man zu einer Übersicht aller vorhandenen Services zu dem Host

##### Servicevorlagengruppe zuordnen

Sie können in openITCOCKPIT Servicevorlagengruppen erstellen, die eine Reihe von Servicevorlagen enthalten. Diese Gruppen können dann über diese Option einem Host zugewiesen werden. Imsich öffnenden Formular können Sie die entsprechende Servicevorlagengruppe und zusätzlich die zu erstellenden Services auswählen. Dies hat den Vorteil dass die passenden Services für einen Host sehr schnell erstellt werden können. Damit die änderungen wirksam werden, muss die Konfiguration anschließend Exportiert werden.

#### openITCOCKPIT Agent Discovery

Hierüber kann die einrichtung für einen openITCOCKPIT Agent erfolgen. Es wird zum Agent wizard weitergeleitet.

#### Checkmk Erkennung

Hierüber kann ein Checkmk discovery gestartet werden.

### Statusinformationen

Die Statusinformationen enthalten für den Status relevante Daten. Diese beinhalten neben den Prüfungsparametern und Benachrichtigungseinstellungen eine Leiste die den Status des aktuellen Hosts anzeigt. Diese Leiste ist in der aktuellen Statusfarbe eingefärbt und enthält Informationen, die aufschluss geben seit wann der Host in diesem Status ist, wann die letzte Überprüfung war, wann die nächste Überprüfung ist und den Status typ. Daüberhinaus gibt es hier die Möglichkeit verschiedene aktionen durchzuführen.

#### Prüfzeitraum zurücksetzen

Beim Prüfzeitraum zurücksetzen wird die nächste überprüfung zum nächstmöglichen Zeitpunkt ausgeführt (i.d.R. sofort). Dies kann entweder nur für den Host selbst oder aber auch für den Host und seine Services ausgewählt werden.

#### Plane Wartung

Über diese Option kann ein Wartungszeitraum für diesen Host eingerichtet werden. Hier gibt man an was genau in dem Wartungszeitraum enthalten sein soll, ein Kommentar zum Wartungszeitraum sowie die Zeitspanne von bis wann die Wartung stattfinden soll 

##### Einzelne Hosts

Bei dieser Option wird nur der Host selbst in einen Wartungszeitraum eingetragen.

##### Hosts einschließlich Services

Bei dieser Option wird der Host selbst, sowie seine Services in ein Wartungszeitraum eingetragen

##### Hosts und abhängige Hosts (ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungszeitraum eingetragen

##### Hosts und abhängige Hosts (nicht ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungszeitraum eingetragen

#### Bestätige Hoststatus

Je nach Benachrichtigungseinstellungen werden Benachrichtigungen für einen Host in einem Intervall versendet. Diese Benachrichtigungen können unterbunden werden, indem man den Host status bestätigt. Hier besteht auch die Option den Status für den Host sowie dessen Services zu bestätigen. Die option “Sticky” lässt die bestätigung so lange bestehen, bis der Host wieder im Status “UP” ist

#### Passive Übertragung eines Prüfergebnisses

Mit dem passiven Übertragen von Prüfergebnissen, erhält der Host den angegebenen Status mit Kommentar. Ist “Auf harten Zustand zwingen” angehakt, so bleibt der Zustand aktiv, bis die nächste Überprüfung ausgeführt wird.

#### Deaktiviere Benachrichtigungen

Mit dieser Option können Sie benachrichtigungen für den Host oder den Host und seine Services vorübergehend deaktivieren 

#### Benutzerdefinierte Hostbenachrichtigung senden

Um eine Benutzerdefinierte Hostbenachrichtigung zu senden wählen Sie diese Option. Hier kann ausgewählt werden ob das senden der nachricht erzwungen werden soll. Hierbei wird der Benachrichtigungszeitraum sowie die deaktivierten Benachrichtigungen für den Host ignoriert. Zudem kann man auswählen ob die Benachrichtigung auch an die Eskalationskontakte gesendet werden soll. 

### Geräte informationen

In den Geräte informationen finden Sie eigenschaften zu dem Host. Diese bestehen aus der IP-Adresse / Hostname, die UUID welche den Host im openITCOCKPIT genau identifiziert sowie Berechtigungsinformationen und weitere eigenschaften.

### Zeitleiste

Die Zeitleiste gibt eine genaue Übersicht über den Host, was wann passiert ist. Sie enthält informationen wann ein Host status bestätigt, Wartungszeiten eingetragen, Benachrichtigungen gesendet worden sind und wann der Host welchen Status hatte.

![](/images/hosts-browsertimeline.png)

### Grafana

Unter dem Reiter “Grafana” finden Sie das Grafana dashboard zu diesem Host. 

Hier werden alle verfügbaren graphen zu den Services des Hosts dargestellt


## Service Browser

Der Service Browser gibt eine Übersicht über den aktuellen Zustand des Service. Zudem bekommt man detaillierte Informationen welche Status Informationen, Service Informationen, eine Zeitleiste sowie bei entsprechend installierten Modulen noch mehr informationen beinhalten

### Navigationsleiste

Die Navigationsleiste verlinkt zu verschiedenen Aktionen zu einem Service.

![](/images/services-browsertopnavbar.png)

#### Prüfzeit Zurücksetzen

![](/images/hosts-browserresetchecktime.png)

 Hiermit wird die Prüfzeit des Services zurückgesetzt. Dies hat den selben effekt wie “Prüfzeitraum zurücksetzen” in den Statusinformationen

#### Objekt Dokumentation

![](/images/hosts-browserdocumentation.png)

 Hier kann eine Dokumentation zum Service eingetragen werden 

#### Benachrichtigungen

![](/images/hosts-browsernotifications.png)

 Um eine Übersicht aller gesendeten Benachrichtigungen zum Service zu bekommen klicken Sie auf diese Schaltfläche 

#### Verlaufshistorie

![](/images/attachments/hosts-browsercheckhistory.png)

 Die Verlaufshistorie enthält das Ergebnis jeder überprüfung des Services mit Datum, Prüfversuch, Statustyp und der Ausgabe.

#### Statushistorie

![](/images/hosts-browserstatehistory.png)

 Die Statushistorie enthält die Ergebnisse wann der Service seinen Status gewechselt hat

#### Bestätigungshistorie

![](/images/hosts-browseracknowledgmenthistory.png)

 Die Bestätigungshistorie enthalt alle bestätigungen zum Status des Service

#### Host editieren

![](/images/hosts-browseredit.png)

 Hier kann der Host des Services editiert werden

#### Service editieren

![](/images/services-browsereditservice.png)

 Hier kann der Service selbst editiert werden

#### Mehr Aktionen

![](/images/services-browsermoreactions.png)

##### Service liste

Hier gelangt man zu einer Übersicht aller vorhandenen Services des selben Hosts

### Status Informationen

Die Statusinformationen enthalten für den Status relevante Daten. Diese beinhalten neben den Prüfungsparametern und Benachrichtigungseinstellungen eine Leiste die den Status des aktuellen Services anzeigt. Diese Leiste ist in der aktuellen Statusfarbe eingefärbt und enthält Informationen, die aufschluss geben seit wann der Service in diesem Status ist, wann die letzte Überprüfung war, wann die nächste Überprüfung ist und den Status typ. Daüberhinaus gibt es hier die Möglichkeit andere verschiedene Aktionen durchzuführen.

#### Prüfzeit zurücksetzen

Beim Prüfzeit zurücksetzen wird die nächste überprüfung zum nächstmöglichen Zeitpunkt ausgeführt (i.d.R. sofort).

#### Plane Wartung

Über diese Option kann ein Wartungszeitraum für diesen Service eingerichtet werden. Hier gibt man ein Kommentar zum Wartungszeitraum an sowie die Zeitspanne von bis wann die Wartung stattfinden soll 

#### Passive Übertragung eines Prüfergebnisses

Mit dem passiven Übertragen von Prüfergebnissen, erhält der Service den angegebenen Status mit Kommentar. Ist “Auf harten Zustand zwingen” angehakt, so bleibt der Zustand aktiv, bis die nächste Überprüfung ausgeführt wird.

#### Aktiviere die Flattererkennung (Flapping)

Hier wird die erkennung des Flapping status vorübergehend aktiviert

#### Deaktiviere Benachrichtigungen

Mit dieser Option können Sie benachrichtigungen für den Service vorübergehend deaktivieren 

#### Benutzerdefinierte Servicebenachrichtigung senden

Um eine Benutzerdefinierte Servicebenachrichtigung zu senden wählen Sie diese Option. Hier kann ausgewählt werden ob das senden der Nachricht erzwungen werden soll. Hierbei wird der Benachrichtigungszeitraum sowie die deaktivierten Benachrichtigungen für den Service ignoriert. Zudem kann man auswählen ob die Benachrichtigung auch an die Eskalationskontakte gesendet werden soll. 

### Service Informationen

In den Service Informationen finden Sie eigenschaften zu dem Service. Diese bestehen aus der IP-Adresse / Hostname des Hosts, die UUIDs welche den Host und Service im openITCOCKPIT genau identifiziert sowie Berechtigungsinformationen und weitere eigenschaften.

### Zeitleiste

Die Zeitleiste gibt eine genaue Übersicht über den Service, was wann passiert ist. Sie enthält informationen wann ein Service status bestätigt, Wartungszeiten eingetragen, Benachrichtigungen gesendet worden sind und wann der Service welchen Status hatte.

Darüberhinaus ist zudem der Hoststatus enthalten.

![](/images/services-browsertimeline.png)