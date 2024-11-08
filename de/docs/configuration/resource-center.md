# Service Capacity Management Modul (Ressourcen - Verwaltung Modul) <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Das Service Capacity Management kann über den Paketmanager von openITCOCKPIT installiert werden.
Navigieren Sie zu `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *ScmModule*

Mit Service Capacity Management haben Provider die Möglichkeit den Status ihrer Ressourcen (z.B. IT-Services) zu einem
festgelegten Zeitpunkt zu kommunizieren, um somit mögliche Engpässe besser zu kanalisieren.

## Globale Einstellungen

In diesem Bereich wird festgelegt, bis zu welchem Zeitpunkt (Deadline) der Status einer Ressource spätestens
kommuniziert werden muss. Ein Cronjob prüft, ob zu jeder Ressource ein Status kommuniziert wurde. Die Erinnerungszeit (
in Minuten) legt fest, in welchen Zeitraum eine Erinnerungsmail an die Provider mit fehlendem Status verschickt werden
soll. Zusätzlich kann festgelegt werden, ob ein bereits gesetzter Status überschrieben werden kann (<b>"Allow status
overwriting"</b>). Eine weitere Einschränkung der Statuskommunikation kann über die Einstellung "<b>Require user
assigment</b>" festgelegt werden. Wenn diese Checkbox aktiv ist, ist es nur den zugewiesenen Benutzer erlaubt einen
Status zu setzen.

![Globale Einstellungen](/images/scm/scm_settings.png)

## Ressourcengruppen

Unter dem Menüpunkt `Administration -> Resource Center -> Resource Groups` gelangt man zu dem Konfigurationsbereich der
Ressourcengruppen.

![Menü Ressourcengruppen](/images/scm/scm_resourcegroups_menu.png)

Hier können neue Ressourcengruppen erstellt werden beziehungsweise werden bereits angelegte Ressourcengruppen
aufgelistet.

### Auflistung der Ressourcengruppen

![Ressourcengruppen Liste](/images/scm/scm_resourcegroups_list.png)

### Gesamtübersicht der Ressourcengruppen

Mit einem Klick auf den Button <code>SCM Board</code> gelangt, man zu der Gesamtübersicht über alle
Ressourcengruppen und Ressourcen.

![Ressourcengruppen Übersicht](/images/scm/scm_resourcegroup_summary_details_1.png)

Mit einem Klick auf eine bestimmte Ressourcengruppe wird eine detaillierte Sicht angezeigt.

![Ressourcengruppen Übersicht](/images/scm/scm_resourcegroup_summary_details_2.png)

### Neue Ressourcengruppe erstellen

Mit dem Klicken auf den <code>+ New</code> Button öffnet sich der Bereich, in dem man eine neue
Ressourcengruppe erstellen kann.

Über den Container legt man die Sichtbarkeit dieser Gruppe fest. Automatisch dient dieser, als Filter für die
Benutzerauswahl. Die Benutzerauswahl legt fest, welche Benutzer einen Status setzen dürfen. Die Unterteilung zwischen
Manager und Users legt fest, an wen eine Erinnerungsmail bei fehlendem Status verschickt wird. Eine Eskalation wird
ausgelöst, sollte auch nach dem Versand der Erinnerungsmail kein Status gesetzt werden. Die Eskalation geht an alle User
und Manager.

| Feld         | Erforderlich              | Beschreibung                                                                                                                  |
|--------------|---------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| Container    | :fontawesome-solid-xmark: | Über den Container legt man die Sichtbarkeit dieser Gruppe fest. Automatisch dient dieser, als Filter für die Benutzerauswahl |
| Name         | :fontawesome-solid-xmark: | Name der Ressourcengruppe                                                                                                     |
| Beschreibung |                           | Beschreibung der Ressourcengruppe                                                                                             |
| Benutzer     | :fontawesome-solid-xmark: | Benutzer die eine Erinnerungs- und Eskalationsmail bekommen                                                                   |
| Manager      | :fontawesome-solid-xmark: | Benutzer die eine Eskalationsmail bekommen                                                                                    |

#### Erinnerungsmail:

![Erinnerungsmail](/images/scm/scm_reminder_mail.png)

#### Eskalationsmail:

![Eskalationsmail](/images/scm/scm_escalation_mail.png)

Alle E-Mails werden in der Datenbank protokolliert und sind über den Menüpunkt „Notifications“ einsehbar. Die
Ressourcen-Namen in der E-Mail mit der openITCOCKPIT Weboberfläche verlinkt.

![Ressourcengruppen Benachrichtigungen](/images/scm/scm_resourcegroup_notifications.png)

## Ressource

Über den Menüpunkt `Administration -> Resource Center -> Resource` gelangt man zu der Übersichtsseite der einzelnen
Ressourcen. Mit dem Klicken auf den <code>My resources</code> Button wird die Liste nach eigenen Ressourcen gefiltert.
In der Liste bekommt man alle Details zu den einzelnen Ressourcen, sowie deren Statusinformationen.

Alle Resources sind nach Status sortiert.

![Ressourcen Übersicht](/images/scm/scm_resources_list.png)

Unbestätigte Ressourcen werden zuerst angezeigt.
Eine Ressource kann einen der folgenden Status haben:

| Status | Info              |
|--------|-------------------|
| 🟦     | - unbestätigt (0) |
| 🟩     | - ok (1)          |
| 🟧     | - warning (2)     |
| 🟥     | - critical (3)    |

Über den Menüpunkt `Set status for selected` kann der Status für mehrere Ressourcen gesetzt werden. Alternativ kann auch
nur der Status für eine Ressource gesetzt werden.

![Status setzen](/images/scm/scm_set_status.png)

Jeder übermittelte Status wird protokolliert und ist über den Menüpunkt „Status log“ einsehbar.

![Ressourcen Statuslog](/images/scm/scm_statuslog.png)

Wie auch bei der Ressourcengruppe wird mit dem Klicken auf den Button <code>+ New</code> eine neue Ressource erstellt.
In der Auswahl wählt man die zugehörige Ressourcengruppe. Name der Ressource ist als Pflichtfeld definiert. Die
Beschreibung ist optional.

![Ressource hinzufügen](/images/scm/scm_resource_add.png)

| Feld             | Erforderlich              | Beschreibung                |
|------------------|---------------------------|-----------------------------|
| Ressourcengruppe | :fontawesome-solid-xmark: | Zugehörige Ressourcengruppe |
| Name             | :fontawesome-solid-xmark: | Name der Ressource          |
| Beschreibung     |                           | Beschreibung der Ressource  |

Alle Änderungen an der Ressource sowie Ressourcengruppen werden protokolliert und sind über den Menüpunkt `Changelog`
einsehbar.
![Ressourcen Changelog](/images/scm/scm_changelog_resource.png)

Alle Änderungen der ScmModule - Objekte sind über Menüpunkt `Logs -> Changelog ->  Scm Module Changes` einsehbar.

![Scm Modul Changelog](/images/scm/scm_changelog.png)

## Dashboards

Ein eigens erstelltes Widget für das Dashboard ermöglicht es den Benutzern, immer den aktuellen Status der ihnen
zugewiesenen Ressourcen zu sehen.

![Meine Ressourcen Widget hinzufügen](/images/scm/scm_add_my_resources_widget.png)

Je nach Status wird immer eine passende Meldung angezeigt. Wie zum in diesem Beispiel:

![Meine Ressourcen Widget](/images/scm/scm_my_resources_widget.png)

Für den Fall, dass die Deadline überschritten ist, aber noch nicht zu allen Ressourcen ein Status übermittelt wurde,
wird ein Hinweis angezeigt.

![Meine Ressourcen Widget mit Infotext](/images/scm/scm_my_resources_widget_with_info.png)
