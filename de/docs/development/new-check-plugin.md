# Ein neues openITCOCKPIT Check Plugin erstellen

Für diesen Artikel benötigen Sie eine openITCOCKPIT Entwicklungsumgebung. Lesen
Sie [diesen Guide um sich eine openITCOCKPIT Entwicklungsumgebung zu erstellen](../../setup-dev-env/#openitcockpit-entwicklungsumgebung-erstellen)

openITCOCKPIT nutzt ein Plugin basiertes system um den Status von Hosts und Services zu überprüfen. Die Plugin API ist
zu 100 % kompatibel mit der [Nagios](https://nagios-plugins.org/doc/guidelines.html)
, [Naemon](https://www.naemon.org/documentation/usersguide/pluginapi.html)
, [Shinken](https://www.naemon.org/documentation/usersguide/pluginapi.html)
und [Icinga 1.x](https://icinga.com/docs/icinga1/latest/en/pluginapi.html) Plugin API. Standardmäßig wird openITCOCKPIT
mit einem standardset an Plugins zum grundlegenden Überprüfen von Netzwerk features wie Ports, laufende Prozesse, CPU
Auslastung und so weiter.

In manchen Fällen ist es praktikabel ein eigenes, spezialisiertes Plugin für tiefgreifendes Monitoring zu schreiben.

Plugins für openITCOCKPIT können in allen Programmiersprachen entwickelt werden. Angefangen von einem einfachen bash
skript bis hin zur komplexen Python oder C Binary - alles ist möglich. Für manche Sprachen
wie [Perl](https://github.com/monitoring-plugins/monitoring-plugin-perl)
oder [Python](https://pypi.org/project/nagiosplugin/) existieren sogar helper Klassen, welche die Entwicklung
beschleunigen und vereinfachen.

## Plugin Übersicht

Ein Plugin hat, um kompatibel mit openITCOCKPIT zu sein, folgende Mindestvoraussetzungen:

- Das Skript oder Binary muss ausführbar sein
- "Exit" mit einem validen Rückgabewert (siehe [Return Codes](#return-codes))
- Muss mindestens eine Zeile Text (plugin output) an STDOUT zurückgeben.

## Plugin Pfade

Die Standard-Plugins, welche mit openITCOCKPIT ausgeliefert werden, befinden sich im
Ordner `/opt/openitc/nagios/libexec`. Es wird empfohlen (jedoch nicht notwendig) einen eigenen, separaten Ordner für
eigene Plugins, beispielsweise `/opt/openitc/my_checks/`, zu erstellen.

## Return Codes

### Hosts

|Plugin Return Code|Host State|
|---|---|
|0|<span class="badge badge-success" style="color:#343a40" title="UP">UP</span>|
|1|<span class="badge badge-danger" style="color:#343a40" title="DOWN">DOWN</span>|
|2|<span class="badge badge-default" style="color:#343a40" title="UNREACHABLE">UNREACHABLE</span>|

### Services

|Plugin Return Code|Service State|
|---|---|
|0|<span class="badge badge-success" style="color:#343a40" title="OK">OK</span>|
|1|<span class="badge badge-warning" style="color:#343a40" title="WARNING">WARNING</span>|
|2|<span class="badge badge-danger" style="color:#343a40" title="CRITICAL">CRITICAL</span>|
|3|<span class="badge badge-default" style="color:#343a40" title="UNKNOWN">UNKNOWN</span>|

## Plugin Output

Standardmäßig muss der "Plugin Output" eine Zeile Text nach STDOUT, wie in diesem Beispiel, betragen.

```bash
#!/bin/bash
 
echo "This is the minimum plugin output"
 
# Return with status UP or OK
exit 0
```

openITCOCKPIT unterstützt [BBCode](https://en.wikipedia.org/wiki/BBCode) für das Styling von eingebetteten Hyperlinks im
Plugin Output.

```bash
echo "This is [b]bold text[/b]"
```

### Performance Daten (Metriken)
Performance Daten werden von openITCOCKPIT genutzt um Graphen für das Interface, Benachrichtigungen und Grafana zu 
erstellen.

Performance Daten werden durch ein "pipe" Symbol `|` vom Plugin Output separiert. Dies ist optional da nicht jedes
Plugin Performance daten liefert. 

Das format der Performance daten ist wie folgt:
```
'label'=value[UOM];[warn];[crit];[min];[max]
```

1. Eine durch Leerzeichen separierte Liste von Label/Werte Paaren
2. Enthält das Label ein Leerzeichen, muss das Label innerhalb von einfachen anführungszeichen stehen (`'`)
3. Numerische werte müssen im US-Format angegeben werden (`10.5` anstatt `10,5`)
4. Optionale Maßeinheit (bspw.: `s`, `ms`, `kg` etc.)
    1. Optionaler WARNING Schwellwert
    2. Optionaler CRITICAL Schwellwert
    3. Optionaler minimum Schwellwert
    4. Optionaler maximum Schwellwert

|Beispiel Plugin Output|Legende|
|---|---|
|<span style="color:#99CC00;">PING OK - Packet loss = 0%, RTA = 17.30 ms</span>\|<span style="color:#FF6600;">rta=17.302000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0</span>|<span style="color:#99CC00;">Plugin Output</span> <br /> <span style="color:#FF6600;">Performance Daten</span>|

