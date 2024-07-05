[< Volver al Indice](/Docs/readme.md/)

# Eager Load Relationships on an Existing Model

Vamos a especificar qué relaciones deben cargarse de forma predeterminada en un modelo.

Iniciamos abriendo el browser para crear post con el siguiente comando:

```bash
php artisan tinker
```

Ya dentro de ese browser ejecutamos el siguiente comando para crear 10 posts asociados solamente a la categoría con el id numero 1. 

```bash
App\Models\Post::factory(10)->create(['category_id' => 1]);
```

Se tiene que ver de la siguiente manera

![Create](./images/30.1%20create.png)

Vamos al archivo `web.php` y modicaremos las rutas para renderizar mejor la pagina con la siguiente linea de código, esto eso tanto en la ruta slug, como en la de username.

```php
'posts' => $category->posts->load(['category', 'author' ])
---
'posts' => $author->posts->load(['category', 'author' ])
```

Para hacer el código mas clean y ahorrarnos los dos anteriores pasos, nos vamos para el archivo `Post.php` y agregamos la siguiente linea de código que se hace exactamente lo mismos.

```php
protected $with = ['category', 'author'];
```

Eliminamos en `web.php` lo siguiente
```php
->with(['category', 'author'])
---
'posts' => $category->posts->load(['category', 'author' ])
---
'posts' => $author->posts->load(['category', 'author' ])
```