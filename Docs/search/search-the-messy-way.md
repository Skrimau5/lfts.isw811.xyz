[< Volver al Indice](/Docs/readme.md/)

# Search (The Messy Way)

Primeramente, nos vamos al archivo `web.php` y agregamos y modificamos lo siguiente en la ruta `/` para poder hacer las búsquedas en la pagina.

```php
Route::get('/', function () {

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
})->name('home');
```

Luego nos vamos al archivo `_posts-header.blade.php` y agregamos lo siguiente en el input de `search` para que los que buscamos no se borre de la barra de búsqueda.

```bash
value="{{ request('search') }}"
```

Se tendria que ver de la siguiente manera:

```bash
        <div class="relative flex lg:inline-flex items-center bg-gray-100 rounded-xl px-3 py-2">
            <form method="GET" action="#">
                <input type="text" 
                name="search" 
                placeholder="Find something" 
                class="bg-transparent placeholder-black font-semibold text-sm"
                value="{{ request('search') }}">
            </form>
        </div>
```

Se tendria que ver la pagina Web de la siguiente manera cuando hagamos una busqueda en el filtro

![Verificación del search](./images/37.1%20web.png)