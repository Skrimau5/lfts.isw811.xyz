[< Volver al Indice](/Docs/readme.md/)

# Extract a Category Dropdown Blade Component

Abrimos nuestra maquina virtual y ejecutamos el siguiente comando para crear un nuevo archivo llamado `category-dropdown.blade.php`.

```bash
php artisan make:component CategoryDropdown
```

Luego nos ubicamos en el archivo `_posts-header.blade.php` y cortamos todo el código del componente `x-dropdown` y agregamos el siguiente componente.

```php
<x-category-dropdown />
```

Ahora, nos vamos al nuevo archivo creado `category-dropdown.blade.php` y pegamos el código cortado anteriormente que seria el siguiente.

```php
<x-dropdown>
            <x-slot name="trigger">
                <button class="py-2 pl-3 pr-9 text-sm font-semibold w-full lg:w-32 text-left flex lg:inline-flex">{{ isset($currentCategory) ? ucwords($currentCategory->name) :'Categories' }}

                    <svg class="transform -rotate-90 absolute pointer-events-none" style="right: 12px;" width="22" height="22" viewBox="0 0 22 22">
                        <g fill="none" fill-rule="evenodd">
                            <path stroke="#000" stroke-opacity=".012" stroke-width=".5" d="M21 1v20.16H.84V1z">
                            </path>
                            <path fill="#222" d="M13.854 7.224l-3.847 3.856 3.847 3.856-1.184 1.184-5.04-5.04 5.04-5.04z"></path>
                        </g>
                    </svg>
                </button>
            </x-slot>


            <a href="/" class="block text-left px-3 text-sm leading-6 hover:bg-blue-500 focus:bg-blue-500 hover:text-white focus:text-white">All</a>
            <x-dropdown-item href="/" :active="request()->routeIs('home')">All</x-dropdown-item>

            @foreach ($categories as $category)
            <x-dropdown-item>
            <a href="/category/{{ $category->slug }}" 
            :active='request()->is("categories/{$category->slug}")'
            >{{ ucwords($category->name) }}</x-dropdown-item>
            @endforeach
        </x-dropdown>
```

Ahora, nos vamos al archivo `CategoryDropdown.php` y modificamos el return, agregando lo siguiente.
, el `currentCategory` lo cortamos del archivo `PostController.php`
```php
return view('components.category-dropdown', [
            'categories' => Category::all(),
            'currentCategory' => Category::firstWhere('slug', request('category'))]);
```

Y ahora, nos vamos a los archivos `web.php` y `PostController.php` y eliminamos la siguiente linea de código de los return.

```php
'categories' => Category::all()
```

El `PostController.php` queda asi

```php
public function index()
    {
        return view('posts.index', [
            'posts' => Post::latest()->filter(request(['search', 'category']))->get()
        ]);

    }

    public function show (Post $post)
    {
        return view('posts.show', [
            'post' => $post
        ]);
    }        
```

Continuando, creamos una carpeta llamada `posts` dentro de la carpeta `views`, y posteriormente movemos los archivos `_post-header.blade.php`, `post.blade.php` y `posts.blade.php`, ahora, una vez dentro de la nueva carpeta `posts` cambiamos los nombres de los archivos.

* Primero el archivo `_post-header.blade.php`, lo cambiamos a `_header.blade.php`.
* Luego, el archivo `post.blade.php`, lo cambiamos a `show.blade.php`.
* Y por ultimo, el archivo `posts.blade.php`, lo cambiamos a `index.blade.php`.

Y ahora en el archivo `index.blade.php` modificamos el `@include`.

```php
@include ('posts._header')
```