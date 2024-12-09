# Determining the host status

## Pull Mode
In Pull Mode, openITCOCKPIT will actively query the status information from the target device. By default this is done by the `OITC_AGENT_ACTIVE` service check. This service gets deployed on each host, that is monitored in pull mode, automatically.
By default openITCOCKPIT will use the default ICMP/Ping (check-host-alive) check to determine the state of the host.

You can also use the openITCOCKPIT Monitoring Agent as host check. To do so, disabe the `OITC_AGENT_ACTIVE` on the corresponding host. **Do not delete the service**! Only disable it.

![Disable Service](/images/agent/disable_service.png)

Than change the host template of the host to `openITCOCKPIT Agent - Pull` and refresh your monitoring configuration.

openITCOCKPIT will now use the host check to query the data from the Monitoring Agent. As soon as the Agent does not respond or is not reachable to host will switch into the "Down" state.

### Host template or command is missing

In case of the default templates are missing on your system, you need to create them manually.

#### Command

| Field        | Value                                                                                                                   |
|--------------|-------------------------------------------------------------------------------------------------------------------------|
| Command type | `Host check command`                                                                                                    |
| Name         | `check-host-alive-oitc-agent-pull`                                                                                      |
| Command line | `/opt/openitc/receiver/bin/poller.php poller -H "$HOSTNAME$" -c /opt/openitc/receiver/etc/production.json --host-check` |

#### Host template

| Field                         | Value                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------|
| Template name                 | `openITCOCKPIT Agent - Pull`                                                        |
| Template type                 | `Generic Template`                                                                  |
| Description                   | `Actively monitor a Host via openITCOCKPIT Monitoring Agent operating in Pull Mode` |
| Check period                  | `24x7`                                                                              |
| Enable active checks          | `Yes`                                                                               |
| Check command                 | `check-host-alive-oitc-agent-pull`                                                  |
| Check interval                | `60`                                                                                |
| Retry interval                | `60`                                                                                |
| Max. number of check attempts | `1`                                                                                 |


## Push Mode

In Push Mode, openITCOCKPIT can not actively query the host state from the target device. For this reason, openITCOCKPIT checks the timestamp of the last data transmission from the Monitoring Agent. If the Agent did not submit data for more than X minutes, the host switch into "Down" state.

To enable this, edit the Host and pick `openITCOCKPIT Agent - Push` as host template  and refresh your monitoring configuration.
openITCOCKPIT will no evaluate the timestamp of the last transmission to determine the host status.

### Host template or command is missing

In case of the default templates are missing on your system, you need to create them manually.

#### Command

| Field        | Value                                                                                       |
|--------------|---------------------------------------------------------------------------------------------|
| Command type | `Host check command`                                                                        |
| Name         | `check-host-alive-oitc-agent-push`                                                          |
| Command line | `/opt/openitc/frontend/bin/cake agent --check -H --hostuuid "$HOSTNAME$" --critical $ARG1$` |
| ARG1         | `Age in seconds`                                                                            |

#### Host template

| Field                         | Value                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------|
| Template name                 | `openITCOCKPIT Agent - Push`                                                        |
| Template type                 | `Generic Template`                                                                  |
| Description                   | `Host monitored via openITCOCKPIT Monitoring Agent operating in Push Mode` |
| Check period                  | `24x7`                                                                              |
| Enable active checks          | `Yes`                                                                               |
| Check command                 | `check-host-alive-oitc-agent-push`                                                  |
| ARG1                          | `120`                                                                               |
| Check interval                | `60`                                                                                |
| Retry interval                | `60`                                                                                |
| Max. number of check attempts | `1`                                                                                 |
