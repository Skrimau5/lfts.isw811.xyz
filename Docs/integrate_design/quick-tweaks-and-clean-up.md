[< Volver al Indice](/Docs/readme.md/)

# Quick Tweaks and Clean-Up

Nos ubicamos en el archivo `dropdown.blade.php` y modificamos el `div` de links para darle unos estilos:

```php
 <!-- Links -->
    <div x-show="show" class="py-2 absolute bg-gray-100 mt-2 rounded-xl w-full z-50 overflow-auto max-h-52" style="display: none">
        {{ $slot }}
    </div>
```

Ahora nos vamos para el archivo `_posts-header.blade.php` y primero eliminamos la siguientes dos lineas del código que no la necesitamos.

```html
 <h2 class="inline-flex mt-2">By Lary Laracore <img src="/images/lary-head.svg" alt="Head of Lary the mascot"></h2>

    <p class="text-sm mt-14">
        Another year. Another update. We're refreshing the popular Laravel series with new content.
        I'm going to keep you guys up to speed with what's going on!
    </p>
```

Y después, documentamos lo siguiente:

```html
<!--
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
        -->
```

Y además, modificamos que en vez de mt-8, lo cambiamos a lo siguiente:

```html
<div class="space-y-2 lg:space-y-0 lg:space-x-4 mt-4">
```

Posteriormente, nos ubicamos en el archivo `PostFactory.php` y modificamos los atributos `excerpt` y `body`:

```php
'excerpt' => '<p>' . implode('</p><p>', $this->faker->paragraphs(2)) . '</p>',
'body' => '<p>' . implode('</p><p>', $this->faker->paragraphs(6)) . '</p>'
```

Y después, nos dirigimos a la maquina virtual y nos ubicamos en `/vagrant/sites/lfts.isw811.xyz/` y ejecutamos el siguiente comando para borrar y volver a crear las tablas:

```bash
php artisan migrate:fresh
```

Y seguidamente, ejecutamos el siguiente comando:  

```bash
php artisan migrate:fresh --seed
```

Luego 

```bash
php artisan tinker
```

Y por ultimo:

```bash
App\Models\Post::factory(30)->create(['category_id' => 1]);
```

Nos vamos al archivo `post-featured-card.blade.php` y modificamos lo siguiente:

```php
<div class="text-sm mt-2 space-y-4">
    {!! $post->excerpt !!}
</div>
```

Hacemos lo mismo en el archivo `post-card.blade.php`.

```php
<div class="text-sm mt-4 space-y-4">
    {!! $post->excerpt !!}
</div>
```

Y por ultimo, editamos lo siguiente del archivo `post.blade.php`.

```php
<div class="space-y-4 lg:text-lg leading-loose">
    {!! $post->body !!}
</div>
```