[< Volver al Indice](/Docs/readme.md/)

# Use the Filesystem Class to Read a Directory

Lo que vamos hacer es buscar y leer todas las publicaciones dentro del directorio de recursos/publicaciones. Una vez que ya tengamos una matriz adecuada, podemos recorrerlas y mostrarlas en la página principal de descripción general del blog.

Lo primero es comenzamos eliminando la rutas que agregamos en los archivos HMTL creados en el capitulo anterior:

```html
<h1>My First Post</h1>

<p>
    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
</p>
```

Luego vamos a modificamos el archivo `web.php`, en el cual eliminaremos una parte del codigo para ubicarlo en otra parte:

```php
Route::get('/', function () {

    return view('posts', [
        'posts' => Post::all()
    ]);
});

Route::get('posts/{post}', function ($slug) {
 
    return view('post', [
        'post' => Post::find($slug)
    ]);

})->where('post', '[A-z_\-]+');
```

El codigo que se encontraba anteriormente lo vamos a mover a un archivo el cual vamos a crear dentro de la carpeta de `app`, el cual se llamara `Post.php`, ese archivo será un class y se le habilitaran tres librerias para poder hacer más dinamico el recorrido:

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\File;
use PhpParser\Node\Expr\FuncCall;

class Post
{
    public static function all()
    {
        $files = File::files(resource_path("posts/"));

        return array_map(fn($file) => $file->getContents(), $files);
    }

    public static function find($slug)
    {
        if (!file_exists($path = resource_path("posts/{$slug}.html"))) {
            throw new ModelNotFoundException();
        }

        return cache()->remember("posts.{$slug}", 1200, fn() => file_get_contents($path));
    }
}

```

Luego vamos a modificar el archivo `posts.blade.php`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <title>My Blog</title>
</head>
<body>
    <?php foreach ( $posts as $post ) : ?>
    <article>
        <?= $post; ?>
    </article>
    <?php endforeach; ?>
</body>
</html>
```

Luego creamos un cuarto Post, se crea para dar un ejemplo

```html
---
tittle: My Fourth Post
excerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit
date: 2024-07-17
---

<h1>My Fourth Post</h1>

<p>
    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
</p>
```
