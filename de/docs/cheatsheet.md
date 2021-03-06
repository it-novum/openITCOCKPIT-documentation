## Markdown Cheatsheet 

## Text markup

### Fett Text (Bold)
```
Dies ist ein **Fetter Text**
```
Dies ist ein **Fetter Text**

### Italic text (Kursiv)
```
hier steht *Kursiver text*
```
hier steht *Kursiver text*

## Links

### Relative Links
- es muss ein `/` am ende des Links stehen

```
[Zeitabschnitte](../configuration/timeperiods/)
```
[Zeitabschnitte](../configuration/timeperiods/)


### Anchor Links

Link auf eine Überschrift in der selben Datei

- alles lower case und leerzeichen durch "`-`" ersetzen

```
[Anchor Links text](#anchor-links) 

### Anchor Links

```
[Anchor Links text](#anchor-links) 

#### Anchor Links in anderer Datei

```
[API Keys](../development/api/#api-keys)
```
[API Keys](../development/api/#api-keys)

## Trennlinien

```
___
```
Erzeugt:
___

## Codeblocks und highlighting
````
```
codeblock
```
````

### Highlighting

#### PHP

- PHP benötigt für das highlighting den öffnenden php tag ``` <?php ```


````
```php
<?php
declare(strict_types=1);

namespace App\Controller;

use App\Model\Table\FooTable;
use Cake\ORM\Locator\LocatorAwareTrait;

/**
 * Class FooController
 * @package App\Controller
 */
class FooController extends AppController {
    public function foo(){

    }
}
```
````


```php
<?php
declare(strict_types=1);

namespace App\Controller;

use App\Model\Table\FooTable;
use Cake\ORM\Locator\LocatorAwareTrait;

/**
 * Class FooController
 * @package App\Controller
 */
class FooController extends AppController {
    public function foo(){

    }
}

```
#### Javascript

````
```js
let nachricht = function() {
    let geheim = 42;

    return function() {
        return geheim;
    };
};
```
````

```js
let nachricht = function() {
    let geheim = 42;

    return function() {
        return geheim;
    };
};
```

## Blockquotes
```
> Donec massa lacus, ultricies a ullamcorper in, fermentum sed augue.
Nunc augue augue, aliquam non hendrerit ac, commodo vel nisi.
>> Sed adipiscing elit vitae augue consectetur a gravida nunc vehicula. Donec auctorodio non est accumsan facilisis. Aliquam id turpis in dolor tincidunt mollis ac eu diam.
>>> Donec massa lacus, ultricies a ullamcorper in, fermentum sed augue.
Nunc augue augue, aliquam non hendrerit ac, commodo vel nisi.

```
> Donec massa lacus, ultricies a ullamcorper in, fermentum sed augue.
Nunc augue augue, aliquam non hendrerit ac, commodo vel nisi.
>> Sed adipiscing elit vitae augue consectetur a gravida nunc vehicula. Donec auctorodio non est accumsan facilisis. Aliquam id turpis in dolor tincidunt mollis ac eu diam.
>>> Donec massa lacus, ultricies a ullamcorper in, fermentum sed augue.
Nunc augue augue, aliquam non hendrerit ac, commodo vel nisi.



## Admonition

```
!!! note
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

!!! note
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
___

```
!!! note "Changing The Title"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

!!! note "Changing The Title"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
___
```
!!! info
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! info
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! tip
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! tip
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! success
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! success
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! question
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! question
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! warning
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! warning
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! failure
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! failure
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! danger
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! danger
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! bug
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! bug
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! example
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! example
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
```
!!! quote
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
```

!!! quote
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus
___
## Emojis und Icons

### Emojis
[Emoji cheat sheet liste](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md)


```
 :warning:
```
 :warning:



### FontAwesome
[FontAwesome cheat sheet liste](https://fontawesome.com/v5/cheatsheet)


```
:fontawesome-solid-retweet: :fontawesome-solid-rocket:
```
:fontawesome-solid-retweet: 
:fontawesome-solid-rocket:


