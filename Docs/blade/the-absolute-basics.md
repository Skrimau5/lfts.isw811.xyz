[< Volver al Indice](/Docs/readme.md/)

# Blade: The Absolute Basics

Blade es el motor de plantillas de Laravel para tus vistas. Se puede considerar como una capa encima de PHP para hacer que la sintaxis sea requerida para construir estas vistas y asimismas estas sean lo más limpia y concisa posible. En última instancia, estas plantillas de Blade serán compiladas para vainilla PHP detrás de escena.

Un ejemplo es cambiar el archivo `posts.blade.php` a `posts.php`, y realizar el siguiente cambio en el código:

```html
 <body>
    <?php foreach ($posts as $post) : ?>
        <article>
            <h1>
                <a href="/posts/<?= $post->slug; ?>">
                    {{ $post->title }}
                </a>

            </h1>

            <div>
                <?= $post->excerpt; ?>
            </div>
        </article>
    <?php endforeach; ?>
</body>
```

Si el archivo esta con la extension `.blade` la pagina debería funcionar sin ningun problema:

![Pagina con la extension .blade](images/14.1%20posts.png)

De lo contrario, si el archivo no tiene la extensión `.blade` y se llama simplemente `posts.php`, la página no mostrará los títulos de los post.

![Pagina con la extension .blade](images/14.2%20error.png)

Modificamos `post.blade.php`

 ```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/app.css">
    <title>My Blog</title>
</head>

<body>
    <article>
        <h1>{{ $post->title }}</h1>

        <div>
        {{!! $post->body !!}}
        </div>
    </article>

    <a href="/">Go back</a>
</body>

</html>
```

Seguidamente, para seguir utilizando la sintaxis de Blade correctamente, modificaremos el archivo `posts.blade.php`, cambiando el bucle `@foreach`, la forma en que se acceden a los atributos y agregando una clase al artículo:

 ```html
 <body>
    @foreach ($posts as $post)
    <article class="{{ $loop->even ? 'foobar' : '' }}">
        <h1>
            <a href="/posts/{{ $post->slug }}">
                {{ $post->title }}
            </a>

        </h1>

        <div>
            {{ $post->excerpt }}
        </div>
    </article>
    @endforeach
</body>
```