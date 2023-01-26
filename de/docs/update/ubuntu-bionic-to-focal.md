# Update von Ubuntu Bionic (18.04) auf Ubuntu Focal (20.04)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, das zugrundeliegende Betriebssystem aktuell zu halten.
Mit dieser Anleitung können Sie Ihr Ubuntu Bionic System auf Ubuntu Focal aktualisieren.

##  Voraussetzungen
 -  openITCOCKPIT in der Version 4.x
 -  Keine Pakete die `lxd` beinhalten.

## Entfernen aller `lxd` Pakete
Sollten auf Ihrem System `lxd` Pakete installier sein, müssen diese zuerst entfernt werden. Prüfen können Sie dies mit dem Befehl
```
apt list --installed | grep lxd
```

Sollten Pakete installiert sein, müssen diese zuerst entfernt werden
```
apt -y remove lxd*
```



