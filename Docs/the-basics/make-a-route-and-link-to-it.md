[< Volver al Indice](/readme.md)

# Make a Route and link to it

Vamos a cambiar el archivo "welcome.blade.php" que se encuentra en `/views/welcome.blade.php`, por `"posts.blade.php"`

Y en la parte de `/routes/web.php` cambiamos lo siguiente:

```php
Route::get('/', function () {
    return view('post');
});
```

Ahora seguidamente vamos a eliminar el archivo `app.js` que se encuentra ubicado en la carpeta `/public` y despues nos vamos al archivo `posts.blade.php` y eliminamos la linea de codigo del script:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <title>My Blog</title>
</head>
<body>
    <h1>Hello World</h1>
</body>
</html>
```

Luego modificamos el archivo `app.css`:

```css
body {
    background: white;
    color: #222222;
}
```

Seguidamente vamos a modificar el archivo `posts.blade.php`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <title>My Blog</title>
</head>
<body>
    <article>
        <h1>My firts Post</h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>
</body>
</html>
```

Luego volvemos a modificar el archivo css:

```css
body {
    background: white;
    color: #222222;
    max-width: 600px;
    margin: auto;
    font-family: sans-serif;
}

p{
    line-height: 1.6;
}
```

Luego de realizar lo anterior vamos agregar otro article en el archivo `posts.blade.php`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <title>My Blog</title>
</head>
<body>
    <article>
        <h1>My firts Post</h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>

    <article>
        <h1>My Second Post</h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>
</body>
</html>
```

Luego vamos al CSS para darle margen

```css
article{
    margin-top: 3rem;
    padding: 3rem;
    border-top: 1px solid #c5c5c5; 
}
```

Luego vamos a `/routes/web.php` y agregamos esta linea de comando

```php
Route::get('post', function () {
    return view ('post');
    });
```

Seguidamente vamos a crear un archivo en la carpeta **resources** el cual se llamará `post.blade.php` para poder rediriguir el "My firt post" ha otra ruta y agregamos lo siguiente:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <title>My Blog</title>
</head>
<body>
    <article>
        <h1><a href="/post">My firts Post</a></h1>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.
        </p>
    </article>

    <a href="/">Go back</a>
</body>
</html>
```

La pagina cuando iniciemos va salir de la siguiente manera.
![Vista Inicial](images/7.2%20posts.png)

Cuando ingresemos a un post se va ver de la siguiente manera
![Vista Inicial](images/7.2%20post.png)