# Mod-Gearman

Mod-Gearman ermöglicht es openITCOCKPIT, Überwachungsaufgaben auf mehrere Worker-Prozesse oder Server mithilfe des Gearman-Jobservers zu verteilen. Das bedeutet, dass anstelle aller Überwachungsprüfungen auf einem einzelnen openITCOCKPIT-Server ausgeführt zu werden, die Arbeitslast auf mehrere Server verteilt werden kann, was die Skalierbarkeit und Leistung verbessert.

!!! info
    Alle openITCOCKPIT-Versionen > 4.7.1 werden standardmäßig mit Mod-Gearman ausgeliefert.

Dieses Dokument gilt für traditionelle Installationen von openITCOCKPIT. Wenn Sie eine Docker-/Container-basierte Konfiguration verwenden, lesen Sie bitte diese [Dokumentation](../../installation/docker).

## Unterschied zwischen Mod-Gearman und verteiltem Monitoring

Das [Distributed Monitoring Module von openITCOCKPIT](../../configuration/distribute-module/) ermöglicht die Einrichtung eigenständiger Überwachungsserver, die als "Satellitensysteme" bezeichnet werden. openITCOCKPIT-Satellitensysteme bieten eine Weboberfläche und sind die beste Lösung zur Überwachung entfernter Standorte oder mehrerer Rechenzentren.

Satellitensysteme von openITCOCKPIT können in begrenztem Umfang auch zur Lastverteilung genutzt werden.

Mod-Gearman hingegen verteilt die Prüfausführung auf mehrere Worker und fungiert als Load-Balancer. Bei Bedarf können weitere Mod-Gearman-Worker gestartet werden, um eine größere Last zu bewältigen.

Sowohl openITCOCKPIT als auch openITCOCKPIT-Satellitensysteme sind mit Mod-Gearman ausgestattet.

![Mod-Gearman-Architektur](/images/mod_gearman/mod-gearman_architecture.png)

## Mod-Gearman-Worker

Die Ausführung von Überwachungs-Plugins kann viel CPU-Leistung verbrauchen. Plugins, die in Python oder Perl geschrieben sind, sind zwar einfach zu warten, benötigen aber viel mehr Ressourcen zur Ausführung als Plugins, die in Go oder C geschrieben sind.

Wenn Sie einige Ressourcen auf Ihrem openITCOCKPIT-Server freigeben möchten, können Sie einen neuen Server einrichten, der nur als Mod-Gearman-Worker fungiert. Das Worker-System wird eine Verbindung zum openITCOCKPIT-Server herstellen und die Ausführung von Host- und Serviceprüfungen übernehmen. Wenn mehrere Mod-Gearman-Worker verbunden sind, wird die Last auf alle Worker verteilt.

Benachrichtigungen und Ereignisskripte werden immer auf dem openITCOCKPIT-Server ausgeführt.

### Lokaler Worker
Standardmäßig verfügt openITCOCKPIT über einen lokalen Mod-Gearman-Worker. Dieser Dienst kann über Systemd gesteuert werden.
```
systemctl status mod-gearman-worker.service
```

Dieser Dienst wird durch das Paket `openitcockpit-mod-gearman-worker-go-local` bereitgestellt und kann entfernt werden. Durch Deinstallieren des Pakets `openitcockpit-mod-gearman-worker-go-local` oder durch Anhalten des `mod-gearman-worker.service` wird der openITCOCKPIT-Server keine Host- und Servicetprüfungen mehr ausführen. Bitte stellen Sie sicher, dass externe Mod-Gearman-Worker im Voraus eingerichtet sind!

### Umgehen von Mod-Gearman

Um Mod-Gearman für einen gesamten Host zu umgehen, können Sie das benutzerdefinierte Makro `WORKER` mit dem Wert `local` setzen.

![Mod-Gearman umgehen](/images/mod_gearman/bypass_mod_gearman.jpg)

Sie können das Makro auch für einen bestimmten Dienst definieren, um nur diesen Dienst auszuschließen.

## Eingebettetes Perl

Eingebettetes Perl (Embedded Perl) kann die Ausführung von Perl-Plugins erheblich beschleunigen und auch den benötigte CPU-Leistung verringern.
Ein gutes Beispiel ist das beliebte Plugin `check_nwc_health`. Glücklicherweise ist dieses Plugin von Anfang an mit eingebettetem Perl kompatibel.


### Ein- und Ausschließen von eingebettetem Perl pro Plugin

Nicht alle Überwachungs-Plugins sind mit eingebettetem Perl kompatibel. Wenn Sie Ihr Plugin aktualisieren möchten, um es kompatibel zu machen, können Sie [diesen Richtlinien](https://www.naemon.io/documentation/usersguide/epnplugins.html) folgen.

Um Mod-Gearman anzuweisen, den eingebetteten Perl-Interpreter für ein bestimmtes Plugin zu verwenden, fügen Sie diese Zeile in die **ersten 10 Zeilen** des Perl-Skripts ein:
```
# nagios: +epn
```

Um Mod-Gearman anzuweisen, den eingebetteten Perl-Interpreter **nicht** für ein bestimmtes Plugin zu verwenden, fügen Sie diese Zeile in die **ersten 10 Zeilen** des Perl-Skripts ein:
```
# nagios: -epn
```

Durch Setzen von `use_embedded_perl_implicitly=1` in der Datei `mod_gearman/worker.cfg` werden alle Perl-Plugins über eingebettetes Perl ausgeführt.

#### Einschränkungen

Kommandos, die eines dieser Sonderzeichen enthalten
```
!$^&*()~[]\|{};<>?`
```
werden nur über eingebettetes Perl ausgeführt, wenn die Zeichen in einfachen Anführungszeichen eingeschlossen sind.

Beispiel:

```
/check_files.pl --filename=*.txt     # Dies wird nicht über eingebettetes Perl ausgeführt
```

```
/check_files.pl --filename='*.txt'   # Einfache Anführungszeichen - wird eingebettetes Perl verwenden
```

## Deaktivieren von Mod-Gearman

openITCOCKPIT-Versionen 4.7.2 und höher haben Mod-Gearman standardmäßig aktiviert. Mod-Gearman kann deaktiviert werden, wenn Sie das alte Verhalten wiederherstellen möchten, bei dem alle Plugins direkt von der Überwachungs-Engine ausgeführt werden.

Um dies zu tun, navigieren Sie zu `System -> Konfigurationsdatei Editor` und bearbeiten Sie die Datei `/opt/openitc/nagios/etc/nagios.cfg`.

![Deaktivieren von Mod-Gearman](/images/mod_gearman/enable_mg.jpg)

Deaktivieren Sie die Option `enable_mod_gearman` und klicken Sie auf Speichern.


## Einrichten eines Mod-Gearman-Workers
Wie bereits erwähnt, ist das Hauptziel von Mod-Gearman, die Arbeitslast auf mehrere Server zu verteilen. openITCOCKPIT stellt vorgefertigte Pakete des Mod-Gearman-Workers für Debian, Ubuntu und RHEL bereit.

### Freigabe des Gearman-Job-Servers
Zunächst müssen Sie den `Gearman-Job-Server` für Ihr Netzwerk freigeben. Öffnen Sie die Datei `/etc/default/gearman-job-server` und ändern Sie den Parameter `--listen=localhost` auf `--listen=0.0.0.0`.
Um die Änderungen zu übernehmen, starten Sie den Dienst neu: `systemctl restart gearman-job-server.service`

Sie können `netstat` verwenden, um zu überprüfen, ob der Gearman-Job-Server jetzt auf allen IP-Adressen lauscht:
```
[Ubuntu]root@openitcockpit~# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
tcp        0      0 0.0.0.0:4730            0.0.0.0:*               LISTEN      112        657506310  677284/gearmand
```

Die Kommunikation von Mod-Gearman ist mit einem gemeinsamen geheimen Schlüssel verschlüsselt. Sie finden den zufälligen generierten Schlüssel auf Ihrem openITCOCKPIT-Server in der Datei `/opt/openitc/etc/mod_gearman/secret.file`.



### Installation des Mod-Gearman-Workers

Wir empfehlen, mit einer leeren VM der neuesten Ubuntu LTS-Version zu beginnen.

1. Repository laden.

    Stellen Sie sicher, dass Sie das [openITCOCKPIT-Repository](https://openitcockpit.io/download_server/) auf Ihrem System aktiviert haben.

2. Abhängigkeiten installieren
    ```
    apt-get install openitcockpit-mod-gearman-worker-go
    ```

    !!! warning
        Verwenden Sie NICHT das Paket `openitcockpit-mod-gearman-worker-go-local`!

    Alle Überprüfungs-Plugins befinden sich unter `/opt/openitc/nagios/libexec`. Sie können beliebige benutzerdefinierte Plugins zu diesem (oder einem anderen) Ort hinzufügen.

3. Verbindung des Workers mit dem openITCOCKPIT-Server herstellen

    Öffnen Sie die Datei `/etc/openitcockpit-mod-gearman/worker.cfg` und setzen Sie den Hostnamen oder die IP-Adresse Ihres openITCOCKPIT-Servers.
    ```cfg
    server=openitcockpit.example.org:4730

    # Stellen Sie auch sicher, dass die Verschlüsselungsparameter identisch sind
    # Der Schlüssel befindet sich in der Datei /opt/openitc/etc/mod_gearman/secret.file auf Ihrem openITCOCKPIT-Server
    encryption=yes
    key=870b2ba934d9992b30298cb98726825e
    ```

    Um die Einstellungen zu übernehmen, starten Sie den Dienst neu: `systemctl restart mod-gearman-worker.service`

    Der Mod-Gearman-Worker ist jetzt bereit und wird sich mit Ihrem openITCOCKPIT-Server verbinden.

    Das Protokoll des Mod-Gearman-Workers befindet sich unter `/opt/openitc/logs/mod_gearman/mod_gearman_worker.log`.


### Überprüfen
Führen Sie den Befehl `/opt/openitc/mod_gearman/bin/gearman_top` auf Ihrem openITCOCKPIT-Server aus, um zu überprüfen, ob sich der neue Mod-Gearman-Worker erfolgreich verbunden hat.

![Gearman_top](/images/mod_gearman/gearman_top.png)

## Verteilung der Prüfungen

Mod-Gearman verteilt die Ausführung der Prüfungen auf alle verfügbaren Worker.
Das bedeutet, dass Prüfungen eines Dienstes von einem Host von verschiedenen Mod-Gearman-Workern ausgeführt werden können.
Dieses Beispiel demonstriert das Verhalten mit einem Checkplugins, welches den Hostnamen des Mod-Gearman-Workers ausgibt, von dem es ausgeführt wurde.

![Zufällige Routen von Prüfungen](/images/mod_gearman/random_routing.png)

Wie Sie sehen können, ist es völlig zufällig, welcher Mod-Gearman-Worker welche Überprüfung ausführt, auch wenn die Services demselben Host zugewiesen sind.

Es gibt Situationen, in denen es wichtig ist zu kontrollieren, welche Prüfungen von welchem Mod-Gearman-Worker ausgeführt werden. Sie können dies tun, indem Sie das `WORKER`-benutzerdefinierte Makro für einen bestimmten Host, Service, Hostvorlage oder Servicevorlage definieren.

Durch Festlegen von `WORKER=local` werden die Prüfungen **immer** von der Überwachungs-Engine auf dem openITCOCKPIT-Server selbst ausgeführt und umgehen Mod-Gearman vollständig.


### Prüfungen auf einem bestimmten Worker ausführen

Das benutzerdefinierte Makro `WORKER` kann auch verwendet werden, um Prüfungen an einen bestimmten Worker oder eine Gruppe von Workern zu binden.
In diesem Beispiel werden alle Prüfungen des Hosts `Worker Test` (im obigen Screenshot gezeigt) an einen bestimmten Worker in `Fulda` (einer Stadt in Deutschland) gebunden.

#### Anpassung der worker.cfg

Zunächst müssen Sie eine Liste von _hostgroup-Schlüsselwörtern_ in der Datei `/etc/openitcockpit-mod-gearman/worker.cfg` definieren, um festzulegen, welche Prüfungen von diesem Worker ausgeführt werden sollen.

!!! info
    Diese Liste von _hostgroups_ hat nichts mit den Hostgruppen zu tun, die Sie in der openITCOCKPIT-Benutzeroberfläche definieren!

```
# Legt eine Liste von Hostgruppen fest, für die dieser Worker arbeiten soll.
# Geben Sie entweder eine durch Kommas getrennte Liste an oder verwenden Sie
# mehrere Zeilen.
hostgroups=Fulda
```

Sie können mehrere _hostgroup-Schlüsselwörter_ durch Verwendung einer durch Kommas getrennten Liste definieren
```
hostgroups=Fulda,Frankfurt,Berlin
```

Starten Sie den Worker neu, um die Änderungen zu übernehmen

```
systemctl restart mod-gearman-worker.service
```

#### Konfiguration des Hosts / Services bearbeiten

Nachdem Sie die _hostgroup-Schlüsselwörter_ in der Worker-Konfiguration hinterlegt haben, können Sie den Befehl
`/opt/openitc/mod_gearman/bin/gearman_top` auf Ihrem openITCOCKPIT-Server ausführen, um zu überprüfen, ob separate Warteschlangen für jedes Schlüsselwort aufgetaucht sind.

![Eigene Hostgruppen-Warteschlangen für Fulda Frankfurt und Berlin](/images/mod_gearman/mod_gearman_hostgroup_routing.jpg)

Um Prüfungen an einen Worker zu binden, müssen Sie das `WORKER`-benutzerdefinierte Makro für einen Host, einen Service, eine Hostvorlage oder eine Servicevorlage definieren.

Definieren Sie das Makro `WORKER` mit dem Wert `hostgroup_Fulda`

![Eigene Hostgruppen-Warteschlangen für Fulda Frankfurt und Berlin](/images/mod_gearman/mg_routing_oitc.jpg)

!!! note
    Es ist wichtig, dass der Wert des benutzerdefinierten Makros mit `hostgroup_` vorangestellt ist.

Um die Änderungen zu übernehmen, [aktualisieren Sie die Überwachungskonfiguration](../../beginners/create-first-host/#aktualisieren-der-uberwachungskonfiguration).

Alle Prüfungen mit `WORKER=hostgroup_Fulda` werden jetzt von dem definierten Worker behandelt

![Eigene Hostgruppen-Warteschlangen für Fulda Frankfurt und Berlin](/images/mod_gearman/mod_gearman_forced_worker.jpg)


#### Was sind die `worker_` Warteschlangen?
Diese Warteschlangen werden von Mod-Gearman für interne Statusnachrichten verwendet. Bitte ignorieren Sie diese.

## Troubleshooting

### Operation nicht erlaubt

Wenn Sie eine Fehlermeldung wie `check_icmp: Failed to obtain ICMP socket: Operation not permitted` erhalten, müssen Sie die folgenden Dateiberechtigungen setzen:

```
chown root:root /opt/openitc/nagios/libexec/check_icmp
chown root:root /opt/openitc/nagios/libexec/check_dhcp

chmod u+s /opt/openitc/nagios/libexec/check_icmp
chmod u+s /opt/openitc/nagios/libexec/check_dhcp
```

## Zu viele offene Dateien

Wenn Ihr Gearman-Job-Server nicht reagiert oder Fehlermeldungen wie `ERROR 2015-04-14 22:02:54.000000 [ main ] accept(Too many open files) -> libgearman-server/gearmand.cc:788` auftreten, haben Sie das Limit der offenen Dateien erreicht.
Dies passiert, wenn einige tausend Worker versuchen, sich mit einem Gearman-Job-Server zu verbinden.
Sie können dieses Problem beheben, indem Sie das Limit der offenen Dateien für den Gearman-Job-Server erhöhen.

Bearbeiten Sie den Systemd-Dienst `systemctl edit --full gearman-job-server.service` und fügen Sie die folgende Zeile in den Abschnitt `[Service]` ein:
```
LimitNOFILE=16384
```
![Modifizierter systemd-Dienst](/images/mod_gearman/mg_modified_service.jpg)

Um die Änderungen zu übernehmen, müssen Sie den Gearman-Job-Server neu starten
```
systemctl restart gearman-job-server.service naemon.service statusengine.service
```

Sie können jetzt einige tausend Worker mit Ihrem System verbinden
![Viele tausend Worker](/images/mod_gearman/mod_gearman_many_workers.jpg)


## Verwaiste Prüfungen
Wenn Sie eine Reihe von Fehlermeldungen wie diese erhalten:
```
(service check orphaned, is the mod-gearman worker on queue 'service' running?)
```
bedeutet dies, dass keine Worker Ihre Host- oder Service-Prüfungen ausführen. Stellen Sie sicher, dass die Mod-Gearman-Worker ausgeführt werden.

```
systemctl restart mod-gearman-worker.service
```

## Temporäre Dateien

Einige Monitoring-Plugins erstellen temporäre Dateien auf der Festplatte, um _Counter-Werte_ mit den Werten der letzten Ausführung zu vergleichen. Ein bekanntes Plugin ist das `check_new_health` Plugin, dieses erstellt, sofern nicht anders angegeben, temporäre Dateien unter `/var/tmp/check_nwc_health`.

Das `check_diskstats` Plugin verwendet den Ordner `/var/tmp/nagios`.

Sollten Sie Plugins verwenden, welche temporäre Dateien erstellen und benötigen um korrekte Werte liefern zu können, müssen Sie dafür sorgen, das alle Worker über die gleichen temporären Dateien verfügen. Dies können Sie in der Regel am einfachsten mit einem NFS-Share erreichen, welches auf allen Mod-Gearman Workern eingebunden wird.

