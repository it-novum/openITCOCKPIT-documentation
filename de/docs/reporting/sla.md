# SLA <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## SLA Konfiguration

Unter dem Menüpunkt `Administration -> SLA MAnagement -> SLAs` gelangt man zu dem SLA Konfigurationsbereich.
Hier können neue SLAs erstellt werden beziehungsweise werden bereits angelegte SLAs aufgelistet.

![SLA Übersicht](/images/sla/sla_list.png)

Für alle SLAs die bereits ausgewertet wurden, wird der aktuelle Wert angezeigt.

Damit ein SLA ausgerechnet werden kann, müssen neben dem Namen und Zeitraum, ein Auswertungsintervall und garantierte
Verfügbarkeit in Prozent angegeben werden. Falls gewünscht, kann ein Wert für eine vorzeitige Warnung eingetragen
werden.
Dieser Wert muss natürlich höher sein, als der Wert der garantierten Verfügbarkeit.

Für die SLA Auswertung wird immer der erste Tag des Auswertungsintervall genommen. Zum Beispiel für den `MONAT`
wird erster Tag des Monats und für die `WOCHE` Montag als Start der Auswertung genommen. Wenn der SLA an einem
bestimmten Tag anfangen soll, kann man das im `Startdatum` Feld eintragen.

![SLA kongigurieren](/images/sla/sla_configuration.png)

#### Basiskonfiguration

| Feld                          | Erforderlich | Beschreibung                                                                                         |
|-------------------------------|---|------------------------------------------------------------------------------------------------------|
| Container                     | :fontawesome-solid-xmark: | SLA Container                                                                                        |
| Name                          | :fontawesome-solid-xmark: | Name der SLA                                                                                         |
| Beschreibung                  |  | Beschreibung der SLA                                                                                 |
| Auswertungsintervall          | :fontawesome-solid-xmark: | TAG, WOCHE, MONAT, QUARTAL, JAHR                                                                     |
| Startdatum                    |  | Startdatum des SLAs                                                                                  |
| Garantierte Verfügbarkeit     | :fontawesome-solid-xmark: | Garantierte Verfügbarkeit in Prozent.                                                                |
| Warnen beim Wert              |  | Ab diesem Wert kann eine Warnung für das SLA angezeigt werden                                        |
| Zeitraum                      | :fontawesome-solid-xmark: | Zeitraum der bei der Auswertung berücksichtigt werden soll                                           |
| Berücksichtige Wartungszeiten |  | Bestimmt ob Wartungszeiten berücksichtigt werden sollen. Ausfälle in Wartungszeiten werden ignoriert |
| Reflexionszustand             | :fontawesome-solid-xmark: | Der auszuwertende Statustyp. Nur Hard-State oder Hard- und Soft-State                                |

Nach der Installation des SLA Moduls wird der Konfigurationsbereich der Hostvorlage beziehungsweise des Hosts um die
SLA Option erweitert. Der SLA kann immer entweder der Hostvorlage zugewiesen werden, damit sind alle Hosts, die diese
Vorlage verwenden automatisch im SLA. Alternativ kann der SLA natürlich auch direkt dem Host zugewiesen werden.

Über den Menüpunkt `Zugewiesene hosts` gelangt man zu der Liste mit allen Hosts, die einem SLA, entweder direkt oder
über die Hostvorlagen, angehören.

![Menüpunkte Zugewiesene hosts](/images/sla/sla_menu_affected_hosts.png)

In diese Liste kann man direkt sehen, wie die SLA zugewiesen wurde. Durch die direkte Verlinkung können Hostvorlagen
oder Hosts direkt bearbeitet werden. Durch die Filterung nach Hostnamen kann die Zahl der Listeneinträge reduziert
werden.

![Zugewiesene hosts](/images/sla/sla_affected_hosts.png)

Sobald SLA ausgewertet wird in der SLA Liste die Verfügbarkeit des SLAs angezeigt. Diese ist mit der SLA
Verfügbarkeitsübersicht verlinkt. Diese Übersicht kann auch über den Menüpunkt `Zeige details` erreicht werden.

![SLA Übersicht](/images/sla/sla_view_details.png)

Auf dieser Seite wird die aktuelle Verfügbarkeit des gesamten SLAs angezeigt. Der niedrigste Wert repräsentiert
die aktuelle Verfügbarkeit eines SLAs. Neben der aktuellen Verfügbarkeit werden alle relevanten Konfigurationsdetails
und eine Zusammenfassung angezeigt. In dem Balkendiagramm werden die Hosts aufsteigend mit der niedrigsten Verfügbarkeit
aufgelistet.

Im unteren Bereich werden alle Hosts und deren Services aufgelistet. Auch hier ist die Reihenfolge so gewählt, dass
Hosts mit der niedrigsten Verfügbarkeit zuerst aufgelistet werden. Auch die Services werden nach dieser Sortierung
angeordnet. Um die Suche nach bestimmten Hosts zu ermöglichen, wurden die Filter nach Hostnamen oder der Verfügbarkeit
hinzugefügt.

Alle Hosts, die einem SLA zugeordnet sind, erhalten im `Hosts ->Browser` Bereich eine eigene Verfügbarkeitsanzeige.

![SLA Verfügbarkeitsanzeige für Host](/images/sla/sla_host_browser.png)

Diese Anzeige wird immer angezeigt, sodass man immer aktuelle Verfügbarkeit des Hosts im Blick hat. Über diese Anzeige
gelangt man auch zu der detaillierten Ansicht der Host-Verfügbarkeit.

![SLA Host details](/images/sla/sla_host_browser_details.png)

In dieser Übersicht bekommt man nicht nur die Verfügbarkeit des Hosts, sondern auch der Services aufgelistet. Auch
einzelne Services haben eine eigene Verfügbarkeitsanzeige im  `Services ->Browser` Bereich.

![SLA Service details](/images/sla/sla_service_browser_details.png)

Auf der SLA Service Übersicht bekommt man zusätzlich eine Auflistung der letzten 10 Tage.
