# Import Module <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The Import Module is one of the most comprehensive and complex modules in openITCOCKPIT. The module can be used to import hosts from other systems. This can be a classic CSV import or an import from a configuration management database (CMDB) such as i-doit or iTop. The module is also used to import new openITCOCKPIT agents in push mode. For all importers, it also enables the rule-based assignment of service checks. It supports various methods, including status transfer from other monitoring systems.

## Module installation

Navigate to `Administration -> System tools -> Package Manager` and install the *ImportModule*

## Host Defaults

As a first step, at least one standard definition must be created under *Host Defaults*. The host default settings are used to define the host template, container, satellite system and assigned services parameters.

Navigate to `Administration -> Object Import -> Host Defaults` and create a new definition using the **New** button.

![](/images/import-module/host_defaults.png)

Selecting a container defines the container into which the new hosts are to be imported. The host template can be used to define which template is to be used as the basis for newly imported hosts. By selecting further shared containers, it is also possible to create specific views directly. Finally, the last detail is to select whether the new hosts are to be created on the master system or a satellite.

The optional sections can then be used to define the rules for automatic service assignment.

![](/images/import-module/servicetemplategroup_matches.png)

The image shows an example of the assignment of service template groups where one of the attributes Hostname, Description, Address or Software is compared with a regular expression. If the regular expression is found, the selected service template group is assigned.

## Importer

The actual data import is realised via the importers. There are different types of importers.

- **CSV**
    - Enables the import of CSV files
- **openITCOCKPIT Agent**
    - In addition to the option of adding a host via wizards, the openITCOCKPIT Agent can also be the data source for an import.
- **CMDB**
    - An import from iTop and i-doit can be selected in the CMDBs area
- **External monitoring Systems**
    - In addition to classic CMDBs, other monitoring systems, such as Icinga2, can also be used as data sources. The special feature here is that not only the hosts, but also the status information from the external monitoring system is determined and displayed.
- **CMDB + External monitoring System**
    - A combination of methods is also possible, whereby the import is based on the information from the CMDB and is compared with the information from the external monitoring system. In this case, not only hosts are imported, but also the status information from the external monitoring system.

### CSV Import

After defining a host default settings template, importers for CSV files can be created directly.

Navigate to `Administration -> Object Import -> Importers`.

![](/images/import-module/csv_settings.png)

The correct attributes in the mapping and the selection of a host default settings template are particularly important so that the assignments can be made correctly.

![](/images/import-module/csv_mapping.png)

A working CSV file for the import could look like this:

```
hostname;address;description;software
srvweb04.itsm.love;127.10.10.1;Web server 1;Linux-local,nginx
srvweb05.itsm.love;127.10.10.2;Web server 2;Linux-local,nginx
srvmysqldb01.itsm.love;127.0.0.1;MySQL DB Server;Linux-local,mysql
```

### openITCOCKPIT Agent

A special host default setting is required to import openITCOCKPIT agents. The assignment is made via the agent checks. 

Navigate to `Administration -> Object import -> Host Defaults`.

![](/images/import-module/agent_checks_matches.png)

All other parameters behave in the same way as other host default settings and are therefore not described here.

Navigate to `Administration -> Object Import -> Importers`.

The importer settings are similar to those of a CSV importer. It is important to select the openITCOCKPIT Agent as the data source and to select the correct template for the host default assignments.

![](/images/import-module/agent_host_defaults_assignment.png)

### CMDB

Before a CMDB can be used as a data source, it must first be created as an external system.

The CMDB-specific connection data must be specified.

Navigate to `Administration -> Object import -> External Systems`.

![](/images/import-module/ext_systems_conn_settings.png)

You also need to define which object types from the CMDB are to be included in the import.

![](/images/import-module/ext_systems_object_types.png)

Once the CMDB has been set up as an external system, the importer can be created as usual. Select the corresponding CMDB (i-doit, iTop, ...) in combination with the external system to be queried as the data source.

Navigate to `Administration -> Object import -> Importers`.

![](/images/import-module/importer_cmdb_source.png)

!!! info "Hint"
    By importing the hosts, they are also extended with asset information from the CMDB.

### Externes Monitoring System

As with the CMDB, the external monitoring system must first be created before creating an importer.

Navigate to `Administration -> Object import -> External Monitoring`.

Once the system has been created, the importer can be created.

Navigate to `Administration -> Object import -> Importers`.

![](/images/import-module/importer_ext_mon_source.png)

### CMDB + Externes Monitoring System

The combination requires a defined external monitoring system and an external system. The creation takes place according to the points External monitoring system and CMDB.

Navigate to `Administration -> Object import -> Importers`.

The importer can now be created with both data sources.

![](/images/import-module/importer_both_source.png)

## Import der Daten

Once all preparations have been made, the import can now be carried out.

Navigate to `Administration -> Object import -> Imported Hosts`.

The desired importer can be selected and executed via the **Start import** button.

![](/images/import-module/start_import.png)

If the connection is successful, all systems to be imported are listed and you can start the import by clicking the **Start data import** button.

![](/images/import-module/hosts_for_import.png)

The next step provides an overview of all hosts, the assigned services and other information. The transfer to the monitoring is done via the **Synchronize with monitoring** button.

![](/images/import-module/import_sync_monitoring.png)

!!! info "Hint"
    To activate monitoring, the monitoring configuration must be refreshed as usual.