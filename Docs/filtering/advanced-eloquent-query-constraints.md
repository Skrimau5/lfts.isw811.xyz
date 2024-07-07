[< Volver al Indice](/Docs/readme.md/)

# Advanced Eloquent Query Constraints

Primero nos vamos al archivo `Post.php` y agregamos lo siguiente en la función `scopeFilter` para buscar por categoría.

```php
$query->when($filters['category'] ?? false, fn($query, $category) =>
        $query->whereHas('category', fn ($query) =>
        $query->where('slug', $category)));
```

Luego nos ubicamos en el archivo `PostController.php` y agregamos `category` en el request del return de `posts` y también agregamos el `currentCategory`.

```php
return view('posts', [
            'posts' => Post::latest()->filter(request(['search', 'category']))->get(),
            'categories' => Category::all(),
            'currentCategory' => Category::firstWhere('slug', request('category'))
        ]);
```

Posteriormente, nos vamos al archivo `web.php` y eliminamos la ruta `categories`.

Después, nos vamos al archivo `_post-header.blade.php` y modificamos el `href` del componente `<x-dropdown-item`.

```php
            @foreach ($categories as $category)
            <x-dropdown-item>
            <a href="/category/{{ $category->slug }}" 
            :active='request()->is("categories/{$category->slug}")'
            >{{ ucwords($category->name) }}</x-dropdown-item>
            @endforeach
        </x-dropdown>
```

Si todo sale bien tendria que salirnos esto, si por ejemplo buscamos: `http://lfts.isw811.xyz/?search=tenetur&category=saepe-eos-iusto-sed-natus-facere-qui`

![Verificación del search](./images/39.1%20search.png)