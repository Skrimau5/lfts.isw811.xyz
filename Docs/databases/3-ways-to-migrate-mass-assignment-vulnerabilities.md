[< Volver al Indice](/Docs/readme.md/)

Vamos a revisar si el sistema es vulnerable.

Laravel proporciona un par de maneras de especificar qué atributos pueden o no ser asignados masivamente. Sin embargo, hay una tercera opción al final de este episodio que es igualmente válida.

Comenzamos creando rápidamente un nuevo post:

![Creando un nuevo post](./images/22.2%20third.png)

Ahora realizaremos un cambio en el archivo `Post.php`, 

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'excerpt', 'body' ];
}
```

Esta modificación que se realizo es para evitar un error al crear un nuevo post con el siguiente comando:

```php
> use App\Models\Post;
> Post::create([
.     'title' => 'My Fourth Post',
.     'excerpt' => 'excerpt of post',
.     'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
. ]);

```
Además, hay otras dos maneras de mitigar las vulnerabilidades de asignación masiva.

* La primera fue la que ya realizamos para lograr ejecutar el comando anterior.

```php
protected $fillable = ['title', 'excerpt', 'body' ];
```

* La segunda es la siguiente, esta forma de mitigar se realiza para que a la hora de crear ya sea un post por ejemplo, este no se le pueda crear un id propiamente, si no que el id que se creara será a partir del id del post anterior. Es decir que si el id del post anterior es 2, el id de este nuevo post sera 3 definitivamente aunque por parámetros se mande que el id va a ser 10000.

```php
protected $guarded = [id];
```

* El tercero es el mismo que el segundo pero sin parámetros agregados, pero en cambio este si deja crear el id propiamente:

```php
protected $guarded = [];
```