# Container

Container sind eine Kernkomponente von openITCOCKPIT und _die_ zentrale Berechtigungskomponente für Objekte. Benutzer,
Hosts, Karten, Kontakte, Servicevorlagen und alle weiteren Objekte in openITCOCKPIT müssen einem Container zugewiesen
werden.

Container entscheiden darüber, welche Objekte ein Benutzer sehen und bearbeiten darf.

Der `root` Container ist der Standardcontainer. Alle weiteren Container, die am System erstellt werden, sind
Untercontainer des Root-Containers.

Die Container werden in der Container Übersicht in einer Baumstruktur dargestellt. Über diese Baumansicht ist es
möglich, weitere Container vom Typ Mandant, Standort und Knoten hinzuzufügen und zu bearbeiten.

![Container Übersicht](/images/configuration/containers-overview-tree.png)

### Containertypen

Folgende typen von Containern gibt es in openITCOCKPIT

- root
- Mandant
- Standort
- Knoten - generischer Container
- Kontaktgruppe
- Hostgruppe
- Servicegruppe
- Servicevorlagengruppe

### Root-Container

Objekte die im Root-Container abgelegt werden, sind global für alle Benutzer am System sichtbar. Somit eignet sich der
Root-Container ideal für Objekte, welche von unterschiedlichen Organisationseinheiten oder Mandanten genutzt werden
sollen. Beispiele dafür sind der Zeitraum `24x7` oder die Servicevorlage `Ping`.

!!! danger "Wichtig"
    Objekte, welche dem Root-Container zugewiesen wurden, können später nicht mehr in einen anderen Container verschoben
    werden! Wir empfehlen die nutzung von Mandanten Container.

Benutzer, welche Schreibzugriff auf den Root-Container haben, sind globale Systemadministratoren. Sie können alle
Objekte einsehen und bearbeiten. Globale Systemadministratoren sind mit einer goldenen Krone gekennzeichnet.
![Root-Container Benutzer](/images/configuration/root-container-user.png){align=center}

### Berechtigungen über Container

Container entscheiden darüber, welche Object ein Benutzer sehen und bearbeiten kann. Einem Benutzer können mehrere Container zugewiesen werden.
Wenn der Benutzer nur lesenden Zugriff auf den Container bekommen soll, muss die `read` Option gesetzt werden.
Für schreibenden Zugriff `read/write`.

![Benutzer Container](/images/configuration/user-containers.png){align=center}

Container Berechtigungen können auch in `Container Rollen` zusammengefasst werden. So müssen die Berechtigungen nicht für alle Benutzer manuell erstellt und angepasst werden.

In diesem Beispiel gehen wir von folgender Container Struktur aus:
```
root
└── Demo Tenant (Mandant)
    ├── Team Data Center (Knoten)
    │   ├── Berlin (Standort)
    │   └── Fulda (Standort)
    └── Team Developers (Knoten)
        └── Fulda (Standort)
```

openITCOCKPIT zeigt die Container immer als einen Pfad an:
```
/root/Demo Tenant/Team Data Center/Berlin
/root/Demo Tenant/Team Data Center/Fulda
/root/Demo Tenant/Team Developers/Fulda
```

Die Container Berechtigungen werden dabei immer von rechts nach links aufgelöst.

- Ein Benutzer, der dem Container `/root` zugewiesen wird, wird automatisch ein globaler Systemadministrator und kann alle Objekte sehen und Bearbeiten.
- Wird ein Benutzer `/root/Demo Tenant` zugewiesen, so kann der Benutzer alle Objekte des Mandanten inklusive aller Untercontainer des Mandanten sehen. 
- Wird ein Benutzer `/root/Demo Tenant/Team Developers` zugewiesen, so kann der Benutzer Objekte des Mandanten, sowie des Containers "Team Developers" und aller Untercontainer sehen. 
- Wird ein Benutzer `/root/Demo Tenant/Team Developers/Fulda` zugewiesen, so kann der Benutzer Objekte des Mandanten, sowie des Containers "Fulda" und aller Untercontainer sehen.


## Mandanten

Mandanten sind spezifische Container in openITCOCKPIT die zur Strukturierung und granularer Berechtigung dienen.
Mandanten können nur als direkte Untercontainer des Root-Containers erstellt werden.

Objekte, die einem Mandanten zugewiesen werden, können von allen Benutzern des Mandanten genutzt werden. Somit sind sie
geeignet Kontakte, Kontaktgruppen, Servicevorlagen und Zeiträume, welche von der kompletten Organisation genutzt werden
sollen, zu speichern.

Ein Mandant bildet die Grundlage für weitere Container vom Typ Standort oder Knoten.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Name | :fontawesome-solid-times: | Name des zu erstellenden Mandanten |
| Beschreibung |  | Beschreibung des Mandanten |
| Vorname |  | Vorname des Mandanten |
| Nachname |  | Nachname des Mandanten |
| Straße |  | Straße des Mandanten |
| Postleitzahl |  | Postleitzahl des Mandanten |
| Stadt |  | Stadt des Mandanten |



## Standorte

Standorte sind spezifische Container in openITCOCKPIT die zur Strukturierung und granularer Berechtigung dienen.

Sofern das `OpenStreetMapModule` installiert ist, werden Hosts und Services anhand der Standorte automatisch auf einer
Landkarte zusammengefasst.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | Elterncontainer des zu erstellenden Standortes |
| Name | :fontawesome-solid-times: | Name des zu erstellenden Standortes |
| Beschreibung |  | Beschreibung des Standortes |
| Breitengrad |  | Breitengrad des Standortes. Die Zahl muss zwischen -90 und 90 Grad sein |
| Längengrad |  | Längengrad des Standortes. Die Zahl muss zwischen -180 und 180 Grad sein|
| Zeitzone |  | Zeitzone des Standortes |

## Knoten (Nodes)

Ein Container vom Type Knoten wird in der Regel zur Darstellung interner Strukturen und Abteilungen genutzt. Einem
Knoten können dieselben Objekttypen wie einem Standort zugewiesen werden. Ein Knoten setzt einen Mandanten voraus.

Knoten werden über die Baumansicht unter `Verwaltung -> Containerverwaltung -> Container` erstellt. Hier können zudem 
auch [Mandanten](#mandanten) und [Standorte](#standorte) erstellt werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Name | :fontawesome-solid-times: | Name des zu erstellenden Knotens |


## Containerverwaltung

Über den Menüpunkt Containerverwaltung kann eine Liste aller Container aufgerufen werden. Es stehen verschiedene
Darstellungsmöglichkeiten zur Verfügung.

Über den Punkt `Zeige Details` kann eine detaillierte Übersicht über den ausgewählten Container aufgerufen werden. Diese
zeigt eine Liste von allen Objekten, welche sich im ausgewählten Container befindet. Zur besseren Übersicht kann der
Container auch als ein Graph angezeigt werden.

![Root-Container Benutzer](/images/configuration/container-graph.png){align=center}

