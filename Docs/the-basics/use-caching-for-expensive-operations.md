[< Volver al Indice](/Docs/readme.md/)


# Use Caching for Expensive Operations

Vamos almacenar en caché el HTML de cada publicación para mejorar el rendimiento de la misma, ya que buscar mediante el `file_get_contents()` cada vez que vemos una publicación de blog no es lo ideal. Entonces por ejemplo, si diez mil personas ven una publicación de blog al mismo tiempo, eso significa que está llamando a file_get_contents() diez mil veces. Esto es un total desperdicio, particularmente cuando las publicaciones de blog rara vez cambian.

Se va realizar el siguiente cambio en el archivo `web.php`: 

```php
Route::get('posts/{post}', function ($slug) {

    if (! file_exists($path = __DIR__ . "/../resources/posts/{$slug}.html")) {
       return redirect('/');
    }

    $post = cache()->remember("post.{$slug}", 1200, fn() => file_get_contents($path));

    return view('post', ['post' => $post]);

})->where('post', '[A-z_\-]+');
```