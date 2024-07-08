[< Volver al Indice](/Docs/readme.md/)

# Some Light Chapter Clean Up

Para iniciar nos vamos a `show.blade.php` y agregamos lo siguiente:

```html
    @error ('body')
        <span class="text-xs text-red-5000"> {{ $message }}</span>
    @enderror
```

Luego ubicándonos en el archivo `show.blade.php` y cortamos todo el contenido que se encuentra en el componente `@auth` 

Ahora creamos un nuevo archivo dentro de la carpeta `posts` llamado `_add-comment-form.blade.php` y agregamos el codigo anteriormente cortado.

```html
@auth
                <x-panel>
                    <form method="POST" action="/posts/{{ $post->slug }}/comments">
                    @csrf

                    <header class="flex items-center">
                     <img src="https://i.pravatar.cc/60?u={{ auth()->id() }}"
                     alt=""
                     width="40"
                     height="40"
                     class="rounded-full">

                    <h2 class="ml-4">Want to participate?</h2>
                    </header>

                    <div class="mt-6">
                    <textarea
                    name="body"
                    class="w-full text-sm focus:outline-none focus:ring"
                    rows="5"
                    placeholder="Quick, thing of something to say!"
                    required></textarea>

                    @error ('body')
                    <span class="text-xs text-red-5000"> {{ $message }}</span>
                    @enderror
                    
                    </div>

                    <div class="flex justify-end mt-6 pt-6 border-t border-gray-200">
                    <button type="submit"
                    class="bg-blue-500 text-white uppercase font-semibold text-xs py-2 px-10 rounded-2xl hover:bg-blue-600">
                    POST</button>
                    </div>
                    </form>
                </x-panel>
                @else
                     <p class="front-semibold"> 
                        <a href="/register"class="hover:underline">Register</a> or <a href="/login" class="hover:underline">log in </a> to leave a comment </a>
                    </p>
            @endauth
```

Volvemos al archivo `show.blade.php` y agregamos la siguiente linea de código donde cortamos lo anterior.

```php
@include ('posts._add-comment-form')
```

Luego nos vamos al archivo `_add-comment-form.blade.php` y cortamos el componente `button`.

Ahora, creamos un nuevo archivo dentro de la carpeta `components` llamado `submit-button.blade.php` y pegamos el componente anteriormente cortado y también agregamos lo siguiente.

```php
<button 
    type="submit"
    class="bg-blue-500 text-white uppercase font-semibold text-xs py-2 px-10 rounded-2xl hover:bg-blue-600">
    {{ $slot }}
</button>
```

Donde cortamos el codigo agregamos lo siguiente:

```php
<x-submit-button>Post</x-submit-button>
```

Y para finalizar, nos vamos al archivo post-comment.blade.php y editamos el código con lo siguiente.

```html
@props(['comment'])
<x-panel class="bg-gray-50">
    <article class="flex space-x-4">
        <div class="flex-shrink-0">
            <img src="https://i.pravatar.cc/60?u={{ $comment->user_id }}" alt="" width="60" height="60" class="rounded-xl">
        </div>

        <div>
            <header class="mb-4">
                <h3 class="font-bold">{{ $comment->author->username }}</h3>

                <p class="text-xs">
                    Posted
                    <time>{{ $comment->created_at->format('F j, Y, g:i a') }}</time>
                </p>
            </header>

            <p>
                {{ $comment->body }}
            </p>
        </div>
    </article>
</x-panel>
```

Y verificamos que todo funcione en la pagina web.

![Verificar pagina](./images/57.1%20comple_post.png)