# Downtimes

## Maintenance times

Under Maintenance Times, a range of maintenance times can be created for hosts, services, host groups and containers.

Maintenance times are not considered as system failures in reports.

### Host maintenance times

A host maintenance time is a maintenance period for a single host or individual hosts and their services.

| Field | Required | Description |
|---|---|---|
| Hosts	| :fontawesome-solid-times:	| Hosts for which a maintenance time is to be created |
| Maintenance time for| :fontawesome-solid-times:	| Here you can define whether a maintenance time is to be created for the host only or for the host as well as its services. |
| Comments | | Comments for the maintenance time being created |
| Recurring maintenance times | | If this option is enabled, a start time, duration, day(s) of the week or day of the month can be set for the recurring maintenance time. |
| Single maintenance time	| | | 	
| From | :fontawesome-solid-times: | Date and time when the maintenance time should start |
| To | :fontawesome-solid-times: | Date and time when the maintenance time should end Recurring maintenance times |
| Start time | :fontawesome-solid-times: | Time when the recurring maintenance time should start |
| Duration | :fontawesome-solid-times: | Duration of the recurring maintenance time |
| Weekdays | :fontawesome-solid-times: | On which day of the week should the recurring maintenance time take place? |
| Day of the month | :fontawesome-solid-times: | On which day of the month should the recurring maintenance time take place? |

### Service maintenance times

A service maintenance time is a maintenance period for one or more services. These services can be from  different hosts.

| Field | Required | Description |
|---|---|---|
| Services	| :fontawesome-solid-times:	| Services for which a maintenance time is to be created |
| Comments | | Comments for the maintenance time being created |
| Recurring maintenance times | | If this option is enabled, a start time, duration, day(s) of the week or day of the month can be set for the recurring maintenance time. |
| Single maintenance time | | |
| From	| :fontawesome-solid-times:	| Date and time when the maintenance time should start |
| To | :fontawesome-solid-times: | Date and time when the maintenance time should end |
| Recurring maintenance times | | |
| Start time	| :fontawesome-solid-times:	| Time when the recurring maintenance time should start |
| Duration | :fontawesome-solid-times: | Duration of the recurring maintenance time |
| Weekdays | :fontawesome-solid-times: | On which day of the week should the recurring maintenance time take place? |
| Day of the month | :fontawesome-solid-times: | On which day of the month should the recurring maintenance time take place? | 

### Host group maintenance times

A host group maintenance period is similar to a host maintenance period. However, entire host groups as well as their services can be included in a maintenance period.

| Field | Required | Description |
|---|---|---|
| Host groups	| :fontawesome-solid-times:	| Host group for which a maintenance time is to be created |
| Maintenance time for | :fontawesome-solid-times: | Here you can define whether a maintenance time is to be created for the hosts only or for the hosts as well as their services. |
| Comments | | Comments for the maintenance time being created |
| Recurring maintenance times | | If this option is enabled, a start time, duration, day(s) of the week or day of the month can be set for the recurring maintenance time. |
| Single maintenance time | | |
| From | :fontawesome-solid-times: | Date and time when the maintenance time should start |
| To | :fontawesome-solid-times: | Date and time when the maintenance time should end |
| Recurring maintenance times | | |
| Start time | :fontawesome-solid-times: | Time when the recurring maintenance time should start |
| Duration | :fontawesome-solid-times: | Duration of the recurring maintenance time |
| Weekdays | :fontawesome-solid-times: | On which day of the week should the recurring maintenance time take place? |
| Day of the month | :fontawesome-solid-times: | On which day of the month should the recurring maintenance time take place? |

### Container maintenance times

A container maintenance time enables complete containers to be placed into a maintenance period in openITCOCKPIT. You can also select whether only the specified container itself or whether its child containers are also recursively included in the maintenance time.

| Field | Required | Description |
|---|---|---|
| Host	| :fontawesome-solid-times:	| Containers for which a maintenance time is to be created |
| Recursive container look-up | | If this option is enabled, the child containers for the specified container are also included in the maintenance time. |
| Maintenance time for | :fontawesome-solid-times: | Here you can define whether a maintenance time is to be created for the host only or for the host as well as its services. |
| Comments | | Comments for the maintenance time being created |
| Recurring maintenance times | | If this option is enabled, a start time, duration, day(s) of the week or day of the month can be set for the recurring maintenance time. |
| Single maintenance period |	
| From | :fontawesome-solid-times: | Date and time when the maintenance time should start |
| To	| :fontawesome-solid-times:	| Date and time when the maintenance time should end |
| Recurring maintenance times |
| Start time | :fontawesome-solid-times: | Time when the recurring maintenance time should start |
| Duration | :fontawesome-solid-times: | Duration of the recurring maintenance time | 
| Weekdays | :fontawesome-solid-times: | On which day of the week should the recurring maintenance time take place? | 
| Day of the month | :fontawesome-solid-times: | On which day of the month should the recurring maintenance time take place? |

### Recurring maintenance times

Recurring maintenance times can be created for all the above maintenance types. To do this, the option "Recurring maintenance time" must be activated. Then, instead of the standard "From - To" input fields, there is now a field for the start time, the duration of the maintenance time and on which weekday or day of the month the maintenance should take place.

### Cancelling maintenance times

You can also cancel maintenance times. There are two ways to do this. To cancel a maintenance time for an individual host or service, click on the "Delete" button of the respective object in the maintenance time overview.

If you want to cancel several maintenance times, mark the corresponding hosts or services and select the button "Delete selected" at the bottom of the overview.

## System outages

System outages are outrages of the openITCOCKPIT server itself. These must be created manually.

Time frames defined by system outages are ignored when generating reports.
