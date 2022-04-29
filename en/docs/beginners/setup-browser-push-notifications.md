# Setting up browser push notifications

Most modern web browsers like Mozilla Firefox, Google Chrome or Microsoft Edge offer a notification API.

Using this, openITCOCKPIT can send host or service notifications to your browser.

Examples:

![browser notifications](/images/example_browser_notifications.png)

## Prerequisites

- Modern web browser
- Manually setting permissions in the browser
- openITCOCKPIT must be open in a browser tab (a browser window can run in the background or the taskbar)
- A contact must be assigned to a user
- `Push notifications to the browser` must be enabled in the contact configuration
- `push_notification.service` must be running on the openITCOCKPIT server

## Setting up push notifications

### Browser Berechtigungen

Before openITCOCKPIT can send push notifications to your web browser, you must first manually grant your permission for this. This is a security feature of all browsers that prevents random websites from being able to send spam messages. You can allow or deny these notifications whenever you want.

In this example we will go through the process using Mozilla Firefox.

#### Granting permission

Click on the notification icon in the browser address bar and then click on "Allow notifications".

![browser ask for permissions](/images/browser_ask_for_notification_permissions.png)

!!! info 
    If you remove the authorisation at a later point, you should also deactivate `push notifications to the browser` in the contact configuration

## Edit or create a new contact

In order to receive push notifications, you must link your user account to a monitoring engine contact. By default, no contact is linked to any user account that exists in the openITCOCKPIT interface.

Navigate to `Monitoring -> Objects -> Contacts` and select the contact you want to enable push notifications for.

Assign your user to the contact and enable `push notifications to the browser`.

!!! info 
    The command `host-notify-by-browser-notification` and/or `service-notify-by-browser-notification` wird automatisch ausgewählt. is selected automatically. If the commands are missing, read the [Troubleshooting](#troubleshooting) part of this article.

You can also combine different notification commands like `notify by email` and `browser
notifications` etc.

![contact browser push notfications](/images/contact-browser-push-notifications.png)

After updating the contact, you must also [update the monitoring configuration as well](../create-first-host/#updating-the-monitoring-configuration).

## Notification examples

Each notification includes an icon for a host or service. And each respective status can be distinguished by its own icon colour. Clicking on a notification will open a new browser tab and take you directly to the relevant host or service. The notification will disappear automatically after a few seconds.

![browser notifications](/images/example_browser_notifications.png)

*Note: The notification design depends on the user's operating system. Notifications may look different on other operating systems. The style, however, cannot be changed.*

## Troubleshooting

- Reload the page: `Ctrl + R` or `Cmd + R`

- Connection problems. If your browser loses its connection to the openITCOCKPIT server, you will no longer receive push notifications. Reload the page and this will fix the problem.

- `push_notification` service is not running. In order to receive push notifications, this background process must be running. However, you may also find the web server or reverse proxy configuration can also cause problems. You can use your web browser's developer tools to detect any connection errors. For example: Error message: `push_notification` not running

![push connection error](/images/push_connection_error.png)

Successfully connected:

![push connection successful](/images/push_connection_successfully.png)

If the `push_notification` service is not running, a warning will appear on the troubleshooting page and in the system status display.

![debug push notifications](/images/debug-processes-push-notifications.jpg)

- Some applications suppress browser notifications. For example, under Microsoft Windows 7 the `Snipping Tool` can cause problems. Reloading the openITCOCKPIT website will resolve this issue.

- MacOS may be running in *Nicht Stören* mode. This can also happen automatically, for example when connecting a beamer or TV screen.

![macos dnd](/images/macOS_dnd.png)

- Too many notifications can also cause notifications to be suppressed. Try reducing the number of push notifications to resolve this issue.
- Check your web browser for updates.
- Do the notifications work in Internet Explorer? No.
