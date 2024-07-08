[< Volver al Indice](/Docs/readme.md/)

# Make the Comments Section Dynamic

Iniciamos ubicándonos en nuestro archivo `CommentFactory.php` para añadir nuestros atributos a retornar en la función `definition`.

```php
'post_id' => Post::factory(),
'user_id' => User::factory(),
'body' => $this->faker->paragraph()
```

Luego nos vamos a nuestra maquina virtual y nos ubicamos en `/vagrant/sites/lfts.isw811.xyz` para ejecutar el siguiente comando y abrir nuestro browser para crear los datos de la tabla comments.

```bash
php artisan tinker
```

Ahora una vez dentro del browser, ejecutamos el siguiente comando para crear los datos de la tabla comments

``` bash
App\Models\Comment::factory()->create();
```

Posteriormente, volvemos al proyecto y nos ubicamos en el archivo `Post.php` y agregamos la siguiente función `comments` debajo de la función `scopeFilter`.

```php
public function comments()
    {
        return $this->hasMany(Comment::class);
    }
```

Continuando, nos vamos al archivo `Comments.php` y creamos las siguiente funciones `post` y `author` para poder asociar los comentarios con los post y los autores.

```php
public function post()
    {
        return $this->belongsTo(Post::class);
    }

    public function author()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
```

Ahora, nos vamos al archivo `show.blade.php` y editamos el componente `section` agregando un `@foreach`.

```html
 @foreach ($post->comments as $comment)
    <x-post-comment :comment="$comment" />
@endforeach
```

Después, nos ubicamos en el archivo `post-comment.blade.php` y editamos los componentes `<img/>`, `<h3/>`, `<time/>` y el `<p/>`

```php
<article class="flex bg-gray-100 border border-gray-200 p-6 rounded-xl space-x-4">
    <div class="flex-shrink-0">
        <img src="https://i.pravatar.cc/60?u={{ $comment->id }}" alt="" width="60" height="60" class="rounded-xl">
    </div>

    <div>
        <header class="mb-4">
            <h3 class="font-bold">{{ $comment->author->username }}</h3>

            <p class="text-xs">
                Posted
                <time>{{ $comment->created_at }}</time>
            </p>
        </header>

        <p>
            {{ $comment->body }}
        </p>
    </div>
</article>
```

Por ultimo volvemos a nuestra maquina virtual y abrimos otra vez el browser, y ejecutamos el siguiente comando para crear 10 comentarios a un solo post.

```bash
App\Models\Comment::factory(10)->create(['post_id' => 1]);
```

Verificamos en la pagina web.

![Verificar los 10 comentario](./images/54.1%20all_comments.png)