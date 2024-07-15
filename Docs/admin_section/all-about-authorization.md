[< Volver al Indice](/Docs/readme.md/)

# All About Authorization

Primeramente, nos vamos al archivo `AppServiceProvider.php` y agregamos lo siguiente en la función `boot()` que ese se encontraba en el archivo anteriormente borrado.

```php
        Gate::define('admin', function (User $user) {
            return $user->username === 'Manuel2';
        });

        Blade::if('admin', function () {
            return request()->user()?->can('admin');
        });
```

Seguidamente, nos vamos al archivo `layout.blade.php` y agregamos el `@admin` y metemos los componentes `<x-dropdown-item>` de `Dashboard` y `New Post` dentro del `@admin`

```php
@admin
    <x-dropdown-item href="/admin/posts" :active="request()->is('admin/posts')">Dashboard</x-dropdown-item>
    <x-dropdown-item href="/admin/posts/create" :active="request()->is('admin/posts/create')">New Post</x-dropdown-item>
@endadmin
```

Luego, eliminando el archivo `MustBeAdministrator.php`.

Nos ubicamos en el archivo `Kernel.php` dentro de la carpeta `Controllers` y eliminamos la siguiente linea de código.

```php
'admin' => MustBeAdministrator::class
```

Para finalizar, nos vamos al archivo `web.php` y sustituimos todas las rutas de admin por las siguientes rutas.

```php
// Admin Section
Route::middleware('can:admin')->group(function () {
    Route::resource('admin/posts', AdminPostController::class)->except('show');
});
```