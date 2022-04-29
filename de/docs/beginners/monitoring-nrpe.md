# Monitoring durch NRPE

NRPE bietet eine Möglichkeit, Monitoring Plugins auf einem Remote System auszuführen. Dies setzt einen laufenden
NRPE-Server und installierte Monitoring Plugins auf dem Remote System voraus.

Es wird empfohlen den [openITCOCKPIT Monitoring Agent](../openitcockpit-agent/#monitoring-mit-dem-openitcockpit-agent) zum Ausführen von
Plugins auf dem Remote Host zu verwenden, da dieses Setup weit weniger komplex ist. Sie haben die Möglichkeit zu
entscheiden, welche Methode Sie präferieren.

## NRPE Plugin für openITCOCKPIT installieren

Stellen Sie eine SSH Verbindung mit ihrem openITCOCKPIT Server her und installieren Sie das folgende Paket:

```
apt-get install --no-install-recommends nagios-nrpe-plugin
```

Es wird empfohlen das `check_nrpe` Plugin in den Standard Plugin Ordner von openITCOCKPIT zu verlinken

```
ln -s /usr/lib/nagios/plugins/check_nrpe /opt/openitc/nagios/libexec/check_nrpe
```

Um das neue Plugin nutzen zu können, müssen Sie ein neues Kommando unter `Objekte -> Kommandos` erstellen. Dazu klicken
dort auf die Schaltfläche `+ Neu`.

| Kommando-Definition      |                         |
| ----------- | ------------------------------------ |
| Command type |    Service check command  |
| Command name | `check_nrpe_simple` |
| Command line | `/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c "$ARG1$"` |
| Command argument ($ARG1) | `Command name` |

![openitcockpit nrpe command](/images/openITCOCKPIT-nrpe_command.png)

Um das `check_nrpe` Plugin zu nutzen, müssen Sie zudem eine neue Servicevorlage erstellen. Dazu navigieren Sie
nach `Monitoring -> Vorlagen -> Servicevorlagen` und klicken auf die Schaltfläche `+ Neu`.

Setzen Sie den Container auf `/root`, damit die Servicevorlage für alle Nutzer des Systems sichtbar wird. Als Name
vergeben wir `CHECK_BY_NRPE_SIMPLE`

| Servicevorlagen-Definition      |                         |
| ----------- | ------------------------------------ |
| Template name | `CHECK_BY_NRPE_SIMPLE` |
| Template Type | `Generic templates` |
| Service name | `NRPE Simple` |
| Check period | `24x7` |
| Enable active checks | Yes |
| Check command | `check_nrpe_simple` |
| Command name (ARG1) | blank |
| Notification period | `24x7` |

![nrpe servicetemplate](/images/nrpe-service-template.png)

## NRPE-Server auf dem Zielsystem installieren

Um NRPE nutzen zu können, wird `nagios-nrpe-server` auf dem remote Host vorausgesetzt. Stellen Sie eine SSH Verbindung
mit dem remote Host her und installieren Sie das folgende Paket:

```
apt-get install nagios-plugins nagios-nrpe-server
```

Öffnen Sie die Datei `/etc/nagios/nrpe.cfg` mit einem beliebigen Editor

Suchen Sie nach `allowed_hosts` und fügen Sie die IP-Adresse Ihres openITCOCKPIT Servers hinzu.

```
allowed_hosts=127.0.0.1,::1,172.16.166.154
```

Die Standardkonfiguration kommt mit vordefinierten Basischecks. Wir nutzen diese Beispielchecks nun.

In der Standardkonfiguration wird der Check die Festplatte `/dev/hda1` überprüfen, welche es auf den meisten Systemen
nicht mehr gibt. In unserem Fall ersetzen wir dies durch `/dev/vda1`.

```
command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_vda1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/vda1
command[check_zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200
```

Immer wenn die Konfiguration geändert wurde, muss ein Neustart des `nagios-nrpe-server.service` erfolgen, damit die
Änderungen wirksam werden.

```
systemctl restart nagios-nrpe-server.service
```

## Services erstellen

Navigieren Sie nach `Monitoring -> Services` und klicken Sie auf die Schaltfläche `+ Neu`.

Als Erstes müssen Sie einen Host auswählen, auf dem Sie den Service erstellen möchten und wählen anschließend
die `CHECK_BY_NRPE_SIMPLE` Servicevorlage aus. Das System wird nun alle vordefinierten Werte der Servicevorlage laden.

Ändern Sie den Servicenamen zu `CPU Load`, setzten Sie `check_load` als Kommandoname ($ARG1$) und klicken Sie
anschließend auf `Erstelle Service`.

![create nrpe service](/images/create-nrpe-service.png)

Wiederholen Sie diesen Schritt für alle NRPE Kommandos. Die Kommandonamen sind in der `nrpe.cfg` auf dem Zielhost
definiert. In diesem Fall haben wir die folgenden Standardkommandos:
`check_users`, `check_load`, `check_vda1`, `check_zombie_procs` und `check_total_procs`.

Sind alle Services erstellt, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

Die neuen Services werden nun vom System überwacht.

![services monitored by nrpe](/images/services-monitored-by-nrpe.png)
