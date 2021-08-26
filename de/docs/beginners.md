## Beginners Guide

Dieser Guide zeigt das grundlegende Konzept hinter openITCOCKPIT auf und hilft bei der Überwachung Ihres ersten Hosts. 
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
    Es wird dringen geraten, diesen Teil nicht zu überspringen!

### /root Container
Der "/root" Container ist etwas speziell. Alle Objekte die diesem Container zugeordnet sind, sind **global für alle Benutzer sichtbar!** Dieser Container ist für global häufig verwendete Objekte wie zum Beispiel die "Ping" Servicevorlage oder der Zeitabschnitt "24x7" gedacht.

Wenn Sie dem "/root" Container einen Host zuweisen, ist es **später nicht mehr möglich die Containerzuweisung zu verändern!**

Benutzer die dem "/root" Container zugewiesen wurden, werden automatisch **globale Administratoren** mit vollen Privilegien zu allen Objekten.

Globale Administratoren sind mit einer Krone über Ihrem Benutzernamen gekennzeichnet:
![global admin crown](/images/openITCOCKPIT-global-administrator.png)


### Container Baum
Container fungieren wie ein Baum. der "/root" Container ist immer die "Wurzel" aller nachfolgender Container. Die nächste Ebene im Baum könnte ein "Mandant" sein. Mandanten können Abteilungen Ihres Unternehmens oder sogar völlig unterschiedliche Unternehmen sein. Innerhalb eines Mandanten können sie "Knoten" (Nodes) erstellen. Dies kann hilfreich sein um komplette Firmenstrukturen in Ihrem Monitoring System abzubilden. 

Diesem Beispiel folgend würde eine Container Baum Struktur so aussehen: `/root/Mandant/Knoten/`.

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

- Wenn Sie einen Benutzer dem Container `/root/` zuweisen, so wird dieser Benutzer ein globaler Administrator und hat ***Zugriff auf alle Objekte aller Mandanten**
- Wenn Sie einen Benutzer dem Container `/root/Demo Tenant` zuweisen, hat der Benutzer Zugriff auf alle Objekte innerhalb des Mandanten **sowie aller Untercontainer**
- Wenn Sie einen Benutzer den Container `/root/Demo Tenant/Team Developers` Zuweisen, hat der Benutzer Zugriff auf alle Objekte innerhalb des "Team Developers" Container **sowie all seinen Untercontainern**

Zudem ist es möglich, allen Benutzern Lese- und Schreibrechte auf jeden Container zu geben. Dazu navigieren Sie zu `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzer` und erstellen einen neuen Benutzer. Sie können nun alle Container, auf die der Benutzer Zugriff bekommen soll, auswählen und Lese- sowie Schreibrechte für jeden einzelnen Container vergeben.

![User container permissions](/images/openITCOCKPIT-user-container-permissions.png)

Das containerbasierte Berechtigungskonzept kann sehr komplex werden, aber bietet die größtmögliche Flexibilität und ermöglicht granulare Berechtigungsmöglichkeiten.

!!! note 
    Mit openITCOCKPIT v4 können Container Berechtigungen auch in "Benutzer Container Rollen" abgebildet werden.


## Den ersten Host erstellen

In der Welt von openITCOCKPIT v4 ist ein "Host" das grundlegendste Element. Im Normalfall nutzt openITCOCKPIT ein "ICMP Check" zur Überprüfung Ihres Hosts. Jeder Host stellt verschiedenste Dienste zur Verfügung, wie zum Beispiel E-Mail, DHCP, DNS, web server, load balancer etc. Um ein sinnvolles Monitoring aufzubauen benötigen Sie "Services" in openITCOCKPIT. Da openITCOCKPIT im Hintergrund Nagios oder Naemon nutzt, sind tausendene frei verfügbare Plugins zum Überwachen Ihrer kritischen Dienste und Infrastruktur verfügbar. 

### Host- und Servicevorlagen

In openITCOCKPIT haben Sie die Möglichkeit Host- und Servicevorlagen zu erstellen. Diese definieren Standardwerte, wie zum Beispiel Host- oder Servicegruppen, Kontakte, Benachrichtigungsoptionen und so weiter, die als Vorlage genutzt werden, sobald Sie einen Host oder Service erstellen möchten.

openITCOCKPIT wird bereits mit einer vorgefertigten Auswahl an Vorlagen ausgeliefert.

### Den ersten Host erstellen - diesmal wirklich :)

In diesem Beispiel werden wir ein *Ubuntu Focal* Linux System mit den Diensten *NGINX*, *PHP-FPM* und *MySQL* überwachen.

Um Ihren ersten Host zu erstellen, navigieren Sie nach `Monitoring -> Hosts` und klicken dort auf die Schaltfläche "+ Neu"

openITCOCKPIT wird ein paar grundlegende Fragen über den neuen Host stellen, wie zum Beispiel den Namen, IP Adresse oder FQDN, welche Kontakte im Fehlerfall benachrichtigt werden sollen und so weiter.

Um das Ganze so einfach wie möglich zu halten, wählen wir als Container "/root" aus, sodass der neue Host für alle Benutzer auf dem System sichtbar ist. Als Hostvorlagen wählen wir "default host" aus. Durch die Hostvorlage müssen wir nur noch den Hostnamen und die IP Adresse eintragen.

![create host](/images/openITCOCKPIT-Create-Host.png)

Danach Scrollen Sie an das Ende der Seite, klicken auf: fontawesome-solid-chevron-down: rechts von der Schaltfläche "Erstelle Host" und wählen `Speichern und Service erstellen` aus.

![create service](/images/create-host-and-service.png)

Mit dieser Abkürzung können wir direkt den ersten Service auf unserem neuen Host erstellen.

!!! info "Haben Sie auf Erstelle Host geklickt?"
    Kein Problem. Navigieren Sie zu `Services` und klicken Sie "+ Neu"

Wählen Sie die "Ping" Servicevorlage und klicken Sie auf `Erstelle Service`

![crate service](/images/openITCOCKPIT-Create-Service.png)

Der neu erstellte Service wird nun in der "Nicht überwacht" Liste angezeigt, da er nur erstellt wurde, aber noch nicht zur Monitoring Engine "Exportiert" wurde.

![service not monitored](/images/service-not-monitored.png)

### Aktualisieren der Überwachungskonfiguration

Immer wenn ein neues Objekt, welches für die Monitoring Engine relevant ist, erstellt wird - dazu zählen beispielsweise Hosts, Services, Kontakte, Kontaktgruppen etc. muss ein Aktualisieren der Überwachungskonfiguration erfolgen.

Sie finden diese Option in der oberen rechten Ecke `Aktualisieren Sie die Überwachungskonfiguration`

![export button](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

openITCOCKPIT wird im Hintergrund alle nötigen Konfigurationsdateien für Sie erstellen, validieren und die Monitoring Engine neu laden. Klicken Sie auf die Schaltfläche ":fontawesome-solid-rocket: Starte Aktualisierung" um mit dem Export zu starten.

![export done](/images/openITCOCKPIT-Refresh-Monitoring-Config-Done.png)

Nach ein paar Sekunden wird Ihr neuer Host und Service überwacht.

![new host and services](/images/openITCOCKPIT-New-Host-And-Service-Monitoring.png)

Einen Ping Request an einen Host zu senden ist eine gute Idee, aber kein wirkliches Monitoring. Im nächsten Schritt fügen wir ein paar grundlegende Health checks hinzu.


## Monitoring mit dem openITCOCKPIT Agent

Überwachen von grundlegenden Parametern eines Hosts sollte keine schwierige oder lästige Aufgabe sein. Der [openITCOCKPIT Monitoring Agent](https://openitcockpit.io/download_agent/) ist für Windows, Linux und macOS verfügbar und in der Lage Metriken wie CPU, Arbeitsspeicher, Festplattenauslastung, Netzwerkstatus, Temperaturen etc. Out-of-the-box zu sammeln.

Damit der openITCOCKPIT Monintoring Agent anpass- und erweiterbar ist, ist er zu 100% mit der Nagios Plugin API kompatibel. Daher ist keine zusätzliche Software wie NRPE oder check_by_ssh nötig, um Plugins auf dem Zielsystem auszuführen. 

Die Kommunikation ist standardmäßig verschlüsselt durch HTTPS.

### Herunterladen und Installieren des openITCOCKPIT Monitoring Agent

Bevor Sie anfangen, installieren Sie den openITCOCKPIT Monitoring Agenten auf dem gewünschten Zielsystem, dass Sie überwachen möchten.

Um den Agent herunterzuladen empfehlen wir Ihnen die [offizielle Download Seite](https://openitcockpit.io/download_agent/)

Der Quellcode ist über das GitHub Repository verfügbar: :fontawesome-brands-github:  [https://github.com/it-novum/openitcockpit-agent-go](https://github.com/it-novum/openitcockpit-agent-go)

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

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurationsgenerator, um die Konfigurationsdatei des openITCOCKPIT Monitoring Agent zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überachen möchten und klicken auf die Schaltfläche "Weiter".

!!! info "Verbindungstyp: Auto-TLS"
    Es wird nachdrücklich empfohlen, Auto-TLS als Verbindungstyp auszuwählen. Dies sichert und verschlüsselt die Verbindung zwischen dem openITCOCKPIT Server und dem openITCOCKPIT Monitoring Agent automatisch.
    Mehr Informationen über die Sicherheit des openITCOCKPIT Monitoring Agent finden Sie in der [Dokumentation](https://github.com/it-novum/openitcockpit-agent-go/wiki/Agent-Overview)


![pull config](/images/agent-basic-pull-configuration.png)

Im dritten Schritt wird Ihnen gezeigt wo Sie den openITCOCKPIT Monitoring Agent [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Für dieses Tutorial können Sie mit der Standardkonfiguration fortfahren. Zum nächsten Schritt klicken Sie auf die Schaltfläche "Weiter".

![agent install config](/images/agent-install-config.png)


Der openITCOCKPIT Server wird sich zu dem openITCOCKPIT Monitoring Agent auf dem Zielsystem verbinden und ein TLS Zertifikatsaustasch vollziehen. Für jeden openITCOCKPIT Monitoring Agenten wird ein einzigartiges Zertifikat generiert. Dieses Zertifikat wird für Authentifizierungs- und Verschlüsselungszwecke benötigt.

Klicken Sie auf "Weiter" um fortzufahren.

![cert exchange](/images/certificate-exchange.png)

Das System wird grundlegende Health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die gewünschten Services ausgewählt, klicken Sie auf "Fertig" um das openITCOCKPIT Monitoring Agent Setup abzuschließen.


![create services](/images/agent-create-services.png)

Der letzte Schritt erinnert Sie daran die Monitoring Konfiguration zu aktualisieren. 
Bitte klicken auf [Aktualisieren der Überwachungskonfiguration](#aktualisieren-der-überwachungskonfiguration)

![services create successfully](/images/agent-services-created-successfully.png)


Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![agent services monitored](/images/agent-services-monitored.png)


### Bestimmen des Hoststatus (optional)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden, um den Hoststatus zu bestimmen. Anstelle eines Pings ist es möglich die Ergebnisse des openITCOCKPIT Monitoring Agenten zum Bestimmen des Hoststatus zu verwenden. Für weitere Informationen können Sie die Dokumentation nutzen [https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status) 


### Push Modus

Wählen Sie den Push Modus um fortzufahren.

![agent push or pull use push](/images/agent-push-or-pull-use-push.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurationsgenerator, um die Konfigurationsdatei des openITCOCKPIT Monitoring Agenten zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überwachen möchten und klicken auf die Schaltfläche "Weiter".


Setzen Sie die öffentliche IP Adresse oder FQDN Ihres openITCOCKPIT Servers im Feld `openITCOCKPIT Server Adresse` und tragen den API-Key, welchen der Agent nutzen soll in das Feld `openITCOCKPIT API Schlüssel` 

Klicken Sie auf die Schalfläche `Nächster` um fortzufahren

!!! danger "Sicherheitshinweis!"
    Es wird dringend empfohlen einen neuen Benutzer mit sehr wenigen Berechtigungen zu erstellen und einen API-Key für unprivilgierte Benutzer zu verwenden.
    Um Check Ergebnisse zu übertragen sind keine speziellen Berechtigungen über Benutzerrollen nötig.


![agent push config](/images/agent-basic-push-configuration.png)


Im dritten Schritt wird Ihnen gezeigt, wo Sie den openITCOCKPIT Monitoring Agenten [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Kopieren Sie die angezeigte Konfigurationsdatei an den angegebenen Pfad und starten Sie den openITCOCKPIT Monitoring Agent Dienst neu. Die Kommandos und Dateipfade hängen vom genutzen Betriebssystem ab. Klicken Sie auf `Nächster` um fortzufahren.

![agent config push](/images/agent-install-config-push.png)

Jeder Agent sendet eine eindeutige Kennung an den openITCOCKPIT Server. Um unauthorisierte Agenten daran zu hindern Check Ergebnisse zu übertragen, müssen alle im Push Modus arbeitenden Agenten manuell zu einem Host zugewiesen werden. Klicken Sie auf `Nächster` um fortzufahren.

![host to agent mapping](/images/map-host-to-agent.png)

Das System wird grundlegende Health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die gewünschten Services ausgewählt, klicken Sie auf "Fertig" um das openITCOCKPIT Monitoring Agent Setup abzuschließen.

!!! Info den meisten Fällen
    Da der Agent im Push Modus Arbeitet, ist es möglich dass openITCOCKPIT bisher noch keine Daten empfangen hat und daher keine Services anzeigen kann. Sollte dies der Fall sein, so klicken Sie auf :fontawesome-solid-arrow-left: um auf den vorhergehenden Schritt zurückzukehren, warten 30 Sekunden und klicken anschließend wieder auf die Schaltfläche `Nächster`.

![create services push](/images/agent-create-services-push.png)

Der letzte Schritt erinnert Sie daran die Monitoring Konfiguration zu aktualisieren. 
Bitte klicken auf [Aktualisieren der Überwachungskonfiguration](#aktualisieren-der-überwachungskonfiguration)

![services created push export](/images/agent-services-created-successfully-push.png)


Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![agent services monitored push](/images/agent-services-monitored-push.png)

### Bestimmen des Hoststatus (optional, aber empfohlen)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden um den Hoststatus zu bestimmen.
In den meisten Fällen ist es nicht möglich einen Ping zum Zielsystem zu senden, wenn der Push Modus genutzt wird.

Bearbeiten Sie den Host und wählen die Hostvorlage `openITCOCKPIT Agent - Push` aus und speichern diesen ab. Vergessen Sie nicht anschließend die Monitoring Engine Konfiguration zu aktualisieren (Export). 

openITCOCKPIT wird nun den Timestamp der zuletzt empfangenen Nachricht des openITCOCKPIT Monitoring Agents auswerten, um zu bestimmen, ob der Host verfügbar ist oder nicht.

Für weitere Informationen können Sie die Dokumentation nutzen [https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/it-novum/openitcockpit-agent-go/wiki/Determining-the-host-status) 

![agent push host status](/images/agent-push-host-status.png)


## Monitoring mit Checkmk

Checkmk ist nahtlos in die openITCOCKPIT Oberfläche integriert. Hosts auf denen der Checkmk Agent oder ein SNMP Exporter läuft, können über die openITCOCKPIT Oberfläche gescannt werden. Zum Zweck dieses Tutorials werden wir ein Ubuntu Linux System überwachen.

### Checkmk Modul für openITCOCKPIT installieren

Die Checkmk Erweiterung für openITCOCKPIT wird als Modul ausgeliefert. Diese Modularisierung hat den Vorteil, den openITCOCKPIT Kern klein und flexibel zu halten. 


!!! info "openITCOCKPIT Community Lizenz wird benötigt"
    Um Zugriff auf die Community Module zu erhalten, wird eine Registrierung Ihrer openITCOCKPIT Instanz mit der **kostenlosen** Community Lizenz vorrausgesetzt.


Navigieren sie nach `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *CheckmkModule*

![packagemanager install checkmk](/images/package-manager-install-checkmk.png)

Folgen Sie den Instruktionen

![packagemanager install instructions](/images/package-manger-install-instructions.png)

Die Installation ist fertiggestellt, sobald Sie die folgende Nachricht sehen: `Installation done. Please reload your openITCOCKPIT web interface.`

Navigieren Sie in Ihrem Webbrowser zurück und Drücken `Strg + R` oder `Cmd + R` um die Seite neu zu laden.

Das CheckmkModule sollte nun als installiert angezeigt werden.

![installed successful](/images/checkmk-integration-installed-successfully.png)

Jedes Modul kann die verfügbaren Berechtigungen von openITCOCKPIT erweitern. Im Standard werden alle Berechtigungen der `Administrator` Benutzerrolle gewährt.

Sollte Ihr aktueller Benutzer einer anderen Benutzerrolle zugeordnet sein, stellen Sie sicher, dass Sie dieser Rolle die entsprechenden Berechtigungen gewähren.

Navigieren Sie nach `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzerrollen` und wählen Sie Ihre Benutzerrolle.

![checkmk userrole permissions grant](/images/checkmk-user-roles-permissions.png)

Neue Berechtigungen werden nicht automatisch gewährt (ausgenommen Benutzer der `Administrator` Benutzerrolle). Dies hat den Hintergrund, dass nicht jeder Benutzer Module nutzen kann, die beispielsweise nur zu Test- oder Evaluierungszwecken installiert wurden. 

### Checkmk Agent auf dem Zielsystem installieren

Wie bereits angesprochen, nutzen wir den Checkmk Agenten um das Remote System zu überwachen. 

Zuallererst müssen Sie den Checkmk Agenten von Ihrem openITCOCKPIT Server auf das Zielsystem kopieren:

`scp /opt/openitc/check_mk/share/check_mk/agents/check_mk_agent.linux root@172.16.166.103:/usr/local/bin/check_mk_agent`

!!! tip "Alle Checkmk Agenten für die verschiedenen Betriebssysteme finden Sie hier"
    `/opt/openitc/check_mk/share/check_mk/agents/`

**Verbinden Sie sich nun per SSH mit dem Remote Host**

Der Checkmk Agent wird nicht als daemon, sondern durch `xinetd` ausgeführt.

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

### Zielhost scannen, um Checks automatisch erstellen zu können

im Kontextmenü der Hosts wählen Sie die Option `Checkmk Erkennung`

![checkmk discovery](/images/checkmk-discovery.png)

Nutzen Sie die vorselektierte Option `Führe Remoteerkennung aus` und klicken Sie anschließend auf `Erkennung ausführen`.

![checkmk remote discovery](/images/checkmk-remote-discovery.png)

Sobald der Discovery Prozess abgeschlossen ist, können Sie alle Services, die Sie überwachen möchten, auswählen. Klicken Sie `Speichern` um fortzufahren.

![select checkmk services](/images/select-check-mk-services.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![checkmk services openitcockpit](/images/checkmk-services-openitcockpit.png)


## Überwachung durch SNMP mit Checkmk

Viele Geräte wie zum Beispiel Router, Switche, Sensoren oder Betriebssysteme können via SNMP (Simple Network Management Protocol) überwacht werden. Bevor Sie mit diesem Guide fortfahren, stellen Sie sicher dass Sie den Teil [Monitoring mit Checkmk](#monitoring-mit-checkmk) gelesen haben. 

### Versuchen Sie SNMP Daten des Zielgerätes zu bekommen

Bevor Sie starten, überprüfen Sie bitte, ob Ihr Monitoring Server in der Lage ist, SNMP Daten des Zielgerätes abzufragen. Dazu können Sie das Programm `snmpwalk` nutzen. 

In diesem Beispiel fragen wie ein Ubuntu Linux, auf dem `snmpd` in der Version `2c` und der community `public` läuft ab.

```
snmpwalk -v2c -c public 172.16.166.103
```

Sie sollten eine ähnliche Ausgabe wie diese sehen:

![snmp walk example](/images/snmpwalk_example.png)

Sollte Ihr System nicht in der Lage sein sich mit dem Zielsystem zu verbinden, überprüfen Sie ihre Firewalleinstellungen oder, ob Sie eine falsche SNMP Version nutzen.

### Überwachen eines Linux Hosts durch SNMP via Checkmk

Im Kontextmenü eines Host wählen Sie die Option `Checkmk Erkennung`

![checkmk discovery snmp](/images/checkmk-discovery-snmp.png)

Wählen Sie die `Führe SNMP-Erkennung aus` Option aus und klicken Sie anschließend auf `Erkennung ausführen`.

![checkmk snmp discovery](/images/checkmk-snmp-discovery.png)

Das System wird Sie nach den benötigten SNMP Parametern befragen. Die SNMP Konfiguration wird pro Host gepeichert, Sie müssen diese Daten also nicht nochmals eingeben. Klicken Sie auf `Speichern und SNMP Erkennung ausführen` um fortzufahren

![checkmk snmp config](/images/checkmk-snmp-config.png)

Sobald der Erkennungsprozess vollendet ist, können Sie alle gewünschten Services, welche Sie überwachen möchten, auswählen. Klicken Sie auf `Weiter` um fortzufahren.

![checkmk snmp result](/images/checkmk-snmp-result.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Ein Paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann immer es möglich ist.

![checkmk snmp servicess](/images/checkmk-snmp-services.png)

## Fehlende Servicevorlagen für Checkmk erstellen.

Abhängig von dem Gerät auf dem Sie ein Discovery durchführen möchten, ist es möglich, dass die `Optionen` Auswahlbox leer ist und der Informationstext `Bevor Sie die folgenden Dienste überwachen können, muss eine entsprechende Servicevorlage erstellt werden.` erscheint, gefolgt von einer Tabelle.

In diesem Fall müssen Sie die fehlenden Servicevorlagen erstellen.

![check mk snmp missing servicetemplates](/images/check-mk-snmp-missing-service-template.png)

### Fehlende Servicevorlagen erstellen

Öffnen Sie ein neues Browserfenster und navigieren Sie nach `Monitoring -> Vorlagen -> Servicevorlagen` und klicken Sie auf `+ Neu`.

#### Erstelle eine Servicevorlage für `hp_procurve_cpu`

Es wird empfohlen den selben Namen für eine Servicevorlage und nehmen wie es Checkmk nutzt (MK Check). In diesem Fall ist der MK Check `hp_procurve_cpu` also nutzen wir `CHECK_MK_HP_PROCURVE_CPU` als Servicevorlagen name. Setzten Sie `Checkmk templates` als Vorlagentyp. Deaktivieren Sie `Aktiviere aktive Prüfungen`, nutzen Sie `check_none` als Prüfungskommando und setzen Sie die `Parameter` aus der Tabelle als `ARG1` ein.

Bestätigen Sie mit `Erstelle Servicevorlage`

![create missing checkmk snmp servicetemplate](/images/create_missing_check_mk_snmp_service_template.png)

Servicevorlagen Parameter Übersicht:

| Parameter      | Wert                          |
| ----------- | ------------------------------------ |
| Template name | 	CHECK_MK_HP_PROCURVE_CPU  |
| Service name | CPU load on HP Procurve |
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

Nun sind Sie in der Lage die Services zu erstellen, die Sie überwachen möchten. Starten Sie das SNMP Discovery erneut und wählen Sie alle gewünschten Services aus der Liste aus.

![checkmk create new snmp services](/images/checkmk-create-new-snmp-services.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

![checkmk snmp hp switch](/images/checkmk-snmp-hp-switch.png)

### Überwachungsmethoden vermischen

Sie können neben SNMP gleichzeitig den Checkmk Agenten nutzen. Dazu müssen Sie den Host neu scannen und wählen anschließend `Führen Remoteerkennung aus` aus um zusätzlich den Checkmk Agenten abzufragen.

![checmk remote discovery](/images/checkmk-remote-discovery.png)


## Monitoring durch NRPE

NRPE bietet eine Möglichkeit, Monitoring Plugins auf einem Remote System auszuführen. Dies setzt einen laufenden NRPE-Server und installierte Monitoring Plugins auf dem Remote System voraus.

Es wird empfohlen den [openITCOCKPIT Monitoring Agent](#monitoring-mit-dem-openitcockpit-agent) zum Ausführen von Plugins auf dem Remote Host zu verwenden, da dieses Setup weit weniger komplex ist. Sie haben die Möglichkeit zu entscheiden, welche Methode Sie präferieren.

### NRPE Plugin für openITCOCKPIT installieren

Stellen Sie eine SSH Verbindung mit ihrem openITCOCKPIT Server her und installieren Sie das folgende Paket: 
```
apt-get install --no-install-recommends nagios-nrpe-plugin
```

Es wird empfohlen das `check_nrpe` Plugin in den Standard Plugin Ordner von openITCOCKPIT zu verlinken

```
ln -s /usr/lib/nagios/plugins/check_nrpe /opt/openitc/nagios/libexec/check_nrpe
```

Um das neue Plugin nutzen zu können, müssen Sie ein neues Kommando unter `Objekte -> Kommandos` erstellen. Dazu Klicken dort auf die Schaltfläche `+ Neu`.

| Kommando definition      |                         |
| ----------- | ------------------------------------ |
| Command type | 	Service check command  |
| Command name | `check_nrpe_simple` |
| Command line | `/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c "$ARG1$"` |
| Command argument ($ARG1) | `Command name` |


![openitcockpit nrpe command](/images/openITCOCKPIT-nrpe_command.png)

Um das `check_nrpe` Plugin zu nutzen, müssen Sie zudem eine neue Servicevorlage erstellen. Dazu navigieren Sie nach `Monitoring -> Vorlagen -> Servicevorlagen` und klicken auf die Schaltfläche `+ Neu`. 

Setzen Sie den Container auf `/root` damit die Servicevorlage für alle Nutzer des Systems sichtbar wird. Als Name vergeben wir `CHECK_BY_NRPE_SIMPLE`

| Servicevorlagen definition      |                         |
| ----------- | ------------------------------------ |
| Template name | `CHECK_BY_NRPE_SIMPLE` |
| Template Type | `Generic templates` |
| Service name | `NRPE Simple` |
| Check period | `24x7` |
| Enable active checks | Yes |
| Check command | `check_nrpe_simple` |
| Command name (ARG1) | blank |
| Notification period | `24x7` |

![nrpe servicetemplate](/images/nrpe-service-template.png)

### NRPE-Server auf dem Zielsystem installieren

Um NRPE nutzen zu können, wird `nagios-nrpe-server` auf dem remote Host vorrausgesetzt. Stellen Sie eine SSH Verbindung mit dem remote Host her und installieren Sie das folgende Paket: 

```
apt-get install nagios-plugins nagios-nrpe-server
```

Öffnen Sie die Datei `/etc/nagios/nrpe.cfg` mit einem beliebigen Editor

Suchen Sie nach `allowed_hosts` und fügen Sie die IP Adresse Ihres openITCOCKPIT Servers hinzu.

```
allowed_hosts=127.0.0.1,::1,172.16.166.154
```

Die Standardkonfiguration kommt mit vordefinierten Basischecks. Wir nutzen diese Beispielchecks nun.

In der Standardkonfiguration wird der Check die Festplatte `/dev/hda1` überprüfen, welche es auf den meisten Systemen nicht mehr gibt. In unserem fall ersetzen wir dies durch `/dev/vda1`.

```
command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_vda1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/vda1
command[check_zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200
```

Immer wenn die Konfiguration geändert wurde, muss ein Neustart des `nagios-nrpe-server.service` erfolgen, damit die Änderungen wirksam werden.

```
systemctl restart nagios-nrpe-server.service
```

### Services erstellen

Navigieren Sie nach `Monitoring -> Services` und klicken Sie auf die Schaltfläche `+ Neu`.

Als erstes müssen Sie einen Host auswählen, auf dem Sie den Service erstellen möchten und wählen anschließend die `CHECK_BY_NRPE_SIMPLE` Servicevorlage aus. Das System wird nun alle vordefinierten Werte der Servicevorlage laden.

Ändern Sie den Servicenamen zu `CPU Load`, setzten Sie `check_load` als Kommandoname ($ARG1$) und klicken Sie anschließend auf `Erstelle Service`.

![create nrpe service](/images/create-nrpe-service.png)

Wiederholen Sie diesen Schritt für alle NRPE Kommandos. Die Kommandonamen sind in der `nrpe.cfg` auf dem Zielhost definiert. In diesem Fall haben wir die folgenden Standardkommandos: 
`check_users`, `check_load`, `check_vda1`, `check_zombie_procs` und `check_total_procs`.

Sind alle Services erstellt, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Die neuen Services werden nun vom System überwacht.

![services monitored by nrpe](/images/services-monitored-by-nrpe.png)

## Check by SSH

SSH bietet eine einfache und sichere Möglichkeit, Monitoring Plugins auf einem remote Host auszuführen.

### SSH-Key auf dem openITCOCKPIT Server erstellen

Wenn Sie bisher noch keinen SSH-Key für den Benutzer `nagios` haben, müssen Sie zuerst einen erstellen.

```
su nagios
mkdir /var/lib/nagios/.ssh
ssh-keygen
```

Danach sollten Sie den SSH Host Key im Zielsystem Importieren: `ssh <ziel-host>` und mit `yes` bestätigen.

### SSH-Key auf dem Zielsystem Importieren

Für dieses Beispiel benötigen Sie die Pakete `nagios-plugins` oder `monitoring-plugins` auf dem Zielhost.

```
apt-get install nagios-plugins
```

Im nächsten Schritt erstellen wir einen neuen Benutzer `monitoring`, der für die Ausführung von Checks via SSH genutzt wird. 

```
addgroup --system monitoring
adduser --system --shell /bin/bash monitoring
adduser monitoring monitoring

mkdir -p /home/monitoring/.ssh/
chown monitoring:monitoring /home/monitoring -R

touch /home/monitoring/.ssh/authorized_keys
chmod 644 /home/monitoring/.ssh/authorized_keys
```

Jetzt kopieren Sie Ihren **Public key** in die Datei `/home/monitoring/.ssh/authorized_keys`.


### Checks erstellen

Navigieren Sie nach `Monitoring -> Objekte -> Kommandos` und stellen Sie sicher, dass das `check_by_ssh` Kommando existiert. Dies ist ein Standardkommando von openITCOCKPIT. Falls das Kommando nicht verfügbar ist, klicken Sie auf die Schaltfläche `+ Neu` um es zu erstellen.

| Kommando definition      |                         |
| ----------- | ------------------------------------ |
| Command type | 	Service check command  |
| Command name | `check_by_ssh` |
| Command line | `$USER1$/check_by_ssh -H $HOSTADDRESS$ -l "$ARG1$" -C "$ARG2$"` |
| Command arguemnt ($ARG1) | `Username` |
| Command arguemnt ($ARG2) | `Command` |


![check by ssh command](/images/check_by_ssh_command.png)

Das `check_by_ssh` Plugin kann für die Ausführung von jeglichen Typen von Kommandos auf dem remote Host genutzt werden. Zum Ausführen von Check Plugins ist es nötig, dass der absolute Pfad zum Plugin gesetzt wird. Durch das Erstellen eines Makros mit dem Plugin Pfad, kann man sich hier viel Arbeit sparen.

Navigieren Sie nach `Monitoring -> Objekte -> Benutzerdefinierte Makros` und klicken Sie auf die Schaltfläche `+ Neu`.

| Makro definition      |                         |
| ----------- | ------------------------------------ |
| Makro name | `$USER2$` (or any other) |
| Value | `/usr/lib/nagios/plugins` |
| Description (optional) | `Path of monitoring-plugins on remote host used by check_by_ssh` |

![user defined macro](/images/user-defined-macro.png)

Navigieren Sie nach `Monitoring -> Services` und klicken Sie auf die Schaltfläche `+ Neu`.

Wählen Sie ihren Host und die vordefinierte Servicevorlage `CHECK_BY_SSH`.

| Servicevorlagen definition      |                         |
| ----------- | ------------------------------------ |
| Service name | `CHECK_BY_SSH` |
| Service name | `CPU load` |
| Check period | `24x7` |
| Check command | `check_by_ssh` |
| Username ($ARG1) | `monitoring` |
| Command ($ARG1) | `$USER2$/check_load -w 15,10,5 -c 30,25,20` |

Um fortzufahren klicken Sie auf `Erstelle Service`.

`$USER2$` wird automatisch ersetzt mit dem Wert, der im vorhergehenden Makro gespeichert wurde.

![cpu load by ssh](/images/cpu-load-by-ssh.png)

Wiederholen Sie diesen Schritt für alle Services die Sie benötigen.

Damit die neuen Änderungen wirksam werden, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

Die neuen Services werden nun vom System Überwacht.

![services monitored via SSH](/images/services-monitored-via-ssh.png)

## Browser Push Benachrichtigungen einrichten

Die meisten modernen Webbrowser wie Mozilla Firefox, Google Chrome oder Microsoft Edge bieten eine Benachrichtigung-API an. 

openITCOCKPIT kann diese API nutzen, um Host- oder Servicebenachrichtigungen zu Ihrem Browser zu senden.

Beispiele:

![browser notifications](/images/example_browser_notifications.png)

### Voraussetzungen
- Moderner Webbrowser
- manuelles Setzen der Berechtigungen im Browser
- openITCOCKPIT muss in einem Browser Tab geöffnet sein (Browserfenster kann im Hintergrund oder der Taskbar laufen)
- ein Kontakt muss einem Benutzer zugewiesen sein
- `Push-Benachrichtigungen an den Browser` muss in der Kontaktkonfiguration aktiviert sein
- `push_notification.service` Service muss auf dem openITCOCKPIT Server laufen 

### Push-Benachrichtigungen einrichten

#### Browser Berechtigungen
Bevor openITCOCKPIT Push-Benachrichtungen an Ihren Webbrowser senden kann, müssen Sie manuell die Berechtigung dafür erteilen. Dies ist ein Sicherheitsfeature aller Browser, um zu verhindern, dass wahllos irgendwelche Webseiten Spamnachrichten senden können. Sie können diese Benachrichtigungen erlauben oder verwehren, wann immer Sie wollen.

In diesem Beispiel zeigen wir den Prozess anhand des Mozilla Firefox.

##### Berechtigung erteilen

Klicken Sie auf das Benachrichtigungssymbol in der Browser Adressleiste und klicken Sie anschließend auf "Benachrichtigungen erlauben"

![browser ask for permissions](/images/browser_ask_for_notification_permissions.png)

!!! info
    Wenn Sie die Berechtigung zu einem späteren Zeitpunkt wieder entfernen, deaktivieren Sie auch `Push-Benachrichtigungen an den Browser` in der Kontakt Konfiguration

### Editieren oder Neuerstellen eines Kontaktes

Um Push-Benachrichtigungen erhalten zu können, müssen Sie Ihr Benutzerkonto mit einem Kontakt der Monitoring Engine verknüpfen. Standardmäßig ist kein Kontakt zu einem Benutzerkonto, dass in der openITCOCKPIt Oberfläche existiert, verlinkt.

Navigieren Sie nach `Monitoring -> Objekte -> Kontakte` und wählen Sie den Kontakt, für den Sie die Push-Benachrichtigungen aktivieren wollen, aus.

Weisen Sie ihren Benutzer dem Kontakt zu und aktivieren die Option `Push-Benachrichtigungen an den Browser`.

!!! info
    Das Kommando `host-notify-by-browser-notification` und/oder `service-notify-by-browser-notification` wird automatisch ausgewählt.
    Sollten die Kommandos fehlen, lesen Sie den [Troubleshooting](#troubleshooting) Teil dieses Artikels

Sie können auch verschiedene Benachrichtigungskommandos kombinieren, wie zum Beispiel `notify by email` und `browser notifications etc.

![contact browser push notfications](/images/contact-browser-push-notifications.png)

Nachdem Sie den Kontakt aktualisiert haben, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

### Benachrichtigunsbeispiele

Jede Benachrichtigung beinhaltet ein Icon für einen Host oder Service. Der jeweilige Status wird von der Farbe des Icons dargestellt. Klickt man auf eine Benachrichtigung, so öffnet sich ein neuer Browser-Tab und man wird direkt zu dem betreffenden Host oder Service weitergeleitet. Die Benachtichtigung verschwindet automatisch nach ein paar Sekunden.

![browser notifications](/images/example_browser_notifications.png)

*Hinweis: Das Benachrichtigungsdesign ist abhängig vom Betriebssystem des Benutzers. Benachrichtigungen sehen möglicherweise auf anderen Betriebssystemen anders aus. Es gibt keine möglichkeit den Stil zu verändern*

### Troubleshooting

- Laden Sie die Seite neu: `Strg + R` oder `Cmd + R`

- Verbindungsprobleme. Wenn Ihr Browser die Verbindung zum openITCOCKPIT Server verliert, kann es möglich sein, dass Sie keine Push-Benachrichtigungen mehr erhalten. Laden Sie die Seite neu um das Problem zu beheben.

- `push_notification` Dienst läuft nicht. Dieser Hintergrundprozess muss laufen. Zudem kann auch die Web Server oder Reverse Proxy Konfiguration Probleme verursachen. Sie können die Entwicklerwerkzeuge Ihres Web Browsers nutzen um eventuelle Verbindungsfehler zu entdecken: Fehlermeldung: `push_notification` not running

![push connection error](/images/push_connection_error.png)

Erfolgreich verbunden:

![push connection successful](/images/push_connection_successfully.png)

Läuft der `push_notification` Dienst nicht, wird auf der Fehlerbeseitigungs Seite und in der Systemzustandsanzeige eine Warnung erscheinen.

![debug push notificcations](/images/debug-processes-push-notifications.jpg)

- Manche Anwendungen unterdrücken Browser Benachrichtigungen. Beispielsweise unter Microsoft Windows 7 in Kombination mit dem `Snipping Tool`. Ein Neuladen der openITCOCKPIT Webseite behebt das Problem

- macOS läuft möglicherweise im *Nicht Stören* Modus. Dies kann auch automatisch geschehen beispielsweise beim Verbinden eines Beamers oder TV Bildschirm.

![macos dnd](/images/macOS_dnd.png)

- Zu viele Benachrichtigungen können auch ein Unterdrücken der Benachrichtigungen auslösen. Versuchen Sie die Anzahl der Push-Benachrichtigungen zu reduzieren.

- Überprüfen Sie Ihren Web Browser auf Updates.

- Funktionieren die Benachrichtigungen im Internet Explorer? Nein.


## Email Benachrichtigungen einrichten

Eine Standard Benachrichtigungsmethode, die Sie definitiv auf Ihrem System einrichten sollten, ist `notify-by-email`. Die meissten Unternehmen besitzen bereits eigene Mail Server. Um die Dinge einfach zu halten, wird dieses Tutorial Ihnen zeigen, wie Sie einen vorhandenen Mail Server als Relay Host nutzen können.

### Postfix Mail Server installieren

Wir empfehlen Postfix als Ebene zwischen Ihrem vorhandenen Mail Server und dem Monitoring System.

```
apt-get install postfix
```

Nun setzen wir die IP Adresse des vorhandenen Mail Servers in der Datei `/etc/postfix/main.cf`.

```
relayhost = 192.168.1.1
```

Um die Konfiguration zu aktivieren, starten Sie Postfix neu

```
systemctl restart postfix
```

### Email Konfiguration für openITCOCKPIT setzen

Die Mail Konfiguration für openITCOCKPIT wird in der Datei `/opt/openitc/frontend/config/email.php` gesetzt.

Die Konfiguration für den lokalen Postfix ist sehr einfach. Sie müssen nur `127.0.0.1` als `host`, Port auf `25` sowie `username` und `password` auf `null` setzen.

Sie können auch die folgende Konfiguration nutzen:

```php
<?php
return [
    /**
     * Do not change this
     *
     */
    'Email' => [
        'default' => [
            'transport' => 'default',
            'from'      => 'you@localhost',
            //'charset' => 'utf-8',
            //'headerCharset' => 'utf-8',
        ],
    ],

    /**
     * Email configuration.
     *
     * Make your email settings down below
     *
     */

    'EmailTransport' => [
        'default' => [
            'className' => \Cake\Mailer\Transport\MailTransport::class,
            /*
             * The following keys are used in SMTP transports:
             */
            'host'      => "127.0.0.1",
            'port'      => 25,
            'timeout'   => 30,
            'username'  => null,
            'password'  => null,
            'client'    => null,
            'tls'       => null,
            'url'       => env('EMAIL_TRANSPORT_DEFAULT_URL', null),
        ],
    ]
];
```

#### Absenderadresse ändern

Möchten Sie die Absenderadresse der E-Mails ändern, navigieren Sie nach `Systemkonfiguration -> System -> Systemeinstellungen`.

![change sender address](/images/openITCOCKPIT-change-sender-address.png)

#### Neuen Kontakt erstellen

Um das neue Mail System zu überprüfen, erstellen wir nun einen neuen Kontakt mit Ihrer E-Mail Adresse.

![create new contact](/images/openITCOCKPIT-create-new-contact.png)

Nun weisen wir den Kontakt einem Host oder Service zu.

![assign contact to service](/images/openITCOCKPIT-assign-contact-to-service.png)

Um die neue Konfiguration zu aktivieren, müssen Sie eine [Aktualisierung der Monitoring Konfiguration durchführen](#aktualisieren-der-uberwachungskonfiguration)

### E-Mail Benachrichtigung Testen

Wählen Sie den Host oder Service, dem Sie den Kontakt zugewiesen haben aus. In diesem Beispiel haben wir den Kontakt dem Service `Ping` zugewiesen. Klicken Sie nun auf die Schaltfläche `Benutzerdefinierte Servicebenachrichtigung senden`. Belassen Sie die voreingestellten Einstellungen so wie Sie sind und klicken auf die Schalfläche `Speichern`

![submit custom notifications](/images/openITCOCKPIT-submit-custom-service-notification.png)

Überprüfen Sie nun Ihr Postfach auf neue E-Mails

![Service notification](/images/openITCOCKPIT-service-notification.png)

### E-Mail nicht angekommen ? 

Führen Sie den Befehl `oitc debug --tailf` aus um mehr Informationen aus den Logs zu bekommen

```
[31.01.2018 - 12:22:51] SERVICE NOTIFICATION: Demo Contact[376a2dcf-ba7c-40be-b5ef-1b46c59a85cf];My first Linux host[c963e9f2-a1cb-43f6-8ad6-0babe02294c9];Ping[80ff370a-deff-4b8b-a37c-677a22d2e7a6];CUSTOM (OK);service-notify-by-cake[a517bbb6-f299-4b57-9865-a4e0b70597e4];PING OK - Packet loss = 0%, RTA = 0.28 ms;John Doe;test notification
```
