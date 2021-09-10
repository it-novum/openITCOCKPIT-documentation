# Verteiltes Monitoring und Satelliten <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Das Distribute Modul ermöglicht ein verteiltes Monitoring mit Satellitensystemen. Die Satellitensysteme sind keine vollwertigen openITCOCKPIT instanzen, sondern werden über spezielle Pakete installiert.

Die Satelliten überwachen Ihre Systeme eigenständig und, je nach Synchronisationseinstellungen, werden die Ergebnisse an das Mastersystem (openITCOCKPIT) geschickt oder von diesem abgeholt.

## Voraussetzung

Für die Nutzung des Distribute Modul ist eine Enterprise Lizenz nötig.

## Satelliten in openITCOCKPIT anlegen

Um einen Satelliten in openITCOCKPIT anzulegen, klicken Sie im Hauptmenü auf Systemkonfiguration → System → Satelliten.

in der Satelliten Übersicht klicken Sie anschließend auf die Schaltfläche "Neu".

Anschließend wählen Sie einen Container aus, vergeben einen Namen für den Satelliten und tragen die IP adresse oder Hostname in das Feld "IP-Adresse" ein.

Satelliten können in drei verschiedenen Sychronisationsmodi betrieben werden:
### Synchronisationsmethoden
##### HTTPS-Pull

Das Mastersystem ruft regelmäßig Prüfergebnisse vom Satelliten ab und pusht Konfigurationsänderungen.

Hier muss die URL des Satelliten, sowie die weiteren Parameter des HTTP(s) aufrufs angegeben werden. Zudem kann ausgewählt werden, ob das SSL Zertifikat überprüft wird und ob der Proxy aktiviert werden soll.

Danach muss ein API Schlüssel erstellt und eingetragen werden und das Intervall in sekunden in welchem das Mastersystem die Prüfergebnisse aufnimmt.

##### HTTPS-Push

Das Satellitensystem überträgt die Prüfergebnisse an das Master-System und sucht regelmäßig nach Konfigurationsänderungen.

Hierfür muss lediglich ein API Schlüssel eingetragen werden.

##### SSH

Das Mastersystem erstellt einen SSH-Tunnel zum Satellitensystem, ruft die Prüfergebnisse ab und überträgt Konfigurationsänderungen.

Im SSH Modus wird ein Benutzername, Port sowie der Private Key Path für die Verbindung benötigt. Es muss vorher ein SSH Key austausch für den angegebenen Benutzer vom Mastersystem zum Satelliten stattgefunden haben.

Zudem muss noch der Remote Port des auf dem Satelliten laufenden Gearman angegeben werden.

für alle Synchronisationsmethoden steht im letzten Schritt der erstellung noch die Möglichkeit zum Einstellen der Zeitzone sowie die Synchronisation der Zeit zur verfügung.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | [Container](../container/) in dem der Satellit erstellt werden soll  |
| Satellitenname | :fontawesome-solid-times: | Name des zu erstellenden Satelliten |
| IP-Adresse | :fontawesome-solid-times: | IP-Adresse oder Hostname des Satelliten. Diese Adresse wird für die gesamte Kommunikation zwischen der Master-Instanz und dem Satellitensystem verwendet |
| Synchronisationsmethode | :fontawesome-solid-times: | [Synchronisationsmethode](#synchronisationsmethoden) die die Art der Datenübertragung bestimmt |
| Zeitzone | :fontawesome-solid-times: | Zeitzone des Satelliten |
| Zeitsynchronisation |  |  Legt fest, ob Sie die Systemuhr des Master-Servers mit dem Satellitensystem synchronisieren möchten. Hinweis: Es wird nicht empfohlen, diese Option zu aktivieren. Bitte verwenden Sie nach Möglichkeit einen NTP-Server.  |
| HTTPS PULL-Modus |
| URL | :fontawesome-solid-times: | Satellit URL |
| Überprüfe das Zertifikat |  | nur valide Zertifikate werden akzeptiert |
| Aktiviere Proxy |  | Bestimmt ob der weiter unten eingetragene Proxy für die verbindung mit dem Satellitensystem genutzt werden soll |
| Proxy URL |  | Proxy Server URL |
| API Schlüssel | :fontawesome-solid-times: | API Key Authentifizierung für den Satellit |
| Intervall |  | Zeitintervall in Sekunden, in welchem das Mastersystem die Prüfergebnisse aufnimmt |
| Timeout |  | Zeitlimit in Sekunden, das definiert, wann der Satellit als OFFLINE markiert werden soll. |
| HTTPS PUSH-Modus |
| API Schlüssel | :fontawesome-solid-times: | API Key Authentifizierung für den Satellit |
| Timeout |  | Zeitlimit in Sekunden, das definiert, wann der Satellit als OFFLINE markiert werden soll. |
| SSH |
| Anmelden | :fontawesome-solid-times: | Benutzer mit dem sich über SSH auf dem Satellitensystem angemeldet werden soll |
| Port | :fontawesome-solid-times: | SSH-Port des Remote-Computers. |
| PrivateKeyPath | :fontawesome-solid-times: | Wir verwenden einen Standardpfad zum privaten Schlüssel, wenn dieses Feld leer bleibt |
| RemotePort |  | Gearman-Port der Remote-Maschine. |

## Host auf einem Satelliten erstellen

Um einen Host auf einem Satelliten zu erstellen, erstellen Sie wie gewohnt einen Host. Der einzige Unterschied darin, dass nun im Feld "Satellit" nicht mehr das Mastersystem, sondern der gewünschte Satellit ausgewählt wird.

![](/images/host-satellite.png)