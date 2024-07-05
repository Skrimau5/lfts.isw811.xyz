[< Volver al Indice](/Docs/readme.md/)

# A Small JavaScript Dropdown Detour

Empezamos modificando el archivo `_posts-header.blade.php` en cual agregamos un foreach para llamar las categorías mediante la ruta. 

```html
<div class="relative flex lg:inline-flex items-center bg-gray-100 rounded-xl">
    <select class="flex-1 appearance-none bg-transparent py-2 pl-3 pr-9 text-sm font-semibold">
        <option value="category" disabled selected>Category
        </option>
        @foreach ($categories as $category)
        <option value="{{ $category->slug }}">{{ $category->name }}</option>
         @endforeach
    </select>
```

El código anterior no nos va a funcionar porque primero hay que irnos al archivo `web.php` y agregar la ruta `categories` en todas las rutas.

```php
Route::get('/', function () {

    return view('posts', [
        'posts' => Post::latest()->get(),
        'categories' => Category::all()
    ]);
});
```

Luego vamos a nuestro browser de la computador y nos vamos al siguiente link para descargar el `script` para utilizar javascript:

* [Alpine.js](https://github.com/alpinejs/alpine/tree/v2.8.2)


Este script lo añadimos en el archivo `layout.blade.php`:

```html
<script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
```

Ahora, vamos y modificamos la mayor parte del código del archivo `_posts-header.blade.php` para primero integrar nuestras categorías y darle un apropiado diseño.

```html
<header class="max-w-xl mx-auto mt-20 text-center">
    <h1 class="text-4xl">
        Latest <span class="text-blue-500">Laravel From Scratch</span> News
    </h1>

    <h2 class="inline-flex mt-2">By Lary Laracore <img src="/images/lary-head.svg" alt="Head of Lary the mascot"></h2>

    <p class="text-sm mt-14">
        Another year. Another update. We're refreshing the popular Laravel series with new content.
        I'm going to keep you guys up to speed with what's going on!
    </p>

    <div class="space-y-2 lg:space-y-0 lg:space-x-4 mt-8">
        <!--  Category -->
        <div class="relative lg:inline-flex bg-gray-100 rounded-xl">

            <div x-data="{show: false}" @click.away="show = false">
                <button @click="show = ! show" class="py-2 pl-3 pr-9 text-sm font-semibold w-full lg:w-32 text-left flex lg:inline-flex">{{ isset($currentCategory) ? ucwords($currentCategory->name) :'Categories' }}

                    <svg class="transform -rotate-90 absolute pointer-events-none" style="right: 12px;" width="22" height="22" viewBox="0 0 22 22">
                        <g fill="none" fill-rule="evenodd">
                            <path stroke="#000" stroke-opacity=".012" stroke-width=".5" d="M21 1v20.16H.84V1z">
                            </path>
                            <path fill="#222" d="M13.854 7.224l-3.847 3.856 3.847 3.856-1.184 1.184-5.04-5.04 5.04-5.04z"></path>
                        </g>
                    </svg>

                </button>

                <div x-show="show" class="py-2 absolute bg-gray-100 mt-2 rounded-xl w-full z-50" style="display: none">
                    <a href="/" class="block text-left px-3 text-sm leading-6 hover:bg-blue-500 focus:bg-blue-500 hover:text-white focus:text-white">All</a>


                    @foreach ($categories as $category)
                    <a href="/categories/{{ $category->slug }}" class="
                    block text-left px-3 text-sm leading-6 
                    hover:bg-blue-500 focus:bg-blue-500 hover:text-white focus:text-white 
                    {{ isset($currentCategory) && $currentCategory->is($category) ? 'bg-blue-500 text-white' : ''}}
                     "
                     >{{ ucwords( $category->name )}}</a>
                    @endforeach
                </div>
            </div>
        </div>

        <!-- Other Filters -->
        <div class="relative flex lg:inline-flex items-center bg-gray-100 rounded-xl">
            <select class="flex-1 appearance-none bg-transparent py-2 pl-3 pr-9 text-sm font-semibold">
                <option value="category" disabled selected>Other Filters
                </option>
                <option value="foo">Foo
                </option>
                <option value="bar">Bar
                </option>
            </select>

            <svg class="transform -rotate-90 absolute pointer-events-none" style="right: 12px;" width="22" height="22" viewBox="0 0 22 22">
                <g fill="none" fill-rule="evenodd">
                    <path stroke="#000" stroke-opacity=".012" stroke-width=".5" d="M21 1v20.16H.84V1z">
                    </path>
                    <path fill="#222" d="M13.854 7.224l-3.847 3.856 3.847 3.856-1.184 1.184-5.04-5.04 5.04-5.04z"></path>
                </g>
            </svg>
        </div>

        <!-- Search -->
        <div class="relative flex lg:inline-flex items-center bg-gray-100 rounded-xl px-3 py-2">
            <form method="GET" action="#">
                <input type="text" name="search" placeholder="Find something" class="bg-transparent placeholder-black font-semibold text-sm">
            </form>
        </div>
    </div>
</header>
```

Y para finalizar, volvemos a nuestro archivo `web.php` y agregamos la siguiente linea de código en la ruta de `categories`:

```php
'currentCategory' => $category
```