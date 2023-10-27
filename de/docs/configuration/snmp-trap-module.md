# SNMP Traps <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Installation

Zur installation des SNMPTrapModule führen Sie folgendes Kommando aus:

```bash
apt-get install openitcockpit-module-snmp-trap
```

## Funktionsweise

Die Traps werden vom snmptrapd angenommen und an den snmptthandler übergeben. Dieser legt im Ordner /var/spool/snmptt
spool Dateien ab welche wiederum vom snmptt Daemon verarbeitet / übersetzt und in der Datenbank gespeichert werden. Zum
Schluss werden die Traps mit dem Plugin check_snmptraps.pl in der Datenbank geprüft und verarbeitet. Ein Cronjob befreit
die Datenbank regelmäßig von altlasten (Löschen von veralteten snmptraps)

In der Logdatei `/var/log/snmptt/snmptt.debug`, kann eingesehen werden welche Traps verarbeitet werden konnten oder
unbekannt sind. Zusätzlich kann das debugging deaktiviert werden.

Dazu Navigieren Sie
nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor`
und wählen die Datei `/opt/openitc/etc/SnmpTrapModule/snmptt.ini` aus. Dort setzen Sie den Wert `debugging` auf `1`.

## Test

Für einen Test kann in /etc/snmp/snmptt.conf ein Status von z.B. linkDown auf Critical gesetzt werden. Anschließend kann
dann mit den folgenden Befehlen Traps generiert werden (eventuell muss die OID angepasst werden):

### SNMP v2

```plaintext
snmptrap -v 2c -c public 127.0.0.1 "" .1.3.6.1.6.3.1.1.5.3
snmptrap -v 2c -c public 127.0.0.1 "" .1.3.6.1.6.3.1.1.5.4
```

### SNMP v3

#### Mit Engine ID und authPriv

```plaintext
snmptrap -Ci -e 0x8000123acd1ab43abbfff000fa -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.3
snmptrap -Ci -e 0x8000123acd1ab43abbfff000fa -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.4
```

#### ohne Engine ID (INFORMs) und authPriv

```plaintext
snmptrap -Ci -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.3
snmptrap -Ci -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.4
```

### Probleme mit Ubuntu 22.04 / Debian 12

#### **Beschreibung**

Nach der Installation des Moduls werden keine Traps durch `snmptt` verarbeitet.
Das liegt daran, dass der `snmptrapd` Service nicht korrekt funktioniert, weil dieser mit einer falschen Konfiguration
gestartet wird.

Die Servicedatei befindet sich unter `/usr/lib/systemd/system/snmptrapd.service`.
Nach der Anpassung der Servicedatei muss einmal `systemctl daemon-reload` ausgeführt werden.

#### **<span style="color:#FF6600;">Falsch/Original</span>**

```plaintext
[Unit]
Description=Simple Network Management Protocol (SNMP) Trap Daemon.

[Service]
Type=notify
User=Debian-snmp
ExecStart=/usr/sbin/snmptrapd -LOw -f udp:162 udp6:162
ExecReload=/bin/kill -HUP $MAINPID
```

#### **<span style="color:#99CC00;">Richtig/Geändert</span>**

```plaintext
[Unit]
Description=Simple Network Management Protocol (SNMP) Trap Daemon.
After=network.target
ConditionPathExists=/etc/snmp/snmptrapd.conf

[Service]
Type=simple
ExecStart=/usr/sbin/snmptrapd -LOw -f -p /run/snmptrapd.pid
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
```
Neustart des `snmptrapd` Services

```
systemctl restart snmptrapd.service
```
