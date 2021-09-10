# Acknowledging

Acknowledgement - Status bestätigen: unterdrückt temporär Statusbenachrichtigungen

Für Host und Services werden im falle eines nicht UP/OK Status, je nach Konfiguration, Benachrichtigungen versendet.
Abhängig vom Benachrichtigungszeitraum und Intervall geschieht dies so oft und so lange bis der Host oder Service wieder
in einem UP/OK Status ist oder in einen anderen nicht UP/OK Status wechselt. Diese Benachrichtigungen können Temporär
abgeschaltet werden - für den aktuellen nicht UP/OK Status oder anders gesagt: Sie werden wieder versendet, sobald der
Host oder Service wieder in einem nicht UP/OK Status ist oder aber in einen anderen nicht UP/OK Status wechselt.

### Klebrig (Sticky)

Sticky Acknowledgements (klebrige Bestätigungen) unterbinden das Standardverhalten der Bestätigungen, indem Sie
Benachrichtigungen so lange unterbinden bis ein UP/OK Status erreicht ist. Sollte ein anderer nicht UP/OK Status
erreicht werden als der Aktuelle, so werden trotzdem keine weiteren Benachrichtigungen versendet.

Beispiel:

Ein Service wechselt von einem OK Status zu einem CRITICAL Status. Wird dieser kritische Status **ohne** Sticky
bestätigt, werden die Benachrichtigungen unterdrückt, solange der Service in diesem kritischen Zustand ist. Wechselt er
in einen WARNING Status, so werden Benachrichtigungen wieder versendet. Ist der Service **mit** Sticky bestätigt worden,
werden so lange keine Benachrichtigungen versendet, bis der Service wieder einen OK Status erreicht hat.

### Notify

Die Notify Option sendet eine Benachrichtigung an alle Kontakte des Host oder Service mit der Information, dass das
aktuelle Host oder Service Problem bestätigt wurde.

## Host Status bestätigen

Um einen einzelnen Host Status zu bestätigen, Navigieren Sie nach `Monitoring -> Hosts` und klicken Sie auf den Namen
des entsprechenden Hosts. Im Host Browser angekommen, klicken Sie in der in Statusfarbe eingefärbten Leiste die
Option `Bestätige Hoststatus`.

![ack host status in browser](/images/hostbrowser-ackstatus.png)

Dort können Sie auswählen, ob nur der Status des Hosts selbst, oder aber der Status des Hosts inklusive seiner Services
bestätigt werden soll. Zusätzlich können Sie ein Kommentar hinterlassen und die Optionen [Sticky](#klebrig-sticky)
und [Notify](#notify) setzen.

![ack host](/images/ackhost.png)

### Mehrere Host Status bestätigen

Um mehrere Hosts gleichzeitig zu bestätigen, Navigieren Sie nach `Monitoring -> Host`. In der Host Liste wählen Sie
zuerst die Hosts aus, die Sie bestätigen möchten. Anschließend klicken Sie am Ende der Liste auf die
Schaltfläche `Mehr Aktionen` und wählen `Bestätige Status`. 

![host mass ack](/images/host-mass-ack.png)

## Service Status bestätigen

Um einen einzelnen Service Status zu bestätigen, Navigieren Sie nach `Monitoring -> Services` und klicken Sie auf den
Namen des entsprechenden Services. Im Service Browser angekommen, klicken Sie in der in Statusfarbe eingefärbten Leiste
die Option `Bestätige Servicestatus`.

![ack service status in browser](/images/servicebrowser-ackstatus.png)

Dort können Sie ein Kommentar hinterlassen und die Optionen [Sticky](#klebrig-sticky) und [Notify](#notify) setzen.

![ack service](/images/ackservice.png)

### Mehrere Service Status bestätigen

Um mehrere Services gleichzeitig zu bestätigen, Navigieren Sie nach `Monitoring -> Services`. In der Service Liste wählen Sie
zuerst die Services aus, die Sie bestätigen möchten. Anschließend klicken Sie am Ende der Liste auf die
Schaltfläche `Mehr Aktionen` und wählen `Bestätige Status`. 

![service mass ack](/images/service-mass-ack.png)