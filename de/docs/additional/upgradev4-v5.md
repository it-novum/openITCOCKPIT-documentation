# Upgrade openITCOCKPIT 4 zu openITCOCKPIT 5

![Weg zu openITCOCKPIT 5](/images/openitcockpit5/oitc5_autobahn.png)

Diese Anleitung beschreibt, wie Sie Ihre aktuelle Installation von openITCOCKPIT 4.8.7 (oder neuer) auf openITCOCKPIT 5 aktualisieren.

!!! info
    Bevor Sie mit dem Upgrade beginnen, erstellen Sie bitte ein Backup Ihres Systems! Wir empfehlen, sowohl Ihre Backup- als auch Ihre Update-Prozesse in einer Testumgebung zu testen, bevor Sie sie in einem Live-System verwenden.

### Voraussetzungen

- Stellen Sie sicher, dass:
- Ihre openITCOCKPIT-Installation auf dem neuesten Stand ist
- openITCOCKPIT >= 4.8.7
- Alle Betriebssystem-Updates installiert sind
- Ein funktionierendes Backup Ihrer openITCOCKPIT-Installation verfügbar ist (für den Fall, dass etwas schiefgeht)
- Sie mindestens **20 GB** freien Festplattenspeicher haben
- Alle Befehle als `root`-Benutzer ausgeführt werden

### Docker-Setup?

Für Docker (oder andere Container-Laufzeit) basierte Installationen von openITCOCKPIT ist kein manueller Upgrade-Prozess erforderlich.
Alles, was Sie tun müssen, ist, die Container zu stoppen, die neuen Images zu ziehen und die Container erneut zu starten.

Weitere Informationen finden Sie in den [Container-Update-Anweisungen](/installation/docker/#container-aktualisieren).

### Unterstützte Betriebssysteme:

openITCOCKPIT 5 kann auf den folgenden Betriebssystemen installiert werden:

| Ubuntu Noble (24.04) | Ubuntu Jammy (22.04) | Debian Bookworm (12) | Enterprise Linux* 8 | Enterprise Linux* 9 |
|---|---|---|---|---|
|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check:|

_*Enterprise Linux umfasst Red Hat Enterprise Linux und RHEL-basierte Distributionen wie: CentOS, Rocky Linux, AlmaLinux oder Oracle Linux._

### Unsupported operating systems:

!!! warning
    Ältere Versionen von Ubuntu oder Debian (z. B. Ubuntu Focal oder Debian Bullseye)
    werden von openITCOCKPIT 5 **nicht unterstützt**.
    Bitte aktualisieren Sie Ihr Betriebssystem zuerst, bevor Sie fortfahren

- Update [Ubuntu Bionic auf Focal](/update/ubuntu-bionic-to-focal/)
- Update [Ubuntu Focal auf Jammy](/update/ubuntu-focal-to-jammy/)
- Update [Debian Buster auf Bullseye](/update/debian-buster-to-bullseye/)
- Update [Debian Bullseye auf Bookworm](/update/debian-bullseye-to-bookworm/)


### System vorbereiten

#### Schritt 1 - Non-free-Repositories aktivieren

Standardmäßig sind die `non-free`-Repositories bei allen Installationen von openITCOCKPIT aktiviert.
Es wird empfohlen zu überprüfen, ob Ihr System so konfiguriert ist, dass es Zugriff auf `contrib`- und `non-free`-Pakete hat.

##### Ubuntu-Benutzer

Stellen Sie sicher, dass die Universe-Repositories auf Ihrem System aktiviert wurden.

```bash
add-apt-repository universe
```

##### Debian-Benutzer

Stellen Sie sicher, dass Sie `contrib`- und `non-free`-Repositories in `/etc/apt/sources.list.d/debian.sources` aktiviert haben.

```bash
Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian.list
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware

Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian-security.list
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
```

#### Schritt 2 - Aktualisierung des Betriebssystemes

```bash
apt-get update
apt-get dist-upgrade
```

#### Schritt 3 - Sicherung der Datenbank

!!! warning
    Stellen Sie sicher, dass ausreichend freier Festplattenspeicher vorhanden ist, bevor Sie versuchen, ein Backup zu erstellen!

```bash
mysqldump --defaults-extra-file=/opt/openitc/etc/mysql/dump.cnf --databases openitcockpit --flush-privileges --triggers --routines --no-tablespaces --events --hex-blob \
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
  --ignore-table=openitcockpit.statusengine_host_notifications_log \
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
  --ignore-table=openitcockpit.statusengine_service_notifications_log \
  --ignore-table=openitcockpit.statusengine_service_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_service_statehistory \
  --ignore-table=openitcockpit.statusengine_servicechecks \
  --ignore-table=openitcockpit.statusengine_servicestatus \
  --ignore-table=openitcockpit.statusengine_tasks \
  --ignore-table=openitcockpit.statusengine_users \
  --ignore-table=openitcockpit.customalerts \
  --ignore-table=openitcockpit.customalert_statehistory \
  --ignore-table=openitcockpit.sla_availability_status_hosts_log \
  --ignore-table=openitcockpit.sla_availability_status_services_log \
  --ignore-table=openitcockpit.sla_host_outages \
  --ignore-table=openitcockpit.sla_service_outages \
  >/root/openitcockpit_dump_v4_upgrade.sql
```


#### Schritt 4 - Kompatibilitätsprüfung für openITCOCKPIT 5 durchführen

Um sicherzustellen, dass Ihr System auf openITCOCKPIT 5.x aktualisiert werden kann, stellen wir ein Kompatibilitätsskript zur Überprüfung Ihres Systems bereit.

Führen Sie das folgende Skript auf Ihrer openITCOCKPIT-Instanz aus:

```bash
curl -s https://raw.githubusercontent.com/it-novum/openITCOCKPIT/development/bin/scripts/oitc4to5.sh | sudo /bin/bash
```

![oitc4to5 Erfolgreiche Kompatibilitätsprüfung](/images/openitcockpit5/oitc4to5_success.png)


**An Ihrem System wurden bisher keine Änderungen vorgenommen!**

!!! danger
    Fahren Sie nicht mit dem Update fort, wenn Sie nach der Durchführung der Kompatibilitätsprüfung Fehler oder Warnungen erhalten!


Beheben Sie zuerst die hervorgehobenen Probleme und führen Sie das Skript erneut aus. Sobald alle Fehler behoben sind, können Sie mit dem Update fortfahren.




### Upgrade openITCOCKPIT

Ihr System ist nun vorbereitet und bereit für das Upgrade auf openITCOCKPIT 5.

#### Schritt 1 – Abmelden von openITCOCKPIT

openITCOCKPIT 5 wird mit einem völlig neuen Frontend ausgeliefert. Für ein reibungsloses Upgrade wird empfohlen, sich zuerst von openITCOCKPIT abzumelden.

Den `Abmelden`-Button finden Sie oben rechts.

![Abmelden von openITCOCKPIT](/images/openitcockpit5/upgrade_4_to_5_sign_out.png)


#### Schritt 2 - Repository ändern

openITCOCKPIT 5 verwendet eine andere Repository-Adresse als openITCOCKPIT 4. 
Dies dient dazu, unerwartete System-Upgrades zu verhindern.

Die neue Adresse lautet: `packages5.openitcockpit.io`.

!!! warning
    Derzeit befindet sich openITCOCKPIT 5 in der **Beta-Phase**. Bitte verwenden Sie dieses Version nicht für Produktionssysteme.
    Das Repository ist automatisch für die Verwendung des Kanals `nightly` konfiguriert.

##### Ubuntu-Benutzer

```bash
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list

apt-get update
```

##### Debian-Benutzer

```bash
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list

apt-get update
```

##### RHEL8-Benutzer

!!! warning
    Stellen Sie sicher, dass Sie Ihren openITCOCKPIT Lizenzschlüssel am Ende der Repository-Konfigurationsdatei hinzufügen:
    ```
    username=secret
    password=e5aef99e-817b-0ff5-3f0e-140c1f342792
    ```

```bash
cat <<EOT > /etc/yum.repos.d/openitcockpit.repo
[openitcockpit]
name=openITCOCKPIT Monitoring System
baseurl=https://packages5.openitcockpit.io/openitcockpit/RHEL8/nightly/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://packages5.openitcockpit.io/repokey.txt
EOT

dnf --refresh check-update
```

##### RHEL9-Benutzer

!!! warning
    Stellen Sie sicher, dass Sie Ihren openITCOCKPIT Lizenzschlüssel am Ende der Repository-Konfigurationsdatei hinzufügen:
    ```
    username=secret
    password=e5aef99e-817b-0ff5-3f0e-140c1f342792
    ```

```bash
cat <<EOT > /etc/yum.repos.d/openitcockpit.repo
[openitcockpit]
name=openITCOCKPIT Monitoring System
baseurl=https://packages5.openitcockpit.io/openitcockpit/RHEL8/nightly/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://packages5.openitcockpit.io/repokey.txt
EOT

dnf --refresh check-update
```

#### Schritt 3 - Lizenz übertragen

Nutzer der openITCOCKPIT Community Edition und Enterprise Edition können Ihren bestehenden Lizenzschlüssel weiterhin verwenden. Wichtig ist, dass Sie vor dem Update die Repository-Adresse in der Datei `/etc/apt/auth.conf.d/openitcockpit.conf` in `packages5.openitcockpit.io` ändern.

Die Datei sollte folgendermaßen aussehen:
```
machine packages5.openitcockpit.io login secret password e5aef99e-817b-0ff5-3f0e-140c1f342792
```

Um die Änderungen zu übernehmen, führen Sie den folgenden Befehl aus:

```bash
apt-get update
```

#### Schritt 4 - openITCOCKPIT aktualisieren

!!! warning
    Eine stabile SSH-Verbindung ist erforderlich! Der Aktualisierungsprozess kann eine Weile dauern. Um SSH-Verbindungsprobleme zu vermeiden, empfehlen wir die Verwendung von `tmux` oder `screen`.

Während des Updates werden Sie möglicherweise gefragt, ob Sie einige Konfigurationsdateien durch neuere Versionen ersetzen möchten. Diese Konfigurationsdateien gehören zum Betriebssystem, daher können Sie wählen, ob Sie Ihre aktuellen Versionen behalten oder auf die neueren Versionen aktualisieren möchten. Dies hat keinen Einfluss openITCOCKPIT.

Um das Update zu starten, führen Sie aus:

```bash
apt-get dist-upgrade
```

#### Schritt 5 - Browser-Cache leeren

Bevor Sie sich in Ihre neue openITCOCKPIT-Oberfläche einloggen, sollten Sie den Cache Ihres Browsers leeren.

Mozilla Firefox: <https://support.mozilla.org/en-US/kb/how-clear-firefox-cache>

Google Chrome: <https://support.google.com/accounts/answer/32050?co=GENIE.Platform%3DDesktop&hl=en>

#### Schritt 6 - System neu starten

Ein Neustart des Systems wird empfohlen, ist jedoch nicht erforderlich.

Das Update auf openITCOCKPIT 5 ist nun abgeschlossen 🎉.

### Aktualisierung der openITCOCKPIT-Satellitensysteme (nur für verteiltes Monitoring)

Der Aktualisierungsprozess für openITCOCKPIT-Satellitensysteme ist unkompliziert. openITCOCKPIT 5 kann auch mit openITCOCKPIT 4 Satelliten kommunizieren. Ein Upgrade wird zwar **empfohlen**, ist jedoch (Stand jetzt) nicht erforderlich.

#### Schritt 1 - Betriebssystem aktualisieren

```bash
apt-get update
apt-get dist-upgrade
```

#### Schritt 2 - Repository ändern

openITCOCKPIT 5 verwendet eine andere Repository-Adresse als openITCOCKPIT 4. Dies dient dazu, unerwartete System-Upgrades zu verhindern.

Die neue Adresse lautet: `packages5.openitcockpit.io`.


#### Schritt 3 - openITCOCKPIT-Satellit aktualisieren

```bash
apt-get update
apt-get dist-upgrade
```



### Bekannte Probleme

#### PHP 8.0 unter RHEL
openITCOCKPIT **benötigt** PHP in Version 8.1 oder neuer. 
Einige Enterprise Linux Installationen verwenden noch PHP 8.0. In diesem Fall müssen Sie Ihre PHP-Version zuerst aktualisieren.

Aufgrund der Komplexität des Supports für Enterprise Linux Systeme ist nur die [openITCOCKPIT Enterprise Edition](https://openitcockpit.io/editions/) für 
Red Hat Enterprise Linux und RHEL-basierte Distributionen wie CentOS, Rocky Linux, AlmaLinux oder Oracle Linux verfügbar.

Bitte nehmen Sie [Kontakt mit uns auf](https://it-services.it-novum.com/de/), wenn Sie Unterstützung bei der Aktualisierung Ihrer openITCOCKPIT Installation benötigen.

Stellen Sie vor dem Start sicher, dass Sie die neuesten Updates für Ihr System installiert haben:
```bash
dnf --refresh check-update

dnf update
```

Diese Dokumentation setzt voraus, dass Sie PHP von [Remi's RPM repository](https://rpms.remirepo.net/) installiert haben.

Um Ihre PHP-Version zu aktualisieren, führen Sie bitte den folgenden Befehl aus:

```
dnf module switch-to php:remi-8.1
```

Dadurch wird Ihr System auf die neueste Version von PHP 8.1 umgestellt. Sie können auch PHP 8.2 oder 8.3 verwenden.

Um das Upgrade abzuschließen, führen Sie bitte den folgenden Befehl aus:

```bash
openitcockpit-update
```

### Troubleshooting

#### Netzwerk Fehler

Sollten Sie Verbindungsfehler mit Ihrem System haben, können Sie versuchen die Installation zu reparieren. Nutzen Sie dazu folgendes Kommando:

```bash
apt-get install -f
```

#### Wenn Ihre openITCOCKPIT Version < 4.8.7 ist

Damit der Aktualisierungsprozess erfolgreich abgeschlossen werden kann, müssen Sie mindestens Version 4.8.7 von openITCOCKPIT verwenden.


#### Was ist, wenn ich Ubuntu Bionic, Debian Buster oder openITCOCKPIT 3 verwende?

Bitte nehmen Sie [Kontakt mit uns auf](https://it-services.it-novum.com/de/).
