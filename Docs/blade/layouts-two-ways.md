[< Volver al Indice](/Docs/readme.md/)

# Blade Layouts Two Ways

El siguiente problema que debemos resolver se relaciona con el hecho de que cada una de nuestras vistas contiene la estructura HTML completa, incluyendo cualquier posible script y hojas de estilo.

Esto querie decir que, si necesitamos agregar una nueva hoja de estilo, debemos actualizar cada vista. Esto claramente no es eficiente.

En su lugar, podemos buscar archivos de diseño para reducir la duplicación. En este episodio, vamos a demostrar dos formas diferentes de crear diseños.

Para comenzar, crearemos un archivo en la carpeta `views` y lo llamaremos `layout.blade.php`, y le agregaremos lo siguiente:

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/app.css">
    <title>My Blog</title>
</head>

<body>
    @yield('content')
</body>

</html>

```

Ahora modificaremos por completo el archivo `posts.blade.php`, donde usaremos `@extends` para llamar al archivo de diseño y un `@section` para almacenar el contenido a mostrar:

```html

@extends ('layout')

@section('content')

@foreach ($posts as $post)
<article>
    <h1>
        <a href="/posts/{{ $post->slug }}">
            {{ $post->title }}
        </a>

    </h1>

    <div>
        {{ $post->excerpt }}
    </div>
</article>
@endforeach

@endsection

```

De igual forma, modificamos el archivo `post.blade.php`, utilizando la sintaxsis y componentes de blade:

```html
@extends('layout')

@section ('content')

<article>
    <h1>{{ $post->title }}</h1>

    <div>
        {!! $post->body !!}
    </div>
</article>

<a href="/">Go back</a>

@endsection
```

Luego volvemos a modificar el archivo `layout.blade.php`, en el cual eliminamos el `@yield` y lo reemplazamos por lo siguiente:

```html

<body>
    {{ $slot }}
</body>

```

Creamos una carpeta que se llame **components** donde vamos a mover el archivo que creamos llamado `layout.blade.php`

Luego modificamos el archivo `posts.blade.php`, donde agregamos el componente `x-layout`:

```html

<body>
    <x-layout>
    @foreach ($posts as $post)
    <article>
        <h1>
            <a href="/posts/{{ $post->slug }}">
                {{ $post->title }}
            </a>

        </h1>

        <div>
            {{ $post->excerpt }}
        </div>
    </article>
    @endforeach
</x-layout>
</body>

```