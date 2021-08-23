# Konfigurationsdatei Editor

Der Konfigurationsdatei Editor ist eine Möglichkeit in openITCOCKPIT verschieden Konfigurationsdateien wie beispielsweise die der Monitoring Engine, Statusengine, PHP und weitere zu bearbeiten. Dateien, die über den Konfigurationsdatei Editor bearbeitet wurden, sind auch updatefähig, bedeutet also dass Änderungen an den Dateien über ein openITCOCKPIT Versionswechsel hinaus bestehen bleiben.

Eine Konfigurationsdatei kann auch auf seine Standardwerte wiederhergestellt werden. Dazu öffnet man die entsprechende Datei um Konfigurationsdatei Editor und klickt im oberen rechten Menü auf “Standard wiederherstellen”.

Folgende Konfigurationsdateien können über den Konfigurationsdatei Editor bearbeitet werden:

openITCOCKPIT Interface Konfigurationsdateien
- `/opt/openitc/frontend/config/after_export.php`
- `/opt/openitc/frontend/config/dbbackend.php` 	
- `/opt/openitc/frontend/config/perfdatabackend.php`
- `/opt/openitc/frontend/config/graphite.php`
- `/opt/openitc/frontend/config/gearman.php`	


Monitoring engine
- `/opt/openitc/nagios/etc/nagios.cfg`

Statusengine
- `/opt/openitc/etc/statusengine/Config/Statusengine.php`
- `/opt/openitc/etc/statusengine/config.yml`

NSTA
- `/opt/openitc/etc/nsta/nsta.ini`

Carbon und Whisper (Graphing)
- `/opt/openitc/docker/container/graphing/docker-compose.yml`

PHP-FPM
- `/etc/php/7.4/fpm/pool.d/oitc.conf`

SnmpTrapModule
- `/opt/openitc/etc/SnmpTrapModule/snmptrapd`
- `/opt/openitc/etc/SnmpTrapModule/snmptrapd.conf`
- `/opt/openitc/etc/SnmpTrapModule/snmptt.ini`

PrometheusModule
- `/opt/openitc/frontend/plugins/PrometheusModule/config/prometheus_bridge.php`