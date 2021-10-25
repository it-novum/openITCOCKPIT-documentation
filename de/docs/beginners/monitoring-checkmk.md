# Monitoring mit Checkmk <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

Checkmk ist nahtlos in die openITCOCKPIT Oberfläche integriert. Hosts auf denen der Checkmk Agent oder ein SNMP Exporter
läuft, können über die openITCOCKPIT Oberfläche gescannt werden. Zum Zweck dieses Tutorials werden wir ein Ubuntu Linux
System überwachen.

### Checkmk Modul für openITCOCKPIT installieren

Die Checkmk Erweiterung für openITCOCKPIT wird als Modul ausgeliefert. Diese Modularisierung hat den Vorteil, den
openITCOCKPIT Kern klein und flexibel zu halten.

!!! info "openITCOCKPIT Community Lizenz wird benötigt"
    Um Zugriff auf die Community Module zu erhalten, wird eine Registrierung Ihrer openITCOCKPIT Instanz mit der **
    kostenlosen** Community Lizenz vorausgesetzt.

Navigieren sie nach `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *CheckmkModule*

![packagemanager install checkmk](/images/package-manager-install-checkmk.png)

Folgen Sie den Instruktionen

![packagemanager install instructions](/images/package-manger-install-instructions.png)

Die Installation ist fertiggestellt, sobald Sie die folgende Nachricht
sehen: `Installation done. Please reload your openITCOCKPIT web interface.`

Navigieren Sie in Ihrem Webbrowser zurück und Drücken `Strg + R` oder `Cmd + R` um die Seite neu zu laden.

Das CheckmkModule sollte nun als installiert angezeigt werden.

![installed successful](/images/checkmk-integration-installed-successfully.png)

Jedes Modul kann die verfügbaren Berechtigungen von openITCOCKPIT erweitern. Im Standard werden alle Berechtigungen
der `Administrator` Benutzerrolle gewährt.

Sollte Ihr aktueller Benutzer einer anderen Benutzerrolle zugeordnet sein, stellen Sie sicher, dass Sie dieser Rolle die
entsprechenden Berechtigungen gewähren.

Navigieren Sie nach `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzerrollen` und wählen Sie Ihre Benutzerrolle.

![checkmk userrole permissions grant](/images/checkmk-user-roles-permissions.png)

Neue Berechtigungen werden nicht automatisch gewährt (ausgenommen Benutzer der `Administrator` Benutzerrolle). Dies hat
den Hintergrund, dass nicht jeder Benutzer Module nutzen kann, die beispielsweise nur zu Test- oder Evaluierungszwecken
installiert wurden.

### Checkmk Agent auf dem Zielsystem installieren

Wie bereits angesprochen, nutzen wir den Checkmk Agenten um das Remote System zu überwachen.

Zuallererst müssen Sie den Checkmk Agenten von Ihrem openITCOCKPIT Server auf das Zielsystem kopieren:

`scp /opt/openitc/check_mk/share/check_mk/agents/check_mk_agent.linux root@172.16.166.103:/usr/local/bin/check_mk_agent`

!!! tip "Alle Checkmk Agenten für die verschiedenen Betriebssysteme finden Sie hier"
    `/opt/openitc/check_mk/share/check_mk/agents/`

**Verbinden Sie sich nun per SSH mit dem Remote Host**

Der Checkmk Agent wird nicht als daemon, sondern durch `xinetd` ausgeführt.

```
apt-get install xinetd
chmod +x /usr/local/bin/check_mk_agent
```

!!! danger "Sicherheitshinweis"
    Standardmäßig verwendet Checkmk eine unverschlüsselte klartext Kommunikation!

Als Nächstes müssen Sie die folgende Konfiguration nach `/etc/xinetd.d/check_mk` kopieren:

```
service check_mk
{
    type           = UNLISTED
    port           = 6556
    socket_type    = stream
    protocol       = tcp
    wait           = no
    user           = root
    server         = /usr/local/bin/check_mk_agent

    # configure the IP address(es) of your openITCOCKPIT server here:
    #only_from      = 127.0.0.1 10.0.20.1 10.0.20.2

    # Don't be too verbose. Don't log every check. This might be
    # commented out for debugging. If this option is commented out
    # the default options will be used for this service.
    log_on_success =

    disable        = no
}
```

Um die neue Konfiguration zu aktivieren, müssen Sie `xinetd` neu starten:

```
systemctl restart xinetd.service
```

Das ist alles, was Sie auf dem Remote Host erledigen müssen.

### Zielhost scannen, um Checks automatisch erstellen zu können

im Kontextmenü der Hosts wählen Sie die Option `Checkmk Erkennung`

![checkmk discovery](/images/checkmk-discovery.png)

Nun wählen Sie den Checkmk Agent zur Erkennung nutzen. Als Datasource wählen Sie `Checkmk Agent`aus. 

![checkmk remote discovery](/images/checkmk-remote-discovery-4-3.png)

Sobald der Discovery Prozess abgeschlossen ist, können Sie alle Services, die Sie überwachen möchten, auswählen. Klicken
Sie `Speichern` um fortzufahren.

![select checkmk services](/images/select-check-mk-services-4-3.png)

Um die neue Konfiguration zu aktivieren, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

Ein paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann
immer es möglich ist.

![checkmk services openitcockpit](/images/checkmk-services-openitcockpit.png)

## Überwachung durch SNMP mit Checkmk

Viele Geräte wie zum Beispiel Router, Switche, Sensoren oder Betriebssysteme können via SNMP (Simple Network Management
Protocol) überwacht werden. Bevor Sie mit diesem Guide fortfahren, stellen Sie sicher, dass Sie den
Teil [Monitoring mit Checkmk](#monitoring-mit-checkmk) gelesen haben.

### SNMP Daten des Zielgerätes bekommen

Bevor Sie starten, überprüfen Sie bitte, ob Ihr Monitoring Server in der Lage ist, SNMP Daten des Zielgerätes
abzufragen. Dazu können Sie das Programm `snmpwalk` nutzen.

In diesem Beispiel fragen wie ein Ubuntu Linux, auf dem `snmpd` in der Version `2c` und der community `public` läuft ab.

```
snmpwalk -v2c -c public 172.16.166.103
```

Sie sollten eine ähnliche Ausgabe wie diese sehen:

![snmp walk example](/images/snmpwalk_example.png)

Sollte Ihr System nicht in der Lage sein sich mit dem Zielsystem zu verbinden, überprüfen Sie ihre Firewall 
Einstellungen oder, ob Sie eine falsche SNMP Version nutzen.

### Überwachen eines Linux Hosts durch SNMP via Checkmk

Im Kontextmenü eines Host wählen Sie die Option `Checkmk Erkennung`

![checkmk discovery snmp](/images/checkmk-discovery-snmp.png)

Wählen Sie die `Enable SNMP` Option aus.
Das System wird Sie nach den benötigten SNMP Parametern befragen. Die SNMP Konfiguration wird pro Host gespeichert, Sie
müssen diese Daten also nicht nochmals eingeben. Klicken Sie anschließend auf `Erkennung ausführen` um fortzufahren.

![checkmk remote discovery](/images/checkmk-remote-discovery-4-3.png)


Sobald der Erkennungsprozess vollendet ist, können Sie alle gewünschten Services, welche Sie überwachen möchten,
auswählen. Klicken Sie auf `Weiter` um fortzufahren.

![checkmk snmp result](/images/checkmk-snmp-result.png)

Um die neue Konfiguration zu aktivieren, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

Ein paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann
immer es möglich ist.

![checkmk snmp services](/images/checkmk-snmp-services.png)

### Beschreibung für SNMP Interfaces nutzen

Abhängig vom zu überwachenden Gerät ist es empfehlenswert, anstelle des Index als Identifier für die Netzwerk-Interfaces,
die SNMP Beschreibung (_description_) oder den Alias zu verwenden.

Im Standard werden Interfaces über den Index überwacht. Dies lässt sich leicht am den Namen des Interfaces erkennen.
![Checkmk network interfaces monitored by Index](/images/checkmk-snmp-interface-index.png)

Wenn anstelle des Index die Beschreibung des Interfaces genutzt werden soll, muss dafür eine neue Checkmk Regel erstellt werden.

Erstellen Sie dafür die Datei
`/opt/openitc/check_mk/etc/check_mk/conf.d/wato/interface_description_rule.mk`
mit folgendem Inhalt:
```
globals().setdefault('inventory_if_rules', [])

inventory_if_rules = [
{'id': '35a60268-6aa0-4fb8-8fed-ba51e6b1d1e3', 'value': {'discovery_single': (True, {'item_appearance': 'descr', 'pad_portnumbers': True}), 'matching_conditions': (True, {})}, 'condition': {}},
] + inventory_if_rules
```

Neu erstellte Interface Checks werden nun die Beschreibung verwenden.

![Checkmk network interfaces monitored by description](/images/checkmk-snmp-interface-description.png)

Wenn anstelle der Beschreibung (_description_) der Alias verwendet werden soll, müssen Sie `'item_appearance': 'alias'` setzen.

## Fehlende Servicevorlagen für Checkmk erstellen.

Abhängig von dem Gerät, auf dem Sie ein Discovery durchführen möchten, ist es möglich, dass die `Optionen` Auswahlbox
leer ist und der
Informationstext `Bevor Sie die folgenden Dienste überwachen können, muss eine entsprechende Servicevorlage erstellt werden.`
erscheint, gefolgt von einer Tabelle.

In diesem Fall müssen Sie die fehlenden Servicevorlagen erstellen.

![check mk snmp missing servicetemplates](/images/check-mk-snmp-missing-service-template.png)

### Fehlende Servicevorlagen erstellen

Öffnen Sie ein neues Browserfenster und navigieren Sie nach `Monitoring -> Vorlagen -> Servicevorlagen` und klicken Sie
auf `+ Neu`.

#### Erstelle eine Servicevorlage für `hp_procurve_cpu`

Es wird empfohlen denselben Namen für eine Servicevorlage und nehmen wie es Checkmk nutzt (MK Check). In diesem Fall ist
der MK Check `hp_procurve_cpu` also nutzen wir `CHECK_MK_HP_PROCURVE_CPU` als Servicevorlagen name. Setzten
Sie `Checkmk templates` als Vorlagentyp. Deaktivieren Sie `Aktiviere aktive Prüfungen`, nutzen Sie `check_none` als
Prüfungskommando und setzen Sie die `Parameter` aus der Tabelle als `ARG1` ein.

Bestätigen Sie mit `Erstelle Servicevorlage`

![create missing checkmk snmp servicetemplate](/images/create_missing_check_mk_snmp_service_template.png)

Servicevorlagen Parameter Übersicht:

| Parameter      | Wert                          |
| ----------- | ------------------------------------ |
| Template name |    CHECK_MK_HP_PROCURVE_CPU  |
| Service name | CPU load on HP Procurve |
| Template type | Checkmk templates |
| Enable active checks | No |
| Check command | check_none |
| ARG1 | `(80.0, 90.0)` |
| Check period | 24x7 |
| Max. number of check attempts | 1 |
| Check interval | 60 |
| Retry interval | 60 |

Wiederholen Sie die Schritte für alle fehlenden Servicevorlagen.

#### Servicevorlagen mit MK Checks verlinken

Navigieren Sie nach `Check MK -> Mk Checks` und klicken Sie auf die Schaltfläche `+ Neu`.

Setzen Sie `hp_procurve_cpu` als Check name und wählen Sie die entsprechende Servicevorlage `CHECK_MK_HP_PROCURVE_CPU`
aus.

![link servicetemplate to mk check](/images/link_check_mk_check_to_service_template.png)

Wiederholen Sie dies für alle Servicevorlagen.

![check_mk_mkchecks_to_servicetemplates](/images/check_mk_mkchecks_to_servicetemplates.jpg)

### Services erstellen

Nun sind Sie in der Lage die Services zu erstellen, die Sie überwachen möchten. Starten Sie das SNMP Discovery erneut
und wählen Sie alle gewünschten Services aus der Liste aus.

![checkmk create new snmp services](/images/checkmk-create-new-snmp-services.png)

Um die neue Konfiguration zu aktivieren, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

![checkmk snmp hp switch](/images/checkmk-snmp-hp-switch.png)

### Überwachungsmethoden vermischen

Sie können neben SNMP gleichzeitig den Checkmk Agenten nutzen.
Dazu wählen Sie `Enable Checkmk agent`, als Datasource `Checkmk Agent` und `Enable SNMP`, sowie die SNMP Version und die
Community.

![checkmk remote discovery](/images/checkmk-remote-discovery-4-3.png)

## Checkmk Agent erstellen

Um einen Checkmk Agenten zu erstellen, Navigieren Sie im Hauptmenü nach `Monitoring -> Checkmk -> Checkmk-Agenten`.

Dort klicken Sie in der Übersicht auf die Schaltfläche "Neu"

Danach wählen Sie einen Container aus, vergeben einen namen und tragen anschließend ein Kommandozeilenbefehl ein. Dieser
Kommandozeilenbefehl verweist auf ein Checkmk Skript auf dem openITCOCKPIT Server.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-times: | Container in dem der Checkmk Agent installiert werden soll |
| Name | :fontawesome-solid-times: | Name des Checkmk Agenten |
| Beschreibung |  | Beschreibung des Checkmk Agenten |
| Kommandozeile | :fontawesome-solid-times: | Kommandozeilenbefehl für das Checkmk Agenten Skript |

### Checkmk Agenten herunterladen

Checkmk Agenten können Sie ganz einfach über openITCOCKPIT Herunterladen, indem Sie nach `Monitoring -> Checkmk -> Checkmk-Agenten`
Navigieren und dort auf den Reiter `Agent downloads`

![checkmk downloads](/images/checkmk-agent-downloads.png)