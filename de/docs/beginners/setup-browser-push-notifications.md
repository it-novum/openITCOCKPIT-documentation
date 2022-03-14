# Browser Push-Benachrichtigungen einrichten

Die meisten modernen Webbrowser wie Mozilla Firefox, Google Chrome oder Microsoft Edge bieten eine Benachrichtigung-API
an.

openITCOCKPIT kann diese API nutzen, um Host- oder Servicebenachrichtigungen zu Ihrem Browser zu senden.

Beispiele:

![browser notifications](/images/example_browser_notifications.png)

## Voraussetzungen

- Moderner Webbrowser
- manuelles Setzen der Berechtigungen im Browser
- openITCOCKPIT muss in einem Browser Tab geöffnet sein (Browserfenster kann im Hintergrund oder der Taskbar laufen)
- ein Kontakt muss einem Benutzer zugewiesen sein
- `Push-Benachrichtigungen an den Browser` muss in der Kontaktkonfiguration aktiviert sein
- `push_notification.service` Service muss auf dem openITCOCKPIT Server laufen

## Push-Benachrichtigungen einrichten

### Browser Berechtigungen

Bevor openITCOCKPIT Push-Benachrichtigungen an Ihren Webbrowser senden kann, müssen Sie manuell die Berechtigung dafür
erteilen. Dies ist ein Sicherheitsfeature aller Browser, um zu verhindern, dass wahllos irgendwelche Webseiten
Spamnachrichten senden können. Sie können diese Benachrichtigungen erlauben oder verwehren, wann immer Sie wollen.

In diesem Beispiel zeigen wir den Prozess anhand des Mozilla Firefox.

#### Berechtigung erteilen

Klicken Sie auf das Benachrichtigungssymbol in der Browser Adressleiste und klicken Sie anschließend auf 
"Benachrichtigungen erlauben".

![browser ask for permissions](/images/browser_ask_for_notification_permissions.png)

!!! info 
    Wenn Sie die Berechtigung zu einem späteren Zeitpunkt wieder entfernen, deaktivieren Sie
    auch `Push-Benachrichtigungen an den Browser` in der Kontakt-Konfiguration

## Editieren oder Neuerstellen eines Kontaktes

Um Push-Benachrichtigungen erhalten zu können, müssen Sie Ihr Benutzerkonto mit einem Kontakt der Monitoring Engine
verknüpfen. Standardmäßig ist kein Kontakt zu einem Benutzerkonto, dass in der openITCOCKPIt Oberfläche existiert,
verlinkt.

Navigieren Sie nach `Monitoring -> Objekte -> Kontakte` und wählen Sie den Kontakt, für den Sie die
Push-Benachrichtigungen aktivieren wollen, aus.

Weisen Sie ihren Benutzer dem Kontakt zu und aktivieren die Option `Push-Benachrichtigungen an den Browser`.

!!! info 
    Das Kommando `host-notify-by-browser-notification` und/oder `service-notify-by-browser-notification` wird
    automatisch ausgewählt. Sollten die Kommandos fehlen, lesen Sie den [Troubleshooting](#troubleshooting) Teil dieses
    Artikels

Sie können auch verschiedene Benachrichtigungskommandos kombinieren, wie zum Beispiel `notify by email` und `browser
notifications` etc.

![contact browser push notfications](/images/contact-browser-push-notifications.png)

Nachdem Sie den Kontakt aktualisiert haben, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

## Benachrichtigunsbeispiele

Jede Benachrichtigung beinhaltet ein Icon für einen Host oder Service. Der jeweilige Status wird von der Farbe des Icons
dargestellt. Klickt man auf eine Benachrichtigung, so öffnet sich ein neuer Browser-Tab und man wird direkt zu dem
betreffenden Host oder Service weitergeleitet. Die Benachrichtigung verschwindet automatisch nach ein paar Sekunden.

![browser notifications](/images/example_browser_notifications.png)

*Hinweis: Das Benachrichtigungsdesign ist abhängig vom Betriebssystem des Benutzers. Benachrichtigungen sehen
möglicherweise auf anderen Betriebssystemen anders aus. Es gibt keine möglichkeit den Stil zu verändern*

## Troubleshooting

- Laden Sie die Seite neu: `Strg + R` oder `Cmd + R`

- Verbindungsprobleme. Wenn Ihr Browser die Verbindung zum openITCOCKPIT Server verliert, kann es möglich sein, dass Sie
  keine Push-Benachrichtigungen mehr erhalten. Laden Sie die Seite neu um das Problem zu beheben.

- `push_notification` Dienst läuft nicht. Dieser Hintergrundprozess muss laufen. Zudem kann auch die Webserver oder
  Reverse Proxy Konfiguration Probleme verursachen. Sie können die Entwicklerwerkzeuge Ihres Webbrowsers nutzen, um
  eventuelle Verbindungsfehler zu entdecken: Fehlermeldung: `push_notification` not running

![push connection error](/images/push_connection_error.png)

Erfolgreich verbunden:

![push connection successful](/images/push_connection_successfully.png)

Läuft der `push_notification` Dienst nicht, wird auf der Fehlerbeseitigungs-Seite und in der Systemzustandsanzeige eine
Warnung erscheinen.

![debug push notifications](/images/debug-processes-push-notifications.jpg)

- Manche Anwendungen unterdrücken Browser Benachrichtigungen. Beispielsweise unter Microsoft Windows 7 in Kombination
  mit dem `Snipping Tool`. Ein Neuladen der openITCOCKPIT Webseite behebt das Problem

- macOS läuft möglicherweise im *Nicht Stören* Modus. Dies kann auch automatisch geschehen beispielsweise beim Verbinden
  eines Beamers oder TV Bildschirm.

![macos dnd](/images/macOS_dnd.png)

- Zu viele Benachrichtigungen können auch ein Unterdrücken der Benachrichtigungen auslösen. Versuchen Sie die Anzahl der
  Push-Benachrichtigungen zu reduzieren.

- Überprüfen Sie Ihren Webbrowser auf Updates.

- Funktionieren die Benachrichtigungen im Internet Explorer? Nein.
