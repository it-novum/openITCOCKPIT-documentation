# Allgemeines Update von openITCOCKPIT

Updates von openITCOCKPIT werden über den Paketmanger der jeweiligen Distribution eingespielt.

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

!!! warning "E-Mail Konfiguration"
    Sofern Änderungen an der E-Mail-Konfiguration vorgenommen wurden, sollte die Datei **/opt/openitc/frontend/config/email.php** vor einem Backup gesichert und danach wiederhergestellt werden.

Führen Sie alle Kommandos als `root` Benutzer aus.

## Ubuntu / Debian

Paketquellen aktualisieren
```
apt-get update
```

Update durchführen
```
apt-get dist-upgrade
```


## Red Hat Enterprise Linux

!!! danger
    openITCOCKPIT erwartet, dass die Linux-Standard-Umask auf `022` eingestellt ist (Standard für die meisten Linux-Distributionen).
    Wenn Sie unsicher sind, ändern Sie die Umask auf `022`, bevor Sie mit dem Update fortfahren.
    ```
    umask 0022
    ```

Paketquellen aktualisieren
```
dnf --refresh check-update
```

Update durchführen
```
dnf update
```