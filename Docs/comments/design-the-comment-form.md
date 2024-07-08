[< Volver al Indice](/Docs/readme.md/)

# Design the Comment Form

Comenzamos creando un nuevo archivo en la carpeta `components` llamado `panel.blade.php` y añadimos el siguiente código.

```php
<div {{ $attributes(['class' => 'border border-gray-200 p-6 rounded-xl']) }}>
    {{ $slot }}
</div>
```

Y seguidamente nos vamos al archivo `show.blade.php` y agregamos el siguiente código para crear el formulario dentro del componente `section`.

```html
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
                    </div>

                    <div class="flex justify-end mt-6 pt-6 border-t border-gray-200">
                    <button type="submit"
                    class="bg-blue-500 text-white uppercase font-semibold text-xs py-2 px-10 rounded-2xl hover:bg-blue-600">
                    POST</button>
                    </div>
                    </form>
                </x-panel>
```

Por ultimo verificamos lo realizado en la pagina web.

![Verificar formulario](./images/55.1%20blog_comment.png)