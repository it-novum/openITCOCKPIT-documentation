# Cronjobs

Cronjobs in openITCOCKPIT bieten die Möglichkeit, PHP-Skripte in einem Zeitlich definierten abstand auszuführen. Diese
PHP-Skripte (sog. Tasks) sind beispielsweise bestandteil des openITCOCKPIT Kerns oder Modulen

Beim Erstellen eines neuen Cronjobs wählt man unter "Plugin" zuerst den Ort des auszuführenden Tasks aus. Hat man dies
gemacht, werden die verfügbaren Tasks in der nächsten Dropdown liste angezeigt.

!!! warning
    Cronjobs sind für die Funktionalität von openITCOCKPIT wichtig und sollten nur von erfahrenen Benutzern bearbeitet werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Erweiterung | :fontawesome-solid-xmark: | Ort des auszuführenden Tasks |
| Aufgaben | :fontawesome-solid-xmark: | Welcher Task soll ausgeführt werden |
| Intervall |  | In welchem Intervall in Minuten soll der Task ausgeführt werden |
| Aktiviert |  | Soll der Task ausgeführt werden, so muss diese Checkbox aktiviert werden |

## Systemd Timer
Anders als der Name vermuten lässt, werden die Cronjobs von openITCOCKPIT nicht über den `cron Daemon` ausgeführt, sondern
nutzen die Systemd Timer Funktion.
```
systemctl status oitc_cronjobs.timer
```

## Cronjobs ausführen

Die Ausführung aller Cronjobs kann mit dem Befehl

```
oitc cronjobs -f
```

erzwungen werden. Durch den Parameter `-f` werden alle Cronjobs ausgeführt, unabhängig vom konfigurierten Intervall.

Über die Angabe des Parameters `-t` (oder `--task`) kann die Ausführung eines einzelnen Cronjobs angestoßen werden.
Soll die Ausführung erzwungen werden, unabhängig des konfigurierten Intervalls, so muss zusätzlich der Parameter `-f` angegeben werden.
![Erzwungene Ausführung eines einzelnen Cronjobs](/images/configuration/force_execution_of_one_cronjob.png)

### Liste aller Cronjobs
Eine Liste, welche Cronjobs am System verfügbar sind, kann über den Parameter `-l` (oder `--list`) eingesehen werden
![Liste aller verfügbaren Cronjobs](/images/configuration/list_of_cronjobs.png)
