## Beginners Guide

Dieser Guide zeigt das Grundlegende Konzept hinter openITCOCKPIT auf und hilft bei der Überwachung Ihres ersten Hosts. 
Er richtet sich an neue Benutzer, die grade mit der Benutzung von openITCOCKPIT angefangen haben.


Sollten Sie Ihr openITCOCKPIT noch nicht Installiert haben, können Sie entweder unsere [Installationsanleitung](../installation/) in dieser Dokumentation nutzen oder aber den [Downloadbereich unserer Webseite](https://openitcockpit.io/download/#download) besuchen.

![openitcockpit-login](/images/openitcockpit-login.png)


## Registierung Ihres openITCOCKPITs

Damit Sie Zugriff auf alle frei verfügbaren Community Module haben, müssen Sie Ihr openITCOCKPIT Registrieren. Dazu navigieren Sie zu `Systemkonfiguration -> System -> Registrierung` und tragen den Community Lizenzschlüssel ein. 

!!! note "openITCOCKPIT 4.x Community Lizenz"
    ```
    e5aef99e-817b-0ff5-3f0e-140c1f342792
    ```

!!! note "openITCOCKPIT 3.x Community Lizenz"
    ```
    0dc0d951-e34e-43d0-a5a5-a690738e6a49
    ```

![enter license](/images/openITCOCKPIT-enter-license.png)

openITCOCKPIT wird den eingegebenen Lizenzschlüssel mit dem Repository Server abgleichen. Dementsprechend ist eine Internetverbindung für den Verifikationsprozess nötig. Ist die Verifizierung erfolgreich, haben Sie Zugriff auf alle frei verfügbaren Module.

Wenn Ihr openITCOCKPIT hinter einem Proxy Server läuft, müssen Sie zuvor den Proxy Server in openITCOCKPIT einrichten. Dazu navigieren sie nach `Systemkonfiguration -> System -> Proxy einstellungen`.

![Proxy settings](/images/openITCOCKPIT-Proxy-Settings.png)

## Container Berechtigungen

Zu aller erst müssen Sie sich mit unserem "Container" basiertem Berechtigungskonzept vertraut machen. Alle Objekte wie Benutzer, Hosts, Kontakte, Vorlagen etc. sind an Container gebunden.

!!! danger "Berechtigungen können ein sehr komplexes Thema werden"
    Es wird dringen geraten, dieses teil nicht zu überspringen!

### /root Container
Der "/root" Container ist etwas speziell. Alle Objekte die diesem Container zugeordnet sind, sind **global für alle Benutzer sichtbar!** Dieser Container ist für gewöhnliche Objekte wie zum Beispiel die "Ping" Servicevorlage oder der Zeitabschnitt "24x7" gedacht.

Wenn Sie dem "/root" Container einen Host zuweisen, ist es **später nicht mehr möglich die Container zuweisung zu verändern!**

Benutzer die dem "/root" Container zugewiesen wurden, werden automatisch **globale Administratoren** mit vollen Privilegien zu allen Objekten.

Globale Administratoren sind mit einer Krone über Ihrem Benutzernamen gekennzeichnet:
![global admin crown](/images/openITCOCKPIT-global-administrator.png)


### Container Baum
Container fungieren wie ein Baum. der "/root" Container ist immer die "Wurzel" aller nachfolgender Container. Die nächste Ebene im Baum könnte ein "Mandant" sein. Mandanten können Abteilungen Ihres Unternehmens oder sogar völlig Unterschiedliche Unternehmen sein. Innerhalb eines Mandanten können sie "Knoten" (Nodes) erstellen. Dies kann hilfreich sein um komplette Firmenstrukturen in Ihrem Monitoring System abzubilden. 

Diesm Beispiel folgend würde eine Container Baum Struktur so aussehen: `/root/Mandant/Knoten/`.

Um dies zu veranschaulichen, erstellen wir einen Mandanten mit dem Namen "Demo Tenant" unter `Verwaltung -> Containerverwaltung -> Mandanten`

![tenant container add](/images/openITCOCKPIT-First-Tenant.png)

Der Container Baum sieht nun so aus: `/root/Demo Tenant/`.

Im nächsten Schritt erstellen wir Knoten (Nodes) innerhalb des "Demo Tenant" unter `Verwaltung -> Containerverwaltung -> Container`

![nodes](/images/openITCOCKPIT_container_nodes.png)

In diesem Beispiel erstellen wir einen eigenen Knoten für das "Data center team" und die "Developers". So kann jedes Team seine eigenen Hosts innerhalb Ihrer eigenen Container erstellen.

Unser Container Baum sieht nun so aus:

```
/root/Demo Tenant/Team Data Center
/root/Demo Tenant/Team Developers
```

Benutzer können Sie zu verschiedenen Ebenen im Container Baum zuweisen.

- Wenn Sie einen Benutzer dem Container `/root/` zuweisen, so wird dieser Benutzer ein Globaler Administrator und hat ***Zugriff auf alle Objekte aller Mandanten**
- Wenn Sie einen Benutzer dem Container `/root/Demo Tenant` zuweisen, hat der Benutzer Zugriff auf alle Objekte innerhalb des Mandanten **sowie aller Untercontainer**
- Wenn Sie einen Benutzer den Container `/root/Demo Tenant/Team Developers` Zuweisen, hat der Benutzer Zugriff auf alle Objekte innerhalb des "Team Developers" Container **sowie all seinen Untercontainern**

Zudem ist es möglich, allen Benutzern Lese und Schreibrechte auf jeden Container zu geben. Dazu navigieren Sie zu `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzer` und erstellen einen neuen Benutzer. Sie können nun alle Container, auf die der Benutzer zugriff bekommen soll, auswählen und Lese sowie Schreibrechte für jeden einzelnen Container vergeben.

![User container permissions](/images/openITCOCKPIT-user-container-permissions.png)

Das Container basierte Berechtigungskonzept kann sehr komplex werden, aber bietet die größtmögliche Flexibilität und ermöglicht granulare Berechtigungsmöglchkeiten.

!!! note 
    Mit openITCOCKPIT v4 können Container Berechtigungen auch in "Benutzer Container Rollen" abgebildet werden.


## Den ersten Host erstellen

In der Welt von openITCOCKPIT v4 ist ein "Host" das grundlegendste Element. Im normalfall nutz openITCOCKPIT ein "ICMP check" zur Überprüfung Ihres Hosts. Jeder Host stellt verschiedenste Dienste zur verfügung wie zum Beispiel E-Mail, DHCP, DNS, web server, load balancer etc. Um ein Sinnvolles Monitoring aufzubauen benötigen Sie "Services" in openITCOCKPIT. Da openITCOCKPIT im Hintergrund Nagios oder Naemon nutzt, sind tausendene frei verfügbare Plugins zum überwachen ihrer kritischen Dienste und Infrastruktur verfügbar. 

### Host- und Servicevorlagen

In openITCOCKPIT haben Sie die möglichkeit Host und Servicevorlagen zu erstellen. Diese definieren Standardwerte, wie zum Beispiel Host oder Servicegruppen, Kontakte, Benachrichtigungsoptionen und so weiter, die als Vorlage genutzt werden, sobald Sie einen Host oder Service erstellen möchten.

openITCOCKPIT wird bereits mit einer vorgefertigten Auswahl an Vorlagen ausgeliefert.

### Den ersten Host erstellen - diesmal wirklich :)

In diesem Beispiel werden wir ein *Ubuntu Focal* Linux system mit den Diensten *NGINX*, *PHP-FPM* und *MySQL* überwachen.

Um Ihren ersten Host zu erstellen, navigieren Sie nach `Monitoring -> Hosts` und klicken dort auf die Schaltfläche "+ Neu"

openITCOCKPIT wird ein paar grundlegende Fragen über den neuen Host stellen wie zum Beispiel den Namen, IP Adresse oder FQDN, welche Kontakte im Fehlerfall benachrichtigt werden sollen und so weiter.

Um das ganze so einfach wie möglich zu halten, wählen wir als Container "/root" aus, sodass der neue Host für alle Benutzer auf dem System sichtbar ist. Als Hostvorlagen wählen wir "default host" aus. Durch die Hostvorlage müssen wir nur noch den Hostnamen und die IP Adresse eintragen.

![create host](/images/openITCOCKPIT-Create-Host.png)

Danach Scrollen Sie an das ende der Seite, klicken auf :fontawesome-solid-chevron-down: rechts von der Schaltfläche "Erstelle Host" und wählen `Speichern und Service erstellen` aus.

![create service](/images/create-host-and-service.png)

Mit dieser Abkürzung können wir direktden ersten Service auf unserem neuen Host erstellen.

!!! info "Haben Sie auf Erstelle Host geklickt?"
    Kein Problem. Navigieren Sie zu `Services` und klicken Sie "+ Neu"

Wählen Sie die "Ping" Servicevorlage und klicken Sie auf `Erstelle Service`

![crate service](/images/openITCOCKPIT-Create-Service.png)

Der neu erstellte Service wird nun in der Liste angezeigt, da er nur erstellt wurde aber noch nicht zur Monitoring Engine "Exportiert" wurde.

![service not monitored](/images/service-not-monitored.png)

### Aktualisieren der Überwachungskonfiguration

Immer wenn ein neues Objekt, welches für die Monitoring Engine relevant ist erstellt wird - dazu zählen Beispielsweise Hosts, Services, Kontakte, Kontaktgruppen etc. muss ein Aktualisieren der Überwachungskonfiguration erfolgen.

Sie finden diese Option in der oberen rechten Ecke `Aktualisieren Sie die Überwachungskonfiguration`

![export button](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

openITCOCKPIT wird im Hintergrund alle nötigen Konfigurationsdateien für Sie erstellen, validieren und die Monitoring Engine neu Laden. Klicken Sie auf die Schaltfläche ":fontawesome-solid-rocket: Starte Aktualisierung" um mit dem Export zu starten.

![export done](/images/openITCOCKPIT-Refresh-Monitoring-Config-Done.png)

Nach ein paar Sekunden wird Ihr neuer Host und Service überwacht.

![new host and services](/images/openITCOCKPIT-New-Host-And-Service-Monitoring.png)

Einen Ping Request an einen Host zu senden ist eine gute Idee, aber kein wirkliches Monitoring. Im nächsten Schritt fügen wir ein paar grundlegende Health checks hinzu.


## Monitoring mit dem openITCOCKPIT Agent

Überwachen von grundlegenden Parametern eines Hosts sollte keine schwierige oder lästige Aufgabe sein. Der [openITCOCKPIT Monitoring Agent](https://openitcockpit.io/download_agent/) ist für Windows, Linux und macOS verfügbar und in der Lage metriken wie CPU, Arbeitsspeicher, Festplattenauslastung, Netzwerkstatus, Temperaturen etc. Out-of-the-box zu sammeln.

Damit der openITCOCKPIT Monintoring Agent anpass- und erweiterbar ist, ist er zu 100% mit der Nagios Plugin API kompatibel. Daher ist keine zusätzliche software wie NRPE oder check_by_ssh nötig um Plugins auf dem Zielsystem auszuführen. 

Die Kommunikation ist standardmäßig verschlüsselt durch HTTPS.

### Herunterladen und installieren des openITCOCKPIT Monitoring Agent

Bevor Sie anfangen Installieren Sie den openITCOCKPIT Monitoring Agent auf dem gewünschten Zielsystem, dass Sie überwachen möchten.

Um den Agent herunterzuladen empfehlen wir Ihnen die [offizielle Download seite](https://openitcockpit.io/download_agent/)

Der Quellcode ist über das GitHub repository verfügbar: :fontawesome-brands-github: https://github.com/it-novum/openitcockpit-agent-go

### Überwachen eines Hosts mit dem openITCOCKPIT Monitoring Agent

Im Kontextmenü der Hosts wählen Sie die Option :fontawesome-solid-user-secret: openITCOCKPIT Agent Entdeckung

![select agent discovery](/images/select-agent-discovery.png)

Ein Wizard basierender Konfigurationsprozess wird Sie durch alle Schritte begleiten.

#### Hauptunterschiede zwischen Pull und Push Modus
Im ersten Schritt müssen Sie entscheiden, ob Sie Ihren Host im Push oder Pull Modus überwachen möchten.

- Im **Pull** Modus verbindet sich der openITCOCKPIT **Server** regelmäßig via HTTPS auf dem Port `3333` **zu dem Agenten** und holt die Überprüfungsergebnisse ab
- im **Push** Modus verbindet sich der openITCOCKPIT Monitoring **Agent** regelmäßig und "Schiebt" seine Überprüfungsergebnisse via HTTPS auf dem Port 443 **zu dem** openITCOCKPIT **Server**. Perfekt wenn Ihr Zielsystem hinter einer NAT ist.

Beide Modi sind einfach einzurichten. Für dieses Tutorial nutzen wir den **Pull Modus**. Klicken Sie hier für den [Push Modus](https://openitcockpit.io/beginners/12-monitoring-through-openitcockpit-agent-push-mode)

![push or pull](/images/agent-push-or-pull.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurations Generator um die Konfigurationsdatei des openITCOCKPIT Monitoring Agent zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überachen möchten und klicken auf die Schaltfläche "Weiter".

!!! info "Verbindungstyp: Auto-TLS"
    Es wird nachdrücklich Empfohlen, Auto-TLS als Verbindungstyp auszuwählen. Dies sichert und verschlüsselt die Verbindung zischen dem openITCOCKPIT Server und dem openITCOCKPIT Monitoring Agent automatisch.
    Mehr Informationen über die Sicherheit des openITCOCKPIT Monitoring Agent finden Sie in der [Dokumentation](https://github.com/it-novum/openitcockpit-agent-go/wiki/Agent-Overview)


![pull config](/images/agent-basic-pull-configuration.png)