# Cronjobs

Cronjobs in openITCOCKPIT bieten die Möglichkeit, PHP-Skripte in einem Zeitlich definierten abstand auszuführen. Diese
PHP-Skripte (sog. Tasks) sind beispielsweise bestandteil des openITCOCKPIT Kerns oder Modulen

Beim Erstellen eines neuen Cronjobs wählt man unter "Plugin" zuerst den Ort des auszuführenden Tasks aus. Hat man dies
gemacht, werden die verfügbaren Tasks in der nächsten Dropdown liste angezeigt.

!!! warning
    Cronjobs sind für die Funktionalität von openITCOCKPIT wichtig und sollten nur von erfahrenen Benutzern bearbeitet werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Erweiterung | :fontawesome-solid-times: | Ort des auszuführenden Tasks |
| Aufgaben | :fontawesome-solid-times: | Welcher Task soll ausgeführt werden |
| Intervall |  | In welchem Intervall in minuten soll der Task ausgeführt werden |
| Aktiviert |  | Soll der Task ausgeführt werden, so muss diese checkbox aktiviert werden |

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

erzwungen werden. Durch den Parameter `-f` werden alle Cronjobs ausgeführt, unabhängig vom konfigurierten Interval.
