# Debugging

## Pfade
### Linux
```
/etc/openitcockpit-agent/
/var/log/openitcockpit-agent/
```

### macOS
```
/Applications/openitcockpit-agent/
/Library/Logs/openitcockpit-agent/
```

### Windows
```
C:\Program Files\it-novum\openitcockpit-agent
```

Registry:
```
HKEY_LOCAL_MACHINE\SOFTWARE\it-novum\
```
## Im Vordergrund starten

### Linux
```
sudo systemctl stop openitcockpit-agent

sudo /usr/bin/openitcockpit-agent --config /etc/openitcockpit-agent/config.ini --log /tmp/agent.log --verbose --debug
```


### macOS
```
sudo su
/bin/launchctl stop com.it-novum.openitcockpit.agent

/Applications/openitcockpit-agent/openitcockpit-agent --config /Applications/openitcockpit-agent/config.ini --log /tmp/agent.log --verbose --debug
```

### Windows
Öffnen Sie ein neues `PowerShell`-Fenster. Administratorrechte sind nicht erforderlich, aber empfohlen. Bitte lesen Sie [Windows-Dienstkonfiguration](/agent/windows-service/), wie Sie die Optionen `Verbose` und `Debug` aktivieren.

```ps1
cd "C:\Program Files\it-novum\openitcockpit-agent"
Stop-Service -Name openITCOCKPITAgent

$env:OITC_AGENT_DEBUG="1"
.\openitcockpit-agent.exe -c "$PWD\config.ini" -l "$env:TEMP\agent.log" --debug --verbose
```

## Den Agent abfragen - Pull-Modus mit aktiviertem AutoTLS
Sie können diesen curl-Befehl auf dem openITCOCKPIT Monitoring Server ausführen, um eine Anfrage an den Agent zu senden.
```
curl -k -v https://xxx.xxx.xxx.xxx:3333 --cacert /opt/openitc/agent/server_ca.pem --key /opt/openitc/agent/server_ca.key --cert /opt/openitc/agent/server_ca.pem
```

## Manuelle Abfrage und Verarbeiten der Check-Ergebnisse - Pull-Modus
Sie können diesen Befehl auf dem openITCOCKPIT Monitoring Server ausführen, um eine Anfrage an den Agent zu senden und alle Check-Ergebnisse an die Monitoring-Engine weiterzuleiten.

```
/opt/openitc/receiver/bin/poller.php poller -H <Host-UUID> -c /opt/openitc/receiver/etc/production.json --verbose
```

Wenn Sie die Check-Ergebnisse nicht an die Monitoring-Engine weiterleiten möchten, fügen Sie die Option `--dryrun` hinzu.

## Übermittelte Daten abrufen - Push-Modus
Öffnen Sie die openITCOCKPIT-Weboberfläche und navigieren Sie zu `openITCOCKPIT Agent -> Agents Overview -> Push` und wählen Sie `Show received data` aus dem Dropdown-Menü aus.

Wenn der gesamte Agent in der Liste fehlt, überprüfen Sie bitte die Protokolldatei des Agents auf Fehler.
