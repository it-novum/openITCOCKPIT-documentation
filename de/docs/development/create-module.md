# Ein neues openITCOCKPIT Modul erstellen

Für diesen Artikel benötigen Sie eine openITCOCKPIT Entwicklungsumgebung. Lesen Sie [diesen Guide um sich eine 
openITCOCKPIT Entwicklungsumgebung zu erstellen](../setup-dev-env/#openitcockpit-entwicklungsumgebung-erstellen)

Dieser Artikel enthält die Best-Practices, um neue Features in openITCOCKPIT über ein eigenes Modul hinzuzufügen.
Die Entwicklung eines eigenen Moduls stellt sicher, dass ihr System aktualisier-und-wartbar durch unsere Experten 
bleibt. 

## Einstieg in die Entwicklung

Das Backend von openITCOCKPIT ist in PHP geschrieben und nutzt das Framework [CakePHP 4](https://book.cakephp.org/4/en/index.html).

Das Frontend basiert auf einem [AngularJS](https://angularjs.org/), [jQuery](https://jquery.com/) und [Bootstrap 4](https://getbootstrap.com/docs/4.4/getting-started/introduction/) Stack.

Als IDE empfehlen wir [JetBrains PHPStorm](https://www.jetbrains.com/phpstorm/) und [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) als Browser.


Der Beispielcode ist auf GitHub verfügbar: <https://github.com/it-novum/openITCOCKPIT-ExampleModule>

### Voraussetzungen

Dieses Dokument beschreibt ausschließlich die Entwicklung von Modulen für openITCOCKPIT.

Es wird vorausgesetzt, dass Sie erfahrung mit CakePHP und AngularJS besitzen.

### Arbeitsverzeichnis
Das Arbeitsverzeichnis von openITCOCKPIT ist `/opt/openitc/frontend`.

Stellen Sie sicher, dass Sie sich in diesem Ordner befinden bevor Sie starten.

Es wird zudem empfohlen, git zu nutzen, um ihre änderungen nachzuverfolgen.

## Debug Modus aktivieren

!!! danger "Wichtig"
    Seien Sie sich im Klaren darüber, dass das Aktivieren des debug Modus zu Datenlecks und dem verlust von sensitiven
    Informationen führen kann.

Standardmäßig läuft openITCOCKPIT im Production Modus. Um Fehlermeldungen angezeigt zu bekommen und unkomprimiertes 
(nicht minified) JavaScript zu erhalten, müssen Sie den Debug Modus aktivieren.

Dazu öffnen Sie die Datei `/etc/nginx/openitc/master.conf` und setzen den Parameter `OITC_DEBUG` von `0` auf `1`.

```
fastcgi_param OITC_DEBUG 1;
```

Damit ihre änderungen aktiv werden, müssen Sie folgenden Befehl ausführen: 

```bash
openitcockpit-update --no-system-files
```

!!! danger "Wichtig"
    Nochmal: Seien Sie sich im Klaren darüber, dass das Aktivieren des debug Modus zu Datenlecks und dem verlust von sensitiven
    Informationen führen kann.

### Debug Modus deaktivieren
Um den Debug Modus in openITCOCKPIT zu deaktivieren, müssen Sie folgenden Befehl ausführen:

```bash
openitcockpit-update
```

## "Backen" des Moduls

Bevor Sie starten, stellen Sie sicher, dass Sie sich im Ordner `/opt/openitc/frontend` befinden und einen neuen git
Branch für ihre Entwicklung erstellt haben.

![new git branch](/images/prepare-for-new-module.png)

openITCOCKPIT besitzt ein eigenes CLI Tool "`oitc`", welches unter anderem ein neues "skeleton" eines neuen Moduls 
erstellen kann.
Dies ist das sogenannte bake Kommando, welches auf dem CakePHP "[bake](https://book.cakephp.org/4/en/plugins.html#creating-a-plugin-using-bake)" 
Kommando basiert.

Um ein neues Modul zu erstellen, müssen Sie folgendes Kommando ausführen:
```bash
oitc bake plugin ExampleModule
```

!!! warning "Hinweis"
    Es ist wichtig, dass der Name ihres Moduls auf "Module" endet. Beispiele: Example**Module**, Autoreports**Module**, 
    Mk**Module** und so weiter.

Das System wird Sie nach dem Pfad des Modules (Plugin) fragen. 
```
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
```
Dies bestätigen Sie bitte mit `y`.

Zudem werden Sie gefragt, ob Sie die `composer.json` Datei überschreiben möchten
```
/opt/openitc/frontend/composer.json
```
**Überschreiben Sie diese Datei nicht!** Überspringen Sie dies mit der Antwort `n`.


Beispiel zum Erstellen eines Moduls mit dem bake Befehl:
```bash
root @ /opt/openitc/frontend - [ExampleModule] # oitc bake plugin ExampleModule
Plugin Name: ExampleModule
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
-------------------------------------------------------------------------------
Look okay? (y/n/q)
[y] > y
Generating .gitignore file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/.gitignore
Wrote `/opt/openitc/frontend/plugins/ExampleModule/.gitignore`
Generating README.md file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/README.md
Wrote `/opt/openitc/frontend/plugins/ExampleModule/README.md`
Generating composer.json file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/composer.json
Wrote `/opt/openitc/frontend/plugins/ExampleModule/composer.json`
Generating phpunit.xml.dist file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/phpunit.xml.dist
Wrote `/opt/openitc/frontend/plugins/ExampleModule/phpunit.xml.dist`
Generating src/Controller/AppController.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Controller/AppController.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Controller/AppController.php`
Generating src/Plugin.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php`
Generating tests/bootstrap.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/bootstrap.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/bootstrap.php`
Generating webroot/.gitkeep file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/webroot/.gitkeep
Wrote `/opt/openitc/frontend/plugins/ExampleModule/webroot/.gitkeep`
Modifying composer autoloader

File `/opt/openitc/frontend/composer.json` exists
Do you want to overwrite? (y/n/a/q)
[n] > n
Skip `/opt/openitc/frontend/composer.json`

Generating autoload files
Generated autoload files


/opt/openitc/frontend/src/Application.php modified
-------------------------------------------------------------------------------
Created: ExampleModule in /opt/openitc/frontend/plugins/ExampleModule


root @ /opt/openitc/frontend - [ExampleModule] #
```

### Dateiberechtigungen Reparieren

Immer wenn Sie den `oitc` Befehl zum Generieren von Dateien nutzen, ist es empfehlenswert, die Dateiberechtigungen dem
Webserver Benutzer `www-data` zuzuweisen.

openITCOCKPIT bietet ein eigenes Tool zum Setzen dieser Berechtigungen an.

```bash
oitc rights
```

![oitc rights](/images/oitc-rights.png)

### Aufräumen der src/Application.php Datei
Öffnen Sie die Datei `/opt/openitc/frontend/src/Application.php` und löschen Sie folgende Zeile:
```php
$this->addPlugin('ExampleModule');
```

openITCOCKPIT lädt seine Module automatisch. Es ist keine Manuelle aktion oder code notwendig. 

### Routing ändern

Standardmäßig nutzt CakePHP einen Bindestrich (-) als CamelCase separator in der URL. Aufgrund historischer Umstände ist
es vonnöten, dass Sie diesen Separator durch einen Unterstrich (_) ersetzen.

Dazu öffnen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php` und suchen nach dem folgenden 
Code.
```php
public function routes(RouteBuilder $routes): void
{
    $routes->plugin(
        'ExampleModule',
        ['path' => '/example-module'],
        function (RouteBuilder $builder) {
            // Add custom routes here
 
            $builder->fallbacks();
        }
    );
    parent::routes($routes);
}
```

Nun ändern Sie den Wert des `path` von `example-module` nach `example_module`. 

```php
['path' => '/example_module'],
```

## Hello World - Backend
Die Struktur ihres neuen Moduls sollte aussehen wie in diesem Beispiel:

![modul structure](/images/module-structure.png)

Ein guter Einstiegspunkt wäre die erstellung ihrer ersten Seite mit der ausgabe "Hello World".

### Einen neuen Controller erstellen

CakePHP [Controller](https://book.cakephp.org/4/en/controllers.html) enthalten die gesamte Businesslogik und stellt die 
API Endpunkte für das Frontend dar.

In diesem Beispiel erstellen wir den "TestController"

Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Controller/TestController.php` mit folgendem
Inhalt:

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
class TestController extends AppController {
     
}
```

#### Eine neue Action erstellen

[Actions](https://book.cakephp.org/4/en/controllers.html#controller-actions) enthalten die Logik Ihres API endpunktes. 

Wir erstellen nun eine Action mit dem namen `index` um die Nachricht `Hello World` auszugeben.

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        // Pass the variable "message" with the content "Hello World" to the view
        $this->set('message', 'Hello World');
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message']);
    }
 
}
```

#### Erstellen der View

Die [View](https://book.cakephp.org/4/en/views.html) wird in ihrem Browser gerendert. openITCOCKPIT unterstützt zwei 
View Typen:

Die HTML View wird von AngularJS geladen und enthält die Statische HTML Struktur mit Platzhaltern für Informationen der 
aktuellen [Action](#eine-neue-action-erstellen).

Die JSON View enthält die Daten für die Platzhalter der aktuellen [Action](#eine-neue-action-erstellen).


##### HTML View erstellen

Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/templates/Test/index.php` mit folgendem Inhalt:

```php
<?php
/**
 * @var \App\View\AppView $this
 * @var string $message
 */
?>
 
<div class="row">
    <div class="col-xl-12">
        <div id="panel-1" class="panel">
            <div class="panel-hdr">
                <h2>
                    <?php echo __('Example Module'); ?>
                    <span class="fw-300"><i><?php echo __('Hello World'); ?></i></span>
                </h2>
            </div>
            <div class="panel-container show">
                <div class="panel-content">
 
                    <!-- Output "Hello World (HTML)" that was set by the controller -->
                    <?= h($message); ?>
 
                </div>
            </div>
        </div>
    </div>
</div>
```

!!! info
    AngularJS wird das Template einmal laden und dann Cachen. 
    Nutzen Sie kein `<?php foreach($data as $record): ?>` um Daten auszugeben.



##### JSON View erstellen

Die JSON View wird automatisch vom CakePHP Framework generiert.

Mehr zu diesem Thema erfahren Sie in der [CakePHP Dokumentation](https://book.cakephp.org/4/en/views/json-and-xml-views.html).

#### Berechtigungen für "Administrator" Benutzerrolle zuweisen

Standardmäßig wird jeder Zugriff auf die API Actions verweigert. openITCOCKPIT weist dem "Administrator" Benutzer alle 
Berechtigungen zu mit der Ausführung des folgenden Kommandos:

```bash
openitcockpit-update --no-system-files
```

Ist ihr aktueller Benutzer kein Teil der "Administrator" Gruppe, müssen Sie nach `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzerrollen`
Navigieren und die Berechtigungen manuell zuweisen.

![grant permissions](/images/grant-user-role-permissions.png)

#### Action abfragen

Sie sollten nun in der Lage sein, die `.html` und `.json` Actions anzufragen.

Navigieren Sie in ihrem Webbrowser nach `/example_module/test/index.html` um die HTML Action zu bekommen.

![hello world html browser](/images/hello-world-html.png)

Es ist normal, dass an diesem Punkt keinerlei CSS oder Javascript geladen wird.

Via `/example_module/test/index.json` erhalten Sie die JSON repräsentation der Action.

![hello world json browser](/images/hello-world-json.png)

## Hello World - Frontend
### Neuer Menüeintrag
Standardmäßig ist das Menü von openITCOCKPIT in vier Kategorien unterteilt ([MenuHeadline](https://github.com/it-novum/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/Menu/Menu.php#L32-L35)):
Übersicht, Monitoring, Verwaltung und Systemkonfiguration.

Sie können entweder Links in diesen Kategorien, oder aber eigene Kategorien erstellen.

Alle Menüeinträge ihres Moduls werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/Menu.php` definiert.

#### Menüeintrag in vorhandener Überschrift

**PHP Code**

```bash
<?php
 
namespace ExampleModule\Lib;
 
 
use itnovum\openITCOCKPIT\Core\Menu\MenuCategory;
use itnovum\openITCOCKPIT\Core\Menu\MenuHeadline;
use itnovum\openITCOCKPIT\Core\Menu\MenuInterface;
use itnovum\openITCOCKPIT\Core\Menu\MenuLink;
 
class Menu implements MenuInterface {
 
    /**
     * @return array
     */
    public function getHeadlines() {
        $Overview = new MenuHeadline(\itnovum\openITCOCKPIT\Core\Menu\Menu::MENU_OVERVIEW);
        $Overview
            //Create a new Sub-Category of the Overview Headline
            ->addCategory((new MenuCategory(
                'ExampleModule',
                __('Example Module'),
                1000,
                'fas fa-burn'
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', //Name of the NG-State
                    'Test', //Name of the PHP Controller
                    'index', //Name of the PHP action
                    'ExampleModule', //Name of the Module
                    'fas fa-code', //Menu Icon
                    [],
                    1
                ))
            );
 
        return [$Overview];
    }
 
}
```

**Ergebnis**

![new menu entry](/images/new-menu-entry.png)


**PHPStorm**

![new entry phpstorm](/images/new-menu-entry-phpstorm.png)

Danach führen Sie den Befehl aus, um die Anzeige der editierten Views zu aktualisieren.

```bash
openitcockpit-update --no-system-files
```

#### Menüeintrag unter neuer Überschrift

Falls benötigt, können Sie auch eigene Überschriften erstellen.

**PHP Code**

```php
<?php
 
namespace ExampleModule\Lib;
 
 
use itnovum\openITCOCKPIT\Core\Menu\MenuCategory;
use itnovum\openITCOCKPIT\Core\Menu\MenuHeadline;
use itnovum\openITCOCKPIT\Core\Menu\MenuInterface;
use itnovum\openITCOCKPIT\Core\Menu\MenuLink;
 
class Menu implements MenuInterface {
 
    /**
     * @return array
     */
    public function getHeadlines() {
        $ExampleModuleHeadline = new MenuHeadline(
            'ExampleModuleHeadline',
            __('Example Module')
        );
        $ExampleModuleHeadline
            //Create a new Sub-Category of the Overview Headline
            ->addCategory((new MenuCategory(
                'ExampleModule',
                __('Example Module'),
                1000,
                'fas fa-burn'
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', //Name of the NG-State
                    'Test', //Name of the PHP Controller
                    'index', //Name of the PHP action
                    'ExampleModule', //Name of the Module
                    'fas fa-code', //Menu Icon
                    [],
                    1
                ))
            );
 
        return [$ExampleModuleHeadline];
    }
 
}
```

**Ergebnis**

![](/images/new-menu-headline.png)

**PHPStorm**

![](/images/new-menu-headline-phpstorm.png)

Danach führen Sie den Befehl aus, um die Anzeige der editierten Views zu aktualisieren.

```bash
openitcockpit-update --no-system-files
```

### Neue NG-State / AngularJS Route erstellen

Die Weboberfläche von openITCOCKPIT ist auf dem AngularJS Framework aufgebaut. Jede API Action benötigt einen eigenen 
AngularJS State und Controller. 

Alle States werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/ng.states.js` definiert.

```Javascript
openITCOCKPIT.config(function($stateProvider){
    $stateProvider
        .state('TestIndex', { // Name of the NG-State => Same as in Menu.php
            url: '/example_module/test/index', // URL the browser should display
            templateUrl: '/example_module/test/index.html', // URL of the .html Template for AngularJS
            controller: 'TestIndexController' // Name of the AngularJS Controller. Convention: Controller name + Action Name + 'Controller'
        });
});
```

#### AngularJS Controller erstellen

Jede Action kapselt seine JavaScript logik innerhalb eines AngularJS Controllers. Controller führen immer nur eine 
Action aus. **Jede Action benötigt einen eigenen Controller**. Möchten Sie denselben Code in unterschiedlichen 
Controllern, erstellen Sie einen [AngularJS Service](https://docs.angularjs.org/guide/services).

Erstellen Sie nun ihren "TestIndexController" unter dem Verzeichnis: `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/controllers/Test/TestIndexController.js`.
Konvention: `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/controllers/<PHPController name>/<Controller Name><Action Name>Controller.js`.

```Javascript
angular.module('openITCOCKPIT')
    .controller('TestIndexController', function($scope, $http){
 
        //Name TestIndexController same as in ng.states.js
        //Convention: Controller name + Action Name + 'Controller' = TestIndexController
 
 
        console.log('TestIndexController is loaded');
 
    });
```

Sie können nun auf ihren Menüeintrag klicken und das Ergebnis sehen.

![new module page](/images/new-module-page.png)

## Datenbankzugriff

openITCOCKPIT nutzt das [ORM von CakePHP](https://book.cakephp.org/4/en/orm.html) um Zugriff zur Datenbank zu erlangen.
**Nutzen sie immer das ORM und schreiben Sie niemals eigene plain SQL abfragen**

### Neue Tabelle in der Datenbank erstellen

Um Schema updates zu managen, nutzt openITCOCKPIT das [CakePHP Migrations plugin](https://book.cakephp.org/migrations/3/en/index.html)

#### Neue Tabelle erstellen

Gehen wir davon aus, Sie möchten zusätzliche Informationen zu einem Host speichern. Dazu erstellen wir eine neue 
Tabelle, die diese zusätzlichen Daten speichert.

!!! danger
    Manipulieren Sie NIEMALS existierende Tabellen!

Um eine neue, leere "migration" Datei anzulegen, führen Sie bitte folgendes Kommando aus:
```bash
oitc migrations create -p ExampleModule Initial
```

Beispielausgabe des Kommandos:

```bash
root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] # oitc migrations create -p ExampleModule Initial
using migration paths
- /opt/openitc/frontend/plugins/ExampleModule/config/Migrations
using seed paths
- /opt/openitc/frontend/plugins/ExampleModule/config/Seeds
using migration base class Migrations\AbstractMigration
using alternative template /opt/openitc/frontend/vendor/cakephp/migrations/templates/Phinx/create.php.template
created config/Migrations/20200331090547_initial.php
renaming file in CamelCase to follow CakePHP convention...
renaming file in CamelCase to follow CakePHP convention...
File successfully renamed to /opt/openitc/frontend/plugins/ExampleModule/config/Migrations/20200331090547_Initial.php
root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] #
```

Um Dateiberechtigungen zu setzen, wird zusätzlich empfohlen, den folgenden Befehl auszuführen:
```bash
oitc rights
```

Das System hat eine neue, leere "migration" Datei unter dem folgenden Pfad erstellt: 
`/opt/openitc/frontend/plugins/ExampleModule/config/Migrations/<timestamp>_Initial.php`

![new migration file](/images/new-migration.png)

In dieser Datei können Sie nun das Schema ihrer neuen Tabelle definieren.

`plugins/ExampleModule/config/Migrations/20200331090547_Initial.php`
```php
<?php
declare(strict_types=1);
 
use Migrations\AbstractMigration;
 
/**
 * Class Initial
 *
 * Created via:
 * oitc migrations create -p ExampleModule Initial
 */
class Initial extends AbstractMigration {
 
    /**
     * Whether the tables created in this migration
     * should auto-create an `id` field or not
     *
     * This option is global for all tables created in the migration file.
     * If you set it to false, you have to manually add the primary keys for your
     * tables using the Migrations\Table::addPrimaryKey() method
     *
     * @var bool
     */
    public $autoId = false;
 
    /**
     * Change Method.
     *
     * More information on this method is available here:
     * https://book.cakephp.org/phinx/0/en/migrations.html#the-change-method
     * @return void
     */
    public function change() {
 
        $this->table('example_notes')
            ->addColumn('id', 'integer', [
                'autoIncrement' => true,
                'default'       => null,
                'limit'         => 11,
                'null'          => false,
            ])
            ->addPrimaryKey(['id'])
            ->addColumn('host_id', 'integer', [
                'default' => null,
                'limit'   => 11,
                'null'    => false,
            ])
            ->addColumn('notes', 'string', [
                'default' => null,
                'limit'   => 255,
                'null'    => false,
            ])
            ->create();
    }
}
```

In diesem Beispiel wird die neue Tabelle "example_notes" mit den Feldern id, host_id und notes erstellt.

Um die neue Tabelle in der Datenbank zu erstellen, führen Sie den folgenden Befehl aus:

```bash
openitcockpit-update --no-system-files
```

Sie können die MySQL CLI oder phpMyAdmin zur überprüfung nutzen

Tabelle:
```bash
$ # mysql --defaults-file=/opt/openitc/etc/mysql/mysql.cnf
mysql> show tables like 'example_%';
+-------------------------------------+
| Tables_in_openitcockpit (example_%) |
+-------------------------------------+
| example_module_phinxlog             |
| example_notes                       |
+-------------------------------------+
2 rows in set (0.00 sec)

mysql>
```

Tabellenschema:

```sql
mysql> show create table example_notes\G
*************************** 1. row ***************************
       Table: example_notes
Create Table: CREATE TABLE `example_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_id` int(11) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
 
mysql>
```

#### Einfügen von Beispieldaten
Um den Entwicklungsprozess weniger abstrakt zu gestalten, empfehlen wir, einige Beispieldaten in die neue Tabelle 
einzufügen. Sie können das folgende SQL Statement nutzen, um einen Eintrag für jeden Host zu erstellen.

```sql
INSERT INTO `example_notes` (`host_id`, `notes`) SELECT id, CONCAT('Notes for the host: ', name) FROM `hosts`;
```

### Ein neues Tabellenobjekt erstellen (CakePHP)

Um auf eine Datenbanktabelle über das CakePHP ORM zugreifen zu können, ist ein Tabellenobjekt nötig. 

```bash
oitc bake model ExampleNotes -p ExampleModule
```

Beispielausgabe des Befehls:
```bash
oot @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] # oitc bake model ExampleNotes -p ExampleModule

One moment while associations are detected.

Baking table class for ExampleNotes...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

Baking entity class for ExampleNote...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Model/Entity/ExampleNote.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Model/Entity/ExampleNote.php`

Baking test fixture for ExampleNotes...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/Fixture/ExampleNotesFixture.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/Fixture/ExampleNotesFixture.php`
Bake is detecting possible fixtures...

Baking test case for ExampleModule\Model\Table\ExampleNotesTable ...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/TestCase/Model/Table/ExampleNotesTableTest.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/TestCase/Model/Table/ExampleNotesTableTest.php`
Done

root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] #
```

```bash
oitc rights
```

Das System hat nun automatisch ein neues [Table](https://book.cakephp.org/4/en/orm/table-objects.html) und [Entity](https://book.cakephp.org/4/en/orm/entities.html) Objekt erstellt.

Öffnen Sie nun die Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Model\Table;
 
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;
 
class ExampleNotesTable extends Table {
    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config): void {
        parent::initialize($config);
 
        $this->setTable('example_notes');
        $this->setDisplayField('id');
        $this->setPrimaryKey('id');
 
        $this->belongsTo('Hosts', [
            'foreignKey' => 'host_id',
            'joinType'   => 'INNER',
            'className'  => 'ExampleModule.Hosts',
        ]);
    }
 
    //... more code ...
 
}
```

Das System hat eine [association](https://book.cakephp.org/4/en/orm/associations.html) zwischen der neuen Tabelle und der Hosts Tabelle erkannt und daraus eine [belongsTo](https://book.cakephp.org/4/en/orm/associations.html)
association erstellt.

Um die Hosts Tabelle aus dem Kern zu nutzen, entfernen Sie den `ExampleModule` Präfix.

```php
$this->belongsTo('Hosts', [
    'foreignKey' => 'host_id',
    'joinType'   => 'INNER',
    'className'  => 'Hosts',
]);
```

### Tabelle über Tabellenobjekt abfragen

Öffnen Sie den Code ihres TestControllers um die Tabelle abzufragen.

!!! tip
    Abfragen wie im folgenden Beispiel direkt zu schreiben, ist nicht empfehlenswert.
    Sie sollten immer eine eigene Methode pro Abfrage erstellen. Dies hilft den Code zu strukturieren.

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
use Cake\ORM\TableRegistry;
use ExampleModule\Model\Table\ExampleNotesTable;
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            /**********************************************************/
            /* DO NOT RUN ANY DATABASE QUERY HERE!                    */
            /* THIS CODE IS ONLY TO SHIP THE TEMPLATE                 */
            /**********************************************************/
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        //Load ExampleNotesTable
        /** @var ExampleNotesTable $ExampleNotesTable */
        $ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
        //Query data
        $result = $ExampleNotesTable->find()
            ->order([
                'ExampleNotes.id' => 'asc'
            ])
            ->all();
 
 
        // Pass the variable "message" with the content "Hello World" to the JSON view
        // Pass the variable "result" to the JSON view
        $this->set('message', 'Hello World');
        $this->set('result', $result);
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message', 'result']);
    }
 
}
```

Laden Sie die URL `https://example.org/example_module/test/index.json` um das Ergebnis im Browser anzuzeigen.

![json result](/images/json-result.png)

#### Tabellen Joinen
Solange Sie ihre associations sauber definieren, können Sie ihre Tabellen immer durch die [contain](https://book.cakephp.org/4/en/orm/retrieving-data-and-resultsets.html#eager-loading-associations-via-contain) Methode joinen.

Um die Hosts Tabelle zu joinen, müssen Sie einfach das "Host" Tabellen Objekt "containen":

**Code**
```php
/** @var ExampleNotesTable $ExampleNotesTable */
$ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
//Query data
$result = $ExampleNotesTable->find()
    ->order([
        'ExampleNotes.id' => 'asc'
    ])
    ->contain([
        'Hosts' => function (Query $query) {
            $query
                ->disableAutoFields()
                ->select([
                    'Hosts.id',
                    'Hosts.name',
                    'Hosts.uuid',
                ]);
            return $query;
        }
    ])
    ->all();
```

**Ergebnis**
![json result with hosts](/images/json-result-with-hosts.png)

### Host und Servicestatus abfragen

openITCOCKPIT unterstützt mehrere Datenbank-Backends in welchen Statusinformationen gespeichert werden können. Aus 
diesem Grund müssen zusammenhängende Tabellen immer über das [DbBackend](https://github.com/it-novum/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/DbBackend.php) Objekt geladen werden.

Das DbBackend Objekt ist standardmäßig in jedem Controller verfügbar.

```php
// Load Hoststatus table
$HoststatusTable = $this->DbBackend->getHoststatusTable();
 
// Select fields to load
$HoststatusFields = new HoststatusFields($this->DbBackend);
$HoststatusFields
    ->currentState()
    ->output();
 
//Query Hoststatus Table
$hoststatus = $HoststatusTable->byUuids(
    Hash::extract($result->toArray(), '{n}.host.uuid'),
    $HoststatusFields
);
```

**Code**
```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
use Cake\ORM\Query;
use Cake\ORM\TableRegistry;
use Cake\Utility\Hash;
use ExampleModule\Model\Table\ExampleNotesTable;
use itnovum\openITCOCKPIT\Core\HoststatusFields;
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            /**********************************************************/
            /* DO NOT RUN ANY DATABASE QUERY HERE!                    */
            /* THIS CODE IS ONLY TO SHIP THE TEMPLATE                 */
            /**********************************************************/
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        //Load ExampleNotesTable
        /** @var ExampleNotesTable $ExampleNotesTable */
        $ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
        // Load Hoststatus table
        $HoststatusTable = $this->DbBackend->getHoststatusTable();
 
        //Query data
        $result = $ExampleNotesTable->find()
            ->order([
                'ExampleNotes.id' => 'asc'
            ])
            ->contain([
                'Hosts' => function (Query $query) {
                    $query
                        ->disableAutoFields()
                        ->select([
                            'Hosts.id',
                            'Hosts.name',
                            'Hosts.uuid',
                        ]);
                    return $query;
                }
            ])
            ->all();
 
        // Select fields to load
        $HoststatusFields = new HoststatusFields($this->DbBackend);
        $HoststatusFields
            ->currentState()
            ->output();
 
        //Query Hoststatus Table
        $hoststatus = $HoststatusTable->byUuids(
            Hash::extract($result->toArray(), '{n}.host.uuid'),
            $HoststatusFields
        );
 
        // Pass the variable "message" with the content "Hello World" to the JSON view
        // Pass the variable "result" to the JSON view
        $this->set('message', 'Hello World');
        $this->set('result', $result);
        $this->set('hoststatus', $hoststatus);
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message', 'result', 'hoststatus']);
    }
 
}
```


**Ergebnis**
![hoststatus example](/images/hoststatus-example.png)

### Daten anzeigen

#### AngularJS Controller

Zuerst müssen Sie zum Laden der Daten eine Methode in ihren `TestIndexController.js` Implementieren. 

```php
angular.module('openITCOCKPIT')
    .controller('TestIndexController', function($scope, $http){
 
        //Name TestIndexController same as in ng.states.js
        //Convention: Controller name + Action Name + 'Controller' = TestIndexController
 
 
        $scope.load = function(){
 
            // Query String parameters
            var params = {
                'angular': true
            };
 
            $http.get("/example_module/test/index.json", {
                params: params
            }).then(function(result){
 
                //Save notes from json result into local $scope.notes variable
                $scope.notes = result.data.result;
 
            }, function errorCallback(result){
                if(result.status === 403){
                    $state.go('403');
                }
 
                if(result.status === 404){
                    $state.go('404');
                }
            });
        };
 
        //Fire on page load
        $scope.load();
 
    });
```

#### HTML View Updaten
Im zweiten Schritt müssen Sie ihre Template-Logik in ihre View Datei packen `templates/Test/index.php`.

```php
<?php
/**
 * @var \App\View\AppView $this
 * @var string $message
 */
?>
 
<div class="row">
    <div class="col-xl-12">
        <div id="panel-1" class="panel">
            <div class="panel-hdr">
                <h2>
                    <?php echo __('Example Module'); ?>
                    <span class="fw-300"><i><?php echo __('Hello World'); ?></i></span>
                </h2>
            </div>
            <div class="panel-container show">
                <div class="panel-content">
 
                    <!-- Output "Hello World (HTML)" that was set by the controller -->
                    <?= h($message); ?>
 
                    <table class="table table-striped m-0 table-bordered table-hover table-sm">
                        <thead>
                        <tr>
                            <th><?= __('Host name') ?></th>
                            <th><?= __('Note') ?></th>
                        </tr>
                        </thead>
 
                        <tbody>
                        <!-- Repeat this TR for each record in $scope.notes -->
                        <tr ng-repeat="note in notes">
                            <td>
                                <!-- Print the content of the variable -->
                                {{ note.host.name }}
                            </td>
                            <td>{{ note.notes }}</td>
                        </tr>
                        </tbody>
 
                    </table>
 
                </div>
            </div>
        </div>
    </div>
</div>
```

![angularjs view with data](/images/angularjs-view-with-data.png)

### Eigene Datenbank nutzen
Müssen Sie Daten speichern, die keinen zusammenhang mit openITCOCKPIT daten haben, wird empfohlen, diese in einer 
eigenen Datenbank zu speichern. Module können eigene Datenbankverbindungen erstellen und managen. 

#### Eine neue Datenbank verbindung definieren
Erstellen Sie die Datei `/ExampleModule/config/datasource.php`

```php
<?php
$mcp = new \App\itnovum\openITCOCKPIT\Database\MysqlConfigFileParser();
$ini_file = $mcp->parse_mysql_cnf('/opt/openitc/etc/mysql/mysql.cnf');
 
return [
    'Datasources' => [
        'plugin_connection' => [
            'className' => 'Cake\Database\Connection',
            'driver' => 'Cake\Database\Driver\Mysql',
            'persistent' => true,
            'host' => $ini_file['host'],
            'username' => $ini_file['user'],
            'password' => $ini_file['password'],
            'database' => 'plugin_database',
             /**
              * You do not need to set this flag to use full utf-8 encoding (internal default since CakePHP 3.6).
              */
            'encoding' => 'utf8mb4',
            'timezone' => 'UTC',
            'flags' => [],
            'cacheMetadata' => true,
            'log' => false,
 
            /**
             * Set identifier quoting to true if you are using reserved words or
             * special characters in your table or column names. Enabling this
             * setting will result in queries built using the Query Builder having
             * identifiers quoted when creating SQL. It should be noted that this
             * decreases performance because each query needs to be traversed and
             * manipulated before being executed.
             */
            'quoteIdentifiers' => true,
            ]
    ]
];
```

Dieses Beispiel nutzt den Benutzernamen, Passwort und Host Konfiguration der openITCOCKPIT `mysql.cnf`. Sie können 
eigene Benutzernamen und Passwort kombinationen auch selbst in der Datei eintragen.

#### Laden und nutzen der eigenen Datenbank Konfiguration
Öffnen Sie die Datei `/ExampleModule/src/Plugin.php` und laden Sie die neue Datenbank Konfiguration innerhalb der 
`bootstrap()` Methode. Sie können diesen Code kopieren und einfügen:
```php
<?php
class Plugin extends BasePlugin {
    public function bootstrap(PluginApplicationInterface $app): void {
        Configure::load('DistributeModule.datasource');
        $datasources = Configure::consume('Datasources');
 
        //Check if configuration is already loaded to avoid:
        // => Cannot reconfigure existing key "plugin_test"
        if(ConnectionManager::getConfig(key($datasources)) === null) {
            ConnectionManager::setConfig($datasources);
        }
    }
}
```

Im letzten Schritt müssen Sie die Datenbank konfiguration in allen `Table` Klassen eintragen, welche ihre eigene 
Datenbankverbindung nutzen sollen.
`src/SomeTable.php`
```php
<?php
class ExampleNotesTable extends Table {
    public static function defaultConnectionName(): string {
        //debug(Configure::read('Datasources.plugin_test')); // Returns the config
        return 'plugin_connection';
    }
}
```

!!! warning
    Die Methode `defaultConnectionName()` muss `static` sein!

## Additionalplugin_database

### Core Tabellen mit Plugin tabellen verlinken
In manchen Fällen wird ein link zu einem openITCOCKPIT core Tabellenobjekt von einem Tabellenobjekt eines Moduls 
benötigt.

In diesem Beispiel möchten wir die "additional notes" aus der Modul Tabelle löschen, sobald der zugehörige Host gelöscht
wird. Um dies zu Implementieren müssen wir keinerlei core Code anpassen.

!!! warning
    Es können ausschließlich core Tabellen, die den `PluginManagerTableTrait` nutzen von Modulen erweitert werden
    ```php
    class HostsTable extends Table {
        use PluginManagerTableTrait;
    }
    ```
    Sollten Sie eine core Tabelle erweitern, welche nicht bereits den `PluginManagerTableTrait` nutzt, zögern Sie nicht 
    und senden Sie uns einen Pull Request.

#### config/associations.php
Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/config/associations.php` um eine liste von core 
Tabellen zu definieren, welche mit ihren Plugin-Tabellen assoziiert werden, sollen.

```php
<?php
return [
    'Hosts' => [ //Core Table
        'ExampleModule.ExampleNotes' //Plugin Tables
    ]
];
```

#### Definieren der Table::bindCoreAssociations Methode
Nun müssen Sie die `bindCoreAssociations()` Methode in ihrer Plugin table Klasse erstellen.

Innerhalb dieser Methode können Sie Tabellen associations definieren, die normalerweise in der core `HostsTable` Klasse
definiert worden wären.

`opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Model\Table;
 
use App\Model\Table\HostsTable;
use Cake\Datasource\RepositoryInterface;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;
 
class ExampleNotesTable extends Table {
    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config): void {
        parent::initialize($config);
 
        $this->setTable('example_notes');
        $this->setDisplayField('id');
        $this->setPrimaryKey('id');
 
        $this->belongsTo('Hosts', [
            'foreignKey' => 'host_id',
            'joinType'   => 'INNER',
            'className'  => 'Hosts',
        ]);
    }
 
 
    public function bindCoreAssociations(RepositoryInterface $coreTable) {
 
        // Link the Core HostsTable with the Plugin table without modifying core code.       
 
        switch ($coreTable->getAlias()) {
            case 'Hosts':
                $coreTable->hasOne('ExampleNote', [ //Singular => hasOne!
                    'className' => 'ExampleModule.ExampleNotes',
                    'dependent' => true
                ]);
                break;
        }
    }
}
```

#### Association testen

**Code**
```php
//Query core Hosts Table to test Plugin associations
/** @var HostsTable $HostsTable */
$HostsTable = TableRegistry::getTableLocator()->get('Hosts');
$hosts = $HostsTable->find()
    ->select([
        'Hosts.id',
        'Hosts.name',
        'Hosts.uuid'
    ])
    ->contain([
        'ExampleNote' => function(Query $query){
        $query->select([
            'id',
            'host_id',
            'notes'
        ]);
            return $query;
        }
        //'ExampleNote' //Singular => hasOne!
    ])
    ->all();
```


**Ergebnis**
![json result with hosts 2](/images/json-result-with-hosts-2.png)

### AclDependencies
Standardmäßig wird jede einzelne Controller Action eine neue Benutzerberechtigung erzeugen.

![user permissions example](/images/user-permission-example.png)

Manche Actions hängen jedoch möglicherweise von anderen Actions ab und können die gesamte Applikation beeinträchtigen, 
falls ein Benutzer eine bestimmte berechtigung deaktiviert.

Um dies zu verhindern, können Sie bei Bedarf "ACL Dependencies" definieren.

AclDependencies werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AclDependencies.php` definiert.
```php
<?php
namespace ExampleModule\Lib;
 
 
use App\Lib\PluginAclDependencies;
 
class AclDependencies extends PluginAclDependencies {
 
    public function __construct() {
        parent::__construct();
 
        // Add actions that should always be allowed.
        $this
            //      Controller name, Action mame
            ->allow('Test', 'foobar');
 
        ///////////////////////////////
        //    Add dependencies       //
        //////////////////////////////
 
        $this
            //           Controller name, Action name, depends on: Controller name, Action name
            ->dependency('Test', 'foo', 'Test', 'bar');
    }
}
```

Actions die als "always allowed" markiert oder als "dependency" gesetzt wurden, können nicht mehr durch den Benutzer 
ausgewählt werden. 

Diese werden durch das System automatisch gesetzt.

Wann immer Sie änderungen in den `AclDependencies` vorgenommen haben, müssen Sie anschließend folgenden Befehl ausführen
```bash
openitcockpit-update --no-system-files
```

### AdditionalLinks

`AdditionalLinks` können genutzt werden, um core Views mit eigenen Menüpunkten zu erweitern.

Aktuell unterstützen folgende Views dieses Feature:

|Controller|Action|
|---|---|
|Hosts|index <br /> notMonitored <br /> disabled|
|Services|index <br /> notMonitored <br /> disabled|

Benötigen Sie einen Link in einer bisher nicht unterstützen View, eröffnen Sie bitte ein [Issue auf GitHub](https://github.com/it-novum/openITCOCKPIT/issues).

`AdditionalLinks` werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AdditionalLinks.php` definiert.

**Code**
```php
<?php
namespace ExampleModule\Lib;
 
use App\Lib\PluginAdditionalLinks;
 
/**
 * Class AdditionalLinks
 * @package itnovum\openITCOCKPIT\ExampleModule\AdditionalLinks
 */
class AdditionalLinks extends PluginAdditionalLinks {
 
    /**
     * @var array
     */
    private $links = [];
 
    /**
     * PluginAdditionalLinks constructor.
     */
    public function __construct() {
        // Add a link to hosts index drop down
        $this
            ->link(
                'hosts',
                'index',
                'list',
                'TestIndex({id: host.Host.id})',
                'fas fa-code',
                __('Module Link'),
                'test', //controller for permission check
                'index' //action for permission check
            );
    }
}
```

**Ergebnis**

![AdditionalLinks example](/images/module-AdditionalLinks-example.png)

### AngularAssets
Möchten Sie eigenes CSS und Javascript einbinden (abgesehen von AngularJS Controllern, Services und Directives) müssen 
Sie diese in der Datei ` /opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php` definieren.

!!! warning
    Stellen Sie sicher dass Sie das `AngularAssetsInterface` Implementieren

```php
<?php
 
namespace itnovum\openITCOCKPIT\ExampleModule\AngularAssets;
 
use itnovum\openITCOCKPIT\Core\AngularJS\AngularAssetsInterface;
use itnovum\openITCOCKPIT\Core\AngularJS\PluginAngularAssets;
 
class AngularAssets extends PluginAngularAssets implements AngularAssetsInterface {
 
    /**
     * @var array
     */
    protected $jsFiles = [
        'path/in/webroot/lib.min.js'
    ];
 
 
    protected $cssFiles = [
        '/path/in/webroot/app.css'
    ];
 
    /**
     * @return array
     */
    public function getJsFiles() {
        return $this->_getJsFiles('example_module');
    }
 
    /**
     * @return array
     */
    public function getCssFiles() {
        return $this->_getCssFiles('example_module');
    }
 
 
    /**
     * @return array
     */
    public function getJsFilesOnDisk() {
        return $this->_getJsFilesOnDisk('ExampleModule');
    }
 
    /**
     * @return array
     */
    public function getCssFilesOnDisk() {
        return $this->_getCssFilesOnDisk('ExampleModule');
    }
}
```

### Cronjobs
Cronjobs sind CakePHP commands die das openITCOCKPIT `CronjobInterface` implementieren.

!!! warning
    Stellen Sie sicher, dass Sie das `CronjobInterface` implementieren.

`src/Command/ExampleCronjobCommand.php`
```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Command;
 
use App\Model\Table\ProxiesTable;
use App\Model\Table\SystemsettingsTable;
use Cake\Console\Arguments;
use Cake\Console\Command;
use Cake\Console\ConsoleIo;
use Cake\ORM\TableRegistry;
use itnovum\openITCOCKPIT\Core\Interfaces\CronjobInterface;
 
 
/**
 * Class ExampleCronjobCommand
 * @package ExampleModule\Command
 */
class ExampleCronjobCommand extends Command implements CronjobInterface {
 
    /**
     * @param Arguments $args
     * @param ConsoleIo $io
     */
    public function execute(Arguments $args, ConsoleIo $io) {
        $io->setStyle('green', ['text' => 'green']);
        $io->setStyle('red', ['text' => 'red']);
 
        $io->out('This is an example', 0);
 
        $io->out('<green>   Ok</green>');
        $this->processQueue();
        $io->hr();
    }
}
```

### Widgets
Plugins können auch Widgets enthalten, welche ein Benutzer auf dem Dashboard platzieren kann.

Alle Widgets werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php` definiert.

`src/Lib/AngularAssets.php`
```php
<?php
namespace ExampleModule\Lib;
 
use itnovum\openITCOCKPIT\Core\Dashboards\ModuleWidgetsInterface;
 
class Widgets implements ModuleWidgetsInterface {
 
    /**
     * @var array
     */
    private $ACL_PERMISSIONS = [];
 
    /**
     * Widgets constructor.
     * @param $ACL_PERMISSIONS
     */
    public function __construct($ACL_PERMISSIONS) {
        $this->ACL_PERMISSIONS = $ACL_PERMISSIONS;
    }
 
    /**
     * @return array
     */
    public function getAvailableWidgets() {
        $widgets = [];
        //Check for user permissions
        if (isset($this->ACL_PERMISSIONS['examplemodule']['test']['index'])) {
            $widgets[] = [
                'type_id'   => 900, //A unique identify
                'title'     => __('Example Overview'),
                'icon'      => 'fas fa-code',
                'directive' => 'examplemodule-widget',
                'width'     => 4,
                'height'    => 13
            ];
        }
 
        return $widgets;
    }
 
}
```