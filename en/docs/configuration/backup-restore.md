# Backup & restore

openITCOCKPIT has an integrated tool for creating and importing backups. To use this feature, go to the menu item <kbd><kbd>System Tools</kbd> <i class="fa fa-arrow-right"></i> <kbd>Backup / Restore</kbd></kbd>.

There you have the ability to create backups that will be stored on the openITCOCKPIT server. You can also download an existing backup.

To restore a backup, select the appropriate file from the existing backups in the drop-down list and click on "Start Restore".

If you want to restore a downloaded backup that is not already available on the system, you will need to store the backup file on the server in the `/opt/openitc/nagios/backup` directory.

Once they desired file has been placed on the server, reload the page and you will be able to select the file from the drop-down list and restore the data.

## Start a backup via the API

Currently it is not possible to setup a scheduled backup through the openITCOCKPIT interface. How ever, it is possible to trigger the backup method via the HTTP API of openITCOCKPIT.

The following curl command will create a new backup and could be executed by a task scheduler like `cron` or `systemd`.
```bash
curl -k -X POST \
-H "Content-Type: application/json" \
-H "Authorization: X-OITC-API d2083e61fee067077ac239b7d89084f31c16a66f5e2908f6f74009492b600d3d90db2c5f6175ff199c31e1adbdcf6cf089ecadaf1c93c776bc19c7f41feb42b58f2637883b1a1273035f0ade592415f5" \
--data-raw '{"filename":"auto_backup_api"}' \
"https://demo.openitcockpit.io/backups/backup.json"
```

The system will automatically add a timestamp to the given file name. In this case the file name would be: `auto_backup_api_2022-10-06_145725.sql`


## What data is backed up?

The openITCOCKPIT Backup and Restore Tool creates a backup of the system's MySQL database. This contains the complete configuration of openITCOCKPIT, all hosts and services that are being monitored as well as all users and contacts.

!!! danger
    To save disk space, no historical tables are backed up. If you would like to keep these, they will need to be covered by a separate backup.


## Backup of performance data

In addition to the MySQL database, openITCOCKPIT also saves performance data for creating graphs. This data is stored under `/var/lib/graphite/whisper/openitcockpit/`.

In addition to performing regular full backups, using a file system with a snapshot function such as ZFS or Btrfs is also recommended.

