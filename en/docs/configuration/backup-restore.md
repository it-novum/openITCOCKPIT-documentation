# Backup & restore

openITCOCKPIT has an integrated tool for creating and importing backups. To use this feature, go to the menu item <kbd><kbd>System Tools</kbd> <i class="fa fa-arrow-right"></i> <kbd>Backup / Restore</kbd></kbd>.

There you have the ability to create backups that will be stored on the openITCOCKPIT server. You can also download an existing backup.

To restore a backup, select the appropriate file from the existing backups in the drop-down list and click on "Start Restore".

If you want to restore a downloaded backup that is not already available on the system, you will need to store the backup file on the server in the `/opt/openitc/nagios/backup` directory.

Once they desired file has been placed on the server, reload the page and you will be able to select the file from the drop-down list and restore the data.

## What data is backed up?

The openITCOCKPIT Backup and Restore Tool creates a backup of the system's MySQL database. This contains the complete configuration of openITCOCKPIT, all hosts and services that are being monitored as well as all users and contacts.

!!! danger
    To save disk space, no historical tables are backed up. If you would like to keep these, they will need to be covered by a separate backup.


## Backup of performance data

In addition to the MySQL database, openITCOCKPIT also saves performance data for creating graphs. This data is stored under `/var/lib/graphite/whisper/openitcockpit/`.

In addition to performing regular full backups, using a file system with a snapshot function such as ZFS or Btrfs is also recommended.
