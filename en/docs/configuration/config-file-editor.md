# Configuration file editor

The openITCOCKPIT configuration file editor gives you the ability to edit various configuration files such as those for the monitoring engine, status engine, PHP and others. Files that have been edited using the configuration file editor will also keep pace with system updates. That is, any changes or edits to the files will remain constant even after you have changed the version of your openITCOCKPIT installation.

You can also restore a configuration file to its default values. To do this, open the corresponding file in the configuration file editor and click on “Restore defaults” in the upper right menu.

The following configuration files can be edited using the configuration file editor:

openITCOCKPIT interface configuration files

```
/opt/openitc/frontend/config/after_export.php
/opt/openitc/frontend/config/dbbackend.php
/opt/openitc/frontend/config/perfdatabackend.php
/opt/openitc/frontend/config/graphite.php
/opt/openitc/frontend/config/gearman.php
```

Monitoring engine

```
/opt/openitc/nagios/etc/nagios.cfg
```

Status engine

```
/opt/openitc/etc/statusengine/Config/Statusengine.php
/opt/openitc/etc/statusengine/config.yml
```

NSTA

```
/opt/openitc/etc/nsta/nsta.ini
```

Carbon und Whisper (Graphing)

```
/opt/openitc/docker/container/graphing/docker-compose.yml
```

PHP-FPM

```
/etc/php/7.4/fpm/pool.d/oitc.conf
```

SnmpTrapModule

```
/opt/openitc/etc/SnmpTrapModule/snmptrapd
/opt/openitc/etc/SnmpTrapModule/snmptrapd.conf
/opt/openitc/etc/SnmpTrapModule/snmptt.ini
```

PrometheusModule

```
/opt/openitc/frontend/plugins/PrometheusModule/config/prometheus_bridge.php
```
