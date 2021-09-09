# Installation

Die Installation von openITCOCKPIT erfolgt über den Paketmanger der Linux-Distribution.

## Unterstützte Betriebssysteme

- Ubuntu
    - Focal (20.04)
    - Bionic (18.04)
- Debian
    - Buster (10)

## arm64 / Raspberry Pi
openITCOCKPIT und alle Komponenten stehen auch für arm64 Prozessoren und den Raspberry Pi zur Verfügung.

Die Installation unterscheidet sich dabei nicht von einem 64-Bit System mit AMD oder Intel Prozessor. Wenn Sie ein Raspberry Pi benutzen wollen, muss die [64-Bit Version von Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_arm64/images/) genutzt werden.

## Repository einbinden
### Ubuntu

```
add-apt-repository universe
apt-get install apt-transport-https curl gnupg2 ca-certificates
curl https://packages.openitcockpit.io/repokey.txt | apt-key add -

echo "deb https://packages.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

### Debian

```
deb http://deb.debian.org/debian/ buster main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
```

```
apt-get install apt-transport-https curl gnupg2 ca-certificates
curl https://packages.openitcockpit.io/repokey.txt | apt-key add -

echo "deb https://packages.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

## Installation von openITCOCKPIT
Die eigentliche Installation wird durch folgenden Befehl ausgeführt:
```
apt-get install openitcockpit
```

Im Anschluss muss noch die Grundkonfiguration durchgeführt werden. In diesem Schritt wird zum Beispiel der erste Benutzer für die Weboberfläche erstellt. Im Anschluss erfolgt die restliche Konfiguration über das openITCOCKPIT Webinterface.

```
/opt/openitc/frontend/SETUP.sh
```

## Registrierung der openITCOCKPIT Community Edition

Dieser Schritt ist freiwillig und optional. Der Funktionsumfang von openITCOCKPIT kann durch Module erweitert werden. Einige stehen kostenlos zur Verfügung. Um Zugriff auf die Communitymodule zu erhalten, muss zuerst der openITCOCKPIT Community Schlüssel eingegeben werden. Rufen Sie dazu `System -> Registration` auf und fügen Sie folgenden Schlüssel ein: `e5aef99e-817b-0ff5-3f0e-140c1f342792`. 

Es werden keine weiteren Angaben benötigt.

![Valid license](/images/openITCOCKPIT-v4-valid-license.png){ align=center }

Nach erfolgreicher Aktivierung stehen Ihnen die Community Module unter `System Tools -> Package Manager` zur Verfügung.

## Installation von phpMyAdmin

Dieser Schritt ist freiwillig und optional. openITCOCKPIT nutzt eine MySQL Datenbank. Normalerweise hat der Endanwender keine Berührungspunkte mit der Datenbank. Erfahrene Benutzer können zur Verwaltung der Datenbank das Tool `phpMyAdmin` installieren.

```
apt-get install phpmyadmin
```

Die Konfiguration des Webservers wird automatisch durchgeführt. Die phpMyAdmin Oberflächje ist im Anschluss über `https://xxx.xxx.xxx.xxx/phpmyadmin` erreichbar.

## Systemanforderungen

- Ubuntu Linux 64 bit (20.04 LTS "Focal" und 18.04 LTS "Bionic"), Debian Linux 64 bit (10 "Buster")
- 2 CPU Kerne (x86-64 oder arm64)
- 2 GB RAM
- 20 GB freier Festplattenspeicher


## Upgrade openITCOCKPIT v3.x zu openITCOCKPIT v4.x

![oitc upgrade v3 - v4](/images/oitc_autobahn.png)

Diese Anleitung beschreibt die Aktualisierung von ihrer aktuellen openITCOCKPIT 3.7.3 (oder neuer) zu openITCOCKPIT 4.

!!! info "Bevor Sie mit dem Upgrade Starten, erstellen Sie bitte ein Backup ihres Systems!"
    Es wird empfohlen das Backup und den Aktualisierungsprozess in einer Testumgebung zu testen.

### Voraussetzungen

  - Stellen Sie sicher, dass ihre openITCOCKPIT Installation auf dem neusten Stand ist.
  - openITCOCKPIT >= 3.7.3
  - Alle Betriebssystemupdates sind installiert.
  - Ein funktionierendes Backup ihrer openITCOCKPIT installation (für den fall, dass etwas schiefläuft).
  - mindestens **20 GB** freier Festplatten speicherplatz.
  - Distributed Monitoring: es wird vorausgesetzt, dass **alle** Satellitensysteme auch auf openITCOCKPIT v4 aktualisiert werden.
  - Führen Sie alle Kommandos als `root` Benutzer aus

### Unterstützte Betriebssysteme 

| Ubuntu Focal (20.04) | Ubuntu Bionic (18.04) | Ubuntu Xenial (16.04) | Ubuntu Trusty (14.04) | Debian Buster (10) | Debian Stretch (9) | Debian Jessie (8) |
|---|---|---|---|---|---|---|
|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-exclamation-triangle:|:fontawesome-solid-times:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-exclamation-triangle:|:fontawesome-solid-times:|


:fontawesome-solid-exclamation-triangle: **Ubuntu Xenial (16.04)**

openITCOCKPIT unterstützt kein Ubuntu Xenial. Bei einer aktualisierung auf openITCOCKPIT 4 wird ein Distributionsupgrade auf Ubuntu Bionic (18.04) durchgeführt.


:fontawesome-solid-exclamation-triangle: **Debian Stretch (9)**

openITCOCKPIT unterstützt kein Debian Stretch. Bei einer aktualisierung auf openITCOCKPIT 4 wird ein Distributionsupgrade auf Debian Buster (10) durchgeführt.

### System vorbereiten

Wenn Sie Ubuntu Xenial verwenden, müssen Sie das `lxd` Paket entfernen, da dies möglicherweise fehler beim Upgrade auf Ubuntu Bionic und openITCOCKPIT v4 verursachen könnte.
```bash
#only run on Ubuntu Xenial!
apt-get remove lxd
```

### Schritt 1 - Betriebssystem aktualisieren

```bash
apt-get update
apt-get dist-upgrade
```

### Schritt 2 - Datenbank Backup erstellen

!!! warning
    Stellen Sie sicher, dass genügend freier Festplattenspeicher bereitsteht.

```bash
mysqldump --defaults-extra-file=/etc/mysql/debian.cnf --databases openitcockpit --flush-privileges --single-transaction --triggers --routines --events --hex-blob \
  --ignore-table=openitcockpit.nagios_externalcommands \
  --ignore-table=openitcockpit.nagios_hostchecks \
  --ignore-table=openitcockpit.nagios_logentries \
  --ignore-table=openitcockpit.nagios_servicechecks \
  --ignore-table=openitcockpit.nagios_systemcommands \
  --ignore-table=openitcockpit.nagios_timedeventqueue \
  --ignore-table=openitcockpit.nagios_timedevents \
  --ignore-table=openitcockpit.statusengine_dbversion \
  --ignore-table=openitcockpit.statusengine_host_acknowledgements \
  --ignore-table=openitcockpit.statusengine_host_downtimehistory \
  --ignore-table=openitcockpit.statusengine_host_notifications \
  --ignore-table=openitcockpit.statusengine_host_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_host_statehistory \
  --ignore-table=openitcockpit.statusengine_hostchecks \
  --ignore-table=openitcockpit.statusengine_hoststatus \
  --ignore-table=openitcockpit.statusengine_logentries \
  --ignore-table=openitcockpit.statusengine_nodes \
  --ignore-table=openitcockpit.statusengine_perfdata \
  --ignore-table=openitcockpit.statusengine_service_acknowledgements \
  --ignore-table=openitcockpit.statusengine_service_downtimehistory \
  --ignore-table=openitcockpit.statusengine_service_notifications \
  --ignore-table=openitcockpit.statusengine_service_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_service_statehistory \
  --ignore-table=openitcockpit.statusengine_servicechecks \
  --ignore-table=openitcockpit.statusengine_servicestatus \
  --ignore-table=openitcockpit.statusengine_tasks \
  --ignore-table=openitcockpit.statusengine_users \
  >/root/openitcockpit_dump_v3_upgrade.sql
```


### Schritt 3 - Führen Sie den openITCOCKPIT v4 Kompatibilitätscheck aus

!!! danger "Hinweis für Benutzer des i-doit und discovery Moduls"
    Die Module `openitcockpit-module-discovery` und `openitcockpit-module-idoit` sind in openITCOCKPIT 4 **nicht verfügbar**
    Sollten Sie diese Module in benutzung haben, sollten Sie aktuell noch **nicht** auf openITCOCKPIT 4 aktualisieren!

Um sicherzustellen, dass ihr System in der lage ist auf openITCOCKPIT 4.x aktualisiert werden zu können, stellen wir ein 
Kompatibilitätscheck-Skript zur verfügung.

Führen Sie das Skript auf ihrer openITCOCKPIT Instanz aus.

```bash
curl -s https://raw.githubusercontent.com/it-novum/openITCOCKPIT/development/bin/scripts/oitc3to4.sh | sudo /bin/bash
```

![oitc 3-4](/images/oitc3to4.png)


**Es wurden bisher keine änderungen an ihrem System vorgenommen!**

!!! danger "Achtung!"
    Fahren Sie nicht mit der aktualisierung fort, solange Sie noch Fehler oder Warnungen durch das Kompatibilitätscheck
    bekommen!


Lösen Sie sie angezeigten Probleme und führen Sie das check Skript erneut aus.
Haben Sie alle Fehler gelöst, können Sie mit der aktualisierung fortfahren. 


#### Schritt 3.1 Distributed monitoring

Es wird vorausgesetzt, dass alle Satelliten Systeme auf openITCOCKPIT 4 aktualisiert werden. 

Mit dem aktuellen Release ist es nicht möglich openITCOCKPIT 3.x Satelliten mit einem openITCOCKPIT 4.x Master System zu
verbinden. Sollten Sie aus irgend welchen Gründen ihre Satelliten Systeme **nicht** aktualisieren können, aktualisieren
Sie ihr Master System jetzt nicht!

#### Schritt 3.2 openITCOCKPIT aktualisieren

!!! warning "Stabile SSH-Verbindung wird benötigt!"
    Der Aktualisierungsprozess kann eine Weile dauern. Um SSH Verbindungsproblemen vorzubeugen, empfehlen wir die 
    Benutzung von `tmux` oder `screen`.

**Das Kompatibilitätscheck-Skript zeigt die benötigten Kommandos zum Aktualisieren ihrer openITCOCKPIT Installation auf
Basis der installierten Module und der genutzten Distribution an. Die Aktualisierungskommandos werden individuell für
jedes System generiert**

!!! danger
    Nutzen sie KEINE anderen Kommandos um ihr System zu aktualisieren!

##### Ubuntu Nutzer

Stellen Sie sicher, dass auf ihrem System die `universe` repositories aktiviert sind.

```bash
add-apt-repository universe
```

##### Debian Nutzer

Stellen Sie sicher, dass auf ihrem System die `non-free` repositories aktiviert sind.

`/etc/apt/sources.list`

```bash 
deb http://ftp.de.debian.org/debian/ buster main contrib non-free
deb http://ftp.de.debian.org/debian/ buster-updates main contrib non-free
deb http://security.debian.org/ buster/updates main contrib non-free
```

**Führen Sie die Kommandos aus ihrem Kompatibilitätscheck-Skript aus um ihre openITCOCKPIT Installation zu aktualisieren**

Während der aktualisierung werden Sie möglicherweise gefragt, ob Sie einige Konfigurationsdateien mit neueren Versionen 
überschreiben möchten. Diese Konfigurationsdateien gehören dem Betriebssystem an, Sie können aso wählen, ob Sie Ihre 
Version oder die neuere Version haben möchten. Dies hat keine Auswirkung auf die openITCOCKPIT aktualisierung.

##### Ubuntu Xenial und Debian Stretch nutzer

Die openITCOCKPIT aktualisierung wird zusätzlich auch ihre Distribution aktualisieren (Ubuntu Xenial auf Ubuntu Bionic 
und Debian Stretch auf Debian Buster). Haben Sie eigene Software oder drittanbieter repositories eingebunden, müssen Sie
zudem sicherstellen, dass diese Kompatibel mit Ubuntu Bionic oder Debian Buster ist.

### Schritt 4 - Benutzerpasswörter zurücksetzen

Nach dem Aktualisierungsprozess müssen alle [Benutzerpasswörter zurückgesetzt](../additional/reset-passwords/) werden. Sollten Sie LDAP nutzen müssen Sie 
dies nicht durchführen.