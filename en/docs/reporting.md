# Reporting

openITCOCKPIT is able to generate situational reports. These reports can include a wide range of data such as: maintenance times, outages, availability and the current status of individual hosts and services. 

## Instant Reports

Instant Reports in openITCOCKPIT are a variant of reports that can be generated as HTML or PDF and optionally be sent at a user-defined interval.

Instant Reports contain a summary of the status of hosts, services, host groups or service groups, depending on the selection.

### Create a Instant Reports

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

### Generate a Instant Report

When you have created an "Instant Report", click on the menu of the corresponding "Instant Report" (1) and then on the "Generate" button (2).

![](/images/instantreports-generate.png)


In the form that opens, you then enter the format in which the report is to be generated and the time period to be considered.

The report will then be displayed in the browser or made available for download.



## Current Status Report



The "Current Status Report" generates a report in HTML or PDF format based on selected services.

In addition to the status filter functions, it is also possible to filter by confirmations, maintenance times and the inspection type.

The generated report contains the host status of the selected services as well as the various metrics (performance data) of the services.

| Field         | Required                  | Description                       |
| ------------- | ------------------------- | --------------------------------- |
| Services      | :fontawesome-solid-times: | Services that are to be evaluated |
| Report format | :fontawesome-solid-times: | Report or Format HTML or PDF      |

## Maintenance Time Reports



Maintenance time reports in openITCOCKPIT provide information about which hosts or which hosts and services were in a maintenance time and when. This is displayed visually using a calendar and diagrams.

### Create a Maintenance Time Report



To create a maintenance time report, click on the item "Maintenance time reports" in the main menu.

There you select whether only hosts or hosts and services are to be evaluated.

For the report format, you have the choice between an HTML report that is displayed in the browser or a PDF report that is offered for download.

The time period defines which maintenance times are to be taken into account.

The reflection state defines whether either only a soft and hard state (hard state and soft state) or only a hard state should be taken into account.

| Field            | Required                  | Description                                                  |
| ---------------- | ------------------------- | ------------------------------------------------------------ |
| Evaluation       | :fontawesome-solid-times: | Hosts or hosts including services                            |
| Report Format    | :fontawesome-solid-times: | Report format HTML or PDF                                    |
| Time Period      | :fontawesome-solid-times: | [Time period](../configuration/timeperiods/) to consider     |
| From             |                           | Start period of evaluation                                   |
| To               |                           | End period of evaluation                                     |
| Reflection State | :fontawesome-solid-times: | The type of state to be evaluated. Hard state or soft and hard state |
| Dynamic Colour   |                           | If there is an error, different colours are shown            |

## Autoreports CE

The auto report module in openITCOCKPIT is a configurable report that can be sent automatically. A report contains the downtime, maximum permissible downtime and the availability of the selected hosts and services.

### Create an Autoreport 



To create an auto report, first click on the "New" button in the auto reports overview.

The Auto report Wizard opens and guides you through the creation of the report.

First select a container for the report and assign a name.

Then select a time period for the evaluation.

The evaluation period defines the period of time from which the report is to be evaluated.

The sending interval defines the period when the report is to be sent.

After that, you either enter a guaranteed availability in percent or the maximum number of failures.

The displayed graphs can be shown either in percent or in hours. To specify this, you must make a selection in the "Graph" field.

The reflection state defines whether either only a soft and hard state (hard state and soft state) or only a hard state should be taken into account.

To prevent maintenance times from being displayed as failures in the report, you can activate the option "Consider maintenance times".

In order to additionally consider public holidays, activate the option "Consider public holidays" and then select a calendar.

In order for the report to be sent, at least one user must also be selected.

In the next step, select the hosts that are to be evaluated in the report.

An overview of the services of all selected hosts appears. Here you can select how they are to be evaluated.

In the last step you will see an overview of the configured settings for the report. If everything fits, click on "Done".

The report will now be sent automatically at the specified time. You also have the option of generating the report directly as a PDF or HTML file. To do this, click on "Generate Report" in the menu of the corresponding report.

Then select the output format and the time period to be evaluated. After clicking on "Generate report", you will either be offered the report as a PDF for download or it will be displayed directly in the browser in the HTML version.

#### Report Configuration

| Field                      | Required                  | Description                                                  |
| -------------------------- | ------------------------- | ------------------------------------------------------------ |
| Container                  | :fontawesome-solid-times: | Container in which the Autoreport is to be created           |
| Report name                | :fontawesome-solid-times: | Name of the Autoreport                                       |
| Report description         |                           | Description of the Autoreport                                |
| Set Start                  |                           | Start date of the report is to be defined                    |
| Start date                 |                           | Start date of the report. Can only be edited if "Set Start" has been activated. |
| Time period                | :fontawesome-solid-times: | [Time period](../configuration/timeperiods/) to consider     |
| Evaluation Period          | :fontawesome-solid-times: | Day, Week, Month, Quarter or Year                            |
| Transmission interval      | :fontawesome-solid-times: | Daily, Weekly, Monthly, Quarterly, Yearly or Never           |
| Guaranteed availability    | :fontawesome-solid-times: | Availability in percent. Either "Guaranteed availability" or "Maximum number of failures" must be specified |
| Maximum number of outages  | :fontawesome-solid-times: | Maximum number of outages. Either "Guaranteed availability" or "Maximum number of outages" must be specified |
| Graph                      | :fontawesome-solid-times: | Graph in percent or hours                                    |
| Reflection State           | :fontawesome-solid-times: | The type of state to be evaluated. Hard state or soft and hard state |
| Consider maintenance times |                           | Maintenance times do not count as outages if enabled         |
| Consider public holidays   |                           | Public holidays are considered                               |
| Calendar                   |                           | Calendar with public holidays. Only configurable if "Consider Holidays" is enabled. |
| User(s)                    |                           | User(s) to whom the report is to be sent                     |



#### Host and Service Configuration

| Field         | Required                  | Description                               |
| ------------- | ------------------------- | ----------------------------------------- |
| Hosts         | :fontawesome-solid-times: | Hosts that are to be evaluated            |
| Service RegEx |                           | Filter for services as regular expression |

### Autoreport Globals

In the main menu under System Configuration → System → Autoreport Globals, various standard settings for the autoreports can be set. Descriptions of the individual options can be found directly in the table under the "Info Button".

![](/images/autoreportModule-globalsinfo.png)

Please note that the options you set there affect all reports generated via the Autoreport module.
will be affected!
