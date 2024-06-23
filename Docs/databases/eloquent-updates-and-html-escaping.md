[< Volver al Indice](/Docs/readme.md/)

# Eloquent Updates and HTML Escaping

Vamos a ver cómo actualizar los registros de la base de datos usando eloquent. Luego, revisaremos un ejemplo de por qué escapar de la entrada proporcionada por el usuario es esencial para la seguridad de su aplicación.

Para comenzar, abrimos nuestra maquina virtual en `/vagrant/sites/lfts.isw811.xyz` y ejecutamos el siguiente comando para abrir el tinker:

```bash
php artisan tinker
```

Luego, nos ubicamos en el primer post creado con el siguiente comando:

```bash
$post = App\Models\Post::first();
```

Después ejecutamos el siguiente comando para posicionarnos en el `body` del post:

```bash
$post->body;
```

Después ejecutamos el siguiente comando para actualizar el post y volver el body un HTML de tipo `<p>`:

```bash
$post->body = '<p>' . $post->body . '</p>';
```

Cuando se realice el cambio correctamente, ejecutamos el siguiente comando para guardad el update realizado.

```bash
$post->save();
```

Revisamos y refrescamos la pagina para ver el cambio realizado. Se debe ver el párrafo con un poco de interlineado.

![Actualización del body del primer post](./images/21.1%20post.png)

Vamos a repetir el mismo proceso para el segundo post, pero esta vez los vamos a ubicar con el siguiente comando de buscar por `id`:
 
 ```bash
 $post = App\Models\Post::find(2);
 ```

Y ahora volvemos a repetir los mismos comandos mencionados anteriormente para modificar el body
 y hacer un HTML de tipo `<p>`.

 ```bash
$post->body = '<p>' . $post->body . '</p>';
```

Luego ingresamos:

 ```bash
> use app\Models\Post;
```

Despues:

 ```bash
> $post = Post::first();
```

 Seguidamente, ahora actualizaremos el atributo `title` a un HTML de tipo `<strong>`, pero antes de realizar este cambio hay que dirigirnos al archivo `post.blade.php` y cambiar lo siguiente en el `<h1>`:

 ```php
 <article>
        <h1>{!! $post->title !!}</h1>

        <div>
            {!! $post->body !!}
        </div>
    </article>
 ```

 Después de este cambio ya podremos actualizar el atributo `title` a un HTML de tipo `<strong>`.