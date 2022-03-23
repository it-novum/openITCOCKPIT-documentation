## Grundlegende Verwendung der API

!!! warning "Authentifizierung"
    Als Authentifizierungsmethode mit der API empfehlen wir dringend die Benutzung von API Keys. 

### API Keys

Um einen API-Key zu erstellen, müssen Sie die Einstellungen zu Ihrem Profil öffnen. Dazu klicken Sie in openITCOCKPIT auf Ihren Namen.

![apikey profile](/images/profile.png)

Scrollen Sie in den Profileinstellungen bis zu dem Punkt "API-Keys" und klicken Sie auf die Schaltfläche "Erstelle neuen API-Key".

![new api key](/images/profile-newapikey.png)

Für den API Key muss nur eine Beschreibung vergeben werden. In dem Feld "API key (nur lesbar)" wird der API Key erzeugt und kann dort herauskopiert werden. Auf wunsch kann man über die Schaltfläche "Generiere neuen API-Key" einen neuen Schlüssel generieren lassen.

![generate new api key](/images/profile-newapikeypen.png)

Zum Schluss muss nur noch auf Speichern gedrückt werden und der API-Key ist erstellt.

Die erstellten API-Keys können über die Liste "API keys" eingesehen werden.

### Beispiele
Die folgenden Beispiel zeigen, wie man mit unterschiedlichen Programmiersprachen eine HTTP POST Anfrage an die openITCOCKPIT API senden kann.

#### PHP
```sh
# Install Composer
 
curl -sS https://getcomposer.org/installer | php
 
# Install Guzzle
php composer.phar require guzzlehttp/guzzle:~6.0
```

```php
<?php
require_once 'vendor/autoload.php';
 
$client = new GuzzleHttp\Client([
    'base_uri'        => 'https://demo.openitcockpit.io',
    'headers'         => [
        'Content-Type' => 'application/json',
        'Authorization' => 'X-OITC-API d2083e61fee067077ac239b7d89084f31c16a66f5e2908f6f74009492b600d3d90db2c5f6175ff199c31e1adbdcf6cf089ecadaf1c93c776bc19c7f41feb42b58f2637883b1a1273035f0ade592415f5'
    ],
    'verify'          => false,
    'cookies'         => true,
    'connect_timeout' => 5,
    'timeout'         => 10
]);
try {
    $response = $client->post("/hosts/add.json",
        [
            'body' => json_encode(
                [
                    'Host' =>
                    [
                        'name' => 'api host',
                        'address' => '127.0.0.1',
                        'container_id' => 1,
                        'hosttemplate_id' => 1,
                        'notification_interval' => NULL,
                        'check_interval' => NULL,
                        'Hostgroup' => [],
                        'retry_interval' => NULL,
                    ],
                ]
            )
        ]
    );
    $response_content = json_decode($response->getBody()->getContents(), true);
    if(isset($response_content['id'])){
        printf('Host was created successfully. Host ID is: %s%s', $response_content['id'], PHP_EOL);
    }
} catch (Exception $e) {
    echo 'Exception catched: ' . $e->getMessage() . PHP_EOL;
}
```

#### Python
```python
#!/usr/bin/python3

import json
import traceback
import requests
import urllib3
import re
import sys
import time

oitc_url="https://demo.openitcockpit.io"
oitc_apikey="d2083e61fee067077ac239b7d89084f31c16a66f5e2908f6f74009492b600d3d90db2c5f6175ff199c31e1adbdcf6cf089ecadaf1c93c776bc19c7f41feb42b58f2637883b1a1273035f0ade592415f5"

class ApiExample():

    def run(self):
        self.oitc_url = oitc_url
        self.apikey = oitc_apikey

        result = self.send_post_request(
            url="/hosts/add.json",
            data={
                "Host": {
                    "name": 'api host',
                    "address": '127.0.0.1',
                    "container_id": 1,
                    "hosttemplate_id": 1,
                    "notification_interval": None,
                    "check_interval": None,
                    "Hostgroup": [],
                    "retry_interval": None,
                }
            }
        )

        if "id" in result:
            print("Host was created successfully. Host ID is: %s\n" % result['id'])
        else:
            print(result)


    def send_post_request(self, url, data, cookies=None):
            try:
                urllib3.disable_warnings()
            except:
                print(traceback.format_exc())

            url = self.oitc_url + url

            headers = {
                'Content-Type': 'application/json',
                'Authorization': 'X-OITC-API ' + self.apikey
            }

            try:
                response = requests.post(
                    url,
                    json=data,
                    headers=headers,
                    verify=False,
                    cookies=cookies
                )

                # response_body = response.content.decode('utf-8')
                # print(response_body)

                if response.status_code != 200:
                    print("Error while saving data :(")
                    print(response.content.decode('utf-8'))

                if response.content.decode('utf-8').strip() != '':
                    if cookies is None:
                        # Save the PHP Session cookie - (only important für Checkmk Module)
                        # Only store the cookies if we do not already have one stored (only store on the first request)
                        self.cookies = response.cookies
                    return json.loads(response.content.decode('utf-8'))

            except Exception as e:
                print(str(e))
                print(traceback.format_exc())


if __name__ == '__main__':
    ApiExample().run()

```

## Scroll- oder Paginator-Modus nutzen

openITCOCKPIT bietet zwei unterschiedliche Methoden, Daten geordnet als Listen abzufragen.
#### Scroll Modus (empfohlen)

Wir empfehlen den Scroll-Modus für alle API Anfragen auf `/index` Endpunkte und für Suchanfragen.

Im Scroll-Modus enthält die Antwort keine genaue Zählung, wie viele Objekte in der Datenbank für die angegebenen Filter gefunden wurden. Dies verkürzt die Antwortzeit der API deutlich.


Um festzustellen, ob weitere Datensätze verfügbar sein könnten, gibt die API das `hasNextPage`-Feld zurück. 
Um den Scroll-Modus zu aktivieren, wird `scroll=true` an die URL angefügt.

```json
{
  "scroll": {
    "page": 1,
    "limit": 50,
    "offset": 0,
    "hasPrevPage": false,
    "prevPage": 1,
    "nextPage": 2,
    "current": 1,
    "hasNextPage": false
  }
}
```

#### Paginator-Modus
Standardmäßig werden API-Anfragen im Paginator-Modus ausgeführt. Die API-Antwort enthält eine genaue Anzahl
wie viele Objekte in der Datenbank gefunden wurden.

Diese Anfrage ist langsamer in der Ausführung.

```json
{
  "paging": {
    "page": 1,
    "current": 11,
    "count": 11,
    "prevPage": false,
    "nextPage": false,
    "pageCount": 1,
    "limit": 50,
    "options": [],
    "paramType": "named",
    "queryScope": null
  }
}
```

## API Abfragen mit dem Webbrowser generieren
Aufgrund der Tatsache, das die openITCOCKPIT Oberfläche ausschließlich über die HTTP-API mit dem Backend kommuniziert, kann der Browser als ein Generator für API-Anfragen genutzt werden.


### Mozilla Firefox

#### 1. Browser Konsole öffnen
Drücken Sie Dazu `F12` (Windows/Linux) oder `Alt + Cmd + i` (macOS).
Wählen Sie die Registerkarte `Console` und stellen Sie sicher, das `XHR` aktiviert ist.


![Firefox Dev-Console XHR](/images/api/ff_dev_console.png)

#### 2. Filter setzen
Öffnen Sie eine beliebige Unterseite von openITCOCKPIT und erstellen Sie den gewünschten Filter.
Diese Methode funktioniert mit jeder Unterseite und jeder Aktion, welche über das Webfrontend ausgeführt werden kann.

![Liste filtern](/images/api/oitc_filter.png)

#### 3. Abfrage inspizieren

Die vom Webfrontend gesendete Anfrage, sowie die vom openITCOCKPIT Server geschickte Antwort, kann nun bequem im Browser betrachtet werden. Somit ist es möglich, das Frontend als Generator für API Anfragen zu nutzen.

![Firefox openITCOCKPIT API request](/images/api/ff_request.png)


### Google Chrome

#### 1. Browser Konsole öffnen
Drücken Sie Dazu `F12` (Windows/Linux) oder `Alt + Cmd + i` (macOS).
Wählen Sie die Registerkarte `Console` und stellen Sie sicher, das `Log XMLHttpRequests` aktiviert ist.


![Google Chrome Dev-Console XHR](/images/api/gc_dev_console.png)

#### 2. Filter setzen
Öffnen Sie eine beliebige Unterseite von openITCOCKPIT und erstellen Sie den gewünschten Filter.
Diese Methode funktioniert mit jeder Unterseite und jeder Aktion, welche über das Webfrontend ausgeführt werden kann.

![Liste filtern](/images/api/oitc_filter.png)

#### 3. Abfrage inspizieren

Die vom Webfrontend gesendete Anfrage, sowie die vom openITCOCKPIT Server geschickte Antwort, kann nun bequem im Browser betrachtet werden. Somit ist es möglich, das Frontend als Generator für API Anfragen zu nutzen.

![Google Chrome openITCOCKPIT API request](/images/api/gc_request.png)

## API Dokumentation

Die API Dokumentation finden Sie hier [openITCOCKPIT API Dokumentation](https://openitcockpit.io/api/)
