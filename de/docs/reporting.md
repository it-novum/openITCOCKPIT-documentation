# Reporting

openITCOCKPIT ist in der Lage Berichte (Reports) zu generieren. Diese Berichte können unterschiedlichste Daten wie zum
Beispiel Wartungszeiten, Ausfälle, Verfügbarkeiten und den aktuellen Status einzelner Host und Services beinhalten.

## Sofortige Berichte

Sofortige Berichte in openITCOCKPIT sind eine Variante der Berichte, die als HTML oder PDF generiert und optional auch
in einem Benutzerdefinierten Intervall versendet werden können.

Sofortige Berichte enthalten je nach Auswahl eine zusammenfassung des Status von Hosts, Services, Hostgruppen oder
Servicegruppen.

### Sofortigen Bericht erstellen

Um einen "Sofortigen Bericht" zu erstellen, klicken Sie zunächst in der "Sofortige Berichte" Übersicht auf die
Schaltfläche "Neu".

Anschließend wählen Sie im Formular einen Container aus, vergeben einen Namen und wählen den Objekttyp aus, der
ausgewertet werden soll.

Je nach gewähltem Objekttyp wählen Sie im darauffolgenden feld entweder Hosts, Hostgruppen, Services oder Servicegruppen
aus, die ausgewertet werden sollen.

Der Zeitraum gibt an wann die Auswertungszeiten stattfinden sollen.

Der Reflexionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur ein
harter Zustand berücksichtigt werden soll.

Sie haben die möglichkeit wartungszeiten im Bericht zu berücksichtigen, dazu wählen Sie die Option "Berücksichtige
Wartungszeiten".

Ist die Option "Zusammenfassungsanzeige" ausgewählt, wird anstatt der Auflistung von einzelnen Hosts und deren Services
nur eine Gesamte ansicht der Status von Host und Services angezeigt.

Möchten Sie einen Bericht in einem Intervall von Tag, Woche, Monat oder Jahr automatisiert verschicken, so müssen Sie
die Option "Sende E-Mail" aktivieren.

Dort können Sie einem oder mehreren Benutzern den Bericht schicken.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | Container in dem der Sofortige Bericht erstellt werden soll |
| Name | :fontawesome-solid-times: | Name des Sofortigen Berichts |
| Typ | :fontawesome-solid-times: | Objekttyp der ausgewertet werden soll. Hostgruppen, Hosts, Servicegruppen und Services sind möglich  |
| Typ-Objekte | :fontawesome-solid-times: | Abhängig vom gewählten Typ müssen im nächsten Feld entweder Hosts, Hostgruppen, Services oder Servicegruppen ausgewählt werden |
| Auswertung | :fontawesome-solid-times: | Welche Objekte ausgewertet werden -> Nur Hosts, Hosts und Services oder nur Services |
| Zeitraum | :fontawesome-solid-times: | [Zeitraum](../configuration/timeperiods/) der Berücksichtigt werden soll |
| Reflexionszustand | :fontawesome-solid-times: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Berücksichtige Wartungszeiten |  | Bestimmt ob Wartungszeiten berücksichtigt werden sollen |
| Zusammenfassungsanzeige |  | Bestimmt ob anstelle der Auflistungen von einzelnen Hosts eine Gesamtansicht der Status von Host und Services angezeigt wird |
| Sende E-Mail |
| Sendungsintervall | :fontawesome-solid-times: | Sendungsintervall: TAG, WOCHE, MONAT, JAHR |
| Benutzer zum Senden | :fontawesome-solid-times: | Benutzer an den der Bericht gesendet werden soll |



### Sofortigen Bericht generieren

Wenn Sie einen "Sofortigen Bericht" erstellt haben, klicken Sie auf das Menü des entsprechenden "Sofortigen Bericht" (1)
und anschließend auf die Schaltfläche "Generieren" (2).

![](/images/instantreports-generate.png)

Im sich öffnenden Formular geben Sie anschließend das Format an, in dem der Bericht generiert werden soll, sowie den zu
berücksichtigenden Zeitraum.

Danach bekommen Sie den Bericht im Browser angezeigt oder aber als Download zur verfügung gestellt.

## Aktueller Statusbericht

Der "Aktuelle Statusbericht" generiert einen Bericht im HTML oder PDF Format anhand von gewählten Services.

Neben den Status Filter funktionen kann zusätzlich nach Bestätigungen, Wartungszeiten und dem Prüfungstyp gefiltert
werden.

Der generierte Bericht enthält neben dem Hoststatus der gewählten Services auch die verschiedenen Metriken (Performance
Daten) der Services.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Services | :fontawesome-solid-times: | Services die ausgewertet werden sollen |
| Berichtsformat | :fontawesome-solid-times: | Berichtsformat HTML oder PDF |

## Wartungszeitberichte

Wartungszeitberichte in openITCOCKPIT geben aufschluss darüber, welche Hosts oder welche Hosts und Services sich wann in
einer Wartungszeit befanden. Dies wird visuell anhand eines Kalenders und Diagrammen dargestellt.

### Wartungszeitbericht erstellen

Um einen Wartungszeitbericht zu erstellen, klicken Sie im Hauptmenü auf den Punkt "Wartungszeitberichte".

Dort wählen Sie aus ob nur Hosts oder Host und Services ausgewertet werden sollen.

Bei dem Berichtsformat haben Sie die Wahl zwischen einem HTML bericht, der im Browser dargestellt wird oder einem PDF
bericht der zum Download angeboten wird.

Der Zeitraum definiert, welche Wartungszeiten berücksichtigt werden sollen.

Der Reflexionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur ein
harter Zustand berücksichtigt werden soll.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Auswertung | :fontawesome-solid-times: | Hosts oder Hosts inklusive Services |
| Berichtsformat | :fontawesome-solid-times: | Berichtsformat HTML oder PDF |
| Zeitraum | :fontawesome-solid-times: | [Zeitraum](../configuration/timeperiods/) der berücksichtigt werden soll |
| Von |  | Start Zeitraum der Auswertung |
| Bis |  | End Zeitraum der Auswertung |
| Reflexionszustand | :fontawesome-solid-times: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Dynamische Farbe |  | Je nach Ausfall werden verschiedene Farben angezeigt |

## Autoreports <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

Das Autoreport-Modul in openITCOCKPIT ist ein konfigurierbarer Report, der automatisiert versendet werden kann. Ein
Report enthält die Ausfalldauer, maximal zulässige Ausfalldauer, sowie die Verfügbarkeit der gewählten Hosts und
Services.

### Autoreport erstellen

Um einen Autoreport zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu" in der Autoreports Übersicht.

Es öffnet sich der Autoreport Wizard, der Sie durch die Erstellung des Reports begleiten wird.

Wählen Sie zuerst einen Container für den Report aus und vergeben einen Namen.

Danach wählen Sie einen Zeitraum aus der zur Auswertung dient.

Der Bewertungszeitraum definiert den Zeitraum, ab wann ausgewertet werden soll.

Das Sendungsintervall definiert den Zeitraum, wann der Report versendet werden soll.

Danach geben Sie entweder eine garantierte Verfügbarkeit in Prozent an oder die maximale Anzahl von Ausfällen.

Die angezeigten Graphen können entweder in Prozent oder in Stunden angezeigt werden. Um dies Festzulegen müssen Sie in
dem Feld "Graph" eine auswahl tätigen.

Der Reflektionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur
ein harter Zustand berücksichtigt werden soll.

Damit Wartungszeiten im Report nicht als Ausfälle angezeigt werden, können Sie die Option "Berücksichtige
Wartungszeiten" aktivieren.

Um Zusätzlich auch Feiertage zu berücksichtigen, aktivieren Sie die Option "Betrachte Feiertage" und wählen anschließend
einen Kalender aus.

Damit der Bericht versendet werden kann, muss zudem noch mindestens ein Benutzer ausgewählt werden.

Im nächsten Schritt wählen Sie die Hosts, aus die in dem Bericht ausgewertet werden sollen.

Es erscheint eine übersicht der Services aller gewählten Hosts. Hier können Sie auswählen wie diese ausgewertet werden
sollen.

Im letzten Schritt sehen Sie noch eine Übersicht der konfigurierten Einstellungen für den Bericht. Wenn alles passt,
klicken Sie weiter auf "Fertig"

Der Report wird nun automatisch in der angegebenen Zeit versendet. Sie haben allerdings auch die möglichkeit den Report
direkt als PDF oder HTML generieren zu lassen. Dazu klicken Sie im Menü des entsprechenden Reports auf "Generiere
Bericht".

Dort wählen Sie dann das Ausgabeformat aus und den Zeitraum der Ausgewertet werden soll. Nach dem Klick auf "Generiere
Bericht" bekommen Sie entweder den Report als PDF zum Download angeboten oder aber direkt im Browser in der HTML Version
angezeigt.

#### Berichtskonfiguration

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | Container in dem der Autoreport erstellt werden soll |
| Berichtsname | :fontawesome-solid-times: | Name des Autoreports |
| Berichtsbeschreibung |  | Beschreibung des Autoreports |
| Setze Start |  | Startdatum des Berichts soll definiert werden |
| Startdatum |  | Startdatum des Berichts. Kann nur bearbeitet werden wenn "Setze Start" aktiviert wurde |
| Zeitraum | :fontawesome-solid-times: | [Zeitraum](../configuration/timeperiods/) der berücksichtigt werden soll |
| Bewertungszeitraum | :fontawesome-solid-times: | Tag, Woche, Monat, Quartal oder Jahr |
| Sendungsintervall | :fontawesome-solid-times: | Täglich, Wöchentlich, Monatlich, Vierteljährlich, Jährlich oder niemals |
| Garantierte Verfügbarkeit | :fontawesome-solid-times: | Verfügbarkeit in Prozent. Es muss entweder "Garantierte Verfügbarkeit" oder "Maximale Anzahl von Ausfällen" angegeben sein |
| Maximale Anzahl von Ausfällen | :fontawesome-solid-times: | Maximale Anzahl von Ausfällen. Es muss entweder "Garantierte Verfügbarkeit" oder "Maximale Anzahl von Ausfällen" angegeben sein |
| Graph |  | Graph in Prozent oder Stunden |
| Reflexionszustand | :fontawesome-solid-times: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Berücksichtige Wartungszeiten |  | Wartungszeiten zählen nicht als Ausfälle, wenn aktiviert |
| Betrachte Feiertage |  | Feiertage werden berücksichtigt |
| Kalender |  | Kalender mit Feiertagen. Nur konfigurierbar, wenn "Betrachte Feiertage" aktiviert ist |
| Benutzer |  | Benutzer an den der Bericht gesendet wird |

#### Host- und Servicekonfiguration

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Hosts | :fontawesome-solid-times: | Hosts die ausgewertet werden sollen |
| Service RegEx |  | Filter für Services als Regulärer Ausdruck |


### Autoreport Globals

Im Hauptmenü unter Systemkonfiguration → System → Autoreport Globals lassen sich verschiedene Standardeinstellungen zu
den Autoreports einstellen. Beschreibungen zu den einzelnen Optionen finden sich direkt in der Tabelle unter dem "Info
Button".

![](/images/autoreportModule-globalsinfo.png)

Bitte Beachten Sie, dass die Optionen die Sie dort setzen sich auf alle über das Autoreport-Modul generierten Berichte
auswirkt!