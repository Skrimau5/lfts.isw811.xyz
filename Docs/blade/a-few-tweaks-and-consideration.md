[< Volver al Indice](/Docs/readme.md/)

# A Few Tweaks and Consideration

Vamos a eliminar la restricción de ruta que ya no es necesaria en el archivo `web.php`. 

```php
Route::get('posts/{post}', function ($slug) {

    $post = Post::find($slug);

    return view('post', [
        'post' => $post
    ]);
});

```

Seguidamente, consideraremos los beneficios de agregar un segundo método `Post::findOrFail()` el archivo `Post.php` que aborta automáticamente si no se encuentra ninguna publicación que coincida con el slug dado.

```php
public static function findOrFail($slug)
    {
        $post = static::find($slug);

        if (!$post) {
            throw new ModelNotFoundException();
        }

        return $post;
    }
```

Por ultimo vamos actualizar el codigo en el archivo `web.php`, cambiamos la función `find()` por la función `findOrFail()`:

```php
Route::get('posts/{post}', function ($slug) {

    $post = Post::findOrFail($slug);

    return view('post', [
        'post' => $post
    ]);
});
```