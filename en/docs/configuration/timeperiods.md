# Time periods

Time periods are a central component in openITCOCKPIT that can be used for performing a variety of tasks. They define fixed periods of time within a week. These can be used, for example, for notification periods, checking periods or host and service dependencies. Additional public holidays can also be taken into account via the calendar.

### Creating a time period

To create a time period, navigate in the main menu to `Monitoring -> Objects -> Time Periods` and click on the "New" button in the overview.

![timeperiod overview](/images/timeperiod-overview.png)

In the form that opens, select a container and assign a name for the time period you wish to create.

You can then include a custom calendar. The public holidays entered will then be included in the selected time ranges.

You can add new ranges via the "Add" button. These define the days of the week with a start and end time. Everything that is not defined there will fall outside the time period. If, for example, the time period is used for email notifications, no email notification will be sent if a notification is outside the defined time period.

![timeperiod new](/images/timeperiod-new.png)


| Field | Required | Description |
|---|---|---|
| Container | :fontawesome-solid-times: | [Container](../container/)for which the time period is to be visible |
| Name | :fontawesome-solid-times: | Name of the time period |
| Description |  | Description of the time period |
| Calendar | :fontawesome-solid-times: | [Calendar](../calendar/) |
