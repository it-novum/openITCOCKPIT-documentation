# Paketmanager

Der Paketmanager in openITCOCKPIT ermöglicht es Module in openITCOCKPIT zu installieren. Diese Module sind entweder frei verfügbar oder über eine Subskription erhältlich. Die Module sind farblich gekennzeichnet. Freie Module werden Blau dargestellt, Enterprise Module hingegen rot.

## Voraussetzung

Um den Paketmanager benutzen zu können wird eine Valide Lizenz vorausgesetzt. Um Zugriff auf die Freien module zu haben, benötigt man mindestens eine Community Lizenz welche man auf der [openitcockpit.io webseite](https://openitcockpit.io/download_server/) findet. Diese Lizenz muss in openITCOCKPIT eingetragen werden. 

Zudem muss ein Zugang auf die Konsole des Servers gewährleistet sein.

## Installation von Modulen

Die Installation von modulen gestaltet sich einfach. Auf der Übersichtsseite des Paketmanagers sind die verschiedenen Module aufgelistet. Um ein einzelnes Modul zu installieren, klicken Sie auf die schaltfläche “Installieren” des jeweiligen Moduls. Es öffnet sich ein Fenster in dem die benötigten Befehle für die Paketverwaltung des Betriebssystems des openITCOCKPIT Servers angezeigt werden. 

![packagemanager single install](images/packagemanager-installpackages.png)

Den Text innerhalb des Schwarzen bereiches kopiert man sich heraus und fügt ihn in der Konsole des Servers ein. Die Paketverwaltung des Betriebssystems übernimmt den Rest. Wenn die Installation fertiggestellt wurde erscheint der text `Installation done. Please reload your openITCOCKPIT web interface.` in der Konsole.

Um mehrere Module gleichzeitig zu installieren klickt man anstatt auf “Installieren” auf die checkbox daneben. Es öffnet sich wieder das Fenster wie im Screenshot. Dieses kann man schließen und das nächste Modul anhaken. Die Befehle erweitern sich automatisch. Wenn man alle gewünschten Module angehakt hat, kopiert man die Befehle wieder und fügt Sie in der Konsole des Servers ein. Wenn die Installation fertiggestellt wurde erscheint der text `Installation done. Please reload your openITCOCKPIT web interface.` in der Konsole.

![packagemanager multiinstall](images/packagemanager-installpackagesmulti.png)