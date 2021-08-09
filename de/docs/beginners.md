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

### Pull Modus

Beide Modi sind einfach einzurichten. Für dieses Tutorial nutzen wir den **Pull Modus**. Klicken Sie hier für den [Push Modus](#push-modus)

![push or pull](/images/agent-push-or-pull.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurations Generator um die Konfigurationsdatei des openITCOCKPIT Monitoring Agent zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überachen möchten und klicken auf die Schaltfläche "Weiter".

!!! info "Verbindungstyp: Auto-TLS"
    Es wird nachdrücklich Empfohlen, Auto-TLS als Verbindungstyp auszuwählen. Dies sichert und verschlüsselt die Verbindung zischen dem openITCOCKPIT Server und dem openITCOCKPIT Monitoring Agent automatisch.
    Mehr Informationen über die Sicherheit des openITCOCKPIT Monitoring Agent finden Sie in der [Dokumentation](https://github.com/it-novum/openitcockpit-agent-go/wiki/Agent-Overview)


![pull config](/images/agent-basic-pull-configuration.png)

Im dritten Schritt wird Ihnen gezeigt wo Sie den openITCOCKPIT Monitoring Agent [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Für dieses Tutorial können Sie mit der Standardkonfiguration fortfahren. Zum nächsten Schritt klicken Sie auf die Schaltfläche "Weiter".

![agent install config](/images/agent-install-config.png)


Der openITCOCKPIT Server wird sich zu dem openITCOCKPIT Monitoring Agent auf dem Zielsystem verbinden und ein TLS Zertifikatsaustasch vollziehen. Für jeden openITCOCKPIT Monitoring Agent wird ein einzigartiges Zertifikat generiert. Dieses Zertifikat wird für Authentifizierungs und Verschlüsselungszwecke benötigt.

Klicken Sie auf "Weiter" um fortzufahren.

![cert exchange](/images/certificate-exchange.png)

Das System wird grundlegende health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die die gewünschten ausgewählt, klicken Sie auf "Fertig" um das openITCOCKPIT Monitoring Agent Setup abzuschließen.


![create services](/images/agent-create-services.png)

Der Letzte Schritt erinnert Sie daran die Monitoring Konfiguration zu aktualisieren. 
Bitte klicken auf [Aktualisieren der Überwachungskonfiguration](#aktualisieren-der-überwachungskonfiguration)

![services create successfully](/images/agent-services-created-successfully.png)


Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![agent services monitored](/images/agent-services-monitored.png)


### Bestimmen des Host status (optional)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden um den Host status zu bestimmen. Anstelle eines Pings ist es möglich die Ergebnisse des openITCOCKPIT Monitoring Agent zum bestimmen des Hoststatus zu verwenden. Für weitere Informationen können Sie die Dokumentation nutzen https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status 


### Push Modus

Wählen Sie den Push Modus um fortzufahren.

![agent push or pull use push](/images/agent-push-or-pull-use-push.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurations Generator um die Konfigurationsdatei des openITCOCKPIT Monitoring Agent zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überachen möchten und klicken auf die Schaltfläche "Weiter".


Setzen Sie die öffentliche IP Adresse oder FQDN Ihres openITCOCKPIT Servers im Feld `openITCOCKPIT Server Adresse` und tragen den API-Key, welchen der Agent nutzen soll in das Feld `openITCOCKPIT API Schlüssel` 

Klicken Sie auf die Schalfläche `Nächster` um fortzufahren

!!! danger "Sicherheitshinweis!"
    Es wird dringend empfohlen einen neuen Benutzer mit sehr wenigen Berechtigungen zu erstellen und einen API-Key für unprivilgierte Benutzer zu verwenden.
    Um Check Ergebnisse zu übertragen sind keine speziellen Berechtigungen über Benutzerrollen nötig.


![agent push config](/images/agent-basic-push-configuration.png)


Im dritten Schritt wird Ihnen gezeigt wo Sie den openITCOCKPIT Monitoring Agent [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Kopieren Sie die angezeigte Konfigurationsdatei an den angegebenen Pfad und starten Sie den openITCOCKPIT Monitoring Agent Dienst neu. Die Kommandos und Dateipfade hängen vom genutzen Betriebssystem ab. Klicken Sie auf `Nächster` um fortzufahren.

![agent config push](/images/agent-install-config-push.png)

Jeder Agent sendet eine eindeutige Kennung an den openITCOCKPIT Server. Um unauthorisierte Agenten daran zu hindern Check Ergebnisse zu übertragen, müssen alle im Push Modus arbeitenden Agenten manuell zu einem Host zugewiesen werden. Klicken Sie auf `Nächster` um fortzufahren.

![host to agent mapping](/images/map-host-to-agent.png)

Das System wird grundlegende health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die die gewünschten ausgewählt, klicken Sie auf "Fertig" um das openITCOCKPIT Monitoring Agent Setup abzuschließen.

!!! info
    Da der Agent im Push Modus Arbeitet, ist es möglich dass openITCOCKPIT bisher noch keine Daten empfangen hat und daher keine Services anzeigen kann. Sollte dies der Fall sein, so klicken Sie auf :fontawesome-solid-arrow-left: um auf den Vorhergehenden Schritt zuzückzukehren, warten 30 Sekunden und klicken anschließend wieder auf die Schaltfläche `Nächster`.

![create services push](/images/agent-create-services-push.png)

Der Letzte Schritt erinnert Sie daran die Monitoring Konfiguration zu aktualisieren. 
Bitte klicken auf [Aktualisieren der Überwachungskonfiguration](#aktualisieren-der-überwachungskonfiguration)

![services created push export](/images/agent-services-created-successfully-push.png)


Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![agent services monitored push](/images/agent-services-monitored-push.png)

### Bestimmen des Host status (optional, aber empfohlen)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden um den Host status zu bestimmen.
In den meissten fällen ist es nicht möglich einen Ping zum Zielsystem zu senden, wenn der Push Modus genutzt wird.

Bearbeiten Sie den Host und wählen die Hostvorlage `openITCOCKPIT Agent - Push` aus und speichern diesen ab. Vergessen Sie nicht anschließend die Monitoring Engine Konfiguration zu aktualisieren (Export). 

openITCOCKPIT wird nun den Timestamp der zuletzt empfangenen Nachricht des openITCOCKPIT Monitoring Agents auswerten um zu bestimmen ob der Host verfügbar ist oder nicht.

Für weitere Informationen können Sie die Dokumentation nutzen https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status 

![agent push host status](/images/agent-push-host-status.png)


## Monitoring mit Checkmk

Checkmk ist nahtlos in die openITCOCKPIT Oberfläche integriert. Hosts auf denen der Checkmk Agent oder ein SNMP Exporter läuft, können über die openITCOCKPIT Oberfläche gescannt werden. Zum Zweck dieses Tutorials werden wir ein Ubuntu Linux System überwachen.

### Checkmk Modul für openITCOCKPIT installieren

Die Checkmk Erweiterung für openITCOCKPIT wird als Modul ausgeliefert. Diese Modularisierung hat den Vorteil, den openITCOCKPIT Kern klein und flexibel zu halten. 


!!! info "openITCOCKPIT Community Lizenz wird benötigt"
    Um Zugriff auf die Community Module zu erhalten, wird eine Registrierung ihrer openITCOCKPIT Instanz mit der **kostenlosen** Community Lizenz vorrausgesetzt.


Navigieren sie nach `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *CheckmkModule*

![packagemanager install checkmk](/images/package-manager-install-checkmk.png)

Folgen Sie den Instruktionen

![packagemanager install instructions](/images/package-manger-install-instructions.png)

Die Installation ist fertiggestellt, sobald Sie die folgende Nachricht sehen: `Installation done. Please reload your openITCOCKPIT web interface.`

Navigieren Sie in Ihrem Webbrowser zurück und Drücken `Ctrl + R` oder `Cmd + R` um die Seite neu zu laden.

Das CheckmkModule sollte nun als installiert angezeigt werden.

![installed successful](/images/checkmk-integration-installed-successfully.png)

Jedes Modul kann die verfügbaren Berechtigungen von openITCOCKPIT erweitern. Im Standard werden alle Berechtigungen der `Administrator` Benutzerrolle gewährt.

Sollte Ihr aktueller Benutzer einer anderen Benutzerrolle zugeordnet sein, stellen Sie sicher, dass Sie dieser Rolle die entsprechenden Berechtigungen gewähren.

Navigieren Sie nach `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzerrollen` und wählen Sie Ihre Benutzerrolle.

![checkmk userrole permissions grant](/images/checkmk-user-roles-permissions.png)

Neue Berechtigungen werden nicht automatisch gewährt (ausgenommen Benutzer der `Administrator` Benutzerrolle). Dies hat den Hintergrund dass nicht jeder Benutzer Module nutzen kann, die beispielsweise nur zu Test oder Evaluierungszwecken installiert wurden. 

### Checkmk Agent auf dem Zielsystem installieren

Wie bereits angesprochen, nutzen wir den Checkmk Agent um das Remote System zu überwachen. 

Zuallererst müssen Sie den Checkmk Agenten von Ihrem openITCOCKPIT Server auf das Zielsystem kopieren:

`scp /opt/openitc/check_mk/share/check_mk/agents/check_mk_agent.linux root@172.16.166.103:/usr/local/bin/check_mk_agent`

!!! tip "Alle Checkmk Agenten für die verschiedenen Betriebssysteme finden Sie hier"
    `/opt/openitc/check_mk/share/check_mk/agents/`

**Verbinden Sie sich nun per SSH mit dem Remote Host**

Der Checkmk Agent wird nicht als daemon ausgeführt, sondern durch `xinetd` ausgeführt.

```
apt-get install xinetd
chmod +x /usr/local/bin/check_mk_agent
```

!!! danger "Sicherheitshinweis"
    Standardmäßig verwendet Checkmk eine unverschlüsselte klartext Kommunikation!

Als nächstes müssen Sie die folgende Konfiguration nach `/etc/xinetd.d/check_mk` kopieren:

```
service check_mk
{
    type           = UNLISTED
    port           = 6556
    socket_type    = stream
    protocol       = tcp
    wait           = no
    user           = root
    server         = /usr/local/bin/check_mk_agent

    # configure the IP address(es) of your openITCOCKPIT server here:
    #only_from      = 127.0.0.1 10.0.20.1 10.0.20.2

    # Don't be too verbose. Don't log every check. This might be
    # commented out for debugging. If this option is commented out
    # the default options will be used for this service.
    log_on_success =

    disable        = no
}
```

Um die neue Konfiguration zu aktivieren müssen Sie `xinetd` neu starten:

```
systemctl restart xinetd.service
```

Das ist alles was Sie auf dem Remote Host erledigen müssen. 

### Ziel Host scannen um Checks automatisch erstellen zu können

im Kontextmenü der Hosts wählen Sie die Option `Checkmk Erkennung`

![checkmk discovery](/images/checkmk-discovery.png)

Nutzen Sie die vorselektierte Option `Führe Remoteerkennung aus` und klicken Sie anschließend auf `Erkennung ausführen`.

![checkmk remote discovery](/images/checkmk-remote-discovery.png)

Sobald der Discovery Prozess abgeschlossen ist, können Sie alle Services die Sie überwachen möchten auswählen. Klicken Sie 'Speichern' um fortzufahren.

![select checkmk services](/images/select-check-mk-services.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![checkmk services openitcockpit](/images/checkmk-services-openitcockpit.png)


## Überwachung durch SNMP mit Checkmk

Viele Geräte wie zum Beispiel Router, Switche, Sensoren oder Betriebssysteme können via SNMP (Simple Network Management Protocol). Bevor Sie mit diesem Guide fortfahren, stellen Sie sicher dass Sie den Teil [Monitoring mit Checkmk](#monitoring-mit-checkmk) gelesen haben. 

### Versuchen Sie SNMP Daten des Zielgerätes zu bekommen

Bevor Sie starten, überprüfen Sie bitte ob Ihr Monitoring Server in der lage ist, SNMP Daten des Zielgerätes abzufragen. Dazu können Sie das Programm `snmpwalk` nutzen. 

In diesem Beispiel Fragen wie ein Ubuntu Linux, auf dem `snmpd` in der Version `2c` und der community `public` läuft ab.

```
snmpwalk -v2c -c public 172.16.166.103
```

Sie sollten eine Ähnliche ausgabe wie diese sehen:

![snmp walk example](/images/snmpwalk_example.png)

Sollte Ihr System nicht in der Lage sein sich mit dem Zielsystem zu verbinden, überprüfen Sie ihre Firewalleinstellungen oder ob Sie eine falsche SNMP Version nutzen.

### Überwachen eines Linux Hosts durch SNMP via Checkmk

Im Kontextmenü eines Host swählen Sie die Option `Checkmk Erkennung`

![checkmk discovery snmp](/images/checkmk-discovery-snmp.png)

Wählen Sie die `Führe SNMP-Erkennung aus` Option aus und klicken Sie anschließend auf `Erkennung ausführen`.

![checkmk snmp discovery](/images/checkmk-snmp-discovery.png)

Das System wir Sie nach den Benötigten SNMP Parametern befragen. Die SNMP Konfiguration wird pro Host gepeichert, Sie müssen diese daten also nicht nochmals eingeben. Klicken Sie auf `Speichern und SNMP Erkennung ausführen` um fortzufahren

![checkmk snmp config](/images/checkmk-snmp-config.png)

Sobald der Erkennungsprozess vollendet ist, können Sie alle gewünschten Services, welche Sie überwachen möchten, auswählen. Klicken Sie auf `Weiter` zum fortzufahren.

![checkmk snmp result](/images/checkmk-snmp-result.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![checkmk snmp servicess](/images/checkmk-snmp-services.png)

## Fehlende Servicevorlagen für Checkmk erstellen.

Abhängig von dem Gerät auf dem Sie ein Discovery durchführen möchten, ist es möglich, dass die `Optionen` auswahl box leer ist und der Informationstext `Bevor Sie die folgenden Dienste überwachen können, muss eine entsprechende Servicevorlage erstellt werden.` erscheint, gefolgt von einer Tabelle.

In diesem Fall müssen Sie die fehlenden Servicevorlagen erstellen.

![check mk snmp missing servicetemplates](/images/check-mk-snmp-missing-service-template.png)

### Fehlende Servicevorlagen erstellen

Öffnen Sie ein neues Browserfenster und navigieren Sie nach `Monitoring -> Vorlagen -> Servicevorlagen` und klicken Sie auf `+ Neu`.

#### Erstelle eine Service vorlage für `hp_procurve_cpu`

Es wird empfohlen den selben namen für eine Servicevorlage und nehmen wie es Checkmk nutzt (MK Check). In diesem Fall ist der MK Check `hp_procurve_cpu` also nutzen wir `CHECK_MK_HP_PROCURVE_CPU` als Servicevorlagen name. Setzten Sie `Checkmk templates` als Vorlagentyp. Deaktivieren Sie `Aktiviere aktive Prüfungen`, nutzen Sie `check_none` als Prüfungskommando und setzen Sie die `Parameter` aus der Tabelle als `ARG1` ein.

Bestätigen Sie mit `Erstelle Servicevorlage`

![create missing checkmk snmp servicetemplate](/images/create_missing_check_mk_snmp_service_template.png)

Servicevorlagen Parameter Übersicht:

| Parameter      | Wert                          |
| ----------- | ------------------------------------ |
| Template name | 	CHECK_MK_HP_PROCURVE_CPU  |
| Service name | CHECK_MK_HP_PROCURVE_CPU |
| Template type | Checkmk templates |
| Enable active checks | No |
| Check command | check_none |
| ARG1 | `(80.0, 90.0)` |
| Check period | 24x7 |
| Max. number of check attempts | 1 |
| Check interval | 60 |
| Retry interval | 60 |

Wiederholen Sie die Schritte für alle fehlenden Servicevorlagen.


#### Servicevorlagen mit MK Checks verlinken

Navigieren Sie nach `Check MK -> Mk Checks` und klicken Sie auf die Schaltfläche `+ Neu`. 

Setzen Sie `hp_procurve_cpu` als Check name und wählen Sie die entsprechenden Servicevorlage `CHECK_MK_HP_PROCURVE_CPU` aus.

![link servicetemplate to mk check](/images/link_check_mk_check_to_service_template.png)


Wiederholen Sie dies für alle Servicevorlagen.

![check_mk_mkchecks_to_servicetemplates](/images/check_mk_mkchecks_to_servicetemplates.jpg)

### Services erstellen

Nun sind Sie in der Lage die Services zu erstellen, die Sie überwachen möchten. Starten die das SNMP Discovery erneut und wählen Sie alle gewünschten Services aus der Liste aus.

![checkmk create new snmp services](/images/checkmk-create-new-snmp-services.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

![checkmk snmp hp switch](/images/checkmk-snmp-hp-switch.png)

### Überwachungsmethoden vermischen

Sie können neben SNMP gleichzeitig den Checkmk Agenten nutzen. Dazu müssen Sie den Host neu scannen und wählen anschließend `Führen Remoteerkennung aus` aus um zusätzlich den Checkmk Agenten abzufragen.

![checmk remote discovery](/images/checkmk-remote-discovery.png)