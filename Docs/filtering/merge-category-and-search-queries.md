[< Volver al Indice](/Docs/readme.md/)

# Merge Category and Search Queries

Nos vamos al archivo `_header.blade.php` y modificamos el `div` de `search`.

```php
<div class="relative flex lg:inline-flex items-center bg-gray-100 rounded-xl px-3 py-2">
            <form method="GET" action="/">
                
                @if (request('category'))
                <input type="hidden" name="category" value="{{ request('category') }}">
                @endif

                <input type="text" 
                name="search" 
                placeholder="Find something" 
                class="bg-transparent placeholder-black font-semibold text-sm" 
                value="{{ request('search') }}">
            </form>
        </div>
```

Por ultimo, nos vamos al archivo `category-dropdown.blade.php` y modificamos el `href` del `x-dropdown-item` de categoría.

```php
href="/?category={{ $category->slug }}&{{ http_build_query(request()->except('category')) }}"
```