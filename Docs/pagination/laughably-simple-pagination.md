[< Volver al Indice](/Docs/readme.md/)

# Laughably Simple Pagination

Para empezar, nos vamos al `PostsController.php` y editamos la función `index`.

```php
return view('posts.index', [
            'posts' => Post::latest()->filter(
                request(['search', 'category', 'author'])
            )->paginate(18)->withQueryString()
        ]);
```

Luego nos vamos al archivo `index.blade.php` y agregamos lo siguiente debajo del componente `x-posts-grid`.

```php
{{ $posts->links() }}
```

Seguidamente nos vamos al archivo `category-dropdown.blade.php` y haremos lo siguiente

* Primero modificamos el `href` del componente `x-dropdown-item` que se encuentra dentro del `@foreach` agregando `page` en el `except`.

```php
href="/?category={{ $category->slug }}&{{ http_build_query(request()->except('category', 'page')) }}" 
```
* Después, modificamos el `href` del `x-dropdown-item` fuera del `@foreach`.

```php
href="/?{{ http_build_query(request()->except('category', 'page')) }}"
```

Por ultimo abrimos nuestra maquina virtual y nos ubicamos en `/vagrant/sites/lfts.isw811.xyz`, y ejecutamos el siguiente comando.

```bash
php artisan vendor:publish
```

Luego de esto ingresamos la opcion `Tag: laravel-pagination` nos va salir el siguiente mensaje

```bash
Copied Directory [/vendor/laravel/framework/src/Illuminate/Pagination/resources/views] To [/resources/views/vendor/pagination]
Publishing complete.
```

Para finaliza, verificamos nuestra pagina web.

![Pagina con la parte de pagination](./images/44.1%20pages.png)