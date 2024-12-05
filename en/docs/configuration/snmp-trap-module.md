# SNMP Traps <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Installation

To install the SNMPTrapModule, execute the following command:

```bash
apt-get install openitcockpit-module-snmp-trap
```

## How this works:

The traps are accepted by snmptrapd and passed to snmptthandler. This will store spool files in the folder `/var/spool/snmptt`, which in turn will be processed/translated by the snmptt daemon and stored in the database. Finally, the traps are checked and processed in the database using the plugin check_snmptraps.pl. A cron job regularly deletes old and obsolete snmptraps from the database.

In the log file `/var/log/snmptt/snmptt.debug`, you can see which traps were able to be processed or were unknown. You also have the option to turn off debugging.

To do this, navigate to `System Configuration -> System -> Configuration File Editor` and select the file `/opt/openitc/etc/SnmpTrapModule/snmptt.ini`. Now set the debugging value to `1`.

## Test

As a test, a status such as linkDown can be set to Critical in `/etc/snmp/snmptt.conf`. Traps can then be generated with the following commands (the OID may have to be adjusted):

### SNMP v2

```plaintext
snmptrap -v 2c -c public 127.0.0.1 "" .1.3.6.1.6.3.1.1.5.3
snmptrap -v 2c -c public 127.0.0.1 "" .1.3.6.1.6.3.1.1.5.4
```

### SNMP v3

#### With Engine ID and authPriv

```plaintext
snmptrap -Ci -e 0x8000123acd1ab43abbfff000fa -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.3
snmptrap -Ci -e 0x8000123acd1ab43abbfff000fa -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.4
```

#### without Engine ID (INFORMs) and authPriv

```plaintext
snmptrap -Ci -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.3
snmptrap -Ci -v 3 -a SHA -A traptest1 -x AES -X traptest2 -l authPriv -u trapreceiver localhost 0 .1.3.6.1.6.3.1.1.5.4
```

### Troubleshooting on Ubuntu 22.04 / Debian 12

#### **Description**

After installing the module, no traps will be processed by `snmptt`.
This is because the `snmptrapd` service is not working correctly because it is configured incorrectly.

The service file is located at `/usr/lib/systemd/system/snmptrapd.service`.
After adapting the service file,  `systemctl daemon-reload` must be executed once.

#### **<span style="color:#FF6600;">Incorrect/Original</span>**

```plaintext
[Unit]
Description=Simple Network Management Protocol (SNMP) Trap Daemon.

[Service]
Type=notify
User=Debian-snmp
ExecStart=/usr/sbin/snmptrapd -LOw -f udp:162 udp6:162
ExecReload=/bin/kill -HUP $MAINPID
```

#### **<span style="color:#99CC00;">Properly/Modified</span>**

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
Restart `snmptrapd` service

```
systemctl daemon-reload
systemctl restart snmptrapd.service
```
