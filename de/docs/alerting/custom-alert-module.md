# Custom Alert Module <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Das Custom Alert Module (benutzerdefinierte Alarme) von openITCOCKPIT kann als einfache Ticketing-Lösung verwendet werden. Anstatt Kontakte oder Kontaktgruppen direkt in der Konfiguration eines Hosts oder Services zu definieren, verwendet das Custom Alert Module ein regelbasiertes System. Jeder Host oder Service, der die definierten Bedingungen erfüllt, erstellt automatisch benutzerdefinierte Alarme.

Jeder Alarm kann von einem Benutzer kommentiert und somit bestätigt werden.

## Installation des Modules

Navigieren Sie zu `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *CustomalertModule*

Das Custom Alert Module ist eines der wenigen Module, welches eine manuelle Konfigurationsänderungen erfordern.
Öffnen Sie dafür `System -> Konfigurationsdatei Editor` und bearbeiten Sie die Datei  `/opt/openitc/nagios/etc/nagios.cfg`

Aktivieren Sie die Checkbox `statusengine_enable_ocsp` und speichern Sie die Konfiguration.

![statusengine_enable_ocsp option](/images/alerting/custom_alerts/statusengine_enable_ocsp.png)

!!! danger
    Verwenden Sie unbedingt den **Konfigurationsdatei-Editor** der openITCOCKPIT-Weboberfläche. Bitte ändern Sie **keine** Konfigurationsdateien manuell!

Öffnen Sie nun `Benutzerverwaltung -> Verwalte Benutzerrollen` und wählen Sie Ihre Benutzerrolle aus. Bitte stellen Sie sicher, dass Sie alle CustomalertModule-bezogenen Benutzerberechtigungen aktivieren.

![CustomAlertModule Benutzerberechtigungen](/images/alerting/custom_alerts/customalertmodule_user_permissions.png)

## Benutzerdefinierte Alarm Übersicht
![Benutzerdefinierte Alarm Übersicht](/images/alerting/custom_alerts/custom_alerts.png)

Alle benutzerdefinierten Alarme ohne Anmerkungsnachricht (Annotation) werden als „neuer Alarm" gekennzeichnet. Zusätzlich zeigt das System an, wie oft der jeweilige Alarm in den letzten 24 Stunden aufgetreten ist.
Benutzer können eine Anmerkung für einen bestimmten Alarm hinzufügen oder mehrere Alarme auswählen und eine Anmerkung für alle ausgewählten Alarme auf einmal hinzufügen.

Sobald ein Benutzer eine Anmerkung hinzugefügt hat, wird der Alarm als "in Bearbeitung" gekennzeichnet.

Wenn Sie einen an der Wand montierten Bildschirm verwenden möchten, empfehlen wir, die Option zum automatischen Aktualisieren zu aktivieren.

## Alarmverlauf
![Custom Alert Verlauf](/images/alerting/custom_alerts/custom_alerts_history.png)

Jeder benutzerdefinierte Alarm hat ein eigenes Protokoll. Das Protokoll beginnt, wenn eine Alarm erstellt wird, enthält alle Anmerkungen durch Benutzer und protokoliert auch das Schließen eines Alarms.

## Wann werden Alarme erstellt

Das Custom Alert Module verwendet die Ausgabe des Prüf-Plugins, um einen oder mehrere Alarme zu erstellen. Jede neue Zeile (`\n`) in der Ausgabe erstellt einen neuen Alarm.
Nehmen wir zum Beispiel an, das Check-Plugin eines Netzwerk-Switches gibt folgenden Fehler aus:
```
Switch Port 1 is down
Switch Port 2 is down
Switch Port 3 is down
```
openITCOCKPIT und das Custom Alert Module erstellen 3 verschiedene Alarme. Einen für jede neue Zeile.
Falls einer der Ports wieder in einen Up-Zustand wechselt und daher nicht mehr in der Plugin-Ausgabe enthalten ist, wird der Alarm automatisch geschlossen.

Zum Beispiel: Neue Ausgabe
```
Switch Port 1 is down
Switch Port 3 is down
```

Der Alarm `Switch Port 2 is down` wird vom System automatisch geschlossen, da der Fehler behoben wurde und nicht mehr in der Ausgabe vorhanden ist.
Wenn der Service in einen Ok-Zustand wechseln, werden alle Alarme im Zusammenhang mit diesem Service automatisch geschlossen.

Außerdem muss sich der Dienst in einem harten Zustand befinden.

## Umgang mit Downtimes und Acknowledgements
Wenn sich der Service in einer geplanten Wartung befindet (Downtime), wird openITCOCKPIT für diesen Service **keine** Alarme erstellen.

Wenn der Status des Services bereits bestätigt wurden (Acknowledgement), erstellt openITCOCKPIT für diesen Dienst **weiterhin** Alarme, setzt aber den Kommentar der Bestätigung
automatisch als Anmerkungsnachricht und der Alarm wird als "in Bearbeitung" markiert.


## Alarmregeln definieren

Im Gegensatz zu den _klassischen_ Benachrichtigungen werden benutzerdefinierte Alarme durch Regeln und nicht durch eine objektbasierte Konfiguration definiert.
Die Definition, welche Services vom Custom Alert Module verarbeitet werden soll kann über Hosttags, Servicestags oder einen regulären Ausdruck erfolgen.

Wenn die Option `Rekursiv` aktiviert ist, wird die Warnregel auch für alle Elemente in untergeordneten Containern verwendet.

Um Änderungen an den Alarmregeln zu übernehmen, muss eine `Aktualisierung der Überwachungskonfiguration` durchgeführt werden.

![Definition von benutzerdefinierter Alarmregeln](/images/alerting/custom_alerts/custom_alerts_rules.png)

## Hintergrundprozess
Die benutzerdefinierten Alarme werden von einem dedizierten Hintergrundprozess verarbeitet. Der Dienst kann über systemd gesteuert werden `systemctl status customalert_worker.service`

### Vordergrundmodus

Zu Debugging-Zwecken kann dieser Dienst auch im Vordergrund gestartet werden: `oitc CustomalertModule.custom_alert_worker -v`

Die Ausgabe wird ähnlich sein wie:
```
$ oitc CustomalertModule.custom_alert_worker -v
I'm subscribed to 120 services
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/74fd8f59-1348-4e16-85f0-4a5c57c7dd62. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/3844e17d-669f-4c37-9d0f-b41cc7a98730. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/b6e2faa5-ad53-4293-a9ff-057a00aad4bd. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/1d91b0eb-3e70-4984-82a3-e034eb7906d6. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/8b496afa-d1d4-4d19-8acc-790d5c7a087a. Process record: Yes
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/606ea810-b682-41ae-93d3-125c8d5b2ff0. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/8c387276-dc25-4bd4-8668-de7fe0422778. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/6fe3af81-6717-4842-a22b-7aa8dec146b1. Process record: Yes
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/2f0d2a18-dd05-4b32-bf94-b548ab53a3cc. Process record: Yes
Created 1 alerts. Closed 1 alerts.
Received servicecheck for 4d94bdcc-ed6d-41ae-8749-146e2093799a/87adaf1c-dce4-45c6-bdde-b7387409f538. Process record: Yes
Received servicecheck for 3c7fd6ce-f61b-4a67-853a-46c252d5439d/a817e7fd-e840-483c-8360-9a4f6d628508. Process record: Yes
Received servicecheck for 4703dc23-5a0d-41e6-a32b-13c0f97f8daa/fc6b84cf-42f5-4221-9cb4-7d210345da6d. Process record: Yes
Received servicecheck for bc593b86-7bc3-4ab5-a588-9acc6d0f4f61/d2ded165-27aa-4406-90c9-d71011ac9bd7. Process record: Yes
Received servicecheck for fc2342f7-f440-4099-92af-676c68d5f47a/9a29188b-340c-49e6-acd0-6749d123a4e6. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 58620809-3a69-452b-bc3f-876cf96132fa/1e909caa-97a8-4900-9f05-04d4d1144c24. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 3fd68d5f-306c-42d4-b9ee-7ff0432e55b6/25a4df9e-7ace-4171-8edc-c5f877a29b17. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for c36b8048-93ce-4385-ac19-ab5c90574b77/1b69c940-5d9a-4bb5-948c-eef3645cf3ce. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Received servicecheck for 6f397150-8fe8-46bb-8489-a014b1a9aad0/57318050-e049-4b25-a320-64f7ef9415bc. Process record: Yes
Received servicecheck for ad278e43-1280-4f21-a56b-218b8778a993/e3899e4c-21b9-4219-ace1-6b8f75dad7d0. Process record: Yes
Created 0 alerts. Closed 0 alerts.
Created 0 alerts. Closed 0 alerts.
```
