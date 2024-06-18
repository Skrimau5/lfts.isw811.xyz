[< Volver al Indice](/Docs/readme.md/)

# Collection Sorting and Caching Refresher

Se tiene entendido que cada publicación ahora incluye la fecha de publicación como parte de sus metadatos, sin embargo, el feed actualmente no está ordenado según esa fecha. Afortunadamente, debido a que usamos colecciones de Laravel, tareas como esta son muy fáciles. En este episodio, arreglaremos la clasificación y luego discutiremos el almacenamiento en caché "siempre".

Tecnicamente arreglamos la funcion `all()` del archivo `Post.php`, ordenando los post mediante la fecha y además eliminando el cache:

```php
    public static function all()
    {
        return cache()->rememberForever('posts.all', function () {
            return collect(File::files(resource_path("posts")))

                ->map(fn ($file) => YamlFrontMatter::parseFile($file))
                ->map(fn ($document) => new Post(
                    $document->title,
                    $document->excerpt,
                    $document->date,
                    $document->body(),
                    $document->slug
                ))
                ->sortByDesc('date');
        });
    }
```

Seguidamente para comprobar lo del cache, abrimos nuestra maquina virtual y nos ubicamos en `vagrant@webserver:~/sites/lfts.isw811.xyz$`, y realizamos lo siguiente:

```bash
manue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver
$ vagrant up
manue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver
$ vagrant ssh
vagrant@webserver:~$ cd sites/lfts.isw811.xyz/
vagrant@webserver:~/sites/lfts.isw811.xyz$ php artisan tinker
Psy Shell v0.12.4 (PHP 8.2.18 — cli) by Justin Hileman
> 2 + 2
= 4
>
```

Esto abre como una consola para ver revisar lo del cache.

Y luego con la siguiente linea de codigo podremos revisar la cache de la pagina:

```bash
    cache('post.all')
```

Tendria que generar lo siguiente:

![Pagina todos los Posts](images/13.1%20posts.all.png)