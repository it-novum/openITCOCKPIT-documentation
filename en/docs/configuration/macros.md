# Macros

Macros are variables that can be used in openITCOCKPIT, for example to store path information for check plugins or login data.

Macros always begin and end with a $ sign.

## Custom macros

Custom macros are by far the most commonly used type of macros in openITCOCKPIT. The name of the macro is always `USER` followed by a number, for example `$USER1$`

This macro type is often used to store path information, passwords and SNMP communities.

It is possible to hide values, e.g. to not make passwords directly visible. To do this, either select the “Hide value” option when creating or editing a macro or click on the button on the overview page. 

![](/images/UserDefinedMacros-hideValue.png)

![Overview about User defined macros](/images/UserDefinedMacros-Overview.png)

!!! info
    Up to 256 user-defined macros can be saved.

## Contact macros

Contact macros can be stored with contacts to save login data for a ticketing system or other use cases.
The macros always follow the structure `$_CONTACT<macro-name>$`

![Contact Macros](/images/contact-macros.png)

## Host Macros

Host macros can be stored directly in a host template or with an individual host. These are usually used to store SNMP communities or other access data that is only relevant for one host.

The macros always follow the structure `$_HOST<macro-name>$`
  
Macros inherited from the host template are shown in green. Those coloured blue mean the macro was configured directly on the host. 

![Host Macros](/images/host-macros.png)

Host macros are available both when running the host check and when running service checks on the host.

## Service macros

Service macros can be stored directly in a service template or together with an individual service. This is usually used to store access data that is only relevant for one service.

The macros always follow the structure `$_SERVICE<macro-name>$`
  
Macros inherited from the service template are shown in green. Those coloured blue mean the macro was configured directly on the service.

Service macros are only available when running a service check.

## Default Macros

In addition to the macros that users can define themselves, the system also provides a number of default macros.

| Macro                       | Description                                                                                                                                 |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
|Host macros|
| $HOSTNAME$                  | Host UUID ("1284b927-2bd2-4737-a3da-c39854376ca2")                                                                               |
| $HOSTDISPLAYNAME$           | Human-readable name of host ("srvstorage01")                                                                                                 |
| $HOSTALIAS$                 | Human-readable name of host ("srvstorage01"), same as $HOSTDISPLAYNAME$                                                                      |
| $HOSTADDRESS$               | Address or FQDN of the host. ("10.10.12.12")                                                                                                |
| $HOSTSTATE$                 | Current host status as a string ("UP", "DOWN", or "UNREACHABLE").                                                                              |
| $HOSTSTATEID$               | Current host status as an integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                |
| $LASTHOSTSTATE$             | Last host status as a string ("UP", "DOWN", or "UNREACHABLE").                                                                                 |
| $LASTHOSTSTATEID$           | Last host status as an integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                   |
| $HOSTSTATETYPE$             | Current host status type as a string ("SOFT" or "HARD").                                                                                       |
| $HOSTATTEMPT$               | Current checking attempt as an integer                                                                                                            |
| $MAXHOSTATTEMPTS$           | Maximum number of checking attempts                                                                                                          |
| $HOSTEVENTID$               | Number of status change events as a unique number per host                                                                                    |
| $LASTHOSTEVENTID$           | Last unique host event number                                                                                                              |
| $HOSTPROBLEMID$             | Unique number of the current host problem status                                                                                           |
| $LASTHOSTPROBLEMID$         | Unique number of the last host problem status                                                                                              |
| $HOSTLATENCY$               | Delay between planned checking time and actual checking time as a float  ("2.05")                                                        |
| $HOSTEXECUTIONTIME$         | Plugin execution time as a float "4.21").                                                                                          |
| $HOSTDURATION$              | Time since last status change as a string (HH MM SS)                                                                                   |
| $HOSTDURATIONSEC$           | Time since last status change as an integer in seconds                                                                                  |
| $HOSTDOWNTIME$              | If the host is in a scheduled maintenance time, this value is >=1                                                                             |
| $HOSTPERCENTCHANGE$         | Percentage status change as a float (used by flap detection algorithm)                                                 |
| $HOSTGROUPNAME$             | Contains the first host group of a host as a string ("12403d1a-70c0-468b-ad8d-446fb8412205")                                                 |
| $HOSTGROUPNAMES$            | Comma-separated list of all host groups that a host belongs to ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")|
| $LASTHOSTCHECK$             | Unix timestamp (integer) of the last host check                                                                                            |
| $LASTHOSTSTATECHANGE$       | Unix timestamp (integer) of the last state change                                                                                         |
| $LASTHOSTUP$                | Unix timestamp (integer) of last host UP status                                                                                         |
| $LASTHOSTDOWN$              | Unix timestamp (integer) of last host DOWN status                                                                                       |
| $LASTHOSTUNREACHABLE$       | Unix timestamp (integer) of last host UNREACHABLE status                                                                                |
| $HOSTOUTPUT$                | Output of the host check plugin (“OK - 127.5.6.7: rta 0.054ms, lost 0%”)                                                                      |
| $LONGHOSTOUTPUT$            | Long plugin output of the current host check                                                                                               |
| $HOSTPERFDATA$              | Performance data output of the current host check (“rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0”)                            |
| $HOSTCHECKCOMMAND$          | Contains the command UUID and the used command arguments (“5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0.80%!4000.0.90%;”)                  |
| $HOSTACTIONURL$             | Not implemented in openITCOCKPIT                                                                                                           |
| $HOSTNOTESURL$              | Not implemented in openITCOCKPIT                                                                                                           |
| $HOSTNOTES$                 | User-defined, custom notes for a host                                                                                                            |
| $TOTALHOSTSERVICES$         | Total number of services connected to the host                                                                                         |
| $TOTALHOSTSERVICESOK$       | Total number of services connected to the host with status OK                                                                              |
| $TOTALHOSTSERVICESWARNING$  | Total number of services connected to the host with status WARNING                                                                        |
| $TOTALHOSTSERVICESCRITICAL$ | Total number of services connected to the host with status CRITICAL                                                                       |
| $TOTALHOSTSERVICESUNKNOWN$  | Total number of services connected to the host with status UNKNOWN                                                                        |
|Host group macros|
| $HOSTGROUPALIAS$     | The UUID of the host group (“fc11e1b9-9c0f-49d7-90b5-f283fe39a21d”)                                                                     |
| $HOSTGROUPMEMBERS$   | Comma-separated list of host group members as UUIDs (“c7176869-ffb7-4149-b960-bdbf9ae85968,f5e943f3-c46f-4f6d-8fc1-468774a72332”). |
| $HOSTGROUPNOTES$     | Not implemented in openITCOCKPIT                                                                                                       |
| $HOSTGROUPNOTESURL$  | Not implemented in openITCOCKPIT                                                                                                       |
| $HOSTGROUPACTIONURL$ | Not implemented in openITCOCKPIT                                                                                                       |
|Service Macros|
| $SERVICEDESC$            | The UUID of the service (“bd19ce04-3209-4664-a146-bd1220e740bc”)                                                                                  |
| $SERVICEDISPLAYNAME$            | Human-readable name of the service (“PING”)                                                                                                            |
| $SERVICESTATE$           | Current service status as a string (“OK”, “WARNING”, “UNKNOWN”, or “CRITICAL”).                                                                     |
| $SERVICESTATEID$         | Current service status as an integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                        |
| $LASTSERVICESTATE$       | Last service status as a string (“OK”, “WARNING”, “UNKNOWN”, or “CRITICAL”).                                                                         |
| $LASTSERVICESTATEID$     | Last service status as a string (“OK”, “WARNING”, “UNKNOWN”, or “CRITICAL”).                                                                           |
| $SERVICESTATETYPE$       | Current service status type as a string (“SOFT” or “HARD”).                                                                                          |
| $SERVICEATTEMPT$         | Current checking attempt as an integer                                                                                                                  |
| $MAXSERVICEATTEMPTS$     | Maximum number of service check attempts                                                                                                             |
| $SERVICEISVOLATILE$      | Is volatile as integer (0=NO, 1=YES)                                                                                                           |
| $SERVICEEVENTID$         | Number of status change events as a unique number per service                                                                                      |
| $LASTSERVICEEVENTID$     | Last unique service event number                                                                                                                |
| $SERVICEPROBLEMID$       | Unique number of the current service problem state                                                                                              |
| $LASTSERVICEPROBLEMID$   | Unique number of the current service problem state                                                                                                |
| $SERVICELATENCY$         | Delay between planned checking time and actual checking time as a float (“2.05”)                                                              |
| $SERVICEEXECUTIONTIME$   | Plugin execution time as a float (“4.21”).                                                                                                |
| $SERVICEDURATION$        | Time since last status change as a string (HH MM SS)                                                                                        |
| $SERVICEDURATIONSEC$     | Time since last status change as an integer in seconds                                                                                       |
| $SERVICEDOWNTIME$        | If the service is in a planned maintenance time, this value is >= 1                                                                                  |
| $SERVICEPERCENTCHANGE$   | Percentage of status change as a float (Used by flap detection algorithm)                                                        |
| $SERVICEGROUPNAME$       | Contains the first service group of a service as a string ("6123eb90-a3eb-4895-b348-c464d9494d14")                                                  |
| $SERVICEGROUPNAMES$      | Comma-separated list of all service groups to which the service belongs (“6123eb90-a3eb-4895-b348-c464d9494d14,666b1caf-4c0f-45e8-9380-78f9e915b82d”) |
| $LASTSERVICECHECK$       | Unix timestamp (integer) of the last service check                                                                                               |
| $LASTSERVICESTATECHANGE$ | Unix timestamp (integer) of the last service state change                                                                                            |
| $LASTSERVICEOK$          | Unix timestamp (integer) of the last service OK status                                                                                            |
| $LASTSERVICEWARNING$     | Unix timestamp (integer) of the last service WARNING status                                                                                       |
| $LASTSERVICECRITICAL$    | Unix timestamp (integer) of the last service CRITICAL status                                                                                      |
| $LASTSERVICEUNKNOWN$     | Unix timestamp (integer) of last service UNKNOWN status                                                                                       |
| $SERVICEOUTPUT$          | Output des Service Prüf Plugin ("OK - 127.5.6.7: rta 0,054ms, lost 0% ").                                                                         |
| $LONGSERVICEOUTPUT$      | Long plugin output des Aktuellen Service checks.                                                                                                  |
| $SERVICEPERFDATA$        | Performance daten output des Aktuellen Service checks. ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                                 |
| $SERVICECHECKCOMMAND$    | Enthält die Kommando UUID sowie dessen Agrumente ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0,80%!4000.0,90%;")                        |
| $SERVICEACTIONURL$       | Nicht Implementiert in openITCOCKPIT.                                                                                                                 |
| $SERVICENOTESURL$        | Nicht Implementiert in openITCOCKPIT.                                                                                                                 |
| $SERVICENOTES$           | Benutzerdefinierte Notizen für den Service                                                                                                                   |
|Servicegruppen Makros|
| $SERVICEGROUPALIAS$    | UUID der Hostgruppe ("65c7692e-b322-4788-8232-97258b457f22")                                                                        |
| $SERVICEGROUPMEMBERS$  | Kommaseparierte Liste der Servicegruppen Mitglieder als UUIDs ("0a9feda1-569e-40fe-a5a3-b2f389818301,ade06bfb-f9bd-4112-9537-2b3d286a6572"). |
| $SERVICEGROUPNOTES$    | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTESURL$ | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTES$    | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
|Kontakt Makros|
| $CONTACTNAME$       | UUID des Kontakt ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0")                                                                                  |
| $CONTACTGROUPNAME$  | Lesbarer Name des Kontakt ("info").                                                                                                           |
| $CONTACTALIAS$      | Lesbarer Name des Kontakt ("info"), same as $CONTACTGROUPNAME$                                                                                |
| $CONTACTEMAIL$      | Email Adresse des Kontakt. ("community@openitcockpit.io")                                                                                      |
| $CONTACTPAGER$      | Pager Nummer des Kontakt. ("004913456789")                                                                                                     |
| $CONTACTGROUPNAMES$ | Kommaseparierte Liste aller Kontaktgruppen denen der Kontakt angehört. ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112,4992c7ad-1bb4-465a-8fe4-a721461b69a2") |
|Kontaktgruppen Makros|
| $CONTACTGROUPALIAS$   | UUID der Kontaktgruppe ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112")                                                                            |
| $CONTACTGROUPMEMBERS$ | Kommasepariete Liste aller Kontakte die der Kontaktgruppe angehören. ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0,6de7d0f9-413e-41cc-b1e4-3289072b72c4") |
|Zusammenfassungs Makros (INFO: CPU intensiv zu berechenen - mit Vorsicht nutzen!)|
| $TOTALHOSTSUP$                   | Anzahl der Hosts im Status UP.                                                                                              |
| $TOTALHOSTSDOWN$                 | Anzahl der Hosts im Status DOWN.                                                                                            |
| $TOTALHOSTSUNREACHABLE$          | Anzahl der Hosts im Status UNREACHABLE.                                                                                     |
| $TOTALHOSTSDOWNUNHANDLED$        | Anzahl der unbehandelten Hosts. Unbehandelte Hosts sind in einem DOWN Status und nicht bestätigt oder in einer geplanten Wartungszeit.           |
| $TOTALHOSTSUNREACHABLEUNHANDLED$ | Anzahl der unbehandelten hosts. Unbehandelte Hosts sind in einem UNREACHABLE Status und nicht bestätigt oder in einer geplanten Wartungszeit.    |
| $TOTALHOSTPROBLEMS$              | Anzahl der Hosts in einem nicht UP Status.                                                                                        |
| $TOTALHOSTPROBLEMSUNHANDLED$     | Anzahl der unbehandelten Hosts. Unbehandelte Hosts sind in einem nicht UP Status und nicht bestätigt oder in einer geplanten Wartungszeit.         |
| $TOTALSERVICESOK$                | Anzahl der Services im Status OK.                                                                                           |
| $TOTALSERVICESWARNING$           | Anzahl der Services im Status WARNING.                                                                                      |
| $TOTALSERVICESCRITICAL$          | Anzahl der Services im Status CRITICAL.                                                                                     |
| $TOTALSERVICESUNKNOWN$           | Anzahl der Services im Status UNKNOWN.                                                                                      |
| $TOTALSERVICESWARNINGUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem WARNING Status und nicht bestätigt oder in einer geplanten Wartungszeit.  |
| $TOTALSERVICESCRITICALUNHANDLED$ | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem CRITICAL Status und nicht bestätigt oder in einer geplanten Wartungszeit. |
| $TOTALSERVICESUNKNOWNUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem UNKNOWN Status und nicht bestätigt oder in einer geplanten Wartungszeit.  |
| $TOTALSERVICEPROBLEMS$           | Anzahl der Services in einem nicht OK Status.                                                                                     |
| $TOTALSERVICEPROBLEMSUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem nicht OK Status und nicht bestätigt oder in einer geplanten Wartungszeit.   |
|Benachrichtigungsmakros|
| $NOTIFICATIONTYPE$          | Benachrichtigungstyp als String ("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART", "FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND", or "DOWNTIMECANCELLED"). |
| $NOTIFICATIONRECIPIENTS$    | Kommaseparierte Liste aller Kontakte für diese Benachrichtigung. ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")                                           |
| $NOTIFICATIONISESCALATED$   | Ist diese Benachrichtigung eskaliert (0=NO, 1=YES)                                                                                                                                      |
| $NOTIFICATIONAUTHOR$        | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONAUTHORNAME$    | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONAUTHORALIAS$   | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONCOMMENT$       | Kommentar daten der Benachrichtigung.                                                                                                                                                    |
| $HOSTNOTIFICATIONNUMBER$    | Anzahl der gesendeten Benachrichtigungen für einen Host. Geht der Host in einen RECOVERY Status über, wird der Zähler auf 0 zurückgesetzt.                                                                         |
| $HOSTNOTIFICATIONID$        | Eindeutige Event Nummer der Host Benachrichtigung.                                                                                                                                        |
| $SERVICENOTIFICATIONNUMBER$ | Anzahl der gesendeten Benachrichtigungen für einen Service. Geht der Service in einen OK Status über, wird der Zähler auf 0 zurückgesetzt.                                                                         |
| $SERVICENOTIFICATIONID$     | Eindeutige Event Nummer der Service Benachrichtigung.                                                                                                                                     |
|Datum und Zeit Makros|
| $DATE$  | Aktuelles Datum als String (DD-MM-YYYY). |
| $TIME$  | Aktuelle Zeit als String (HH:MM:SS).   |
| $TIMET$ | Aktuelle Zeit als UNIX timestamp.      |
