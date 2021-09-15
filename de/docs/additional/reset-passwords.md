# Passwort zurücksetzen

## Benutzerpasswörter zurücksetzen

!!! info
    Um Passwörter von LDAP (oder anderen Single sign-on Diensten) Nutzern zurückzusetzen, Kontaktieren Sie ihren Single
    sign-on Administrator.

openITCOCKPIT besitzt ein CLI tool um das passwort eines Benutzers zurücksetzen zu können. Es können nur Passwörter von 
Lokalen Accounts zurückgesetzt werden.

```bash
oitc reset_password --print
```

![reset password](/images/oitc_reset_password.png)

Das System ziegt eine Liste aller Benutzer, bei denen das Zurücksetzen des Passwortes möglich ist. 
Mit der `--print` Option wird das Passwort auf dem Terminal angezeigt. Zusätzlich dazu bekommt der Benutzer eine E-Mail
mit dem neuen Passwort zugesendet.

![password mail](/images/oitc_new_password_mail.png)