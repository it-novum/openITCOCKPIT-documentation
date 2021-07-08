## Wartungszeiten

Unter den Wartungszeiten können eine Reihe von Wartungszeiträumen für Host, Services, Hostgruppen und Container erstellt werden. 

Wartungszeiten werden in den Reports nicht als Ausfälle angesehen.

### Host Wartungszeit

Eine Host Wartungszeit ist ein Wartungszeitraum für einen einzelne Hosts oder einzelne Hosts und deren Services. 

### Service Wartungszeit

Eine Service Wartungszeit ist ein Wartungszeitraum für einen oder mehrere Services. Diese Services können von unterschiedlichen Hosts sein.

### Hostgruppen Wartungszeit

Eine Hostgruppen Wartungszeit ist ähnlich wie ein Host Wartungszeitraum. Hier können jedoch ganze Hostgruppen sowie deren Services in eine Wartungszeit aufgenommen werden. 

### Container Wartungszeit

Eine Container Wartungszeit ermöglicht es komplette Container in openITCOCKPIT in einen Wartungszeitraum einzutragen. Hierbei kann ausgewählt werden, ob nur der angegebene Container selbst oder zusätzlich rekursiv seine Kind Container mit in die Wartungszeit aufgenommen werden sollen 

### Wiederkehrende Wartungszeit

Für alle oben genannten Wartungszeit-typen können wiederkehrende Wartungszeiten erstellt werden. Dazu muss die Option “Wiederkehrenden Wartungszeit” aktiviert sein. Anschließend hat man anstatt der Standardmäßigen "Von - Bis" Eingabefelder nun Ein feld für die Startzeit, die Dauer der Wartungszeit und an welchem Wochentag oder an welchem Tag des Monats die Wartungszeit stattfinden soll. 

### Wartungszeit Abbrechen

Wartungszeiten können auch abgebrochen werden. Dazu hat man zwei möglichkeiten. Um eine Wartungszeit für einen einzelnen Host oder Service abzubrechen, klicken Sie in der Wartungszeiten Übersicht auf die Schaltfläche “Löschen” des jeweiligen Objekts.

Möchte man mehrere Wartungszeiten abbrechen, so markiert man die entsprechenden Hosts oder Services und wählt am unteren ende der Übersicht die Schaltfläche “Ausgewählte löschen”.



## Systemausfall

Systemausfälle sind Ausfälle des openITCOCKPIT-Servers selbst. Sie müssen manuell erstellt werden. 

Zeitrahmen, die durch Systemausfälle definiert sind, werden bei der Berichtserstellung ignoriert.