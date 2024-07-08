[< Volver al Indice](/Docs/readme.md/)

# Activate the Comment Form

Para comenzar vamos a abrir nuestra maquina virtual ubicándonos en `/vagrant/sites/lfts.isw811.xyz` para ejecutar el siguiente comando

```bash
php artisan make:controller PostCommentsController
```

Le agregamos el siguiente código.

```php
<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;

class PostCommentsController extends Controller
{
    public function store(Post $post)
    {
        request()->validate([
            'body' => 'required'
        ]);

        $post->comments()->create([
            'user_id' => request()->user()->id,
            'body' => request('body')
        ]);

        return back();
    }
}
```

Luego vamos a `web.php` y agregamos la siguiente linea de comandos

```php
Route::post('posts/{post:slug}/comments', [PostCommentsController::class, 'store']);
```

Seguidamente, nos vamos al archivo `AppServiceProvider.php` y agregamos lo siguiente a la función `boot`.

```php
Model::unguard();
```

Ahora nos vamos al archivo `show.blade.php` y agregamos los componentes `@auth` antes del componte `<x-panel>` y  el `@endauth` después del componente `<p/>`.

Seguidamente agregamos lo siguiente:
```php
@else
    <p class="front-semibold"> 
        <a href="/register"class="hover:underline">Register</a> or <a href="/login" class="hover:underline">log in </a> to leave a comment </a>
    </p>
```

Luego vamos a `post-comment.blade.php` y modificamos.

```php
<div class="flex-shrink-0">
        <img src="https://i.pravatar.cc/60?u={{ $comment->user_id }}" alt="" width="60" height="60" class="rounded-xl">
</div>
```

Para finalizar verificamos lo realizado en la pagina.

* Agregando el comentario.

![Poniendo el comentario](./images/56.2%20create_comments.png)

* Comentario agregado.

![Comentario agregado](./images/56.3%20create_comments.png)