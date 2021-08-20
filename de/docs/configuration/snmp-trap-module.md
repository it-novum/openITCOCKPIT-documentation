## Funktionsweise

Die Funktionsweise des SnmpTrapModule aus openITCOCKPIT v4 ist im Grunde die selbe, wie für die Snmp Trap Installation für die v3.

Was sich grundsätzlich geändert hat:

-   Keine eigene Datenbank mehr. (Das Modul nutzt nun eigene Tabellen in der openitockpit Datenbank.)
-   Tabellen werden über openITCOCKPIT Cronjobs regelmäßig von Altlasten befreit.
-   Keine initiale NagTrap Unterstützung
-   Nutzung des openITCOCKPIT ConfigGenerator für "/etc/snmp/snmptt.ini", "/etc/snmp/snmptrapd.conf", "/etc/default/snmptrapd".

## Installation

### Paketinstallation

Seit openITCOCKPIT Version 4 stehen pakete für das SNMPTrapModule bereit

Dies kann einfach über die Kommandozeile installiert werden 

```plaintext
apt install openitcockpit-module-snmptrap
```

## Funktionsweise / Debugging

Die Traps werden vom snmptrapd angenommen und an den snmptthandler übergeben. Dieser legt im Ordner /var/spool/snmptt spool Dateien ab welche wiederum vom snmptt Daemon verarbeitet / übersetzt und

in der snmptt Datenbank gespeichert werden. Zum Schluss werden die Traps mit dem Plugin check\_snmptraps.pl in der Datenbank geprüft, verarbeitet und gelöscht.

In den Logfiles in /var/log/snmptt/ kann eingesehen werden welche Traps verarbeitet werden konnten oder unbekannt sind. Zusätzlich kann das debugging deaktiviert werden:

**vim /etc/snmp/snmptt.ini**

```plaintext
DEBUGGING = 1
DEBUGGING_FILE = /var/log/snmptt/snmptt.debug
```

## Test

Für einen Test kann in /etc/snmp/snmptt.conf ein Status von z.B. linkDown auf Critical gesetzt werden. Anschließend kann dann mit den folgenden Befehlen Traps generiert werden (evt. OID anpassen):

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

### Aufruf

Idealerweise kann hier mal in der Tabelle SNMPTT nachgeguckt werden ob der Host der die Traps sendet in der Spalte Hostname mit Adresse oder Name auftaucht. Jenachdem

dann den Parameter -H anpassen. Normalerweise sollten die Systeme mit der IP Adresse in der DB landen.

```plaintext
/opt/openitc/nagios/libexec/check_snmptraps.pl -H localhost -c -m
```

!!! tip
    Da das Plugin nur Warning und Critical Traps überprüft (und diese dann auch aus der DB löscht), könnte man einen Cronjob einrichten, um normal/ok Traps aus der Tabelle zu löschen, damit diese immer aufgeräumt ist.


### Anmerkung

Da das Plugin nur Warning und Critical Traps überprüft (und diese dann auch aus der DB löscht), könnte man einen Cronjob einrichten, um normal/ok Traps aus der Tabelle zu löschen, damit diese immer aufgeräumt ist.

**Tabelle aufräumen**

```plaintext
delete from snmptt where severity not in ('CRITICAL', 'WARNING');
```