# Check by SSH

SSH bietet eine einfache und sichere Möglichkeit, Monitoring Plugins auf einem remote Host auszuführen.

## SSH-Key auf dem openITCOCKPIT Server erstellen

Wenn Sie bisher noch keinen SSH-Key für den Benutzer `nagios` haben, müssen Sie zuerst einen erstellen.

```
su nagios
mkdir /var/lib/nagios/.ssh
ssh-keygen
```

Danach sollten Sie den SSH Host Key im Zielsystem Importieren: `ssh <ziel-host>` und mit `yes` bestätigen.

## SSH-Key auf dem Zielsystem Importieren

Für dieses Beispiel benötigen Sie die Pakete `nagios-plugins` oder `monitoring-plugins` auf dem Zielhost.

```
apt-get install nagios-plugins
```

Im nächsten Schritt erstellen wir einen neuen Benutzer `monitoring`, der für die Ausführung von Checks via SSH genutzt
wird.

```
addgroup --system monitoring
adduser --system --shell /bin/bash monitoring
adduser monitoring monitoring

mkdir -p /home/monitoring/.ssh/
chown monitoring:monitoring /home/monitoring -R

touch /home/monitoring/.ssh/authorized_keys
chmod 644 /home/monitoring/.ssh/authorized_keys
```

Jetzt kopieren Sie Ihren **Public key** in die Datei `/home/monitoring/.ssh/authorized_keys`.

## Checks erstellen

Navigieren Sie nach `Monitoring -> Objekte -> Kommandos` und stellen Sie sicher, dass das `check_by_ssh` Kommando
existiert. Dies ist ein Standardkommando von openITCOCKPIT. Falls das Kommando nicht verfügbar ist, klicken Sie auf die
Schaltfläche `+ Neu` um es zu erstellen.

| Kommando definition      |                         |
| ----------- | ------------------------------------ |
| Command type |    Service check command  |
| Command name | `check_by_ssh` |
| Command line | `$USER1$/check_by_ssh -H $HOSTADDRESS$ -l "$ARG1$" -C "$ARG2$"` |
| Command argument ($ARG1) | `Username` |
| Command argument ($ARG2) | `Command` |

![check by ssh command](/images/check_by_ssh_command.png)

Das `check_by_ssh` Plugin kann für die Ausführung von jeglichen Typen von Kommandos auf dem remote Host genutzt werden.
Zum Ausführen von Check Plugins ist es nötig, dass der absolute Pfad zum Plugin gesetzt wird. Durch das Erstellen eines
Makros mit dem Plugin Pfad, kann man sich hier viel Arbeit sparen.

Navigieren Sie nach `Monitoring -> Objekte -> Benutzerdefinierte Makros` und klicken Sie auf die Schaltfläche `+ Neu`.

| Makro definition      |                         |
| ----------- | ------------------------------------ |
| Makro name | `$USER2$` (or any other) |
| Value | `/usr/lib/nagios/plugins` |
| Description (optional) | `Path of monitoring-plugins on remote host used by check_by_ssh` |

![user defined macro](/images/user-defined-macro.png)

Navigieren Sie nach `Monitoring -> Services` und klicken Sie auf die Schaltfläche `+ Neu`.

Wählen Sie ihren Host und die vordefinierte Servicevorlage `CHECK_BY_SSH`.

| Servicevorlagen definition      |                         |
| ----------- | ------------------------------------ |
| Service name | `CHECK_BY_SSH` |
| Service name | `CPU load` |
| Check period | `24x7` |
| Check command | `check_by_ssh` |
| Username ($ARG1) | `monitoring` |
| Command ($ARG1) | `$USER2$/check_load -w 15,10,5 -c 30,25,20` |

Um fortzufahren klicken Sie auf `Erstelle Service`.

`$USER2$` wird automatisch ersetzt mit dem Wert, der im vorhergehenden Makro gespeichert wurde.

![cpu load by ssh](/images/cpu-load-by-ssh.png)

Wiederholen Sie diesen Schritt für alle Services die Sie benötigen.

Damit die neuen Änderungen wirksam werden, müssen Sie
eine [Aktualisierung der Monitoring-Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

Die neuen Services werden nun vom System überwacht.

![services monitored via SSH](/images/services-monitored-via-ssh.png)