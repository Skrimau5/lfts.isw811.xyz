[< Volver al Indice](/Docs/readme.md/)

# Blade Components and CSS Grids

Nos vamos a ubicar el archivo `posts.blade.php` y comentaremos todo menos el componente `main` y escribiremos lo siguiente:

```html
<main class="max-w-6xl mx-auto mt-6 lg:mt-20 space-y-6">
    <x-post-featured-card :post="$posts[0]" />
</main>
```

Seguidamente, nos vamos para el archivo `post-featured-card.blade.php` y editamos el componente `<div class="mt-4">`, le agregamos lo siguiente:

```html
<div class="mt-4">
    <h1 class="text-3xl">
         {{ $post->title }}
    </h1>

    <span class="mt-2 block text-gray-400 text-xs">
        Published <time>1 day ago</time>
    </span>
</div>
```

Y también, en el top del mismo archivo, escribimos lo siguiente:

```html
@props(['post'])
```

Seguidamente, editamos casi todo el archivo `post-featured-card.blade.php` para adaptarlos a nuestras rutas, así quedo:

```html
@props(['post'])

<article class="transition-colors duration-300 hover:bg-gray-100 border border-black border-opacity-0 hover:border-opacity-5 rounded-xl">
    <div class="py-6 px-5 lg:flex">
        <div class="flex-1 lg:mr-8">
            {{-- TODO --}}
            <img src="./images/illustration-1.png" alt="Blog Post illustration" class="rounded-xl">
        </div>

        <div class="flex-1 flex flex-col justify-between">
            <header class="mt-8 lg:mt-0">
                <div class="space-x-2">
                    <a href="/category/{{ $post->category->slug }}" 
                    class="px-3 py-1 border border-blue-300 rounded-full text-blue-300 text-xs uppercase font-semibold" 
                    style="font-size: 10px">{{ $post->category->name}}</a>
                </div>

                <div class="mt-4">
                    <h1 class="text-3xl">
                        <a href="/posts/{{ $post->slug }}">
                        {{ $post->title }}
                        </a>
                    </h1>

                    <span class="mt-2 block text-gray-400 text-xs">
                        Published <time>{{ $post->created_at->diffForHumans() }}</time>
                    </span>
                </div>
            </header>

            <div class="text-sm mt-2">
                <p>
                    {{ $post->excerpt }}
                </p>
            </div>

            <footer class="flex justify-between items-center mt-8">
                <div class="flex items-center text-sm">
                    <img src="./images/lary-avatar.svg" alt="Lary avatar">
                    <div class="ml-3">
                        <h5 class="font-bold">{{ $post->author->name}}</h5>
                        <h6>Mascot at Laracasts</h6>
                    </div>
                </div>

                <div class="hidden lg:block">
                    <a href="/posts/{{ $post->slug }}" class="transition-colors duration-300 text-xs font-semibold bg-gray-200 hover:bg-gray-300 rounded-full py-2 px-8">Read More</a>
                </div>
            </footer>
        </div>
    </div>
</article>
```

Ahora, nos movemos al archivo `posts.blade.php` y editamos lo siguiente:

```html
<main class="max-w-6xl mx-auto mt-6 lg:mt-20 space-y-6">
        <x-post-featured-card :post="$posts[0]" />

        <div class="lg:grid lg:grid-cols-2">
            @foreach ($posts->skip(1) as $post)

            <x-post-card :post="$post" />

            @endforeach

        </div>

    </main>
```

Seguidamente, nos movemos al archivo `post-card.blade.php` y copiamos el siguiente código:

```html
<article class="transition-colors duration-300 hover:bg-gray-100 border border-black border-opacity-0 hover:border-opacity-5 rounded-xl">
    <div class="py-6 px-5">
        <div>
            {{-- TODO --}}
            <img src="./images/illustration-3.png" alt="Blog Post illustration" class="rounded-xl">
        </div>

        <div class="mt-8 flex flex-col justify-between">
            <header>
                <div class="space-x-2">
                    <a href="/category/{{ $post->category->slug }}" class="px-3 py-1 border border-blue-300 rounded-full text-blue-300 text-xs uppercase font-semibold" style="font-size: 10px">{{ $post->category->name}}</a>
                </div>

                <div class="mt-4">
                    <h1 class="text-3xl">
                        <a href="/posts/{{ $post->slug }}">
                            {{ $post->title }}
                        </a>
                    </h1>

                    <span class="mt-2 block text-gray-400 text-xs">
                        Published <time>{{ $post->created_at->diffForHumans() }}</time>
                    </span>
                </div>
            </header>

            <div class="text-sm mt-4">
                <p>
                    {{ $post->excerpt }}
                </p>
            </div>

            <footer class="flex justify-between items-center mt-8">
                <div class="flex items-center text-sm">
                    <img src="./images/lary-avatar.svg" alt="Lary avatar">
                    <div class="ml-3">
                        <h5 class="font-bold">{{ $post->author->name}}</h5>
                        <h6>Mascot at Laracasts</h6>
                    </div>
                </div>

                <div>
                    <a href="/posts/{{ $post->slug }}" class="transition-colors duration-300 text-xs font-semibold bg-gray-200 hover:bg-gray-300 rounded-full py-2 px-8">Read More</a>
                </div>
            </footer>
        </div>
    </div>
</article>
```

Modificamos el siguiente archivo `posts.blade.php`:

```php
<x-layout>
    @include ('_posts-header')

    <main class="max-w-6xl mx-auto mt-6 lg:mt-20 space-y-6">
        @if ($posts->count())
        <x-posts-grid :posts="$posts" />
        @else
        <p class="text-center">No post yet. Please check back later</p>
        @endif
    </main>
</x-layout>
```

También el archivo `post-card.blade.php`:

```php
@props(['post'])

<article {{ $attributes->merge (['class' => 'transition-colors duration-300 hover:bg-gray-100 border border-black border-opacity-0 hover:border-opacity-5 rounded-xl'])}}> <div class="py-6 px-5">
    <div>
        {{-- TODO --}}
        <img src="./images/illustration-3.png" alt="Blog Post illustration" class="rounded-xl">
    </div>

    <div class="mt-8 flex flex-col justify-between">
        <header>
            <div class="space-x-2">
                <a href="/category/{{ $post->category->slug }}" class="px-3 py-1 border border-blue-300 rounded-full text-blue-300 text-xs uppercase font-semibold" style="font-size: 10px">{{ $post->category->name}}</a>
            </div>

            <div class="mt-4">
                <h1 class="text-3xl">
                    <a href="/posts/{{ $post->slug }}">
                        {{ $post->title }}
                    </a>
                </h1>

                <span class="mt-2 block text-gray-400 text-xs">
                    Published <time>{{ $post->created_at->diffForHumans() }}</time>
                </span>
            </div>
        </header>

        <div class="text-sm mt-4">
            <p>
                {{ $post->excerpt }}
            </p>
        </div>

        <footer class="flex justify-between items-center mt-8">
            <div class="flex items-center text-sm">
                <img src="./images/lary-avatar.svg" alt="Lary avatar">
                <div class="ml-3">
                    <h5 class="font-bold">{{ $post->author->name}}</h5>
                    <h6>Mascot at Laracasts</h6>
                </div>
            </div>

            <div>
                <a href="/posts/{{ $post->slug }}" class="transition-colors duration-300 text-xs font-semibold bg-gray-200 hover:bg-gray-300 rounded-full py-2 px-8">Read More</a>
            </div>
        </footer>
    </div>
    </div>
</article>
```

Y por ultimo, creamos un nuevo archivo llamado `posts-grid.blade.php` en la carpeta de `components` que se encuentra dentro de la carpeta `views`.

```html
@props(['posts'])

<x-post-featured-card :post="$posts[0]" />

@if ($posts->count() > 1)
<div class="lg:grid lg:grid-cols-6">
    @foreach ($posts->skip(1) as $post)

    <x-post-card :post="$post" class="{{ $loop->iteration < 3 ? 'col-span-3' : 'col-span-2' }}" />

    @endforeach

</div>
@endif
```