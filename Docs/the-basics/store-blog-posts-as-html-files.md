[< Volver al Indice](/readme.md)

# Store Blog Posts as HMTL Files

Primero se modificara el archivo `post.blade.php` para hacer de forma más dinamica y eficiente lo de las rutas del post y de esta manera almacenar estos mismos como archivos HTML:

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
    <article>
        <?= $post; ?>
    </article>

    <a href="/">Go back</a>
</body>
</html>
```

Seguidamente vamos a modificar el archivo `web.php` al cual le vamos a cambiar lo siguiente:

```php
Route::get('post', function () {
    return view('post', [
        'post' => '<h2>Hello World</h1>' // $post
    ]);
});
```

Vamos a crear una carpeta que se llamará `post` dentro de la carpeta de `resources` y en esa carpeta de `post` crearemos tres archivos html:

![Carpeta creada post](images/8.1%20post.png)

En cada unos de estos HTML se escribira su respectivo post por ejemplo:

```html
     <h1><a href="/post">My firts Post</a></h1>

    <p>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
    </p>
```

Lo ultimo sera que modifiquemos el archivo `web.php`, en este archivo lo que se va realizar es poder mover entre los post almacenados en HTML de forma mas dinamica

```php
Route::get('posts/{post}', function ($slug) {

    $path = __DIR__ . "/../resources/posts/{$slug}.html"

    if (! file_exists($path)){
       return redirect('/');
    }

    $post = file_get_contents($path);


    return view('post', [
        'post' => $post
    ]);
});
```

Por ultimo para finalizar, vamos a cambiar las rutas de los post en el archivo `posts.blade.php`

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
    <article>
        <h1><a href="posts/my-first-post">My firts Post</a></h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>

    <article>
    <h1><a href="/posts/my-second-post">My Second Post</a></h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>

    <article>
    <h1><a href="/posts/my-third-post">My Third Post</a></h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>
</body>
</html>
```

Asi deberia de entrar:
![Carpeta creada post](images/8.2%20posts.png)