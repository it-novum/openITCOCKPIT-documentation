# Jira <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## What can I do with the Jira module?

The Jira Module adds support to create Jira Issues from openITCOCKPIT notifications. Further more, Jira can acknowledge issues in openITCOCKPIT through a Webhook.

When a host or service sends a notification, openITCOCKPIT will create a new Jira Issue. Only one Issue will be create per host or service problem. openITCOCKPIT will also close open Issues, when a host or service
switches back into a recovery state.

openITCOCKPIT supports **Jira Cloud** and **Jira Data Center** installations.

## Configuration

To Setup the Jira integration, navigate to `APIs` -> `Jira`.

Select the Jira type, enter the Jira URL an API Token. For Jira Cloud, also a Username is required. Click on "Refresh Jira Projects" to load a list of available Jira Projects from your Jira Server.

openITCOCKPIT can create issues in different Jira Projects. Select all Jira Projects, you want to create issues in.
It is required to select at least one project.
If you select more than one project, you need to mark one project as the `Default Project`. All issues will be created in the default project. To overwrite the default project, set the `JIRA_PROJECT` custom variable to the Jira Project key
(e.g. `PX` or `SUP`) in the contact, host or service configuration. Please see the macros section.

![openITCOCKPIT Jira Integration settings](/images/alerting/jira/datacenter/openitcockpit_jira_integration.png)

### Close transition ID

To close a Jira Issue, openITCOCKPIT needs to know the ID of the close transition. openITCOCKPIT requires the transition id, to close Jira issues automatically, in the a host or servics recovers.
If you do not provide a transition id or enter a wrong ID, openITCOCKPIT will still create Issues in Jira, but is unable to close any Issues.

Depending on your workflow, the transition ID can be different. Unfortunately Jira Data Center does not provide a API
to query the transition id. You have to lookup the transition id manually in the Jira Web Interface and enter the number.

Navigate to `Projects` -> Select your Project -> `Workflows` and click on the pencil.
![Jira Settings -> Project](/images/alerting/jira/datacenter/jira_main_menu_projects.png)
![openITCOCKPIT Jira Workflow Transitions](/images/alerting/jira/datacenter/jira_edit_workflow.png)

Now you will see a list of all transitions of the workflow. In this example the `Done` transition will be used to mark Issues as closed with the ID `41`.

![openITCOCKPIT Jira Workflow Done Transitions](/images/alerting/jira/datacenter/project_worksflow_Close_transitions_ID.png)


## Setup Webhooks
With Webhooks, Jira can communicate with openITCOCKPIT. This gets used to add an Acknowledgement to openITCOCKPIT, when a Jira Issue moves from `Backlog` to `In Progress`. The acknowledgement will contain the user, or the assigned user.
Also, Jira will notify when an Issue gets closed in Jira. This ensures that openITCOCKPIT will create a new Issue, in case a problem got not resolved.


!!! danger
    For security reasons it is recommended to create a new openITCOCKPIT User and User Role whiteout any permissions.

To setup Webhooks, an openITCOCKPIT [API Keys](/development/api/#api-keys).


### Jira Data Center
![Jira Settings -> System](/images/alerting/jira/datacenter/jira_main_menu_system.png)

To create a Webhook, you need to navigate to `System` -> `Webhooks` and click on `Create a Webhook` in the top right corner.

#### Acknowledge Webhook

![Jira -> Create a Webhook](/images/alerting/jira/datacenter/1_create_webhook.png)

Copy and past the Webhook URL for acknowledgements, openITCOCKPIT displays in the Jira Settings.

Important Settings are:
- **Name**: `openITCOCKPIT Acknowledge`
- **URL**: *See openITCOCKPIT Jira Settings*
- **Description**: `Used to acknowledge host and Services problems in openITCOCKPIT`

!!! warning
    Jira requires a valid SSL certificate for the Webhook endpoint!

Click on `Create` at the bottom of the page to save the Webhook.

![Jira Create Acknowledge Webhook](/images/alerting/jira/datacenter/2_create_webhook_acknowledge.png)

#### Close Issue Webhook

Create a second Webhook, which will tell openITCOCKPIT when a issue got closed in Jira.

Copy and past the Webhook URL for close issues, openITCOCKPIT displays in the Jira Settings.

Important Settings are:
- **Name**: `openITCOCKPIT Close`
- **URL**: *See openITCOCKPIT Jira Settings*
- **Description**: `Used to notify openITCOCKPIT when a Issue gets closed in Jira`

Click on `Create` at the bottom of the page to save the Webhook.

![Jira Create Acknowledge Webhook](/images/alerting/jira/datacenter/2_create_webhook_close.png)


For more information about Webhooks, please see the official Jira documentation: [https://confluence.atlassian.com/adminjiraserver/managing-webhooks-938846912.html](https://confluence.atlassian.com/adminjiraserver/managing-webhooks-938846912.html)

#### Edit Workflow

It is important o update the Workflow of your Jira project, otherwise Jira will not call the Webhooks and not inform openITCOCKPIT about Issue updates.

![Jira Settings -> Project](/images/alerting/jira/datacenter/jira_main_menu_projects.png)

Navigate to `Projects` and select the corresponding Jira Project. Now click on `Workflows` on the left side, click on your Workflow and than select edit in to top right corner.

![Jira Settings -> Project -> Workflow](/images/alerting/jira/datacenter/3_edit_project_workflow.png)
![Jira Settings -> Project -> Workflow -> Edit](/images/alerting/jira/datacenter/3.1_edit_workflow_via_designer.png)

#### Trigger Acknowledge Webhook

In this case, we want to configure Jira, to create an Acknowledgement in openITCOCKPIT, when a Issue gets moved into `In Progress`. This can differ from your Workflow, how ever the basic principle is the same.
To execute the Webhook, click on `All` and than on `Post Functions` on the right side.

![Jira Settings -> Workflow -> Add Post Function](/images/alerting/jira/datacenter/4_add_webhook_as_post_function.png)

You will see a list of all default post functions. Click on `Add post function`.

![Jira Settings -> Workflow -> Add New Post Function](/images/alerting/jira/datacenter/5_add_post_function.png)

Select `Trigger a Webhook` and select the `openITCOCKPIT Acknowledge` Webhook.

![Jira Settings -> Workflow -> Add New Post Function -> Select Webhook](/images/alerting/jira/datacenter/6_select_trigger_webhook.png)
![Jira Settings -> Workflow -> Add New Post Function -> Select the openITCOCKPIT Webhook](/images/alerting/jira/datacenter/7_select_openitcockpit_acknowledge_webhook.png)

Once you are done, you will see the openITCOCKPIT Webhook got added to the list of post functions. To apply the Settings, it's important to Publish the new Workflow.

![Jira Settings -> Workflow -> Publish](/images/alerting/jira/datacenter/8_acknowledge_webhook_done.png)

#### Trigger Close Webhook

Repeat the steps discriped above, but this time you add the Post Function to your `Done` state.

![Jira Settings -> Workflow -> Add Post Function](/images/alerting/jira/datacenter/9_add_close_webhook.png)
![Jira Settings -> Workflow -> Publish](/images/alerting/jira/datacenter/10_close_webhook_done.png)

## Macros

Macros (custom variables) can be used to overwrite the default Jira Project, add an assignee or parent Issue, to to change the issue type. To be flexible, these settings can be defined as a custom variable
for hosts, services or the contact.

- `JIRA_ASSIGNEE` - Jira Username like `jdoe` which will be assigned to the Issue
- `JIRA_PROJECT` - Project key to overwrite the default project e.g. `PX`
- `JIRA_ISSUE_TYPE` - To overwrite the default Issue Type like `Bug` or `Aufgabe`
- `JIRA_PARENT_ISSUE` - A valid Jira Issue that should be assigned as "related issue" (e.g `PX-30`)

## Commands

By default, openITCOCKPIT will provide the notification commands `host-notifiy-by-jira` and `service-notify-by-jira`. Both can be used in the contact configuration to create Jira Issues from alerts.

**host-notifiy-by-jira**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type host --hostuuid "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --state $HOSTSTATEID$ --output "$HOSTOUTPUT$" --longoutput "$LONGHOSTOUTPUT$"
```

**service-notifiy-by-jira**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type service --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --notificationtype "$NOTIFICATIONTYPE$" --state $SERVICESTATEID$ --output "$SERVICEOUTPUT$" --longoutput "$LONGSERVICEOUTPUT$"
```

You can pass a assignee, project, issue type or parent issue as parameter. Most of the time you will probably use contact, host or service custom variables to do so.
The following examples show how you can pass parameters as custom variables.

![Pass custom variables to the Jira notification command](/images/alerting/jira/datacenter/jira_host_macros.png)

**host-notifiy-by-jira-macros**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type host --hostuuid "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --state $HOSTSTATEID$ --output "$HOSTOUTPUT$" --longoutput "$LONGHOSTOUTPUT$" --jira-assignee "$_CONTACTJIRA_ASSIGNEE$" --jira-project "$_HOSTJIRA_PROJECT$" --jira-issue-type "$_HOSTJIRA_ISSUE_TYPE$" --jira-parent-issue "$_HOSTJIRA_PARENT_ISSUE$"
```

**service-notifiy-by-jira-macros**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type service --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --notificationtype "$NOTIFICATIONTYPE$" --state $SERVICESTATEID$ --output "$SERVICEOUTPUT$" --longoutput "$LONGSERVICEOUTPUT$" --jira-assignee "$_CONTACTJIRA_ASSIGNEE$" --jira-project "$_HOSTJIRA_PROJECT$" --jira-issue-type "$_HOSTJIRA_ISSUE_TYPE$" --jira-parent-issue "$_HOSTJIRA_PARENT_ISSUE$"
```