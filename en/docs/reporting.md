# Reporting

openITCOCKPIT is able to generate situational reports. These reports can include a wide range of data such as: maintenance times, outages, availability and the current status of individual hosts and services. 

## Instant Reports

Instant Reports in openITCOCKPIT are a variant of reports that can be generated as HTML or PDF and optionally be sent at a user-defined interval.

Instant Reports contain a summary of the status of hosts, services, host groups or service groups, depending on the selection.

## Create Instant Reports

To create an "Instant Report", first click on the "New" button in the "Instant Reports" overview.

Then select a container in the form, assign a name and select the object type to be evaluated.

Depending on the selected object type, select either hosts, host groups, service or service groups to be evaluated in the following field.

The period specifies when the evaluation times should take place.

The reflection state defines whether either only a soft and hard state (hard state or soft state) or only a hard state should be considered.

You have the option to include maintenance times in the report by selecting the option "Include maintenance times".

If the "Summary Display" option is selected, instead of listing individual hosts and their services, only an overall view of the status of the host and services is displayed.

If you want to send a report automatically at an interval of day, week, month or year, you must activate the option "Send e-mail".There you can send the report to one or more users.

| Field                      | Required                  | Description                                                  |
| -------------------------- | ------------------------- | ------------------------------------------------------------ |
| Container                  | :fontawesome-solid-times: | Container in which the immediate report is to be created     |
| Name                       | :fontawesome-solid-times: | Name of the instant report                                   |
| Type                       | :fontawesome-solid-times: | Object type to be evaluated. Host groups, hosts, service groups and services are possible |
| Type-Object                | :fontawesome-solid-times: | Depending on the type selected, either hosts, host groups, services or service groups must be selected in the next field |
| Evaluation                 | :fontawesome-solid-times: | Which objects are evaluated -> Only hosts, hosts and services or only services |
| Time period                | :fontawesome-solid-times: | [Time period](../configuration/timeperiods/) to consider     |
| Reflection State           | :fontawesome-solid-times: | The type of state to be evaluated. Hard state or soft and hard state |
| Consider maintenance times |                           | Determines whether maintenance times are to be taken into account |
| Summary Display            |                           | Determines whether an overall view of the status of host and services is displayed instead of the listings of individual hosts. |
| Send Email                 |                           |                                                              |
| Sending Interval           | :fontawesome-solid-times: | Sending interval: DAY, WEEK, MONTH, YEAR                     |
| User(s) to send            | :fontawesome-solid-times: | User(s) to whom the report is to be sent                     |