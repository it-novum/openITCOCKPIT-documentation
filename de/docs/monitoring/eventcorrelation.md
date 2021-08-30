# Ereigniskorrelationsmodul (Eventcorrelation)

Das Ereigniskorrelationsmodul in openITCOCKPIT ist eine sehr hilfreiche Komponente, wenn es darum geht, aus verschiedenen Services einen einzigen Gesamtstatus zu bekommen.

Eine Ereigniskorrelation ist ein virtueller Host, der virtuelle Services hat.

Beim Erstellen einer Ereigniskorrelation wird daher ein Host erstellt, der von einer Hostvorlage vom Typ "EVC Template" abgeleitet wird.

Diesen virtuellen Host ist nachher in der Host-Übersicht genauso sichtbar wie ein Real existierender Host.

## Ereigniskorrelation erstellen

Nachdem der Host für die Ereigniskorrelation erstellt wurden, kann man die Ereigniskorrelation selbst bearbeiten.

In einer neuen Ereigniskorrelation ist Grundsätzlich anfangs eine einzige Ebene Sichtbar. Auf dieser Ebene klickt man auf die Schaltfläche "Neuer vService".

Mehrere Services können durch logische Operatoren miteinander verbunden werden. Dabei wird nach einem logischen Operator immer ein virtueller Service (vService) erstellt, der den Status, der aus den Services und dem Operator resultiert, annimmt.

Es gibt folgende Operatoren:

###### UND / AND

Der "UND" Operator verlangt, dass alle seine Services den Status OK haben, damit der virtuelle Service auch den Status OK bekommt.

![](/images/EVC-andOperator.png)

###### ODER / OR

Beim "ODER" Operator muss mindestens ein Service den Status OK haben, damit der virtuelle Service den Status OK bekommt.

![](/images/EVC-orOperator.png)

###### GLEICH / EQUAL

Der "GLEICH" oder "EQUAL" Operator kann nur einen Service haben. Dieser Operator eignet sich dazu ein Servicestatus "durchzuschleifen" um ihn in einer späteren Ebene wieder verwenden zu können.

![](/images/EVC-eqOperator.png)

###### MIN

Min ist ein Operator, der zusätzlich noch eine Zahl als Angabe benötigt. Diese Zahl gibt an, wie viele Services den Status OK haben müssen, damit der virtuelle Service den Status OK bekommt.

![](/images/EVC-min2Operator.png)

Da die virtuellen Services wie echte Services auf dem System behandelt werden, ist es möglich, dass die Services die man zu einer Verknüpfung hinzufügen möchte, auch virtuelle Services aus einer anderen Ereigniskorrelation sein können.