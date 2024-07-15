[< Volver al Indice](/Docs/readme.md/)

# Extract Form-Specific Blade Components

Comenzamos modificando el archivo `create.blade.php` en donde remplazamos los `<div>` de cada atributo para llamarlos de otro archivo y el código sea mucho más ordenado. Así quedaría el archivo.

```php
<x-layout>
    <section class="py-8 max-w-md mx-auto">
        <h1 class="text-lg font-bold mb-4">
            Publish New Post
        </h1>

        <x-panel>
            <form method="POST" action="/admin/posts" enctype="multipart/form-data">
                @csrf

                <x-form.input name="title" />
                <x-form.input name="slug" />
                <x-form.input name="thumbnail" type="file" />
                <x-form.textarea name="excerpt" />
                <x-form.textarea name="body" />

                <x-form.field>
                    <x-form.label name="category" />

                    <select name="category_id" id="category_id">
                        @foreach (\App\Models\Category::all() as $category)
                        <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>{{ ucwords($category->name) }}</option>
                        @endforeach
                    </select>

                    <x-form.error name="category" />
                </x-form.field>
                <x-form.button>Publish</x-form.button>
            </form>
        </x-panel>
    </section>
</x-layout>
```

Seguidamente, creamos una carpeta llamada `form` dentro de la carpeta `components`, dentro de la nueva carpeta creamos 5 archivos nuevos.

* El primero sería `input.blade.php` en cual tendremos el siguiente código para manejar los `<div>` eliminados del archivo `create.blade.php`.

```php
@props(['name', 'type' => 'text'])

<x-form.field>
    <x-form.label name="{{ $name }}"/>

    <input class="border border-gray-400 p-2 w-full"
           type="{{ $type }}"
           name="{{ $name }}"
           id="{{ $name }}"
           value="{{ old($name) }}"
           required
    >

    <x-form.error name="{{ $name }}"/>
</x-form.field>
```

* El segundo archivo creado sería `error.blade.php` en cual agregamos el siguiente código.

```php
@props(['name'])

@error($name)
<p class="text-red-500 text-xs mt-2">{{ $message }}</p>
@enderror
```

* El tercero sería el `textarea.blade.php` en donde agregamos el siguiente código.

```php
@props(['name'])

<x-form.field>
    <x-form.label name="{{ $name }}" />

    <textarea
        class="border border-gray-400 p-2 w-full"
        name="{{ $name }}"
        id="{{ $name }}"
        required
    >{{ old($name) }}</textarea>

    <x-form.error name="{{ $name }}" />
</x-form.field>
```

* El cuarto sería el `label.blade.php` en donde agregamos el siguiente código.

```php
@props(['name'])

<label class="block mb-2 uppercase font-bold text-xs text-gray-700"
       for="{{ $name }}"
>
    {{ ucwords($name) }}
</label>
```

* El ultimo sería el `field.blade.php` agregamos el siguiente código.

```php
<div class="mt-6">
    {{ $slot }}
</div>
```

Ahora, el archivo `submit-button.blade.php` lo movemos a la carpeta nueva llamada `form`, ya dentro de la nueva carpeta, le cambiamos el nombre a `button.blade.php`.

Para finalizar nos vamos al archivo `_add-comment-form.blade.php` y editamos el `<x-submit-button>Post<x-submit-button>` por lo siguiente.

```php
<x-form.button>Submit</x-form.button>
```

Verificamos que la pagina funcione correctamente.

![Verificar pagina](./images/65.1%20upgrade.png)