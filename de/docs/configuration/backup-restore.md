# Backup & Restore

openITCOCKPIT verfügt über ein integriertes Tool zum Erstellen und Einspielen von Backups. Navigieren Sie dazu zu dem Menüpunkt
<kbd><kbd>System Tools</kbd> <i class="fa fa-arrow-right"></i> <kbd>Backup / Restore</kbd></kbd>.


Dort haben Sie die Möglichkeit Backups zu erzeugen, welche auf dem openITCOCKPIT Server abgelegt werden.
Zusätzlich besteht die Möglichkeit, ein existierendes Backup herunterzuladen.


Um ein Backup wieder einzuspielen, wählen Sie die entsprechende Datei aus den vorhandenen Backups in der Dropdown Liste und klicken Sie auf
"Start Restore".

Falls Sie ein heruntergeladenes Backup wieder einspielen möchten, welches nicht auf dem System vorhanden ist, müssen Sie
die Backupdatei auf dem Server im Verzeichnis `/opt/openitc/nagios/backup` ablegen.

Nach einem neu Laden der Seite können Sie die Datei aus der Dropdown Liste auswählen und die Daten wiederherstellen.

## Start a backup via the API

Aktuell bietet die openITCOCKPIT Oberfläche keine Möglichkeit, ein automatisches Backup einzurichten. Es ist jedoch möglich, dies über die HTTP API
von openITCOCKPIT zu realisieren.

Das folgende curl Beispiel zeigt, wie ein regelmäßiges Backup von openITCOCKPIT erstellt werden kann. Der Befehl könnte von einem Aufgabenplaner wie `cron` oder `systemd` ausgeführt werden.
```bash
curl -k -X POST \
-H "Content-Type: application/json" \
-H "Authorization: X-OITC-API d2083e61fee067077ac239b7d89084f31c16a66f5e2908f6f74009492b600d3d90db2c5f6175ff199c31e1adbdcf6cf089ecadaf1c93c776bc19c7f41feb42b58f2637883b1a1273035f0ade592415f5" \
--data-raw '{"filename":"auto_backup_api"}' \
"https://demo.openitcockpit.io/backups/backup.json"
```

Das System fügt dem angegebenen Dateinamen automatisch einen Zeitstempel hinzu. In diesem Fall wäre der Dateiname: `auto_backup_api_2022-10-06_145725.sql`


## Welche Daten werden gesichert

Das Backup and Restore Tool von openITCOCKPIT erstellt eine Sicherung der MySQL Datenbank. Diese enthält die komplette Konfiguration von openITCOCKPIT,
alle Hosts und Services welche überwacht werden, alle Benutzer und Kontakte.

!!! danger
    Um Speicherplatz zu sparen, werden keine historischen Tabellen gesichert. Diese müssten durch ein separates Backup gesichert werden.


## Backup von Performancedaten

Neben der MySQL Datenbank speichert openITCOCKPIT Performancedaten zur Erstellung von Graphen.
Diese Daten werden unter `/var/lib/graphite/whisper/openitcockpit/` abgelegt.

Neben der Möglichkeit regelmäßige Vollbackups durchzuführen, wird der Einsatz eines Dateisystems mit Snapshot-Funktion wie ZFS oder
Btrfs empfohlen.
