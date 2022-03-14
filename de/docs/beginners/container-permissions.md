# Container Berechtigungen

Zu aller erst müssen Sie sich mit unserem "Container" basiertem Berechtigungskonzept vertraut machen. Alle Objekte wie
Benutzer, Hosts, Kontakte, Vorlagen etc. sind an Container gebunden.

!!! danger "Berechtigungen können ein sehr komplexes Thema werden"
    Es wird dringend geraten, diesen Teil nicht zu überspringen!

## /root Container

Der "/root" Container ist etwas speziell. Alle Objekte, die diesem Container zugeordnet sind, sind **global für alle
Benutzer sichtbar!** dieser Container ist für global häufig verwendete Objekte wie zum Beispiel die "Ping"
Servicevorlage oder der Zeitabschnitt "24x7" gedacht.

Wenn Sie dem "/root" Container einen Host zuweisen, ist es **später nicht mehr möglich die Containerzuweisung zu
verändern!**

Benutzer die dem "/root" Container zugewiesen wurden, werden automatisch **globale Administratoren** mit vollen
Privilegien zu allen Objekten.

Globale Administratoren sind mit einer Krone über Ihrem Benutzernamen gekennzeichnet:
![global admin crown](/images/openITCOCKPIT-global-administrator.png)

## Container Baum

Container fungieren wie ein Baum. der "/root" Container ist immer die "Wurzel" aller nachfolgender Container. Die
nächste Ebene im Baum könnte ein "Mandant" sein. Mandanten können Abteilungen Ihres Unternehmens oder sogar völlig
unterschiedliche Unternehmen sein. Innerhalb eines Mandanten können sie "Knoten" (Nodes) erstellen. Dies kann hilfreich
sein, um komplette Firmenstrukturen in Ihrem Monitoring System abzubilden.

Diesem Beispiel folgend würde eine Container-Baum-Struktur so aussehen: `/root/Mandant/Knoten/`.

Um dies zu veranschaulichen, erstellen wir einen Mandanten mit dem Namen "Demo Tenant"
unter `Verwaltung -> Containerverwaltung -> Mandanten`

![tenant container add](/images/openITCOCKPIT-First-Tenant.png)

Der Container Baum sieht nun so aus: `/root/Demo Tenant/`.

Im nächsten Schritt erstellen wir Knoten (Nodes) innerhalb des "Demo Tenant"
unter `Verwaltung -> Containerverwaltung -> Container`

![nodes](/images/openITCOCKPIT_container_nodes.png)

In diesem Beispiel erstellen wir einen eigenen Knoten für das "Data center team" und die "Developers". So kann jedes
Team seine eigenen Hosts innerhalb Ihrer eigenen Container erstellen.

Unser Container Baum sieht nun so aus:

```
/root/Demo Tenant/Team Data Center
/root/Demo Tenant/Team Developers
```

Benutzer können Sie zu verschiedenen Ebenen im Container Baum zuweisen.

- Wenn Sie einen Benutzer dem Container `/root/` zuweisen, so wird dieser Benutzer ein globaler Administrator und
  hat **Zugriff auf alle Objekte aller Mandanten**
- Wenn Sie einen Benutzer dem Container `/root/Demo Tenant` zuweisen, hat der Benutzer Zugriff auf alle Objekte
  innerhalb des Mandanten **sowie aller Untercontainer**
- Wenn Sie einen Benutzer den Container `/root/Demo Tenant/Team Developers` Zuweisen, hat der Benutzer Zugriff auf alle
  Objekte innerhalb des "Team Developers" Container **sowie all seinen Untercontainern**

Zudem ist es möglich, allen Benutzern Lese- und Schreibrechte auf jeden Container zu geben. Dazu navigieren Sie
zu `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzer` und erstellen einen neuen Benutzer. Sie können nun alle
Container, auf die der Benutzer Zugriff bekommen soll, auswählen und Lese- sowie Schreibrechte für jeden einzelnen
Container vergeben.

![User container permissions](/images/openITCOCKPIT-user-container-permissions.png)

Das Container-basierte Berechtigungskonzept kann sehr komplex werden, aber bietet die größtmögliche Flexibilität und
ermöglicht granulare Berechtigungsmöglichkeiten.

!!! note 
    Seit openITCOCKPIT 4 können Container Berechtigungen auch in "Benutzer Container Rollen" abgebildet werden.
