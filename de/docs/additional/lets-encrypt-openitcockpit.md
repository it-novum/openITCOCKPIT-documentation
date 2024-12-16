# So konfigurieren Sie Let's Encrypt SSL-Zertifikate für openITCOCKPIT

Diese Dokumentation beschreibt, wie Sie Ihre openITCOCKPIT-Installation mit SSL-Zertifikaten von Let's Encrypt absichern können.

!!! note

    Diese Anleitung geht davon aus, dass openITCOCKPIT die einzige Applikation auf dem Server ist.
    Sollten Sie mehrere unterschiedliche Webanwendungen auf Ihrem Server parallel betreiben, empfehlen wir, einen
    Reverse Proxy zu nutzen und dort alle SSL-Verbindungen zu terminieren.

## Voraussetzungen

- Für die Nutzung von Let's Encrypt muss das System aus dem Internet erreichbar sein.
- Das System muss über eine Domain oder Subdomain wie `next.openitcockpit.io` verfügen.

## Installation von Certbot

Das Ausstellen von Let's Encrypt-Zertifikaten kann mit Hilfe unterschiedlicher Tools durchgeführt werden. Für openITCOCKPIT selbst spielt es keine Rolle, mit welchem Tool
das SSL-Zertifikat verwaltet wird.

Diese Dokumentation nutzt Certbot zur Verwaltung des Let's Encrypt-Zertifikats.

Installieren Sie daher zuerst Certbot, wie in der [offiziellen Dokumentation](https://certbot.eff.org/) beschrieben. Wir empfehlen die `snap`-basierte Installation.
Wählen Sie als Webserver `Nginx` und als Betriebssystem `Linux (snap)` und folgen Sie der Anleitung.

![Installation von Certbot auf Linux](/images/lets_encrypt/install_certbot.png){ align=center }

## Neues Zertifikat ausstellen

Ein SSL-Zertifikat kann einfach über Certbot erstellt werden. Dafür muss nur der Name der Domain `next.openitcockpit.io` auf Ihre Domain angepasst werden.

```
certbot certonly --nginx -d next.openitcockpit.io
```

Sollten Sie Certbot zum ersten Mal ausführen, werden einige Nachfragen gestellt, wie z. B. eine E-Mail-Adresse. Es wird empfohlen, diese Fragen mit sinnvollen Werten zu beantworten.

![SSL-Zertifikat ausstellen](/images/lets_encrypt/certbot_issue_certificate.png){ align=center }

Im Erfolgsfall erhalten Sie folgende Ausgabe. Kopieren Sie die Dateipfade der zwei Dateien in einen Text-Editor. Diese werden im nächsten Schritt benötigt.
```
Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/next.openitcockpit.io/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/next.openitcockpit.io/privkey.pem
```

## Zertifikate laden

Nun muss das SSL-Zertifikat noch im Nginx-Webserver hinterlegt werden. Öffnen Sie dafür die Datei `/etc/nginx/openitc/ssl_cert.conf` und hinterlegen Sie hier das von
Let's Encrypt ausgestellte Zertifikat wie im folgenden Beispiel:

![SSL-Zertifikat in Nginx laden](/images/lets_encrypt/nginx_load_certificate.png){ align=center }

Um die Änderungen zu übernehmen, muss der Nginx-Webserver neugestartet werden.

```
systemctl restart nginx
```

![Nginx neustarten](/images/lets_encrypt/restart_nginx.png){ align=center }

openITCOCKPIT ist ab sofort mit dem Let's Encrypt-Zertifikat abgesichert. Dies können Sie mit Ihrem Webbrowser überprüfen.

![SSL-Zertifikat im Chrome-Browser anzeigen](/images/lets_encrypt/browser_view_certificate.png){ align=center }

## Automatische Verlängerung testen

Let's Encrypt-Zertifikate haben eine Lebensdauer von 90 Tagen. Certbot verlängert das Zertifikat automatisch, jedoch sollte die Verlängerung einmalig überprüft werden.

Die automatische Verlängerung kann mit diesem Befehl überprüft werden:

```
certbot renew --dry-run
```

![SSL Zertifikat automatisch verlängern](/images/lets_encrypt/renew.png){ align=center }


## Monitoring des Zertifikats (optional)

Es wird empfohlen, das Zertifikat von openITCOCKPIT überwachen zu lassen. Dies ist optional.

Am einfachsten kann die Überwachung über das Plugin [matteocorti/check_ssl_cert](https://github.com/matteocorti/check_ssl_cert/releases) und den [openITCOCKPIT Monitoring Agent](/beginners/openitcockpit-agent/) durchgeführt werden.

### check_ssl_cert installieren

Laden Sie das Plugin [matteocorti/check_ssl_cert](https://github.com/matteocorti/check_ssl_cert/releases) im `.tar.gz`-Format herunter und entpacken Sie es.

```
wget https://github.com/matteocorti/check_ssl_cert/releases/download/v2.84.5/check_ssl_cert-2.84.5.tar.gz
tar xfv check_ssl_cert-2.84.5.tar.gz

cp check_ssl_cert-2.84.5/check_ssl_cert /opt/openitc/nagios/libexec/
```

### Custom Check einrichten

Die Ausführung des Plugins erfolgt über den openITCOCKPIT Monitoring Agent. Erstellen Sie dafür einen neuen Check in der Datei `/etc/openitcockpit-agent/customchecks.ini`.

```ini
[SSL Certificate]
  command = /opt/openitc/nagios/libexec/check_ssl_cert -H localhost -f /etc/letsencrypt/live/next.openitcockpit.io/cert.pem -r /etc/letsencrypt/live/next.openitcockpit.io/fullchain.pem --warning 15 --critical 5
  interval = 3600
  timeout = 5
  enabled = true
```

Um die Änderungen zu übernehmen, muss der Monitoring Agent neugestartet werden. Bitte beachten Sie, dass eventuelle Dateipfade angepasst werden müssen.

```
systemctl restart openitcockpit-agent.service
```

Im Anschluss kann der Custom Check in openITCOCKPIT über den Wizard hinzugefügt werden.

![custom check erstellen](/images/lets_encrypt/create_custom_check.png){ align=center }

openITCOCKPIT überwacht nun die Lebensdauer des Zertifikates.


![Monitoring des Zertifikates mit openITCOCKPIT](/images/lets_encrypt/monitoring_ssl_certificate_openitcockpit.png){ align=center }
