# Creating a New openITCOCKPIT Check Plugin

openITCOCKPIT uses a plugin-based system to check the status of hosts and services. The plugin API is 100% compatible
with the [Nagios](https://nagios-plugins.org/doc/guidelines.html)
, [Naemon](https://www.naemon.io/documentation/usersguide/pluginapi.html)
, [Shinken](https://www.naemon.io/documentation/usersguide/pluginapi.html)
and [Icinga 1.x](https://icinga.com/docs/icinga1/latest/en/pluginapi.html) plugin API. By default, openITCOCKPIT comes
with a standard set of plugins for the basic checking of network features such as ports, running processes, CPU usage,
etc.

In some cases, it will be practical to write your own specialised plugin(s) for in-depth monitoring.

Plugins for openITCOCKPIT can be developed in all programming languages. From a simple bash script to a complex Python
or C binary - everything is possible. For some languages such
as [Perl](https://github.com/monitoring-plugins/monitoring-plugin-perl)
or [Python](https://pypi.org/project/nagiosplugin/) , there are even helper classes that speed up and simplify
development.

## Plugin overview

To be compatible with openITCOCKPIT, a plugin must meet the following minimum requirements:

- The script or binary must be executable
- Must "exit" with a valid return value (see [Return Codes](#return-codes))
- Must return at least one line of text (plugin output) to STDOUT.

## Plugin paths

The standard plugins that are delivered with openITCOCKPIT are located in the folder `/opt/openitc/nagios/libexec`. It
is recommended (but not necessary) to create a separate folder for your own plugins, for
example `/opt/openitc/my_checks/`.

## Return codes

### Hosts

|Plugin return code|Host state|
|---|---|
|0|<span class="badge badge-success" style="color:#343a40" title="UP">UP</span>|
|1|<span class="badge badge-danger" style="color:#343a40" title="DOWN">DOWN</span>|
|2|<span class="badge badge-default" style="color:#343a40" title="UNREACHABLE">UNREACHABLE</span>|

### Services

|Plugin return code|Service state|
|---|---|
|0|<span class="badge badge-success" style="color:#343a40" title="OK">OK</span>|
|1|<span class="badge badge-warning" style="color:#343a40" title="WARNING">WARNING</span>|
|2|<span class="badge badge-danger" style="color:#343a40" title="CRITICAL">CRITICAL</span>|
|3|<span class="badge badge-default" style="color:#343a40" title="UNKNOWN">UNKNOWN</span>|

## Plugin output

By default, the "plugin output" must be one line of text to STDOUT, as in this example:

```bash
#!/bin/bash

echo "This is the minimum plugin output"

# Return with status UP or OK
exit 0
```

openITCOCKPIT supports [BBCode](https://en.wikipedia.org/wiki/BBCode) for controlling the style of embedded hyperlinks
in the plugin output.

```bash
echo "This is [b]bold text[/b]"
```

### Performance data (metrics)

Performance data is used by openITCOCKPIT to create graphs for the user interface, for notifications and Grafana.

Performance data is separated from the plugin output by a "pipe" symbol |. This is optional as not every plugin provides
performance data.

The format for the performance data is as follows:

```
'label'=value[UOM];[warn];[crit];[min];[max]
```

1. A space-separated list of label/value pairs
2. If the label contains a space, the label must be enclosed in single quotes (').
3. Numerical values must be given in US format (`10.5` instead of `10,5`).
4. Optional unit of measurement (e.g.: `s`, `ms`, `kg` etc.)
   1. Optional WARNING threshold 2. Optional CRITICAL threshold 3. Optional minimum threshold 4. Optional maximum
   threshold

|Example plugin output|Legend|
|---|---|
|<span style="color:#99CC00;">PING OK - Packet loss = 0%, RTA = 17.30 ms</span>\|<span style="color:#FF6600;">rta=17.302000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0</span>|<span style="color:#99CC00;">Plugin output</span> <br /> <span style="color:#FF6600;">performance data</span>|
