Das Distribute Modul ermöglicht ein verteiltes Monitoring mit Satellitensystemen. Die Satellitensystem sind keine vollwertigen openITCOCKPIT instanzen, sondern werden über spezielle Pakete installiert.

Die Satelliten überwachen Ihre Systeme eigenständig und, je nach Synchronisationseinstellungen, werden die Ergebnisse an das Mastersystem (openITCOCKPIT) geschickt oder von diesem abgeholt.

## Voraussetzung

Für die Nutzung des Distribute Modul ist eine Enterprise Lizenz nötig.

## Satelliten in openITCOCKPIT anlegen

Um einen Satelliten in openITCOCKPIT anzulegen, klicken Sie im Hauptmenü auf Systemkonfiguration → System → Satelliten.

in der Satelliten Übersicht klicken Sie anschließend auf die Schaltfläche “Neu”.

Anschließend wählen Sie einen Container aus, vergeben einen Namen für den Satelliten und tragen die IP adresse oder Hostname in das Feld “IP-Adresse" ein.

Satelliten können in drei verschiedenen Sychronisationsmodi betrieben werden:

##### HTTPS-Pull

Das Mastersystem ruft regelmäßig Prüfergebnisse vom Satelliten ab und pusht Konfigurationsänderungen.

Hier muss die URL des Satelliten, sowie die weiteren Parameter des HTTP(s) aufrufs angegeben werden. Zudem kann ausgewählt werden, ob das SSL Zertifikat überprüft wird und ob der Proxy Aktiviert werden soll.

Danach muss ein API Schlüssel erstellt und eingetragen werden. und der Intervall in sekunden in welchem das Master System die Prüfergebnisse aufnimmt.

##### HTTPS-Push

Das Satellitensystem überträgt die Prüfergebnisse an das Master-System und sucht regelmäßig nach Konfigurationsänderungen.

Hierfür muss lediglich ein API Schlüssel eingetragen werden.

##### SSH

Das Mastersystem erstellt einen SSH-Tunnel zum Satellitensystem, ruft die Prüfergebnisse ab und überträgt Konfigurationsänderungen.

Im SSH Modus wird ein Benutzername, Port sowie der Private Key Path für die Verbindung benötigt. Es muss vorher ein SSH Key austausch für den angegebenen Benutzer vom Mastersystem zum Satelliten stattgefunden haben.

Zudem muss noch der Remote Port des auf dem Satelliten laufenden Gearman angegeben werden.

für alle Synchronisationsmethoden steht im letzten Schritt der erstellung noch die Möglichkeit zum einstellen der Zeitzone sowie die Synchronisation der Zeit zur verfügung.

## Host auf einem Satelliten erstellen

Um einen Host auf einem Satelliten zu erstellen, erstellen Sie wie gewohnt einen Host. Der einzige unterschied besteht darin, dass nun im Feld “Satellit” nicht mehr das Mastersystem, sondern der gewünschte Satellit ausgewählt wird.

![](/images/host-satellite.png)