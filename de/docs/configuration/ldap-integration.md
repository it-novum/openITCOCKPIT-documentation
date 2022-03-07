# LDAP Integration

openITCOCKPIT kann für die Benutzerauthentifizierung mit einem LDAP Server verbunden werden. Primär wird dabei die
Verwendung von
_Microsoft Active Directory_ empfohlen und unterstützt. Die Nutzung eines _OpenLDAP Servers_ ist ebenfalls möglich,
jedoch können dann einige Funktionen nur eingeschränkt oder gar nicht zur Verfügung stehen.

## LDAP Authentifizierung

Um eine Authentifizierung gegen LDAP zu aktivieren, müssen Sie zuerst
unter `Systemkonfiguration -> System -> `[`Systemeinstellungen`](/configuration/systemsettings/)
die Daten Ihres LDAP-Servers hinterlegen.

Es wird die Verwendung von _Microsoft Active Directory_ empfohlen.

### Microsoft Active Directory

| Key              | Beschreibung                                                                                                                  | Beispiel                                                               |
|------------------|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| AUTH_METHOD      | Welches Authentifizierungsverfahren von openITCOCKPIT genutzt werden soll.                                                    | PHP LDAP                                                               |
| LDAP.TYPE        | Ob es sich um ein Microsoft Active Directory server oder um einen Open LDAP Server handelt                                    | Active Directory LDAP                                                  |
| LDAP.ADDRESS     | Hostname oder IP-Adresse des zu verwenden LDAP-Servers                                                                        | ad.example.com                                                         |
| LDAP.PORT        | Port-Nummer (389 oder 636)                                                                                                    | 389                                                                    |
| LDAP.QUERY       | LDAP Filter zum Filtern von Benutzern                                                                                         | (&(objectClass=user)(samaccounttype=805306368)(objectCategory=person)(cn=*)) |
| LDAP.BASEDN      | Die zu durchsuchende Base-DN                                                                                                  | DC=ad,DC=example,DC=com                                                |
| LDAP.USERNAME    | Benutzername (sAMAccountName) welcher von openITCOCKPIT genutzt werden soll                                                   | ldap_search                                                            |
| LDAP.PASSWORD    | Password des Benutzers                                                                                                        |                                                                        |
| LDAP.SUFFIX      | Der zu verwendende Suffix                                                                                                     | @ad.example.com                                                        |
| LDAP.USE_TLS     | Plain = Klartext, StartTLS = versucht eine verschlüsselte Verbindung zu nutzen, TLS = erzwingt eine verschlüsselte Verbindung | StartTLS                                                               |
| LDAP.GROUP_QUERY | LDAP Filter zum Filtern von Benutzergruppen                                                                                   | ObjectClass=Group                                                      |



### Open LDAP

| Key              | Beschreibung                                                                                                                  | Beispiel                                      |
|------------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| AUTH_METHOD      | Welches Authentifizierungsverfahren von openITCOCKPIT genutzt werden soll.                                                    | `PHP LDAP`                                    |
| LDAP.TYPE        | Ob es sich um ein Microsoft Active Directory server oder um einen Open LDAP Server handelt                                    | `OpenLDAP`                                    |
| LDAP.ADDRESS     | Hostname oder IP-Adresse des zu verwenden LDAP-Servers                                                                        | `open-ldap.oitc.itn`                          |
| LDAP.PORT        | Port-Nummer (389 oder 636)                                                                                                    | `389`                                         |
| LDAP.QUERY       | LDAP Filter zum Filtern von Benutzern                                                                                         | `(&(objectClass=inetOrgPerson)(uid=*))`       |
| LDAP.BASEDN      | Die zu durchsuchende Base-DN                                                                                                  | `dc=example,dc=com`                           |
| LDAP.USERNAME    | Benutzername (als DN), die von openITCOCKPIT genutzt werden soll                                                              | `uid=ldap_search,ou=people,dc=example,dc=com` |
| LDAP.PASSWORD    | Password des Benutzers                                                                                                        |                                               |
| LDAP.SUFFIX      | Der zu verwendende Suffix                                                                                                     | `<leer>`                                      |
| LDAP.USE_TLS     | Plain = Klartext, StartTLS = versucht eine verschlüsselte Verbindung zu nutzen, TLS = erzwingt eine verschlüsselte Verbindung | `Plain`                                       |
| LDAP.GROUP_QUERY | LDAP Filter zum Filtern von Benutzergruppen                                                                                   | `ObjectClass=posixGroup`                      |


## Importieren von Benutzern

Bevor sich ein LDAP-Benutzer an openITCOCKPIT anmelden kann, ist es zwingen erforderlich den Benutzer zu importieren.
Dies erfolgt unter `Benutzerverwaltung -> Verwalte Benutzer -> `[`Importiere von LDAP`](/configuration/usermanagement/#neuen-benutzer-anlegen-active-directory-ldap)

![Import LDAP User](/images/import-ldap-user.png)

Dies kann auch als Test genutzt werden um zu überprüfen, ob die Verbindung mit dem LDAP-Server erfolgreich hergestellt werden konnte.

**Es wird empfohlen mindestendes einen lokalen Administrator-Benutzer zu erstellen, damit im Falle eines Ausfalls des LDAP-Servers weiterhin eine Zugriffsmöglichkeit auf openITCOCKPIT besteht.**

!!! important
    Für openITCOCKPIT ist es erforderlich, dass die Felder:
     
    Microsoft AD: `'samaccountname', 'mail', 'sn', 'givenname'`
    
    Open LDAP: `'uid', 'mail', 'sn', 'givenname'`
    
    befüllt sind. Benutzer die diese Anforderung nicht erfüllen, werden automatisch ausgeblendet.
    Sobald openITCOCKPIT Benutzer ausblendet, wird dies mit der Zeile `2022-01-07 15:42:06 warning: Dropped 51/100 AD/LDAP users due to missing required fields. [samaccountname, mail, sn, givenname]` in der Logdatei `/opt/openitc/frontend/logs/error.log` angezeigt.

## Importieren von Gruppen
!!! info
    Benötigt openITCOCKPIT ≥ 4.4.0


openITCOCKPIT importiert automatisch alle 24 Stunden alle verfügbaren LDAP Gruppen und speichert diese in der Datenbank.

Dieser Prozess kann über den Befehl `oitc cronjobs -f` manuell durchgeführt werden.
```
Scan for new LDAP groups. This will take a while...
Imported 50 groups, removed 3 groups from database.
   Ok
```

## Automatische Berechtigungen über LDAP-Gruppen

openITCOCKPIT unterstützt das automatische zuweisen von [Benutzer Container Rollen](/configuration/usermanagement/#benutzer-container-rollen) und [Benutzer Rollen](/configuration/usermanagement/#benutzer-rollen-verwalten)
über LDAP-Gruppen. Dies steht nur bei Benutzern zur Verfügung, welche aus dem LDAP-Importiert wurden.

openITCOCKPIT fragt dazu alle 24 Stunden die aktuellen Gruppen aller hinterlegten LDAP-Benutzer ab und gleicht diese mit den Benutzer Container Rollen und Benutzer Rollen ab.

Dieser Prozess kann über den Befehl `oitc cronjobs -f` manuell durchgeführt werden.
```
Assign User Container Roles that have LDAP associations to users
Query LDAP groups from LDAP for user dziegler
Query LDAP groups from LDAP for user ibering
   Ok
```

### LDAP-Gruppen zu Benutzer Container Rollen zuweisen
Jeder User Container Rolle kann optional eine (oder mehrere) LDAP-Gruppen zugewiesen werden. openITCOCKPIT wird diese Information nutzen und automatisch allen
Benutzern, welche in den hinterlegten LDAP-Gruppen sind, die User Container Rolle zuweisen.
![Linking User Container Roles with LDAP groups](/images/ldap-user-container-roles.png)

Einem Benutzer können mehre User Container Rollen zugewiesen werden. Somit ist eine maximale flexibilität gewährleistet. User Container Rollen entscheiden darüber, welche
Objekte (Hosts, Servicevorlagen, Reports, usw) ein Benutzer sehen oder bearbeiten darf.


### LDAP-Gruppen zu Benutzer Rollen zuweisen
Jeder Benutzer Rolle kann optional eine (oder mehrere) LDAP-Gruppen zugewiesen werden. openITCOCKPIT nutzt diese Information um LDAP-Benutzern beim Login automatisch einer
Benutzer Rolle zuzuweisen. Da einem Benutzer nur eine Rolle zugewiesen werden kann, werden im Falle von mehren Treffern die Benutzer Rollen alphabetisch sortiert und die erste Benutzer Rolle genommen.
Somit ist eine manuelle priorisierung durch die Benamung möglich.
![Linking User Roles with LDAP groups](/images/ldap-user-roles.png)

Da jedem Benutzer eine Benutzer Rolle zugewiesen werden muss, muss beim Erstellen eines LDAP-Users eine `Fallback Benutzer Rolle` angegeben werden. Diese Rolle wird immer dann genommen,
wenn dem Benutzer über LDAP keine Benutzer Rolle zugewiesen werden kann. Es wird empfohlen, eine `LDAP Fallback User Role` zu erstellen, welche keine Berechtigungen enthält.

Somit sieht ein Benutzer, dem keine Benutzerrolle zugewiesen werden konnte, nur das Dashboad von openITCOCKPIT. Im Gegensatz zu
_User Container Rollen_ entscheiden Benutzer Rollen darüber, welche Aktionen von einem Benutzer ausgeführt werden dürfen.

### Importieren eines LDAP-Benutzers mit automatischer Gruppenzuweisung (Beispiel)
In diesem Beispiel wird ein neuer Benutzer über LDAP importiert. Das System hat dabei die User Container Rollen und die Benutzer Rolle automatisch dem Benutzer zugewiesen.
![Import a new LDAP-User and automatically assign user container roles and a user role](/images/import-ldap-user-auto-assign-groups.png)**





