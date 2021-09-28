# Den ersten Host erstellen

In der Welt von openITCOCKPIT ist ein "Host" das grundlegendste Element. Im Normalfall nutzt openITCOCKPIT ein "ICMP
Check" zur Überprüfung Ihres Hosts. Jeder Host stellt verschiedenste Dienste zur Verfügung, wie zum Beispiel E-Mail,
DHCP, DNS, web server, load balancer etc. Um ein sinnvolles Monitoring aufzubauen, benötigen Sie "Services" in
openITCOCKPIT. Da openITCOCKPIT im Hintergrund Nagios oder Naemon nutzt, sind tausende frei verfügbare Plugins zum
Überwachen Ihrer kritischen Dienste und Infrastruktur verfügbar.

## Host- und Servicevorlagen

In openITCOCKPIT haben Sie die Möglichkeit Host- und Servicevorlagen zu erstellen. Diese definieren Standardwerte, wie
zum Beispiel Host- oder Servicegruppen, Kontakte, Benachrichtigungsoptionen und so weiter, die als Vorlage genutzt
werden, sobald Sie einen Host oder Service erstellen möchten.

openITCOCKPIT wird bereits mit einer vorgefertigten Auswahl an Vorlagen ausgeliefert.

## Den ersten Host erstellen - diesmal wirklich :)

In diesem Beispiel werden wir ein *Ubuntu Focal* Linux System mit den Diensten *NGINX*, *PHP-FPM* und *MySQL*
überwachen.

Um Ihren ersten Host zu erstellen, navigieren Sie nach `Monitoring -> Hosts` und klicken dort auf die Schaltfläche "+
Neu".

openITCOCKPIT wird ein paar grundlegende Fragen über den neuen Host stellen, wie zum Beispiel den Namen, IP-Adresse oder
FQDN, welche Kontakte im Fehlerfall benachrichtigt werden sollen und so weiter.

Um das Ganze so einfach wie möglich zu halten, wählen wir als Container "/root" aus, sodass der neue Host für alle
Benutzer auf dem System sichtbar ist. Als Hostvorlagen wählen wir "default host" aus. Durch die Hostvorlage müssen wir
nur noch den Hostnamen und die IP-Adresse eintragen.

![create host](/images/openITCOCKPIT-Create-Host.png)

Danach Scrollen Sie an das Ende der Seite, klicken auf :fontawesome-solid-chevron-down: rechts von der Schaltfläche 
"Erstelle Host" und wählen `Speichern und Service erstellen` aus.

![create service](/images/create-host-and-service.png)

Mit dieser Abkürzung können wir direkt den ersten Service auf unserem neuen Host erstellen.

!!! info "Haben Sie auf Erstelle Host geklickt?"
    Kein Problem. Navigieren Sie zu `Services` und klicken Sie "+ Neu".

Wählen Sie die "Ping" Servicevorlage und klicken Sie auf `Erstelle Service`

![crate service](/images/openITCOCKPIT-Create-Service.png)

Der neu erstellte Service wird nun in der "Nicht überwacht" Liste angezeigt, da er nur erstellt wurde, aber noch nicht
zur Monitoring-Engine "Exportiert" wurde.

![service not monitored](/images/service-not-monitored.png)

## Aktualisieren der Überwachungskonfiguration

Immer wenn ein neues Objekt, welches für die Monitoring Engine relevant ist, erstellt wird - dazu zählen beispielsweise
Hosts, Services, Kontakte, Kontaktgruppen etc. muss ein Aktualisieren der Überwachungskonfiguration erfolgen.

Sie finden diese Option in der oberen rechten Ecke `Aktualisieren Sie die Überwachungskonfiguration`

![export button](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

openITCOCKPIT wird im Hintergrund alle nötigen Konfigurationsdateien für Sie erstellen, validieren und die Monitoring
Engine neu laden. Klicken Sie auf die Schaltfläche ":fontawesome-solid-rocket: Starte Aktualisierung" um mit dem Export
zu starten.

![export done](/images/openITCOCKPIT-Refresh-Monitoring-Config-Done.png)

Nach ein paar Sekunden wird Ihr neuer Host und Service überwacht.

![new host and services](/images/openITCOCKPIT-New-Host-And-Service-Monitoring.png)

Einen Ping Request an einen Host zu senden ist eine gute Idee, aber kein wirkliches Monitoring. Im nächsten Schritt
fügen wir ein paar grundlegende Health checks hinzu.
