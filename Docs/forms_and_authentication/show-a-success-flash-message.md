[< Volver al Indice](/Docs/readme.md/)

# Show a Success Flash Message

Vamos a empezar abriendo el archivo `layout.blade.php` y agregamos el siguiente componente debajo del componente `section`

```php
<x-flash />
```

Seguidamente, creamos un nuevo archivo llamado `flash.blade.php` en la carpeta components dentro de la carpeta views y agregamos lo siguiente.

``` php
@if (session()->has('success'))
    <div x-data="{ show: true }"
         x-init="setTimeout(() => show = false, 4000)"
         x-show="show"
         class="fixed bg-blue-500 text-white py-2 px-4 rounded-xl bottom-3 right-3 text-sm"
    >
        <p>{{ session('success') }}</p>
    </div>
@endif
```

Por ultimo, nos vamos al archivo `RegisterController.php` y editamos el `return redirect`

```php
return redirect('/')->with('success', 'Your account has been created.');
```

Vamos a crear un nuevo usuario a la pagina y verificamos el mensaje.

![Verificar mensaje](./images/48.1%20message.png)