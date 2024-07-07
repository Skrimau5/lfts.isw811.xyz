[< Volver al Indice](/Docs/readme.md/)

# Failed Validation and Old Input Data

Primero nos vamos al archivo `create.blade.php`  y agregamos el atributo `value` dentro de todos los `inputs`.

```php
value="{{ old('name') }}"
```

Seguidamente, agregamos el siguiente `@error` debajo de todos los `input`.

```php
@error('name')
    <p class="text-red-500 text-xs mt-1">{{ $message }}</p>
@enderror
```

Y por ultimo vamos al archivo `RegisterController.php` y modificamos los atributos `username` y `email`.

```php
'username' => 'required|min:3|max:255|unique:users,username',
'email' => 'required|email|max:255|unique:users,email',
```

Verificamos los errores en la pagina.

![Verificar errores](./images/47.3%20error%20name.png)