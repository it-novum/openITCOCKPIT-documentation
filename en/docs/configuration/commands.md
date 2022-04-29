# Commands

Commands are an essential part of openITCOCKPIT. These define how and with which parameters a command script is to be
called.

In openITCOCKPIT it is possible to define service, host, notification, and event handler commands.

## Creating commands

Go to `Monitoring -> Objects -> Commands` and click the `+ New` button.

Choose your command type

| Field        | Required                  | Description                                                                                                                                                     |
|--------------|---------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Command type | :fontawesome-solid-xmark: | Command type: [service](#service-check-command), [host](#host-check-command), [notification](#notification-command) or [event handler](#event-handlers) command |
| Name         | :fontawesome-solid-xmark: | Command name                                                                                                                                                    |
| Command line | :fontawesome-solid-xmark: | Command line command with [macros](#standard-macros-and-custom-macros) and arguments                                                                            |
| Description  |                           | Description of the command                                                                                                                                      |
| Arguments    |                           | Parameters to be passed to the test script. See [Arguments](#arguments)                                                                                         |

![edit ping command](/images/commands-edit-ping.png)

### Service check command

A service check command is a command that is executed by the monitoring engine. These types of commands are usually
stored on the openITCOCKPIT server under the path `/opt/openitc/nagios/libexec`.

Through the use of arguments ($ARG1$ - $ARG32$), for example, threshold values can be passed from the service to the
command. Only the name of an argument is assigned in the command itself. It gets its value from a service.

### Host check command

Host check commands work the same as service check commands. The only difference here is that the command is made
availble to hosts via the command type.

### Notification command

Notification commands are commands used by the contacts in openITCOCKPIT. The notification commands in openitcockpit are
usually PHP scripts which are either contained in the core or in installable modules.

### Event handlers

Event handler commands define optional system commands (scripts or executables) that run whenever a host or service
changes state.

One use of these is to let Nagios proactively resolve issues before needing to notify anyone.

Examples:

- Restarting a failed service
- Opening a "Trouble Ticket" in a ticketing system
- Logging event information in the database
- etc.

#### When are event handlers executed?

Event handlers are executed when a host or service:

- is in a SOFT problem status
- initially enters a HARD problem status
- is initially recovering from a SOFT or HARD problem status

For more information about event handlers, see
the [Official Naemon Documentation](https://www.naemon.io/documentation/usersguide/eventhandlers.html).

### Standard macros and custom macros

An overview of all available [standard macros](../macros/#default-macros)that, for example, can be used on the command
line can be found in the top bar whenever you create or edit a command. An overview of
the [user-defined macros](../macros/) can also be found under "$USERn$".

![default macros](/images/UserDefinedMacros-DefaultMacroOverview.png)

### Command line

The command line is where all the actual command "magic" takes place. This is where you will call the check script from.
A check script expects transfer parameters such as host address, threshold values or configuration parameters. These are
then passed via variables, referred to as [arguments](#arguments)
and [macros](#standard-macros-and-custom-macros). Arguments are defined in the optional arguments fields (at
the bottom of the “Create Command” / “Edit Command” form) and can then be included as variables in the command line
command.

![macros and args](/images/commands-commandline-macros-args.png)

### Arguments

Arguments are passed from the command to the check script as transfer parameters. For any given command, no fixed value
is defined for an argument, but rather only the name of the argument. The values (here based on threshold values for a
service check command) are then transferred in the service template after the corresponding check command has been
selected. This means a command can be used by several templates with different threshold values.

Arguments in the command configuration:

![command args](/images/commandargs.png)

Arguments in the service template configuration:

![servicetemplate command args](/images/servicetemplate-commandargs.png)
