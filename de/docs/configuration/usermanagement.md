## Benutzer verwalten

Benutzer in openITCOCKPIT werden hier verwaltet.

In der Übersichtsseite findet man neben der Tabellarischen auflistung aller in openITCOCKPIT vorhandenen Benutzer auch die möglichkeit das Passwort eines Benutzers zurückzusetzen.

### Neuen Benutzer anlegen

Um einen neuen Benutzer anzulegen, klicken Sie auf die Schaltfläche "Neuer Lokalen Benutzer"

Im sich nun öffnenden Formular wählen Sie zunächst die entsprechenden Container / Container Rollen aus, auf die der Benutzer zugriff haben soll.

Sie können auch Container und Container Rollen auswählen. Hierbei ist zu beachten, dass Einzeln zugewiesene Container die Berechtigungen von Containerrollen überschreiben. Dies beutet, wenn ein Benutzer über eine Container-Rolle lese und schreibrechte besitzt, kann dieses recht über den einzeln ausgewählten Container verändert werden. Dies hat den Vorteil, dass Berechtigungen für einzelne Container nicht in einer komplett neuen Container-Rolle definiert werden müssen.

![container roles](/images/manageusers-containerroles.png)

Anschließend wählt man für den neuen Benutzer eine Benutzerrolle und setzt ihn auf "Ist aktiv". Ist für einen Benutzer die auswahl box "ist aktiv" nicht gesetzt, kann sich dieser Benutzer nicht mehr in openITCOCKPIT Anmelden.

Neben den Standardfeldern E-Mail-Adresse, Vorname, Nachname, Unternehmen, Position und Telefonnummer hat man hier die möglichkeit standardparameter festzulegen wie das Datumsformat, Zeitzone und die Sprache der Benutzeroberfläche. Diese können vom Benutzer selbst auch über seine Profileinstellungen geändert werden.

Zudem kann man hier dem Benutzer schon API Keys für die API-Key authentifizierung erstellen.

### Neuen Benutzer anlegen (Active Directory / LDAP)

Grundsätzlich funktioniert die erstellung eines Benutzers über LDAP ähnlich der erstellung eines Lokalen Benutzers. Wählen Sie "Importiere von LDAP" um einen neuen Benutzer über LDAP hinzuzufügen.

Jedoch wird hier anstatt der E-Mail-Adresse, Vorname und Nachname anzugeben der SAM-Account-Name aus einer liste ausgewählt. E-Mail, Vorname und Nachname wird dann automatisch ausgefüllt. Auch ein Passwort wird hier nicht vergeben, da sich der neue Benutzer mit seinen LDAP zugangsdaten einloggt.

### Benutzerpasswort zurücksetzen

Um ein Benutzerpasswort zurückzusetzen, klicken sie auf der Übersichtsseite auf "Passwort zurücksetzen"

![reset password](/images/manageusers-resetpassword.png)

Der Benutzer bekommt eine E-Mail mit einem neuen Zufallsgeneriertem Passwort, mit dem er sich auf dem System anmelden kann.




## Benutzerrollen verwalten

Benutzerrollen in openITCOCKPIT repräsentieren das Rollenkonzept für Benutzerrechte. Hier wird bestimmt, was ein Benutzer, der diese Rolle zugewiesen bekommt, im openITCOCKPIT darf oder nicht darf.

## Neue Benutzerrolle anlegen

Um eine neue Benutzerrolle anzulegen, klicken Sie auf die schaltfläche "Neu"

Dort Vergeben Sie einen Namen und eine Beschreibung für die neue Benutzerrolle.

Weiter unten im Formular können Sie die entsprechenden Rechte vergeben. Die rechte können granular für einzelne Seiten und aktionen vergeben werden oder aber über die Schaltfläche "Massenaktionen" mehrere gleichzeitig.

Dort können dann entweder alle rechte, Index, Neu, Editier oder Lösch rechte vergeben werden, wobei Index, Neu Editieren und Löschen nacheinander angeklickt werden können, um für jede Seite diese zu aktivieren.

![userrole bulk actions](/images/manageuserroles-bulkactions.png)



## Benutzer Container Rollen

Benutzer Container Rollen sind Sammlungen von Containernberechtigungen, die zur für Benutzer in openITCOCKPIT genutzt werden können.

Eine Benutzer-Container-Rolle kann für die Berechtigung von Benutzern verwendet werden. Hierzu muss eine neue Benutzer-Container-Rolle erstellt werden.

### Benutzer Container Rolle erstellen

Beim Erstellen einer Benutzer-Container-Rolle vergibt man einen Namen und wählt die gewünschten Container aus.

![containerroles add](/images/usercontainerroles-add.png)

Für die Container vergibt man die entsprechenden Rechte (lesen oder schreiben/lesen). Nach dem Speichern kann die Benutzer Container Rolle verwendet werden.