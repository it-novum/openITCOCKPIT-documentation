## Checkmk

openITCOCKPIT bietet mit dem modul CheckmkModule eine Integration von Checkmk an.

Diese Bietet eine Serviceerkennung für Hosts an und kann direkt über das "Host hinzufügen Formular", oder aber bei einem bestehenden Host über die Host-Übersichtsseite gestartet werden.

### Checkmk Erkennung (Discovery)

Wenn Sie einen Host anlegen, können Sie direkt nach dem Speichern eine Checkmk Serviceerkennung Starten. Dies erreichen Sie über den button "Speicher und Checkmk Erkennung ausführen" im Host erstellen Formular.

Sie können anschließend den gewünschten Checkmk Agenten aus einer Liste auswählen. Diese Agenten können entweder die vorgefertigten "Führe Remoteerkennung aus" und "Führe SNMP Erkennung aus" oder aber auch selbst definierte sein.

### Checkmk Agent erstellen

Um einen Checkmk Agenten zu erstellen, Navigieren Sie im Hauptmenü nach Checkmk → Checkmk Agenten

Dort klicken Sie in der Übersicht auf die Schlatfläche "Neu"

Danach wählen Sie einen Container aus, vergeben einen namen und tragen anschließend ein Kommandozeilenbefehl ein. Dieser Kommandozeilenbefehl verweist auf ein Checkmk Skript auf dem openITCOCKPIT Server.