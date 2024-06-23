[< Volver al Indice](/Docs/readme.md/)

# Route Model Binding

Haremos que mediante la función de enlace de modelo de ruta de Laravel vincularemos un comodín de ruta a una instancia de modelo de Eloquent.

Iniciamos modificando el archivo `web.php` que se encuentra en la carpeta de `routes` para utilizar lograr los enlaces.

```php
Route::get('posts/{post}', function (Post $post) {

    return view('post', [
        'post' => $post
    ]);
});
```

Luego, modificaremos la función `up` en el archivo `2024_06_23_193353_create_posts_table.php` creando un nuevo atributo llamado `slug`.

```php
public function up()
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->string('slug')->unique();
            $table->string('title');
            $table->text('excerpt');
            $table->text('body');
            $table->timestamps();
            $table->timestamp('published_at')->nullable();
        });
    }
```

Después, nos iremos a la maquina virtual y ejecutaremos el siguiente código para borrar y volver a crear la tablas, pero primero nos dirigimos a la base de datos y copiamos las tablas creadas con `copy As` y luego presionamos `Insert Statement`.

```bash
php artisan migrate:fresh
```

Volvemos a crear las tablas pero mediante el `sqlQuery`.

![Crear tabla mediante el sqlQuery](./images/23.1%20insert.png)

Volvemos al archivo `web.php` y lo modificaremos para usar el nuevo atributo `slug` para identificar el post.

```php
Route::get('posts/{post:slug}', function (Post $post) {

    return view('post', [
        'post' => $post
    ]);
});
```

Después, nos movemos al archivo `post.blade.php` para en vez de llamar por `id`, llamar por el nuevo atributo `slug`.

```php
<body>
    <x-layout>
    @foreach ($posts as $post)
<article>
        <h1>
            <a href="/posts/{{ $post->slug }}">
                {{!! $post->title !!}}
            </a>

        </h1>

        <div>
            {{ $post->excerpt }}
        </div>
    </article>
    @endforeach
</x-layout>
</body>
```

Ahora nos ubicamos en el archivo `Post.php` y creamos una nueva función llamada `getRouteKeyName` para retornar el atributo `slug`.

```php 
public function getRouteKeyName()
    {
        return 'slug';
    }
```