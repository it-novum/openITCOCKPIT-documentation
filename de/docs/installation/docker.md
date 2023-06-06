# Docker images

Die offiziellen Docker-Images von openITCOCKPIT stehen hier zur Verfügung:

 - [Docker Hub](https://hub.docker.com/r/openitcockpit/openitcockpit-ce)

Die Docker-Images von openITCOCKPIT stehen für die `amd64` und `arm64` CPU Architekturen zur Verfügung und können somit auch auf einem SoC wie dem Raspberry Pi 4 genutzt werden.

## Voraussetzungen

Docker und Docker Compose sind erforderlich. Bitte folgen Sie der [offiziellen Dokumentation](https://docs.docker.com/get-docker/),
sollten Sie noch kein Docker installiert haben.

## Einstellungen
Die Konfiguration von openITCOCKPIT kann über die Datei `openitcockpit.env` angepasst werden. Es wird empfohlen,
**vor dem ersten start der Container** die Anmeldedaten zu ändern:

```sh
OITC_ADMIN_EMAIL=user@example.org
OITC_ADMIN_PASSWORD=asdf12
OITC_ADMIN_FIRSTNAME=John
OITC_ADMIN_LASTNAME=Doe
```

Alternativ können Sie auch einen neuen [Benutzer erstellen](https://docs.openitcockpit.io/en/configuration/usermanagement/) oder das Passwort ändern.

Außerdem wird empfohlen, dass Password des Grafana-Admin-Benutzers zu ersetzten. Setzten Sie dafür die folgenden zwei Variablen auf den gleichen Wert:
```sh
OITC_GRAFANA_ADMIN_PASSWORD=bGsPMxURCjg4esgJ

GF_SECURITY_ADMIN_PASSWORD=bGsPMxURCjg4esgJ
```

Zur Generierung eines sicheren Passworts kann der Befehl `pwgen -s -1 16` genutzt werden.

Wie üblich bei Docker-Containern, können weitere Einstellungen wie Ports oder Volumes im `compose.yml` bei Bedarf angepasst werden.

## Standardwerte

Standardmäßig stellt openITCOCKPIT diese Ports zur Verfügung:

 - 80 (HTTP)
 - 443 (HTTPS)

Die Standardanmeldeinformationen sind:

 - E-Mail `user@example.org`
 - Password: `asdf12`

## Vorbereitungen

1. Am einfachsten ist es, wenn Sie zuerst mit `git` eine lokale Kopie des Repositories erstellen, welches alle benötigten Daten enthält.
```
git clone https://github.com/it-novum/openITCOCKPIT-ce-docker.git
```

2. Wechseln Sie nun in den Ordner
```
cd openITCOCKPIT-ce-docker
```

3. Bearbeiten Sie die Datei `openitcockpit.env` und passen Sie Benutzername und Passwort an.

## Container starten

Das Starten der Container erfolgt mit Hilfe des Befehls

```
docker compose up -d
```


## Container aktualisieren

Um die Container von openITCOCKPIT zu aktualisieren, folgen Sie bitte diesen Schritten:

1. Aktualisieren Sie die lokale Kopie Ihres Repositories:
```bash
git pull origin main
```

2. Stoppen Sie die laufenden Container
```bash
docker compose down
```

3. Führen Sie das Docker Compose Kommando aus, um die Container zu aktualisieren und starten:
```bash
docker compose up --pull always -d
```

## Tags

Die Docker-Registry von openITCOCKPIT beinhaltet für alle Container die folgende Tags:

- `latest` - Die letzte stabile Version von openITCOCKPIT (empfohlen)
- Eine Version wie z.B. `4.6.4` - Diese Tags beinhalten die angegebene Version von openITCOCKPIT und können genutzt werden, um eine spezifische stabile Version zu erhalten.

- `nightly` - Ein **ungetesteter** Build von openITCOCKPIT, welcher automatisiert erstellt und veröffentlicht wurde. Kann zum Testen von neuen Versionen und Feature genutzt werden. **Nicht für den produktiven Einsatz gedacht!**


## Fehlersuche

### Befehle in einem Container ausführen

1.  Führen Sie den Befehl `docker ps` aus, um die ID des gewünschten Containers auszulesen.
2. Im nächsten Schritt können Sie über den Befehl  `docker exec` in den Container _springen_
```
docker exec -it d92a1431e619 bash
```

### Eine MySQL Konsole starten

1. Gehen Sie zuerst mit dem Befehl `docker exec` in den `openitcockpit-ce` Container.
2. Führen Sie den Befehl `mysql --defaults-file=/opt/openitc/etc/mysql/mysql.cnf` aus um eine MySQL Shell zu erhalten.

### Query Gearman status
1. Gehen Sie zuerst mit dem Befehl `docker exec` in den `openitcockpit-ce` Container.
2. Führen Sie den Befehl `gearadmin --status -h gearmand` aus um eine MySQL Shell zu erhalten.

Sollten Sie den Hostnamen des Gearman-Job-Servers angepasst haben, können Sie den Wert direkt aus der Umgebungsvariable auslesen: `gearadmin --status -h $OITC_GEARMAN_ADDRESS`

### Neustarten von Diensten
In der Regel müssen Sie keine Dienste manuell neustarten. Über den `openitcockpit-ce` Container ist es jedoch möglich, bestimmte Dienste in anderen Containern neu zu starten.
Dafür kann der Befehl `oitc supervisor --help` genutzt werden.

Beispiele:
```
oitc supervisor status naemon
oitc supervisor restart nginx
oitc supervisor stop nginx
oitc supervisor start nginx
```

## Eigene Monitoring-Plugins installieren

Der Container `openitcockpit/mod_gearman_worker` ist verantwortlich für das Ausführen von Monitoring-Plugins. Dieser Container basiert immer auf
der aktuellen LTS Version von Ubuntu und kann als Basisimage für neue Container genutzt werden.

Daf+r müssen Sie zuerst ein eigenes `Dockerfile` erstellen, welche alle gewünschten Plugins installieren. In diesem Beispiel, wird der Container um das Plugin
[check_ssl_cert](https://github.com/matteocorti/check_ssl_cert) erweitert.

```Dockerfile
FROM openitcockpit/mod_gearman_worker:latest

USER root

# Install plugin dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y perl wget curl bind9-host bc openssl nmap

# Install the plugin
RUN wget https://github.com/matteocorti/check_ssl_cert/releases/download/v2.69.0/check_ssl_cert-2.69.0.tar.gz &&\
    tar xfv check_ssl_cert-2.69.0.tar.gz &&\
    cp check_ssl_cert-2.69.0/check_ssl_cert /opt/openitc/nagios/libexec/check_ssl_cert &&\
    chmod +x /opt/openitc/nagios/libexec/check_ssl_cert

```


Erstellen Sie das neues Docker-Image:
```
docker build --rm -t openitcockpit/custom_mod_gearman_worker:latest .
```

Im letzten Schritt müssen Sie noch Ihr eigenes Docker-Image in der `compose.yml`-Datei eintragen. Suchen Sie dafür den Container `openitcockpit/mod_gearman_worker` und ersetzten
Sie das Image durch Ihr eigenes, zum Beispiel `openitcockpit/custom_mod_gearman_worker:latest`


Nach einem Neustart der Container, wird Ihr eigens angepasster Container genutzt.
```
[Ubuntu][11:49]root@srvcontainerswarm04/tmp/custom_mod_gearman# docker exec -it dffc5ffe8681 bash
root@dffc5ffe8681:/# /opt/openitc/nagios/libexec/check_ssl_cert -H openitcockpit.io
SSL_CERT OK - openitcockpit.io:443, https, x509 certificate 'openitcockpit.io' from 'Let's Encrypt' valid until Aug  6 21:32:16 2023 GMT (expires in 76 days)|days_chain_elem1=76;20;15;; days_chain_elem2=847;20;15;; days_chain_elem3=497;20;15;;
root@dffc5ffe8681:/#
```


## Portainer

[Portainer Community Edition](https://github.com/portainer/portainer) ist eine Weboberfläche, mit dessen Hilfe sich Docker-Container bequem und einfach verwalten lassen.

Über _Stacks_ ermöglicht die Portainer Oberfläche, dass Verwalten von Docker-Compose Dateien. Klicken Sie dazu unter `Stacks` auf `Add stack`.

1. Als Name können sie `openitcockpit-ce` setzen.

2. Das [Docker-Compose-File](https://raw.githubusercontent.com/it-novum/openITCOCKPIT-ce-docker/main/compose.yml) können Sie entweder über den Web-Editor hinzufügen, oder alternativ direkt aus dem GitHub Repository `https://github.com/it-novum/openITCOCKPIT-ce-docker` beziehen.

    **Bitte beachten Sie**, dass alle Verweise auf das `openitcockpit.env`-File durch `stack.env` ersetzten müssen.

    Suchen Sie dafür nach diesen Einträgen
    ```
    env_file:
     - openitcockpit.env
    ```

    Ersetzten Sie sie durch
    ```
    env_file:
     - stack.env
    ```

    Sie können dies mit Hilfe des Web-Editors durchführen. (`CTRL + F` oder `CMD + F`)
    ![Find and replace openitcockpit.env with stack.env](/images/docker/portainer_stack_env.png)

3. Wähle Sie unter `Environment variables` den `Advanced mode` und kopieren Sie den Inhalt der Datei [openitcockpit.env](https://raw.githubusercontent.com/it-novum/openITCOCKPIT-ce-docker/main/openitcockpit.env).
    Alternative können Sie auch `Load variables from .env file` auswählen dann die Datei `openitcockpit.env` hochladen.
    ![Portainer Stack configuration for openITCOCKPIT](/images/docker/portainer_create_stack.png)


4. Klicken Sie auf `Deploy the stack`
    Portainer wird nun den kompletten Stack erstellen und alle Container starten.
    ![Portainer running stack](/images/docker/portainer_stack_running.png)

## Startsequenz

Der Startvorgang des openITCOCKPIT Containers kann einige Zeit in Anspruch nehmen. Der Container überprüft bei jedem Start den Zustand der Datenbank und führt eventuelle Updates durch.
Sobald das openITCOCKPIT Frontend erreichbar ist, gibt der Container die Meldung `openITCOCKPIT is now ready` aus.

### Docker
![openITCOCKPIT is ready via Docker Compose](/images/docker/docker_ready.png)

### Portainer
![openITCOCKPIT is ready via Portainer CE](/images/docker/container_ready.png)
