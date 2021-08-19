# Benutzerdefinierte Makros

Benutzerdefinierte Makros sind Variablen, die in openITCOCKPIT genutzt werden können um zum Beispiel Pfadangaben für Plugins oder Logindaten zu speichern. 

Es besteht die Möglichkeit Werte auszublenden, um z.B. Passwörter nicht direkt sichtbar zu machen. Dazu wählt man entweder beim erstellen oder editieren von einem Makro die Option “Wert verstecken” an oder klickt auf der Übersichtsseite die Schaltfläche 

![](/images/userdefinedmacros-hidevalue.png)

Es können bis zu 256 Makros gespeichert werden.


| macro                       | description                                                                                                                                 |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
|Host Macros|
| $HOSTNAME$                  | The UUID of the host ("1284b927-2bd2-4737-a3da-c39854376ca2")                                                                               |
| $HOSTDISPLAYNAME$           | The human name of the host ("srvstorage01")                                                                                                 |
| $HOSTALIAS$                 | The human name of the host ("srvstorage01"), same as $HOSTDISPLAYNAME$                                                                      |
| $HOSTADDRESS$               | Address or FQDN of the host. ("10.10.12.12")                                                                                                |
| $HOSTSTATE$                 | Current host state as string ("UP", "DOWN", or "UNREACHABLE").                                                                              |
| $HOSTSTATEID$               | Current host state as integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                |
| $LASTHOSTSTATE$             | Last host state as string ("UP", "DOWN", or "UNREACHABLE").                                                                                 |
| $LASTHOSTSTATEID$           | Last host state as integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                   |
| $HOSTSTATETYPE$             | Current host state type as string ("SOFT" or "HARD").                                                                                       |
| $HOSTATTEMPT$               | Current check attempt as integer                                                                                                            |
| $MAXHOSTATTEMPTS$           | Max number of host check attempts.                                                                                                          |
| $HOSTEVENTID$               | Number of state change events as unique number per host.                                                                                    |
| $LASTHOSTEVENTID$           | Last unique host event number.                                                                                                              |
| $HOSTPROBLEMID$             | Unique number of the current host problem state.                                                                                            |
| $LASTHOSTPROBLEMID$         | Unique number of the last host problem state.                                                                                               |
| $HOSTLATENCY$               | Delay between scheduled check time and actual check time as floating point. ("2.05")                                                        |
| $HOSTEXECUTIONTIME$         | Plugin execution time as floating point. ("4.21").                                                                                          |
| $HOSTDURATION$              | Time since last state change occured as string (HH MM SS)                                                                                   |
| $HOSTDURATIONSEC$           | Time since last state change occured as integer in seconds.                                                                                 |
| $HOSTDOWNTIME$              | If the host in a scheduled downtime, this value will be >= 1.                                                                               |
| $HOSTPERCENTCHANGE$         | State change percentage as floating point. (This is used by the flap detection algorithm).                                                  |
| $HOSTGROUPNAME$             | Contain the first host group of an host as string ("12403d1a-70c0-468b-ad8d-446fb8412205")                                                  |
| $HOSTGROUPNAMES$            | A comma separated of all the host groups the host belongs to. ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04") |
| $LASTHOSTCHECK$             | Unix timestamp (integer) of the last host check.                                                                                            |
| $LASTHOSTSTATECHANGE$       | Unix timestamp (integer) of last host state change.                                                                                         |
| $LASTHOSTUP$                | Unix timestamp (integer) of the last host UP state.                                                                                         |
| $LASTHOSTDOWN$              | Unix timestamp (integer) of the last host DOWN state.                                                                                       |
| $LASTHOSTUNREACHABLE$       | Unix timestamp (integer) of the last host UNREACHABLE state.                                                                                |
| $HOSTOUTPUT$                | Output of host check plugin ("OK - 127.5.6.7: rta 0,054ms, lost 0% ").                                                                      |
| $LONGHOSTOUTPUT$            | The long plugin output of current host check.                                                                                               |
| $HOSTPERFDATA$              | Performance date output of current host check. ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                              |
| $HOSTCHECKCOMMAND$          | Contains the command UUID including used command arguments ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0,80%!4000.0,90%;")                  |
| $HOSTACTIONURL$             | Not implemented by openITCOCKPIT.                                                                                                           |
| $HOSTNOTESURL$              | Not implemented by openITCOCKPIT.                                                                                                           |
| $HOSTNOTES$                 | Uer defined notes for the host.                                                                                                             |
| $TOTALHOSTSERVICES$         | Total number of services associated with the host.                                                                                          |
| $TOTALHOSTSERVICESOK$       | Total number of services associated with the host in state OK.                                                                              |
| $TOTALHOSTSERVICESWARNING$  | Total number of services associated with the host in state WARNING.                                                                         |
| $TOTALHOSTSERVICESCRITICAL$ | Total number of services associated with the host in state CRITICAL.                                                                        |
| $TOTALHOSTSERVICESUNKNOWN$  | Total number of services associated with the host in state UNKNOWN.                                                                         |
|Host group macros|
| $HOSTGROUPALIAS$     | The UUID of the host group ("fc11e1b9-9c0f-49d7-90b5-f283fe39a21d")                                                                     |
| $HOSTGROUPMEMBERS$   | A comma separated list of the host group mebers as UUIDs ("c7176869-ffb7-4149-b960-bdbf9ae85968,f5e943f3-c46f-4f6d-8fc1-468774a72332"). |
| $HOSTGROUPNOTES$     | Not implemented by openITCOCKPIT.                                                                                                       |
| $HOSTGROUPNOTESURL$  | Not implemented by openITCOCKPIT.                                                                                                       |
| $HOSTGROUPACTIONURL$ | Not implemented by openITCOCKPIT.                                                                                                       |
|Servce Macros|
| $SERVICEDESC$            | The UUID of the service ("bd19ce04-3209-4664-a146-bd1220e740bc")                                                                                  |
| $SERVICEDESC$            | The human name of the service ("PING")                                                                                                            |
| $SERVICESTATE$           | Current service state as string  ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                     |
| $SERVICESTATEID$         | Current service state as integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                        |
| $LASTSERVICESTATE$       | Last service state as string ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                         |
| $LASTSERVICESTATEID$     | Last service state as integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                           |
| $SERVICESTATETYPE$       | Current service state type as string ("SOFT" or "HARD").                                                                                          |
| $SERVICEATTEMPT$         | Current check attempt as integer                                                                                                                  |
| $MAXSERVICEATTEMPTS$     | Max number of service check attempts.                                                                                                             |
| $SERVICEISVOLATILE$      | Is volatile as integer (0=NO, 1=YES)                                                                                                              |
| $SERVICEEVENTID$         | Number of state change events as unique number per service.                                                                                       |
| $LASTSERVICEEVENTID$     | Last unique service event number.                                                                                                                 |
| $SERVICEPROBLEMID$       | Unique number of the current service problem state.                                                                                               |
| $LASTSERVICEPROBLEMID$   | Unique number of the last service problem state.                                                                                                  |
| $SERVICELATENCY$         | Delay between scheduled check time and actual check time as floating point. ("2.05")                                                              |
| $SERVICEEXECUTIONTIME$   | Plugin execution time as floating point. ("4.21").                                                                                                |
| $SERVICEDURATION$        | Time since last state change occured as string (HH MM SS)                                                                                         |
| $SERVICEDURATIONSEC$     | Time since last state change occured as integer in seconds.                                                                                       |
| $SERVICEDOWNTIME$        | If the service in a scheduled downtime, this value will be >= 1.                                                                                  |
| $SERVICEPERCENTCHANGE$   | State change percentage as floating point. (This is used by the flap detection algorithm).                                                        |
| $SERVICEGROUPNAME$       | Contain the first service group of an service as string ("6123eb90-a3eb-4895-b348-c464d9494d14")                                                  |
| $SERVICEGROUPNAMES$      | A comma separated of all the service groups the service belongs to. ("6123eb90-a3eb-4895-b348-c464d9494d14,666b1caf-4c0f-45e8-9380-78f9e915b82d") |
| $LASTSERVICECHECK$       | Unix timestamp (integer) of the last service check.                                                                                               |
| $LASTSERVICESTATECHANGE$ | Unix timestamp (integer) of last service state change.                                                                                            |
| $LASTSERVICEOK$          | Unix timestamp (integer) of the last service OK state.                                                                                            |
| $LASTSERVICEWARNING$     | Unix timestamp (integer) of the last service WARNING state.                                                                                       |
| $LASTSERVICECRITICAL$    | Unix timestamp (integer) of the last service CRITICAL state.                                                                                      |
| $LASTSERVICEUNKNOWN$     | Unix timestamp (integer) of the last service UNKNOWN state.                                                                                       |
| $SERVICEOUTPUT$          | Output of service check plugin ("OK - 127.5.6.7: rta 0,054ms, lost 0% ").                                                                         |
| $LONGSERVICEOUTPUT$      | The long plugin output of current service check.                                                                                                  |
| $SERVICEPERFDATA$        | Performance date output of current service check. ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                                 |
| $SERVICECHECKCOMMAND$    | Contains the command UUID including used command arguments ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0,80%!4000.0,90%;")                        |
| $SERVICEACTIONURL$       | Not implemented by openITCOCKPIT.                                                                                                                 |
| $SERVICENOTESURL$        | Not implemented by openITCOCKPIT.                                                                                                                 |
| $SERVICENOTES$           | Uer defined notes for the host.                                                                                                                   |
|Service group macros|
| $SERVICEGROUPALIAS$    | The UUID of the host group ("65c7692e-b322-4788-8232-97258b457f22")                                                                        |
| $SERVICEGROUPMEMBERS$  | A comma separated list of the service group mebers as UUIDs ("0a9feda1-569e-40fe-a5a3-b2f389818301,ade06bfb-f9bd-4112-9537-2b3d286a6572"). |
| $SERVICEGROUPNOTES$    | Not implemented by openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTESURL$ | Not implemented by openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTES$    | Not implemented by openITCOCKPIT.                                                                                                          |
|Contact macros|
| $CONTACTNAME$       | The UUID of the contact ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0")                                                                                  |
| $CONTACTGROUPNAME$  | The human name of the contact ("info").                                                                                                           |
| $CONTACTALIAS$      | The human name of the contact ("info"), same as $CONTACTGROUPNAME$                                                                                |
| $CONTACTEMAIL$      | Email address of the contact. ("community@openitcockpit.io")                                                                                      |
| $CONTACTPAGER$      | Pager number of the contact. ("004913456789")                                                                                                     |
| $CONTACTGROUPNAMES$ | A comma separated of all the contact groups the contact belongs to. ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112,4992c7ad-1bb4-465a-8fe4-a721461b69a2") |
|Contact group macros|
| $CONTACTGROUPALIAS$   | The UUID of the contact group ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112")                                                                            |
| $CONTACTGROUPMEMBERS$ | A comma separated of all the contacts belongs to the contact group. ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0,6de7d0f9-413e-41cc-b1e4-3289072b72c4") |
|SUMMARY Macros (Notice: CPU intensive to calculate - use with care)|
| $TOTALHOSTSUP$                   | Number of hosts in state UP.                                                                                              |
| $TOTALHOSTSDOWN$                 | Number of hosts in state DOWN.                                                                                            |
| $TOTALHOSTSUNREACHABLE$          | Number of hosts in state UNREACHABLE.                                                                                     |
| $TOTALHOSTSDOWNUNHANDLED$        | Number of unhandled hosts. Unhandled hosts are in a DOWN state and not acknowledged or in a scheduled downtime.           |
| $TOTALHOSTSUNREACHABLEUNHANDLED$ | Number of unhandled hosts. Unhandled hosts are in a UNREACHABLE state and not acknowledged or in a scheduled downtime.    |
| $TOTALHOSTPROBLEMS$              | Number of hosts in a non UP state.                                                                                        |
| $TOTALHOSTPROBLEMSUNHANDLED$     | Number of unhandled hosts. Unhandled hosts are in a non UP state and not acknowledged or in a scheduled downtime.         |
| $TOTALSERVICESOK$                | Number of services in state OK.                                                                                           |
| $TOTALSERVICESWARNING$           | Number of services in state WARNING.                                                                                      |
| $TOTALSERVICESCRITICAL$          | Number of services in state CRITICAL.                                                                                     |
| $TOTALSERVICESUNKNOWN$           | Number of services in state UNKNOWN.                                                                                      |
| $TOTALSERVICESWARNINGUNHANDLED$  | Number of unhandled services. Unhandled services are in a WARNING state and not acknowledged or in a scheduled downtime.  |
| $TOTALSERVICESCRITICALUNHANDLED$ | Number of unhandled services. Unhandled services are in a CRITICAL state and not acknowledged or in a scheduled downtime. |
| $TOTALSERVICESUNKNOWNUNHANDLED$  | Number of unhandled services. Unhandled services are in a UNKNOWN state and not acknowledged or in a scheduled downtime.  |
| $TOTALSERVICEPROBLEMS$           | Number of services in a non OK state.                                                                                     |
| $TOTALSERVICEPROBLEMSUNHANDLED$  | Number of unhandled services. Unhandled services are in a non OK state and not acknowledged or in a scheduled downtime.   |
|Notification macros|
| $NOTIFICATIONTYPE$          | Notification type as string ("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART", "FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND", or "DOWNTIMECANCELLED"). |
| $NOTIFICATIONRECIPIENTS$    | A comma separated of all the contacts for this notification. ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")                                           |
| $NOTIFICATIONISESCALATED$   | Is this an escalated notification (0=NO, 1=YES)                                                                                                                                      |
| $NOTIFICATIONAUTHOR$        | openITCOCKPIT user name as string.                                                                                                                                                   |
| $NOTIFICATIONAUTHORNAME$    | openITCOCKPIT user name as string.                                                                                                                                                   |
| $NOTIFICATIONAUTHORALIAS$   | openITCOCKPIT user name as string.                                                                                                                                                   |
| $NOTIFICATIONCOMMENT$       | Comment data of the notification.                                                                                                                                                    |
| $HOSTNOTIFICATIONNUMBER$    | Number of send notifications for a host. If the host state goes to RECOVERY, the counter will be reset to 0.                                                                         |
| $HOSTNOTIFICATIONID$        | Unique event number of the host notification.                                                                                                                                        |
| $SERVICENOTIFICATIONNUMBER$ | Number of send notifications for a service. If the service state goes to OK, the counter will be reset to 0.                                                                         |
| $SERVICENOTIFICATIONID$     | Unique event number of the service notification.                                                                                                                                     |
|Date and time Macros|
| $DATE$  | Current date as string (DD-MM-YYYY). |
| $TIME$  | Current time as string (HH:MM:SS).   |
| $TIMET$ | Current time as UNIX timestamp.      |