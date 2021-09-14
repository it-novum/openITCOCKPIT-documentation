## Docker Container

Das Graphing Backend von openITCOCKPIT läuft auf verschiedenen Docker Containern. Wir nutzen [Docker Compose](https://docs.docker.com/compose/)
um die Container zu verwalten. Alle Container können mittels `systemd` kontrolliert werden.

Graphing Backen starten:
```bash
systemctl start openitcockpit-graphing.service
```

Graphing Backen stoppen:
```bash
systemctl stop openitcockpit-graphing.service
```

Graphing Backen Status:
```bash
systemctl status openitcockpit-graphing.service
```


![systemd status](/images/systemd-graphing-backend-status.png)


Sie können den Status der Container auch durch das Docker CLI abfragen

Graphing Backen Status:
```bash
docker container ps
```

![docker status](/images/docker-status.png)


### Logdatei

```bash
cd /opt/openitc/docker/container/graphing
docker-compose logs -f
```

### docker-compose.yml Datei

Die Datei `docker-compose.yml` ist in folgendem Ordner zu finden:

```bash
/opt/openitc/docker/container/graphing/docker-compose.yml
```

!!! danger
    Editieren Sie die docker-compose Datei nicht von Hand, da diese von openITCOCKPIT automatisch generiert wird!

### Carbon-C-Relay

Das Carbon-C-Relay ist ein Load-Balancer für mehrere Carbon-Cache instanzen.
Der Standard `LINE_RECEIVER_PORT` (Plaintext Protokoll basierend auf TCP) ist `2003` und wird auf `127.0.0.1:2003` 
geöffnet.
Sie können den Port über die openITCOCKPIT Weboberfläche ändern.
Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/carbon-c-relay.conf` generiert.

### Carbon-Cache Instanzen

Die Carbon-Cache Instanzen schreiben und lesen daten aus den Whisper Dateien.
Der Standard Whisper Pfad auf dem openITCOCKPIT server ist `/var/lib/graphite/whisper`. 
Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/carbon.conf` generiert.

### Graphite-Web

Bietet eine HTTP-JSON-API für den einfachen zugriff, auf die in den Whisper Dateien gespeicherten Daten.
Graphite-Web sendet seine anfragen an die [Carbon-Cache Instanzen](#carbon-cache-instanzen).
Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/local_settings.py` generiert.

### Grafana

