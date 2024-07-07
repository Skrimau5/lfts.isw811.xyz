[< Volver al Indice](/Docs/readme.md/)

# Convert the Blog Post Page

Primero, modificamos el archivo post.blade.php, en cual lo que hicimos fue agregarle nuestro estilo y nuestras rutas:

```html
<x-layout>
    <section class="px-6 py-8">
        <main class="max-w-6xl mx-auto mt-10 lg:mt-20 space-y-6">
            <article class="max-w-4xl mx-auto lg:grid lg:grid-cols-12 gap-x-10">
                <div class="col-span-4 lg:text-center lg:pt-14 mb-10">
                    <img src="/images/illustration-1.png" alt="" class="rounded-xl">

                    <p class="mt-4 block text-gray-400 text-xs">
                        Published <time>{{ $post->created_at->diffForHumans() }}</time>
                    </p>

                    <div class="flex items-center lg:justify-center text-sm mt-4">
                        <img src="/images/lary-avatar.svg" alt="Lary avatar">
                        <div class="ml-3 text-left">
                            <h5 class="font-bold">{{ $post->author->name}}</h5>
                        </div>
                    </div>
                </div>

                <div class="col-span-8">
                    <div class="hidden lg:flex justify-between mb-6">
                        <a href="/" class="transition-colors duration-300 relative inline-flex items-center text-lg hover:text-blue-500">
                            <svg width="22" height="22" viewBox="0 0 22 22" class="mr-2">
                                <g fill="none" fill-rule="evenodd">
                                    <path stroke="#000" stroke-opacity=".012" stroke-width=".5" d="M21 1v20.16H.84V1z">
                                    </path>
                                    <path class="fill-current" d="M13.854 7.224l-3.847 3.856 3.847 3.856-1.184 1.184-5.04-5.04 5.04-5.04z">
                                    </path>
                                </g>
                            </svg>

                            Back to Posts
                        </a>

                        <div class="space-x-2">
                            <x-category-button :category="$post->category" />
                        </div>
                    </div>

                    <h1 class="font-bold text-3xl lg:text-4xl mb-10">
                        {{ $post->title }}
                    </h1>

                    <div class="space-y-4 lg:text-lg leading-loose">
                        {{ $post->body }}
                    </div>
                </div>
            </article>
        </main>
    </section>

</x-layout>
```

Y además, creamos un nuevo archivo llamada `category-button.blade.php` en la carpeta `components` en cual manejamos el `slug`:

```php
@props (['category'])

<a href="/category/{{$category->slug }}" 
class="px-3 py-1 border border-blue-300 rounded-full text-blue-300 text-xs uppercase font-semibold" 
style="font-size: 10px">{{$category->name}}</a>
```

Luego nos vamos para `post-card.blade.php` y modificamos lo siguiente:

```php
    <div class="mt-6 flex flex-col justify-between flex-1">
        <header>
            <div class="space-x-2">
            <x-category-button : category="$post->category"/>
            </div>
```