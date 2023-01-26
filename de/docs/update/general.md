# Allgemeines Update von openITCOCKPIT

Updates von openITCOCKPIT werden über den Paketmanger der jeweiligen Distribution eingespielt.

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

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

Paketquellen aktualisieren
```
dnf --refresh check-update
```

Update durchführen
```
dnf update
```