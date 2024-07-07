[< Volver al Indice](/Docs/readme.md/)

# Search (The Cleaner Way)

Vamos abrir nuestra maquina virtual en la ubicación de `/vagrant/sites/lfts.isw811.xyz` y ejecutamos el comando para crear un archivo controller llamado `PostController`.

```bash
php artisan make:controller PostController
```

Seguidamente nos ubicamos en el archivo `web.php` y cortamos el código que se encuentra dentro de la ruta `Route::get('/')` y también el que se encuentra dentro de la ruta `Route::get('posts/{post:slug}')`.

Luego, nos vamos al nuevo archivo nuevo creado llamado `PostController.php`que se encuentra en la carpeta `Controller`, dentro de la carpeta `Http` y creamos dos funciones, una se llama `index()`, en esa copiamos el código anteriormente cortado de la ruta `Route::get('/')` 

```php
    public function index ()
    {
    $posts = Post::latest();

    if(request('search')){
        $posts
            ->where('title', 'like', '%' . request('search') . '%')
            ->orWhere('body', 'like', '%' . request('search') . '%');
    }
    return view('posts', [
        'posts' => $posts->get(),
        'categories' => Category::all()
    ]);
    }
```

Y en `web.php` vamos a ingresar lo siguiente

```php
Route::get('/', [PostController::class, 'index'])->name('home');
```

Luego en la otra función llamada `show()` copiamos el código de la ruta `Route::get('posts/{post:slug}')`.

```php
    public function show (Post $post)
    {
        return view('post', [
            'post' => $post
        ]);
    }
```
Y en `web.php` vamos a ingresar lo siguiente

```php
Route::get('posts/{post:slug}', [PostController::class, 'show']);
```

Ahora nos vamos al archivo `Post.php` y editamos la siguiente función.

```php
public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? false, fn ($query, $search) =>
            $query
                ->where('title', 'like', '%' . $search . '%')
                ->orWhere('body', 'like', '%' . $search . '%'));
    }
```

Y por ultimo, volvemos al archivo `PostController.php` y editamos la función `index()`.

```php
public function index()
    {
        return view('posts', [
            'posts' => Post::latest()->filter(request(['search']))->get(),
            'categories' => Category::all()
        ]);
    }
```