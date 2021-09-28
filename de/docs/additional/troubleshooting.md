# Troubleshooting

## Ich habe einen Host erstellt, finde ihn aber nicht in der Host-liste

Ein neu erstellter Host wird nicht in der Host-liste angezeigt. Neu erstellte Hosts finden Sie in der Host-liste unter
dem Reiter `Nicht überwacht`. Dies bedeutet, dass der Host zwar in openITCOCKPIT existiert, der Monitoring Engine aber
nicht bekannt ist.

Sie müssen einen [Export der Konfiguration](../../monitoring/basic-principles/#wie-fuhre-ich-einen-export-aus)
durchführen, damit der Host überwacht wird.

## sudo_server

**Fehlermeldung**
  
Englisch:
```
Attention! Lost connection to SudoServer. External commands may not work. Please try to reload this page
```

Deutsch:
```
Achtung! Verbindung zum SudoServer verloren. Externe Befehle funktionieren möglicherweise nicht. Bitte versuche diese Seite neu zu laden.
```



**Problem**

`sudo_server.service` läuft nicht oder die Weboberfläche hat die Verbindung verloren.

**Lösung**

Laden Sie die Webseite neu.

Ist das Problem immer noch vorhanden, starten Sie den Dienst sudo_server neu.

```
systemctl restart sudo_server.service
```

Sollte das Problem weiterhin bestehen, können Sie sich [mit uns in Verbindung setzen](../support/#ich-brauche-hilfe).

## Debugging / Fehlerbeseitigungsseite

### Interface Informationen (Informationen zur Schnittstelle)

Über die Interface-Informationen bekommen Sie eine Übersicht Ihres openITCOCKPIT Servers. Hier werden Informationen zur
genutzten Version und Edition angezeigt. Darüber hinaus werden hier auch Informationen zur verwendeten Monitoring-Engine
sowie deren Pfade zur Konfiguration, den Backups und dem Command Interface bereitgestellt.

![interface info](/images/debugging-interfaceinfo.png)

### Prozessinformationen

Unter `Verwaltung -> Systemwerkzeuge -> Fehlerbeseitigung` finden Sie die Debugging (Fehlerbeseitigung) Übersicht. Über
die Prozessinformationen bekommen Sie eine Übersicht der Prozesse, die für den Betrieb von openITCOCKPIT notwendig sind.

![process info](/images/debugging-processinfo.png)

### SQL Query Log

Im SQL Query Log werden alle SQL Queries angezeigt, die in der SQL Datenbank vonstattengehen.

![querylog](/images/debugging-sqlquerylog.png)

!!! tip
    Damit das logging der SQL Queries gelingt, muss die Option `'log' => true` in der
    Datei `/opt/openitc/frontend/config/datasource.php` gesetzt werden!

### Server Informationen

Die Server Informationen halten verschiedene Basisdaten zu Ihrem openITCOCKPIT Server bereit. Darunter fallen
Informationen zum Betriebssystem, Webserver, Basis PHP Informationen und der CPU.

### CPU Load und RAM / Festplatten auslastung des openITCOCKPIT Servers

Die openITCOCKPIT Weboberfläche bietet eine Übersicht der aktuellen CPU, RAM, SWAP sowie Festplattenauslastung an. 
Diese ist auf der Debugging-Seite einsehbar.

### Queuing Engine
Eine Übersicht der Queuing Engine finden Sie auf der Debugging-Seite. Hier werden alle Queues des Gearman-Job-Servers sowie deren Status angezeigt.
![gearman-job-server overview](/images/debugging-queuingengine.png)

### E-Mail Konfiguration
Eine Übersicht der aktuellen E-Mail Konfiguration erhalten Sie auf der Debugging-Seite unter dem Punkt "E-Mail konfiguration". 

### PHP Konfiguration
Eine Übersicht der aktuellen gesamten PHP Konfiguration erhalten Sie am Ende der Debugging-Seite.

## System Health / Systemzustand
Die System Health Anzeige gibt aufschluss über den gesamtstatus des openITCOCKPIT Systems.
Siehe [System Health anzeige](../../monitoring/user-interface/#system-health) 

## Wo finde ich welche Logdateien?

### Naemon Log

Die Logdatei der Monitoring Engine Naemon finden Sie unter

```
/opt/openitc/nagios/var/nagios.log
```

Es wird empfohlen die Logdatei mit dem Befehl `oitc debug --tailf` zu betrachten, da hierbei die Unix-Timestamps und UUIDs
ersetzt werden, was die Lesbarkeit der Protokolldatei deutlich erhöht.

### openITCOCKPIT Web Frontend

```
/opt/openitc/logs/frontend/
```

### Gearman Job Server

```
/var/log/gearman-job-server/gearmand.log
```

### PHP-FPM

```
/var/log/php7.{0,1,2,3,4,...}-fpm.log
```

### NGINX

```
/opt/openitc/logs/nginx/
```

### MySQL

```
/var/log/mysql/error.log
```