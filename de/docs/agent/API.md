# API

## Webserver API

Diese Dokumentation beschreibt die API des eingebauten Webservers des openITCOCKPIT Monitoring Agent.

### GET /
Prüfergebnisse im JSON-Format. Das Ergebnis könnte `{}` sein, wenn die Prüfungen nicht korrekt abgeschlossen wurden oder nicht serialisiert werden konnten.

### GET /config
Wenn der Konfigurations-Push-Modus aktiviert ist, wird das folgende JSON zurückgegeben:

```json
{
    "configuration": "Base64-String der Konfigurationsdatei",
    "customcheck_configuration": "Base64-String der benutzerdefinierten Prüfkonfigurationsdatei oder leerer String, wenn sie nicht existiert"
}
```

### POST /config

Erwartet ein JSON im gleichen Format wie `GET /config`.

Das Base64 wird dekodiert und in die aktuellen Konfigurationspfade geschrieben.

### GET /autotls

Gibt einen Zertifikatsanforderungsdatensatz (CSR) für Auto-TLS zurück. Dies wird einen neuen privaten Schlüssel generieren, wenn keiner vorhanden ist.

```json
{
    "csr": "Inhalt des CSR im PEM-Format"
}
```

### POST /autotls

Speichert ein neues SSL-Zertifikat und CA-Zertifikat für Auto-TLS.

```json
{
    "signed": "",
    "ca": ""
}
```

#### Auto-TLS

Nach der Einrichtung von Auto-TLS sind weitere Zertifikatsaktualisierungen nur vom openITCOCKPIT-Server aus möglich, da dann eine gültige HTTPS-Verbindung erforderlich ist. Sie können auch die Basisauthentifizierung aktivieren, wenn Sie zusätzliche Sicherheit für den ersten "Handshake" wünschen.

Die `/autotls` Endpunkte sind nur verfügbar, wenn `try-autossl=True` in `config.ini` aktiviert ist.

## openITCOCKPIT API Endpunkte

Diese Dokumentation beschreibt die openITCOCKPIT API, die vom Agent im Push-Modus verwendet wird.

### POST /agentconnector/register_agent.json
Wird verwendet, um einen neuen Agenten zu registrieren und den Autorisierungsstatus zu überprüfen.

#### Neuen Agenten registrieren
Anfrage: POST `/agentconnector/register_agent.json`
```json
{
    "agentuuid": "<uuid>",
    "password": "", // Empty for new Agents
    "hostname": "<optional>",
    "ipaddress": "<optional>"
}
```
Antwort:
```json
Status: 201 Created
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3..."
}
```

#### Überprüfen des Autorisierungsstatus vorhandener Agenten

Anfrage: POST `/agentconnector/register_agent.json`
```json
Status: 200 OK
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3..."
}

```

#### Fehler
```json
400 Bad Request
{
    "error": "Field uuid or password is missing in POST data"
}
```

```json
403 Forbidden
{
    "error": "The given UUID is already registed with a password!"
}
```

```json
404 Not Found
{
    "error": "No Agent found for given UUID and password"
}
```

```json
405 Method Not Allowed
{
    "message": "Method Not Allowed",
    "url": "\/agentconnector\/register_agent.json",
    "code": 405
}
```

---

### POST /agentconnector/submit_checkdata.json
Wird verwendet, um Prüfergebnisdaten an den openITCOCKPIT-Überwachungsserver zu übertragen

#### Push check results
Anfrage: POST `/agentconnector/submit_checkdata.json`
```json
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3...",
    "checkdata": {
        "agent":        {},
        "cpu":          {},
        "customchecks": {},
        "disk_io":      {},
        "disks":        {},
        ...
    }
}
```
Antwort:
```json
Status: 200 OK
{
    "received_checks": 10
}
```

#### Fehler
```json
400 Bad Request
{
    "error": "Invalid credentials or host not found"
}
```

```json
405 Method Not Allowed
{
    "message": "Method Not Allowed",
    "url": "\/agentconnector\/submit_checkdata.json",
    "code": 405
}
```