# Cron jobs

Cron jobs in openITCOCKPIT offer users the ability to run PHP scripts at defined time intervals. These PHP scripts (called tasks) are part of the openITCOCKPIT core or modules.

To create a new cron job, first select the location of the task you want to perform under “Plugin”. The available tasks will then be displayed in the next drop-down list.

!!! warning
    Cron jobs are an important component of how openITCOCKPIT functions and so should only be edited by experienced users.

| Field        | Required                  | Description                                                  |
|--------------|---------------------------|--------------------------------------------------------------|
| Enhancements | :fontawesome-solid-xmark: | Task to be executed                                          |
| Tasks        | :fontawesome-solid-xmark: | Task to be executed                                          |
| Interval     |                           | Interval (in minutes) at which the task should be executed   |
| Activated    |                           | If the task is to be executed, this checkbox must be ticked. |

## Systemd Timer
Contrary to what the name suggests, openITCOCKPIT's cron jobs are not executed via the `cron daemon`, but rather use the systemd timer function.

```
systemctl status oitc_cronjobs.timer
```

## Executing cron jobs

All cron jobs can be force executed using the command

```
oitc cronjobs -f
```

The `-f` (or `--force`) parameter forces all cron jobs to run, regardless of the configured interval.

The execution of a single cron job can be triggered by specifying the parameter `-t` (or `--task`).
If the execution should be forced, regardless of the configured interval, the parameter `-f` must also be specified.
![Forced execution of a single cron job](/images/configuration/force_execution_of_one_cronjob.png)

### Liste of all cron jobs
A list of which cron jobs are available on the system can be viewed using the `-l` (or `--list`) parameter
![List of all available cron jobs](/images/configuration/list_of_cronjobs.png)
