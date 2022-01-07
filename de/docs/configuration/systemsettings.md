# Systemeinstellungen

Die Systemeinstellungen definieren grundlegende Einstellungen an openITCOCKPIT und sind unter
<kbd><kbd>System</kbd> <i class="fa fa-arrow-right"></i> <kbd>Systemeinstellungen</kbd></kbd>
zu finden.

!!! danger
    Diese Einstellungen sollten nur von erfahrenen Benutzern verändert werden,
    da dies im schlimmsten Fall zum kompletten Ausfall des Monitorings führen kann!

## Verfügbare Einstellungen

| Schlüssel | Beschreibung |
| -- | --- |
| **SUDO\_SERVER** |  |
| API\_KEY | API Schlüssel für die sudoserver socket API  |     
| **WEBSERVER** |  |
| USER | Benutzername für den Webserver |
| GROUP | Benutzergruppe für den Webserver |
| **MONITORING** |  |
| USER | Der Benutzername ihres Monitoring Systems |
| GROUP | Die Benutzergruppe ihres Monitoring Systems |
| FROM\_ADDRESS | Absender E-Mail adresse für Benachrichtigungen |
| FROM\_NAME | Absender Name der in den Benachrichtigungs E-Mails angezeigt werden soll |
| MESSAGE\_HEADER | Header für Plaintext E-Mails |
| ACK\_RECEIVER\_SERVER | E-Mail Server mit dem sich verbunden wird. Benötigtes Format: `server.com:port/imap[/ssl]` |
| ACK\_RECEIVER\_ADDRESS | Benutzername für Absender E-Mail Adresse |
| ACK\_RECEIVER\_PASSWORD | Passwort für Absender Benutzer |
| CMD | Die command pipe für Ihr Monitoring System |
| HOST.INITSTATE | Initialstatus für Hosts |
| SERVICE.INITSTATE | Initialstatus für Services |
| RESTART | Kommandozeilenbefehl um die Monitoring Engine neu zu starten |
| RELOAD | Kommandozeilenbefehl um die Konfiguration der Monitoring Engine neu einzulesen |
| STOP | Kommandozeilenbefehl um die Monitoring Engine zu stoppen |
| START | Kommandozeilenbefehl um die Monitoring Engine zu starten |
| STATUS | Kommandozeilenbefehl um den Status der Monitoring Engine abzurufen |
| CORECONFIG | Pfad zur Konfigurationsdatei der Monitoring Engine |
| STATUS_DAT | Pfad zur status.dat Datei des Monitoring Systems |
| FRESHNESS_THRESHOLD_ADDITION | Wert in Sekunden, der auf den `Service check interval` für Passive Services addiert wird, bevor das Monitoring System einen Freshness check ausführt  |
| AFTER_EXPORT | Ein Kommandozeilenbefehl, der bei jedem Export ausgeführt wird. Hier ist vorsicht geboten, da dies als `root` ausgeführt wird! |
| SINGLE_INSTANCE_SYNC | Ist diese Option aktiviert, kann eine openITCOCKPIT Instanz ausgewählt werden, die die neue Konfiguration bekommt.  Wenn deaktviert werden alle Instanzen aktuell gehalten |
| QUERY_HANDLER | Pfad des query handler auf dem Monitoring System |
| HOST_CHECK_ACTIVE_DEFAULT | Ist diese Option aktiviert, ist bei neuen Hostvorlagen die option `Aktiviere aktive Prüfungen` standardmäßig aktiviert |
| SERVICE_CHECK_ACTIVE_DEFAULT | Ist diese Option aktiviert, ist bei neuen Servicevorlagen die option `Aktiviere aktive Prüfungen` standardmäßig aktiviert |
| **SYSTEM** |  |
| ADDRESS | Die IP Adresse oder FQDN des openITCOCKPIT Servers |
| ANONYMOUS_STATISTICS | Ist diese Option aktiviert, werden anonymisierte Daten an die Entwickler von openITCOCKPIT weitergegeben. [Weitere Informationen]() |
| **FRONTEND** | |
| SYSTEMNAME | Der Name Ihres openITCOCKPIT Systems |
| SHOW_EXPORT_RUNNING | Ist diese Option aktiviert, werden laufende Exports im Kopfbereich von openITCOCKPIT angezeigt |
| MASTER_INSTANCE | Der Name der openITCOCKPIT Hauptinstanz |
| AUTH_METHOD | Die Authentifizierungsmethode die für das Login genutzt werden soll |
| LDAP.TYPE | LDAP Server typ |
| LDAP.ADDRESS | Die IP Adresse oder der Hostname Ihres LDAP Servers |
| LDAP.PORT | Der Port Ihres LDAP Servers |
| LDAP.QUERY | Der Abfrage filter für LDAP Anfragen |
| LDAP.BASEDN | LDAP BaseDN |
| LDAP.USERNAME | Der Benutzername mit dem sich zum LDAP Server verbunden wird |
| LDAP.PASSWORD | Passwort für den `LDAP.USERNAME` |
| LDAP.SUFFIX | Domainsuffix |
| LDAP.USE_TLS | Wenn aktiviert, wird TLS Verschlüsselung anstatt Klartext für die LDAP verbindung genutzt |
| LDAP.GROUP_QUERY | LDAP Filter um zu steuern, welche LDAP-Gruppen in die openITCOCKPIT Datenbank importiert werden sollen. |
| SSO.CLIENT_ID | Client ID welche vom SSO Server generiert wurde |
| SSO.CLIENT_SECRET | Client Secret welcher vom SSO Server generiert wurde |
| SSO.AUTH_ENDPOINT | Authorisierungs Endpunkt des SSO Servers |
| SSO.TOKEN_ENDPOINT | Token Endpunkt des SSO Servers |
| SSO.USER_ENDPOINT | Benutzer Endpunkt des SSO Servers |
| SSO.NO_EMAIL_MESSAGE | Diese Fehlermeldung erscheint, wenn die angegebene E-Mail Adresse nicht in openITCOCKPIT gefunden werden konnte |
| SSO.LOG_OFF_LINK | Logout Link des SSO Servers |
| CERT.DEFAULT_USER_EMAIL | Standard E-Mail Adresse die genutzt wird, wenn keine E-Mail Adresse während des Zertifikat Logins gefunden wurde |
| HIDDEN_USER_IN_CHANGELOG | Ist diese Option aktiviert, werden die Namen im Änderungsprotokoll zu Privatsphärezwecken versteckt. |
| PRESELECTED_DOWNTIME_OPTION | Standardwert für die Auswahl von Einzelnen `Host` oder `Host einschließlich Services` in Wartungszeiten |
| DISABLE_LOGIN_ANIMATION | Animationen auf der Login Seite werden Deaktiviert. Dies kann sehr nützlich bei Fernzugriffen  sein |
| REPLACE_USER_MACROS | Wenn diese Option aktiviert ist, werden die Benutzerdefinierten Makros `$USERn$` in der Kommandozeile der Host und Service status Übersichten übersetzt |
| ENABLE_IFRAME_IN_DASHBOARDS | Wenn aktiviert ist das Webseiten Widget im Dashboard verfügbar. Mit diesem können drittanbieter webseiten eingebunden werden |
| SSO.AUTH_PROVIDER | Hier kann ausgewählt werden, welcher Authentifizierungs-Provider vom System genutzt werden soll |
| SSO.FORCE_USER_TO_LOGINPAGE | Automatische weiterleitung auf die Login Seite des oAuth Servers, wenn der Benutzer nicht eingeloggt ist |
| REPLACE_PASSWORD_IN_OBJECT_MACROS | Wenn diese Option aktiviert ist, werden Passwörter in `$_HOST...` und `$_SERVICE...` in den Host und Serviceübersichten Übersetzt|
| **CHECK_MK** |  |
| BIN | Pfad zur Check_mk binary |
| MATCH | Diese Services werden nicht durch Check_mk komprimiert. Regulärer Ausdruck |
| ETC | Pfad zu den Check_mk Konfigurationsdateien |
| VAR | Pfad zu den Check_mk Variablen Dateien |
| ACTIVE_CHECK | Name der Check_mk active check Servicevorlage |
| **ARCHIVE** ||
| AGE.SERVICECHECKS | Zeit in Wochen wie lange Service check ergebnisse gespeichert werden sollen |
| AGE.HOSTCHECKS | Zeit in Wochen wie lange Host check ergebnisse gespeichert werden sollen |
| AGE.STATEHISTORIES | Zeit in Wochen wie lange `State change events` gespeichert werden sollen |
| AGE.LOGENTRIES | Zeit in Wochen wie lange Log einträge gespeichert werden sollen |
| AGE.NOTIFICATIONS | Zeit in Wochen wie lange Benachrichtigungen gespeichert werden sollen. Sollte mit `AGE.CONTACTNOTIFICATIONS` und `AGE.CONTACTNOTIFICATIONMETHODS` gleich gehalten werden |
| AGE.CONTACTNOTIFICATIONS | Zeit in Wochen wie lange Kontakt Benachrichtungen gespeichert werden sollen. Sollte mit `AGE.NOTIFICATIONS` und `AGE.CONTACTNOTIFICATIONMETHODS` gleich gehalten werden |
| AGE.CONTACTNOTIFICATIONMETHODS | Zeit in Wochen wie lange Kontakt Benachrichtigungsmethoden gespeichert werden sollen. Sollte mit `AGE.CONTACTNOTIFICATIONS` und `AGE.NOTIFICATIONS` gleich gehalten werden |
| **INIT** |  |
| SUDO_SERVER_STATUS | Kommandozeilenbefehl um den Status des `SUDO_SERVER` Dienst abzufragen |
| GEARMAN_WORKER_STATUS | Kommandozeilenbefehl um den Status des `GEARMAN_WORKER` Dienst abzufragen |
| OITC_CMD_STATUS | Kommandozeilenbefehl um den Status der `OITC_CMD` abzufragen |
| NPCD_STATUS | Kommandozeilenbefehl um den Status des `NPCD` Dienst abzufragen |
| NDO_STATUS | Kommandozeilenbefehl um den Status der `NDO` abzufragen |
| STATUSENIGNE_STATUS | Kommandozeilenbefehl um den Status des `STATUSENGINE` Dienst abzufragen |
| GEARMAN_JOB_SERVER_STATUS | Kommandozeilenbefehl um den Status des `GEARMAN_JOB_SERVER` Dienst abzufragen |
| PHPNSTA_STATUS | Kommandozeilenbefehl um den Status des `PHPNSTA` Dienst abzufragen |
| PUSH_NOTIFICATION | Kommandozeilenbefehl um den Status des `PUSH_NOTIFICATION` Dienst abzufragen |
| NODEJS_SERVER | Kommandozeilenbefehl um den Status des `NODEJS_SERVER` Dienst abzufragen |
| GEARMAN_WORKER_RESTART | Kommandozeilenbefehl um den `GEARMAN_WORKER` Dienst neu zu starten |
| OITC_GRAPHING_RESTART | Kommandozeilenbefehl um den `OITC_GRAPHING` Dienst neu zu starten |
| PHPNSTA_RESTART | Kommandozeilenbefehl um den `PHPNSTA` Dienst neu zu starten |
| STATUSENGINE_RESTART | Kommandozeilenbefehl um den `STATUSENGINE` Dienst neu zu starten |
| NSTA_RESTART | Kommandozeilenbefehl um den `NSTA` Dienst neu zu starten |
| NSTA_RELOAD | Kommandozeilenbefehl um die Konfiguration des `NSTA` Dienst neu zu laden |
| NSTA_STATUS | Kommandozeilenbefehl um den Status des `NSTA` Dienst abzufragen |
| SNMPTRAPD_RESTART | Kommandozeilenbefehl um den `SNMPTRAPD` Dienst neu zu starten |
| SNMPTT_RESTART | Kommandozeilenbefehl um den `SNMPTT` Dienst neu zu starten |
| **TICKET_SYSTEM** ||
| URL | Link zum Ticket System |

