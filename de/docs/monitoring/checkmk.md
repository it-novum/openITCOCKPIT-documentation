# Überwachung mit Checkmk <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

openITCOCKPIT bietet mit dem CheckmkModule eine Integration von Checkmk an.

Diese bietet eine Serviceerkennung für Hosts an und kann direkt über das "Host hinzufügen Formular", oder aber bei einem
bestehenden Host über die Host-Übersichtsseite gestartet werden.

## Checkmk Erkennung (Discovery)

Wenn Sie einen Host anlegen, können Sie direkt nach dem Speichern eine Checkmk Serviceerkennung Starten. Dies erreichen
Sie über den button "Speicher und Checkmk Erkennung ausführen" im Host erstellen Formular.

Sie können anschließend den gewünschten Checkmk Agenten aus einer Liste auswählen. Diese Agenten können entweder die
vorgefertigten "Führe Remoteerkennung aus" und "Führe SNMP Erkennung aus" oder aber auch selbst definierte sein.

## Checkmk Agent erstellen

Um einen Checkmk Agenten zu erstellen, Navigieren Sie im Hauptmenü nach Checkmk → Checkmk Agenten

Dort klicken Sie in der Übersicht auf die Schlatfläche "Neu"

Danach wählen Sie einen Container aus, vergeben einen namen und tragen anschließend ein Kommandozeilenbefehl ein. Dieser
Kommandozeilenbefehl verweist auf ein Checkmk Skript auf dem openITCOCKPIT Server.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | Container in dem der Checkmk Agent installiert werden soll |
| Name | :fontawesome-solid-times: | Name des Checkmk Agenten |
| Beschreibung |  | Beschreibung des Checkmk Agenten |
| Kommandozeile | :fontawesome-solid-times: | Kommandozeilenbefehl für das Checkmk Agenten Skript |