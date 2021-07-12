## Container

Container sind eine Kernkomponente in openITCOCKPIT. Ob Benutzer, Karten oder Hosts, alles was in openITCOCKPIT angelegt werden kann oder Überwacht wird, befindet sich in Containern. Sie können zum Strukturieren genutzt werden und sind *die* Zentrale Berechtigungskomponente.

Der root Container ist der Standardcontainer der alle anschließenden Container enthält. Alles was in diesem angelegt wird, ist Global verfügbar. 

Die Container werden in der Container Übersicht in einer Baumstruktur dargestellt. Über diese Baumansicht ist es möglich, weitere Container vom Typ Mandant, Standort und Knoten hinzuzufügen und zu bearbeiten. 

### Containertypen

Folgende typen von Containern gibt es in openITCOCKPIT

-   root
-   Mandant
-   Standort
-   Knoten - Generischer Container
-   Kontaktgruppe
-   Hostgruppe
-   Servicegruppe
-   Servicevorlagengruppe

### Container Details

Um eine Übersicht der Untercontainer sowie deren Inhalt zu bekommen, klickt man in der Container Übersicht auf “Zeige Details” eines Mandanten, Knoten oder Standort.

Dort kann man zwischen zwei verschiedenen Ansichten auswählen. Die Container ansicht zeigt alle Untercontainer inklusive der Hosts des gewählten Containers an. 

Die Container Karte hingegen zeigt eine logische Karte der Struktur des gewählten Containers.


## Mandanten

Mandanten sind Spezifische Container in openITCOCKPIT die zur Strukturierung und Granularer Berechtigung dienen.

Sie unterscheiden sich von normalen Containern darin, dass Sie neben dem Namen zusätzliche Eigenschaften enthalten.

Diese sind 

-   Beschreibung
-   Vorname
-   Nachname
-   Straße
-   Postleitzahl
-   Stadt

Ein Mandant bildet die Grundlage für weitere Container vom Typ Standort oder einfache Knoten. 

### Details

Um eine Übersicht der untercontainer sowie deren Inhalt zu bekommen, klickt man in der Mandanten Übersicht auf “Zeige Details” eines Mandanten.

Dort kann man zwischen zwei verschiedenen Ansichten auswählen. Die Container ansicht zeigt alle Untercontainer inklusive der Hosts des gewählten Containers an. 

Die Container Karte hingegen zeigt eine logische Karte der Struktur des gewählten Containers.


## Standorte

Standorte sind Spezifische Container in openITCOCKPIT die zur Strukturierung und Granularer Berechtigung dienen.

Sie unterscheiden sich von normalen Containern darin, dass Sie neben dem Namen zusätzliche Eigenschaften enthalten.

Diese sind 

-   Beschreibung
-   Breitengrad
-   Längengrad
-   Zeitzone

Standorte können, wenn die Breiten und Längengrad informationen angegeben sind, auch über ein Modul automatisiert auf einer Karte angezeigt werden.