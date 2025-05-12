# Installation

Die Installation von openITCOCKPIT erfolgt über den Paketmanager der Linux-Distribution.

## Unterstützte Betriebssysteme

- Ubuntu
    - Noble (24.04)
    - Jammy (22.04)
- Debian
    - Bookworm (12)
- Enterprise Linux
    - Red Hat 8
    - Red Hat 9

## arm64 / Raspberry Pi
openITCOCKPIT und alle Komponenten stehen auch für arm64 Prozessoren und den Raspberry Pi zur Verfügung.

Die Installation unterscheidet sich dabei nicht von einem 64-Bit System mit AMD oder Intel Prozessor. Wenn Sie ein Raspberry Pi benutzen wollen, muss die [64-Bit Version von Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_arm64/images/) genutzt werden.

## Repository einbinden
### Ubuntu

```
add-apt-repository universe
apt-get install apt-transport-https curl gnupg2 ca-certificates

mkdir -p /etc/apt/keyrings
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

### Debian

Stellen Sie sicher, dass Sie `contrib` und `non-free` Repositorys in `/etc/apt/sources.list.d/debian.sources` aktiviert haben.
```
Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian.list
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware

Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian-security.list
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
```

Aktivieren Sie das openITCOCKPIT Repository

```
apt-get install apt-transport-https curl gnupg2 ca-certificates

mkdir -p /etc/apt/keyrings
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
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

Dieser Schritt ist freiwillig und optional. Der Funktionsumfang von openITCOCKPIT kann durch Module erweitert werden. Einige stehen kostenlos zur Verfügung. Um Zugriff auf die Community Module zu erhalten, muss zuerst der openITCOCKPIT Community Schlüssel eingegeben werden. Rufen Sie dazu `System -> Registration` auf und fügen Sie folgenden Schlüssel ein: `e5aef99e-817b-0ff5-3f0e-140c1f342792`.

Es werden keine weiteren Angaben benötigt.

![Valid license](/images/openITCOCKPIT-v4-valid-license.png){ align=center }

Nach erfolgreicher Aktivierung stehen Ihnen die Community Module unter `System Tools -> Package Manager` zur Verfügung.

## Installation von phpMyAdmin

Dieser Schritt ist freiwillig und optional. openITCOCKPIT nutzt eine MySQL Datenbank. Normalerweise hat der Endanwender keine Berührungspunkte mit der Datenbank. Erfahrene Benutzer können zur Verwaltung der Datenbank das Tool `phpMyAdmin` installieren.

```
apt-get install phpmyadmin
```

Die Konfiguration des Webservers wird automatisch durchgeführt. Die phpMyAdmin Oberfläche ist im Anschluss über `https://xxx.xxx.xxx.xxx/phpmyadmin` erreichbar.

## Systemanforderungen

- Ubuntu Linux 64 bit, Debian Linux 64 bit, RHEL 64 bit
- 2 CPU Kerne (x86-64 oder arm64)
- 4 GB RAM
- 60 GB freier Festplattenspeicher
