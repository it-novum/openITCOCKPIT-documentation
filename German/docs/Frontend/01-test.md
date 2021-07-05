
Das ist ein Test

# php

```php
<?php
    public function index() {
        if (!$this->isAngularJsRequest()) {
            //Only ship HTML Template
            return;
        }

        /** @var CommandsTable $CommandsTable */
        $CommandsTable = TableRegistry::getTableLocator()->get('Commands');
        $CommandFilter = new CommandsFilter($this->request);

        $PaginateOMat = new PaginateOMat($this, $this->isScrollRequest(), $CommandFilter->getPage());
        $all_commands = $CommandsTable->getCommandsIndex($CommandFilter, $PaginateOMat);

        $this->set('all_commands', $all_commands);
        $this->viewBuilder()->setOption('serialize', ['all_commands']);
    }
```


# css
```css
.half {
    width: 50%;
    float: left;
    text-align: center;
}
```


