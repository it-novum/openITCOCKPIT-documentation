# Using openITCOCKPIT behind a reverse proxy

!!! hint
    hint To be able to use openITCOCKPIT behind a reverse proxy, **no adjustments** have to be made to the openITCOCKPIT web server configuration!


This documentation describes how openITCOCKPIT can be run behind an Nginx or Apache2 reverse proxy.

You will need to replace the values in the example configurations below with your own values.


| Value                                         | Description                                                                 |
| -------------------------------------------- | ---------------------------------------------------------------------------- |
| openitcockpit.example.org                    | Subdomain used to call up the openITCOCKPIT web front end.  |
| /etc/ssl/certs/ssl-cert-snakeoil{.pem\|.key} | File path to the TLS certificate used to activate HTTPS                |
| 207.154.223.22                               | Public IPv4 address of the reverse proxy                                   |
| 157.230.114.24                               | Internal IPv4 address of the openITCOCKPIT server                                |

## Nginx as a reverse proxy

Copy the following configuration to `/etc/nginx/sites-available/openitcockpit-proxy`

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name  openitcockpit.example.org;

    server_tokens off;
    return 301 https://$host$request_uri;
}

server {

    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name  openitcockpit.example.org;

    server_tokens off;
    
    # Set the IP Address or FQDN of your openITCOCKPIT Monitoring Server here
    set $oitcserver 157.230.114.24;
    
    # Set the TLS certificate you like to use - for example Let’s Encrypt
    ssl_certificate     /etc/ssl/certs/ssl-cert-snakeoil.pem;
    ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
    
    # Proxy openITCOCKPIT HTTP requests
    location / {
        proxy_pass https://$oitcserver;
        proxy_ssl_verify off;
        
        proxy_set_header Host      $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # Proxy Web Socket Connections
    location ~ ^/(sudo_server|push_notifications|nsta)$ {
        proxy_pass https://$oitcserver;
        proxy_ssl_verify off;
        
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

Please make sure you have amended all IP addresses to reflect your actual system values.
Finally, your new configuration must be activated:

```plaintext
ln -s /etc/nginx/sites-available/openitcockpit-proxy /etc/nginx/sites-enabled/openitcockpit-proxy
```

```plaintext
systemctl restart nginx
```

openITCOCKPIT should now be accessible via your reverse proxy.


## Apache2 as a reverse proxy

Copy the following configuration to `/etc/apache2/sites-available/openitcockpit-proxy.conf`

```apacheconf
<VirtualHost 207.154.223.22:80>
  ServerName openitcockpit.example.org
  Redirect / https://openitcockpit.example.org/

  ErrorLog ${APACHE_LOG_DIR}/openitcockpit_error.log
  CustomLog ${APACHE_LOG_DIR}/openitcockpit_access.log combined
</VirtualHost>

<VirtualHost 207.154.223.22:443>
  ServerName openitcockpit.example.org

  # Set the IP Address or FQDN of your openITCOCKPIT Monitoring Server here
  Define oitcserver 157.230.114.24

  ServerSignature Off

  # HTTPS
  SSLEngine on
  SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
  SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem

  # Logging
  ErrorLog ${APACHE_LOG_DIR}/openitcockpit_error.log
  CustomLog ${APACHE_LOG_DIR}/openitcockpit_access.log combined

  # Reverse Proxy Settings
  ProxyPreserveHost On
  SSLProxyEngine On
  SSLProxyCheckPeerName Off

  RequestHeader set X-Forwarded-Proto "https"
  RequestHeader set X-Forwarded-Port "443"
  RequestHeader set X-Forwarded-Ssl on

  # Proxy WebSocket requests
  RewriteEngine On
  RewriteCond %{HTTP:Upgrade} =websocket [NC]
  RewriteRule /(.*)            wss://${oitcserver}/$1 [P,L]

  ProxyPass / https://${oitcserver}/
  # If you use a FQDN for external access
  ProxyPassReverse / https://openitcockpit.example.org/
  # If you use an ip address for external access
  #ProxyPassReverse / https://207.154.223.22/

</VirtualHost>
```


Please make sure you have amended all IP addresses to reflect your actual system values.
To activate the new configuration, the required Apache modules must be loaded first.

```plaintext
a2enmod http2
a2enmod ssl
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_wstunnel
a2enmod headers
a2enmod rewrite
```

Finally, your new configuration must be activated:

```plaintext
a2ensite openitcockpit-proxy
```

```plaintext
systemctl restart apache2
```

