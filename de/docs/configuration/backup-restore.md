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

## Welche Daten werden gesichert

Das Backup and Restore Tool von openITCOCKPIT erstellt eine Sicherung der MySQL Datenbank. Diese enthält die komplette Konfiguration von openITCOCKPIT,
alle Hosts und Services welche überwacht werden, alle Benutzer und Kontakte.

!!! danger
    Um Speicherplatz zu sparen, werden keine historischen Tabellen gesichert. Diese müssten durch ein seperates Backup gesichert werden.


## Backup von Performancdaten

Neben der MySQL Datenbank speichert openITCOCKPIT Performancedaten zur Erstellung von Graphen.
Diese Daten werden unter `/var/lib/graphite/whisper/openitcockpit/` abgelegt.

Neben der Möglichkeit regelmäßige Vollbackups durchzuführen, wird der Einsatz eines Dateisystems mit Snapshot-Funktion wie ZFS oder
Btrfs empfohlen.


