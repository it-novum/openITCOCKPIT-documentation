# Zeitabschnitte

Zeitabschnitte stellen in openITCOCKPIT eine zentrale Komponente, die für vielfältige Aufgaben genutzt werden können. Sie definieren feste Zeitabschnitte innerhalb einer Woche. Diese können beispielsweise für Benachrichtigungszeiträume, Prüfzeiträume oder Host und Serviceabhängigkeiten genutzt werden. Über Kalender können zusätzlich Feiertage mit berücksichtigt werden.

### Zeitabschnitt erstellen
Um einen Zeitabschnitt zu erstellen, Navigieren Sie im Hauptmenü nach `Monitoring -> Objekte -> Zeitabschnitte` und klicken dort in der übersicht auf die Schaltfläche "Neu"

![timeperiod overview](/images/timeperiod-overview.png)


In dem sich öffnenden Formular wählen Sie einen Container aus und vergeben einen Namen für den Zeitabschnitt.

Danach können Sie einen benutzerdefinierten Kalender mit aufnehmen. Die dort eingetragenen Feiertage werden bei den ausgewählten Zeitbereichen mit berücksichtigt.

Bei den Zeitbereichen können über die Schaltfläche "Hinzufügen" neue Bereiche hinzugefügt werden. Diese definieren Wochentage mit einem Start und einem Endzeitpunkt. Alles, was dort nicht definiert ist, liegt außerhalb des Zeitabschnittes. Wird dir Zeitabschnitt beispielsweise von E-Mail Benachrichtigungen genutzt, so wird bei einem Benachrichtigungsfall außerhalb des definierten Zeitbereiches keine E-Mail Benachrichtigung versendet. 

![timeperiod new](/images/timeperiod-new.png)


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | [Container](../container/), für den der Zeitabschnitt sichtbar sein soll |
| Name | :fontawesome-solid-xmark: | Name des Zeitabschnittes |
| Beschreibung |  | Beschreibung des Zeitabschnittes |
| Kalender | :fontawesome-solid-xmark: | [Kalender](../calendar/) |

