[< Volver al Indice](/Docs/readme.md/)

# How a Route Loads a View

En Laravel las rutas se configuran en el archivo `routes/web.php`.

Por ejemplo con el siguiente fragmento se renderiza la vista _Welcome_.

```bash
Route::get('/', function () {
    return view('welcome');
});
```

Laravel puede retornar cualquier tipo de contenido.

```bash
Route::get('/', function () {
    return 'Hello World';
});
```

Incluso puede retornar JSON.

```bash
Route::get('/', function () {
    return ['foo' => 'bar'];
});
```