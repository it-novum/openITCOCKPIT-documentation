# Downtimes

## Wartungszeiten

Unter den Wartungszeiten können eine Reihe von Wartungszeiträumen für Host, Services, Hostgruppen und Container erstellt
werden.

Wartungszeiten werden in den Reports nicht als Ausfälle angesehen.

### Host Wartungszeit

Eine Host-Wartungszeit ist ein Wartungszeitraum für einen einzelnen Hosts oder einzelne Hosts und deren Services.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Hosts | :fontawesome-solid-xmark: | Hosts, für die eine Wartungszeit erstellt werden soll |
| Wartungszeitraum für | :fontawesome-solid-xmark: | Hier kann festgelegt werden, ob nur für den Host oder den Host inklusive seiner Services eine Wartungszeit erstellt werden soll. |
| Kommentar |  | Kommentar für die zu erstellende Wartungszeit |
| Wiederkehrende Wartungszeit |  | Wird diese Option aktiviert, so kann eine Startzeit, Dauer, Wochentage oder Tag des Monats für die Wiederkehrende Wartungszeit gesetzt werden. |
| Einzelne Wartungszeit |
| Von | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit starten soll |
| Bis | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit enden soll |
| Wiederkehrende Wartungszeit |
| Startzeit | :fontawesome-solid-xmark: | Startzeit wann die Wiederkehrende Wartungszeit anfangen soll |
| Dauer | :fontawesome-solid-xmark: | Dauer der Wiederkehrenden Wartungszeit |
| Wochentage | :fontawesome-solid-xmark: | An welchem Wochentag soll die Wiederkehrende Wartungszeit erfolgen |
| Tag des Monats | :fontawesome-solid-xmark: | An welchem Tag des Monats soll die Wiederkehrende Wartungszeit erfolgen |

### Service Wartungszeit

Eine Service-Wartungszeit ist ein Wartungszeitraum für einen oder mehrere Services. Diese Services können von
unterschiedlichen Hosts sein.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Services | :fontawesome-solid-xmark: | Services, für die eine Wartungszeit erstellt werden soll |
| Kommentar |  | Kommentar für die zu erstellende Wartungszeit |
| Wiederkehrende Wartungszeit |  | Wird diese Option aktiviert, so kann eine Startzeit, Dauer, Wochentage oder Tag des Monats für die Wiederkehrende Wartungszeit gesetzt werden. |
| Einzelne Wartungszeit |
| Von | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit starten soll |
| Bis | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit enden soll |
| Wiederkehrende Wartungszeit |
| Startzeit | :fontawesome-solid-xmark: | Startzeit wann die Wiederkehrende Wartungszeit anfangen soll |
| Dauer | :fontawesome-solid-xmark: | Dauer der Wiederkehrenden Wartungszeit |
| Wochentage | :fontawesome-solid-xmark: | An welchem Wochentag soll die Wiederkehrende Wartungszeit erfolgen |
| Tag des Monats | :fontawesome-solid-xmark: | An welchem Tag des Monats soll die Wiederkehrende Wartungszeit erfolgen |

### Hostgruppen Wartungszeit

Eine Hostgruppen Wartungszeit ist ähnlich wie ein Host Wartungszeitraum. Hier können jedoch ganze Hostgruppen sowie
deren Services in eine Wartungszeit aufgenommen werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Hostgruppen | :fontawesome-solid-xmark: | Hostgruppe, für die eine Wartungszeit erstellt werden soll |
| Wartungszeitraum für | :fontawesome-solid-xmark: | Hier kann festgelegt werden, ob nur für die Hosts oder die Hosts inklusive ihrer Services eine Wartungszeit erstellt werden soll. |
| Kommentar |  | Kommentar für die zu erstellende Wartungszeit |
| Wiederkehrende Wartungszeit |  | Wird diese Option aktiviert, so kann eine Startzeit, Dauer, Wochentage oder Tag des Monats für die Wiederkehrende Wartungszeit gesetzt werden. |
| Einzelne Wartungszeit |
| Von | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit starten soll |
| Bis | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit enden soll |
| Wiederkehrende Wartungszeit |
| Startzeit | :fontawesome-solid-xmark: | Startzeit wann die Wiederkehrende Wartungszeit anfangen soll |
| Dauer | :fontawesome-solid-xmark: | Dauer der Wiederkehrenden Wartungszeit |
| Wochentage | :fontawesome-solid-xmark: | An welchem Wochentag soll die Wiederkehrende Wartungszeit erfolgen |
| Tag des Monats | :fontawesome-solid-xmark: | An welchem Tag des Monats soll die Wiederkehrende Wartungszeit erfolgen |

### Container Wartungszeit

Eine Container-Wartungszeit ermöglicht es komplette Container in openITCOCKPIT in einen Wartungszeitraum einzutragen.
Hierbei kann ausgewählt werden, ob nur der angegebene Container selbst oder zusätzlich rekursiv seine Kind-Container mit
in die Wartungszeit aufgenommen werden sollen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Host | :fontawesome-solid-xmark: | Container, für die eine Wartungszeit erstellt werden soll |
| Rekursives Nachschlagen von Containern |  | Ist diese Option Aktiviert, so werden auch die Kind-Container des angegebenen Containers in die Wartungszeit mit aufgenommen |
| Wartungszeitraum für | :fontawesome-solid-xmark: | Hier kann festgelegt werden, ob nur für den Host oder den Host inklusive seiner Services eine Wartungszeit erstellt werden soll. |
| Kommentar |  | Kommentar für die zu erstellende Wartungszeit |
| Wiederkehrende Wartungszeit |  | Wird diese Option aktiviert, so kann eine Startzeit, Dauer, Wochentage oder Tag des Monats für die Wiederkehrende Wartungszeit gesetzt werden. |
| Einzelne Wartungszeit |
| Von | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit starten soll |
| Bis | :fontawesome-solid-xmark: | Datum und Uhrzeit, wann die Wartungszeit enden soll |
| Wiederkehrende Wartungszeit |
| Startzeit | :fontawesome-solid-xmark: | Startzeit wann die Wiederkehrende Wartungszeit anfangen soll |
| Dauer | :fontawesome-solid-xmark: | Dauer der Wiederkehrenden Wartungszeit |
| Wochentage | :fontawesome-solid-xmark: | An welchem Wochentag soll die Wiederkehrende Wartungszeit erfolgen |
| Tag des Monats | :fontawesome-solid-xmark: | An welchem Tag des Monats soll die Wiederkehrende Wartungszeit erfolgen |

### Wiederkehrende Wartungszeit

Für alle oben genannten Wartungszeit-typen können wiederkehrende Wartungszeiten erstellt werden. Dazu muss die Option 
"Wiederkehrenden Wartungszeit" aktiviert sein. Anschließend hat man anstatt der Standardmäßigen "Von - Bis" 
Eingabefelder nun Ein feld für die Startzeit, die Dauer der Wartungszeit und an welchem Wochentag oder an welchem Tag 
des Monats die Wartungszeit stattfinden soll.

### Wartungszeit Abbrechen

Wartungszeiten können auch abgebrochen werden. Dazu hat man zwei möglichkeiten. Um eine Wartungszeit für einen einzelnen
Host oder Service abzubrechen, klicken Sie in der Wartungszeiten Übersicht auf die Schaltfläche "Löschen" des jeweiligen
Objekts.

Möchte man mehrere Wartungszeiten abbrechen, so markiert man die entsprechenden Hosts oder Services und wählt am unteren
Ende der Übersicht die Schaltfläche "Ausgewählte löschen".

## Systemausfall

Systemausfälle sind Ausfälle des openITCOCKPIT-Servers selbst. Sie müssen manuell erstellt werden.

Zeitrahmen, die durch Systemausfälle definiert sind, werden bei der Berichtserstellung ignoriert.