[< Volver al Indice](/Docs/readme.md/)

# Show All Posts Associated With a Category

Ahora que tenemos el concepto de una categoría en nuestra aplicación, vamos a crear una nueva ruta que recupere y cargue todas las publicaciones que están asociadas con la categoría dada.

Comenzamos creando la ruta de categorías en el archivo `web.php`.

```php
Route::get('categories/{category}', function (Category $category) {

    return view('posts', [
        'posts' => $category->posts
    ]);
});
```
Seguidamente, creamos la siguiente función en el archivo `Category.php` para hacer la relación con eloquent vista en el episodio anterior pero esta vez con los posts.

```php
public function posts()
    {
        return $this->hasMany(Post::class);
    }
```

Para comprobar esta relación, nos vamos a la maquina virtual nos ubicamos en `/vagrant/sites/lfts.isw811.xyz` y ejecutamos el siguiente comando ya antes visto:

```bash
php artisan tinker
```

Ahora si, dentro de esa terminal ejecutamos los siguientes comandos de la imagen:

![Comprobar relación](./images/25.1%20category.png)

Para finalizar, editaremos los archivos `posts.blade.php` y `post.blade.php` que en vez de llamar la ruta mediante id, se llame mediante el `slug`.

```php
<a href="/categories/{{$post->category->slug}}">{{$post->category->name}}</a>
```

Ahora nos iremos al archivo `web.php` y arreglamos ruta para que llame al `slug` para que la pagina funcione sin ningún problema.

```php
Route::get('categories/{category:slug}', function (Category $category) {

    return view('posts', [
        'posts' => $category->posts
    ]);
});
```

Nos deberia de quedar de la siguiente manera:
![Ruta con slug](./images/25.2%20posts.png)