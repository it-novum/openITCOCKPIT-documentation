# E-Mail Benachrichtigungen einrichten

Eine Standard Benachrichtigungsmethode, die Sie definitiv auf Ihrem System einrichten sollten, ist `notify-by-email`.
Die meisten Unternehmen besitzen bereits eigene Mail Server. Um die Dinge einfach zu halten, wird dieses Tutorial Ihnen
zeigen, wie Sie einen vorhandenen Mail-Server als Relay Host nutzen können.

## Postfix Mail Server installieren

Wir empfehlen Postfix als Ebene zwischen Ihrem vorhandenen Mail Server und dem Monitoring System.

```
apt-get install postfix
```

Nun setzen wir die IP-Adresse des vorhandenen Mail Servers in der Datei `/etc/postfix/main.cf`.

```
relayhost = 192.168.1.1
```

Um die Konfiguration zu aktivieren, starten Sie Postfix neu

```
systemctl restart postfix
```

## E-Mail Konfiguration für openITCOCKPIT setzen

Die Mail Konfiguration für openITCOCKPIT wird in der Datei `/opt/openitc/frontend/config/email.php` gesetzt.

Die Konfiguration für den lokalen Postfix ist sehr einfach. Sie müssen nur `127.0.0.1` als `host`, Port auf `25`
sowie `username` und `password` auf `null` setzen.

Sie können auch die folgende Konfiguration nutzen:

```php
<?php
return [
    /**
     * Do not change this
     *
     */
    'Email' => [
        'default' => [
            'transport' => 'default',
            'from'      => 'you@localhost',
            //'charset' => 'utf-8',
            //'headerCharset' => 'utf-8',
        ],
    ],

    /**
     * Email configuration.
     *
     * Make your email settings down below
     *
     */

    'EmailTransport' => [
        'default' => [
            'className' => \Cake\Mailer\Transport\MailTransport::class,
            /*
             * The following keys are used in SMTP transports:
             */
            'host'      => "127.0.0.1",
            'port'      => 25,
            'timeout'   => 30,
            'username'  => null,
            'password'  => null,
            'client'    => null,
            'tls'       => null,
            'url'       => env('EMAIL_TRANSPORT_DEFAULT_URL', null),
        ],
    ]
];
```

### Absenderadresse ändern

Möchten Sie die Absenderadresse der E-Mails ändern, navigieren Sie
nach `Systemkonfiguration -> System -> Systemeinstellungen`.

![change sender address](/images/openITCOCKPIT-change-sender-address.png)

### Neuen Kontakt erstellen

Um das neue Mail System zu überprüfen, erstellen wir nun einen neuen Kontakt mit Ihrer E-Mail-Adresse.

![create new contact](/images/openITCOCKPIT-create-new-contact.png)

Nun weisen wir den Kontakt einem Host oder Service zu.

![assign contact to service](/images/openITCOCKPIT-assign-contact-to-service.png)

Um die neue Konfiguration zu aktivieren, müssen Sie
eine [Aktualisierung der Monitoring Konfiguration durchführen](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

## E-Mail Benachrichtigung Testen

Wählen Sie den Host oder Service, dem Sie den Kontakt zugewiesen haben aus. In diesem Beispiel haben wir den Kontakt dem
Service `Ping` zugewiesen. Klicken Sie nun auf die Schaltfläche `Benutzerdefinierte Servicebenachrichtigung senden`.
Belassen Sie die voreingestellten Einstellungen so wie Sie sind und klicken auf die Schaltfläche `Speichern`

![submit custom notifications](/images/openITCOCKPIT-submit-custom-service-notification.png)

Überprüfen Sie nun Ihr Postfach auf neue E-Mails.

![Service notification](/images/openITCOCKPIT-service-notification.png)

## E-Mail nicht angekommen?

Führen Sie den Befehl `oitc debug --tailf` aus, um mehr Informationen aus den Logs zu bekommen.

```
[31.01.2018 - 12:22:51] SERVICE NOTIFICATION: Demo Contact[376a2dcf-ba7c-40be-b5ef-1b46c59a85cf];My first Linux host[c963e9f2-a1cb-43f6-8ad6-0babe02294c9];Ping[80ff370a-deff-4b8b-a37c-677a22d2e7a6];CUSTOM (OK);service-notify-by-cake[a517bbb6-f299-4b57-9865-a4e0b70597e4];PING OK - Packet loss = 0%, RTA = 0.28 ms;John Doe;test notification
```
