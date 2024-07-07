[< Volver al Indice](/Docs/readme.md/)

# Author Filtering

Nps ubicamos en el archivo `post-card.blade.php`, y también en el archivo `post-featured-card.blade.php` y modificamos el siguiente `<div class="ml-3">`.

```php
<h5 class="font-bold">
    <a href="/authors/{{ $post->author->username }}">{{ $post->author->name}}</a>
</h5>
```

Luego nos vamos al archivo `web.php` y editamos el return de la ruta `Route::get('authors/{author:username}')`.

```php
return view('posts.index', [
        'posts' => $author->posts
    ]);
```

Seguidamente nos vamos al archivo `Post.php` y agregamos lo siguiente a la función `scopeFilter`.

```php
$query->when($filters['author'] ?? false, fn ($query, $author) =>
            $query->whereHas('author', fn ($query) =>
                $query->where('username', $author)));
```

Nos vamos para `PostController.php` y agregamos la plabra `author`

```php
public function index()
    {
        return view('posts.index', [
            'posts' => Post::latest()->filter(request(['search', 'category', 'author']))->get()
        ]);

    }
```

Nos vamos al archivo `show.blade.php` y editamos el siguiente `<div class="ml-3 text-left">` agregando el siguiente código.

```html
<h5 class="font-bold">
    <a href="/?author={{ $post->author->username }}">{{ $post->author->name}}</a>
</h5>
```

Seguidamente, volvemos a los archivos `post-card.blade.php`, y `post-featured-card.blade.php` y volvemos a editar el `<div class="ml-3">`.

```php
<h5 class="font-bold">
    <a href="/?author={{ $post->author->username }}">{{ $post->author->name}}</a>
</h5>
```

Por ultimo nos vamos al archivo `web.php` y eliminamos la ruta de `authors` para dejar limpio el código.

Cuando todo este codigo este completamente ejecutado y seleccionemos un author, tendria que verse asi:

![Verificación del author](./images/41.1%20authors.png)