[< Volver al Indice](/Docs/readme.md/)

# Make a Post Model and Migration

Vamos a aplicar este aprendizaje a nuestro proyecto. Eliminaremos la antigua implementación basada en archivos del capítulo anterior y la reemplazaremos con un nuevo modelo Post Eloquent. 

También prepararemos una migración para construir la tabla de publicaciones. Empezamos eliminando el archivo `Post.php` que se encuentra en la carpeta `Models`, dentro de la carpeta `app`.

Posteriormente, abrimos nuestra maquina virtual y la ubicamos en `/vagrant/sites/lfts.isw811.xyz`.

Luego ejecutamos el siguiente comando para crear un nuevo archivo de migración:

```bash
php artisan make:migration create_post_table
```

Seguidamente vamos a eliminar la carpeta `post` que se encuentra ubicada dentro de la carpeta de `resources`

Luego de esto, modificamos la función `up` en el archivo creado anteriormente `2024_06_23_185803_create_post_table`, este archivo se encuentra en la carpeta migrations, dentro de la carpeta database:

```php
public function up()
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('excerpt');
            $table->text('body');
            $table->timestamps();
            $table->timestamp('published_at')->nullable();
        });
    }
```

Vamos a volver a la maquina virtual y ejecutamos el siguiente comando para crear la tabla post en la base de datos:

```bash
php artisan migrate
```

Así se tendría que ver en la base de datos:

![Base de datos actualizad con la tabla post](./images/20.1%20posts.png)

Vamos a ir a la maquina virtual ejecutamos el siguiente comando para crear el model de la tabla post ya creada:

```bash
php artisan make:model Post
```

Seguidamente volvemos a la maquina virtual otra vez y ejecutamos el siguiente comando para abrir una terminal de php:

```bash
php artisan tinker
```

Cuando estemos dentro de esa terminal ejecutamos el siguiente comando con el cual podemos ver todos los posts creados:

```bash
 App\Models\Post::all();
```

Crearemos un `post` con los siguientes comandos:

* Primero creamos la instancia

```bash
 $post = new App\Models\Post;
```

* Segundo:
    * Creamos el usuario con los siguiente comandos

 ```bash   
> $post->title = 'My First Post';
= "My First Post"

> $post->excerpt = 'Lorem ipsum dolor sit amet consectetur';
= "Lorem ipsum dolor sit amet consectetur"

> $post->body = 'Lorem ipsum dolor sit amet consectetur adipiscing elit pulvinar vulputate gravida, congue facilisi eros fusce venenatis sociosqu montes tellus leo, nulla curae interdum facilisis etiam velit lacus suspendisse id. Suspendisse cum inceptos mattis tempus proin dictumst fusce condimentum at magna vehicula, ullamcorper nam varius nisl a hendrerit tristique fringilla cursus ac, natoque sagittis bibendum ultrices velit habitant himenaeos eget urna aenean. Mollis ornare parturient sapien fames nascetur volutpat sollicitudin euismod suspendisse donec natoque, hac ultrices penatibus rutrum imperdiet viverra tincidunt
. sociosqu integer tellus dictumst vestibulum, hendrerit elementum fringilla sed ligula convallis dictum duis malesuada class.';
= """
  Lorem ipsum dolor sit amet consectetur adipiscing elit pulvinar vulputate gravida, congue facilisi eros fusce venenatis sociosqu montes tellus leo, nulla curae interdum facilisis etiam velit lacus suspendisse id. Suspendisse cum inceptos mattis tempus proin dictumst fusce condimentum at magna vehicula, ullamcorper nam varius nisl a hendrerit tristique fringilla cursus ac, natoque sagittis bibendum ultrices velit habitant himenaeos eget urna aenean. Mollis ornare parturient sapien fames nascetur volutpat sollicitudin euismod suspendisse donec natoque, hac ultrices penatibus rutrum imperdiet viverra tincidunt\n
  sociosqu integer tellus dictumst vestibulum, hendrerit elementum fringilla sed ligula convallis dictum duis malesuada class.
  """

> $post->save();
= true
```

Se tendria que ver asi:

![tabla post](./images/20.2%20databases.png)

Con el siguiente comando podemos buscar un post mediante `ID`:

```bash
Post::find('Id a buscar');
```

Con el siguiente comando podemos ver todos los posts creados:

```bash
Post::all();
```

Con el siguiente comando podemos ver el primer post creado:

```bash
$post->first();
```

Luego vamos a editar el archivo `web.php` cambiando el `slug` por `id`.

```php
Route::get('posts/{post}', function ($id) {

    return view('post', [
        'post' => Post::findOrFail($id)
    ]);
});
```

Por ultimo cambiamos también el archivo `posts.blade.php`, igualmente cambiando el `slug` por `id`.

```php
<article>
        <h1>
            <a href="/posts/{{ $post->id }}">
                {{ $post->title }}
            </a>

        </h1>

        <div>
            {{ $post->excerpt }}
        </div>
    </article>
```

Al final creamos otro Post para la siguiente session