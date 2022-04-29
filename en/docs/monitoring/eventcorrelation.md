# Event correlation <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

The event correlation module in openITCOCKPIT is a very helpful component when you need a single, overall status for different services.

So what is an “event correlation”? Simply put, an event correlation is a virtual host with virtual services.

When creating an event correlation, a host is created that is derived from the "EVC Template" type host template.

This virtual host is then visible just like any real host in the host overview.

## Creating event correlations

After the host for the event correlation has been created, the event correlation itself can then be edited.

In a new event correlation, a single level is initially visible. At this level, click on the button "New vService".

Several services can be connected to each other by logical operators. After a logical operator is created, a virtual service (vService) is always created, which in turn assumes the status drawn from the services and the operator.

The following operators are possible:

###### AND

The "AND" operator requires that all its services have the status OK so that the virtual service also receives an OK status.

![](/images/EVC-andOperator.png)

###### OR

With the "OR" operator, at least one service must have the status OK for the virtual service to receive an OK status.

![](/images/EVC-orOperator.png)

###### EQUALS

The "EQUALS" operator can only have one service. This operator is suitable for "looping through" a service status in order to use it again in a later level.

![](/images/EVC-eqOperator.png)

###### MIN

The "MIN" operator also requires a number as a specifier. This number indicates how many services must have the status OK so that the virtual service receives an OK status.

![](/images/EVC-min2Operator.png)

Since virtual services are treated like real services by the system, it is possible to add services to a link that are also virtual services from another event correlation.

| Field                               | Required                  | Description                                                                                                                   |
|-------------------------------------|---------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| Basic configuration                 |
| Container                           | :fontawesome-solid-xmark: | [Container](../../configuration/container/#container) in which the host is to be created                                      |
| Host templates                      | :fontawesome-solid-xmark: | [Host template](../../configuration/hosts-services/#host-templates) in which the host is to be created                        |
| Host name / name of the correlation | :fontawesome-solid-xmark: | Name of the host or event correlation to be created                                                                           |
| Description                         |                           | Description of the host template. Will be inherited as the host description                                                   |
| Priority                            |                           | Priority for filtering in lists                                                                                               |
| Checking configuration              |
| Checking period                     | :fontawesome-solid-xmark: | Defines the [timeperiod](../../configuration/timeperiods/#time-periods) in which checks should take place                     |
| Checking interval                   | :fontawesome-solid-xmark: | Defines the interval at which checks should take place. See [intervals](../../configuration/hosts-services/#intervals_2)      |
| Repeat interval                     | :fontawesome-solid-xmark: | Defines the waiting period before a new check takes place after a non-UP status has been reached. See [intervals](../../configuration/hosts-services/#intervals_2) |
| Max. number of checking attempts    | :fontawesome-solid-xmark: | Determines the number of attempts to check a host before it transitions to a hard state. See [Intervalle](../../configuration/hosts-services/#intervals_2)        |
| Notification configuration          |
| Notification period                 | :fontawesome-solid-xmark: | Determines the time period in which notifications are sent for a host                                                         |
| Notification interval               | :fontawesome-solid-xmark: | Defines the interval for notifications sent to this host                                                                      |
| Contacts                            | :fontawesome-solid-xmark: | One or more contacts who will receive notifications about this host                                                           |
| Contact groups                      | :fontawesome-solid-xmark: | One or more contact groups that will receive notifications about this host                                                    |
| Host notification options           |                           | Defines the statuses that must be reached before notifications are sent                                                       |
