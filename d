warning: in the working copy of 'composer.json', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'composer.lock', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'resources/views/posts.blade.php', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'routes/web.php', LF will be replaced by CRLF the next time Git touches it
[1mdiff --git a/Docs/the-basics/find-a-composer-package-for-post-metadata.md b/Docs/the-basics/find-a-composer-package-for-post-metadata.md[m
[1mindex 2251d2a..5b97e38 100644[m
[1m--- a/Docs/the-basics/find-a-composer-package-for-post-metadata.md[m
[1m+++ b/Docs/the-basics/find-a-composer-package-for-post-metadata.md[m
[36m@@ -1 +1,234 @@[m
[31m-[< Volver al Indice](/Docs/readme.md/)[m
\ No newline at end of file[m
[32m+[m[32m[< Volver al Indice](/Docs/readme.md/)[m
[32m+[m
[32m+[m[32m# Find a Composer Package for Post Metadata[m
[32m+[m
[32m+[m[32mUsaremos el Yaml Front Matter. Vamos a encontrar un paquete Composer que nos ayude a analizarlo. Esto nos dará una buena oportunidad de aprender lo fácil y útil que es Composer.[m
[32m+[m
[32m+[m[32mInstalamos la siguiente linea de codigo en la maquina virtual:[m
[32m+[m
[32m+[m[32m```bash[m
[32m+[m[32mmanue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver[m
[32m+[m[32m$ vagrant up[m
[32m+[m[32mmanue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver[m
[32m+[m[32m$ vagrant ssh[m
[32m+[m[32mvagrant@webserver:~$ cd sites/lfts.isw811.xyz/[m
[32m+[m[32mvagrant@webserver:~/sites/lfts.isw811.xyz$ composer require spatie/yaml-front-matter[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mEsto instalara las librerias del Yaml Front Matter[m
[32m+[m
[32m+[m[32mVamos a utilizar la caperta de `my-fourth-post-html`, que programamos con el capiitulo anterior, vamos a modicarlo con lo siguiente:[m
[32m+[m
[32m+[m[32m```html[m
[32m+[m[32m---[m
[32m+[m
[32m+[m[32mtitle: My Fourth Post[m
[32m+[m[32mslug: my-fourth-post[m
[32m+[m[32mexcerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit.[m
[32m+[m[32mdate: 2023-10-16[m
[32m+[m
[32m+[m[32m---[m
[32m+[m
[32m+[m[32m<p>[m
[32m+[m[32m    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium[m
[32m+[m[32m    qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
[32m+[m[32m</p>[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mSeguidamente vamos a modificar de igual manera todos los post[m
[32m+[m
[32m+[m[32mLuego modificaremos el archivo `Post.php`, en este archivo lo que vamos hacer es crear en la clase su respectivo constructor y arreglamos las funciones:[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\ModelNotFoundException;[m
[32m+[m[32muse Illuminate\Support\Facades\File;[m
[32m+[m[32muse PhpParser\Node\Expr\FuncCall;[m
[32m+[m
[32m+[m[32mclass Post[m
[32m+[m[32m{[m
[32m+[m[32m    public $title;[m
[32m+[m
[32m+[m[32m    public $excerpt;[m
[32m+[m
[32m+[m[32m    public $date;[m
[32m+[m
[32m+[m[32m    public $body;[m
[32m+[m
[32m+[m[32m    public $slug;[m
[32m+[m
[32m+[m[32m    public function __construct($title, $excerpt, $date, $body, $slug)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->title = $title;[m
[32m+[m[32m        $this->excerpt = $excerpt;[m
[32m+[m[32m        $this->date = $date;[m
[32m+[m[32m        $this->body = $body;[m
[32m+[m[32m        $this->slug = $slug;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public static function all()[m
[32m+[m[32m    {[m
[32m+[m[32m        $files = File::files(resource_path("posts/"));[m
[32m+[m
[32m+[m[32m        return array_map(fn($file) => $file->getContents(), $files);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public static function find($slug)[m
[32m+[m[32m    {[m
[32m+[m[32m        base_path();[m
[32m+[m[32m        if (!file_exists($path = resource_path("posts/{$slug}.html"))) {[m
[32m+[m[32m            throw new ModelNotFoundException();[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        return cache()->remember("post.{$slug}", 1200, fn () => file_get_contents($path));[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32mLuego en el archivo `web.php` vamos a crear un new post para así poder retonar dichos atributos[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32mRoute::get('/', function () {[m
[32m+[m
[32m+[m[32m    $files = File::files(resource_path("posts/"));[m
[32m+[m[32m    $posts = [];[m
[32m+[m
[32m+[m[32m    foreach ($files as $file) {[m
[32m+[m[32m        $documents = YamlFrontMatter::parseFile($file);[m
[32m+[m
[32m+[m[32m        $posts[] = new Post([m
[32m+[m[32m            $documents->title,[m
[32m+[m[32m            $documents->excerpt,[m
[32m+[m[32m            $documents->date,[m
[32m+[m[32m            $documents->body(),[m
[32m+[m[32m            $documents->slug[m
[32m+[m[32m        );[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    return view('posts', [[m
[32m+[m[32m        'posts' => $posts]);[m
[32m+[m[32m});[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mRegresamos al archivo `posts.blade.php` y los editamos para lograr llamar los atributos de la clase[m
[32m+[m
[32m+[m[32m```html[m
[32m+[m[32m<body>[m
[32m+[m[32m    <?php foreach ($posts as $post) : ?>[m
[32m+[m[32m        <article>[m
[32m+[m[32m            <h1>[m
[32m+[m[32m                <a href="/posts/<?= $post->slug; ?>">[m
[32m+[m[32m                    <?= $post->title; ?>[m
[32m+[m[32m                </a>[m
[32m+[m
[32m+[m[32m            </h1>[m
[32m+[m
[32m+[m[32m            <div>[m
[32m+[m[32m                <?= $post->excerpt; ?>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </article>[m
[32m+[m[32m    <?php endforeach; ?>[m
[32m+[m[32m</body>[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mLuego vamos a realizar un ajuste al archivo `web.php` en cual creamos un `map()` para hacer más limpio el codigo.[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32mRoute::get('/', function () {[m
[32m+[m
[32m+[m[32m    $posts = collect(File::files(resource_path("posts")))[m
[32m+[m
[32m+[m[32m        ->map(fn ($file) => YamlFrontMatter::parseFile($file))[m
[32m+[m[32m        ->map(fn ($document) => new Post([m
[32m+[m[32m            $document->title,[m
[32m+[m[32m            $document->excerpt,[m
[32m+[m[32m            $document->date,[m
[32m+[m[32m            $document->body(),[m
[32m+[m[32m            $document->slug[m
[32m+[m[32m        ));[m
[32m+[m
[32m+[m[32m    return view('posts', [[m
[32m+[m[32m        'posts' => $posts[m
[32m+[m[32m    ]);[m
[32m+[m[32m});[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mVolvemos a modidificar el codigo para que este quede aún más facil de entender:[m
[32m+[m
[32m+[m[32mPrimero, nos vamos al archivo `Post.php` y modifcamos la funcion `all` agregando lo siguiente:[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32m public static function all()[m
[32m+[m[32m    {[m
[32m+[m[32m        return collect(File::files(resource_path("posts")))[m
[32m+[m
[32m+[m[32m            ->map(fn ($file) => YamlFrontMatter::parseFile($file))[m
[32m+[m[32m            ->map(fn ($document) => new Post([m
[32m+[m[32m                $document->title,[m
[32m+[m[32m                $document->excerpt,[m
[32m+[m[32m                $document->date,[m
[32m+[m[32m                $document->body(),[m
[32m+[m[32m                $document->slug[m
[32m+[m[32m            ));[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mSegundo, en el archivo de `web.php` cambiamos lo siguiente:[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32mRoute::get('/', function () {[m
[32m+[m
[32m+[m[32m    return view('posts', [[m
[32m+[m[32m        'posts' => Post::all()[m
[32m+[m[32m    ]);[m
[32m+[m[32m});[m
[32m+[m[32m```[m
[32m+[m[32mPor ultimo vamos a editar el archivo `Post.php` otra vez, pero esta vez modificamos la funcion `find()` haciendo lo siguiente:[m
[32m+[m
[32m+[m[32m```php[m
[32m+[m[32mpublic static function find($slug)[m
[32m+[m[32m{[m
[32m+[m[32m    return static::all()->firstWhere('slug', $slug);[m
[32m+[m[32m}[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mSeguidamente vamos a editar el archivo `post.blade.php` con el siguiente codigo, esto abarca la parte del post individual.[m
[32m+[m
[32m+[m[32m```Html[m
[32m+[m[32m<!DOCTYPE html>[m
[32m+[m[32m<html lang="en">[m
[32m+[m
[32m+[m[32m<head>[m
[32m+[m[32m    <meta charset="UTF-8">[m
[32m+[m[32m    <meta name="viewport" content="width=device-width, initial-scale=1.0">[m
[32m+[m[32m    <link rel="stylesheet" href="/app.css">[m
[32m+[m[32m    <title>My Blog</title>[m
[32m+[m[32m</head>[m
[32m+[m
[32m+[m[32m<body>[m
[32m+[m[32m    <article>[m
[32m+[m[32m        <h1><?= $post->title; ?></h1>[m
[32m+[m
[32m+[m[32m        <div>[m
[32m+[m[32m            <?= $post->body; ?>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </article>[m
[32m+[m
[32m+[m[32m    <a href="/">Go back</a>[m
[32m+[m[32m</body>[m
[32m+[m
[32m+[m[32m</html>[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32mVista de los Posts[m
[32m+[m[32m![Pagina todos los Posts](images/12.1%20posts.png)[m
[32m+[m
[32m+[m[32mVista del Post[m
[32m+[m[32m![Pagina todos los Posts](images/12.2%20post.png)[m
\ No newline at end of file[m
[1mdiff --git a/app/Models/Post.php b/app/Models/Post.php[m
[1mindex a52d693..f6b4374 100644[m
[1m--- a/app/Models/Post.php[m
[1m+++ b/app/Models/Post.php[m
[36m@@ -2,26 +2,48 @@[m
 [m
 namespace App\Models;[m
 [m
[31m-use Illuminate\Database\Eloquent\Model;[m
 use Illuminate\Database\Eloquent\ModelNotFoundException;[m
 use Illuminate\Support\Facades\File;[m
 use PhpParser\Node\Expr\FuncCall;[m
[32m+[m[32muse Spatie\YamlFrontMatter\YamlFrontMatter;[m
 [m
 class Post[m
 {[m
[32m+[m[32m    public $title;[m
[32m+[m
[32m+[m[32m    public $excerpt;[m
[32m+[m
[32m+[m[32m    public $date;[m
[32m+[m
[32m+[m[32m    public $body;[m
[32m+[m
[32m+[m[32m    public $slug;[m
[32m+[m
[32m+[m[32m    public function __construct($title, $excerpt, $date, $body, $slug)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->title = $title;[m
[32m+[m[32m        $this->excerpt = $excerpt;[m
[32m+[m[32m        $this->date = $date;[m
[32m+[m[32m        $this->body = $body;[m
[32m+[m[32m        $this->slug = $slug;[m
[32m+[m[32m    }[m
[32m+[m
     public static function all()[m
     {[m
[31m-        $files = File::files(resource_path("posts/"));[m
[32m+[m[32m        return collect(File::files(resource_path("posts")))[m
 [m
[31m-        return array_map(fn($file) => $file->getContents(), $files);[m
[32m+[m[32m            ->map(fn ($file) => YamlFrontMatter::parseFile($file))[m
[32m+[m[32m            ->map(fn ($document) => new Post([m
[32m+[m[32m                $document->title,[m
[32m+[m[32m                $document->excerpt,[m
[32m+[m[32m                $document->date,[m
[32m+[m[32m                $document->body(),[m
[32m+[m[32m                $document->slug[m
[32m+[m[32m            ));[m
     }[m
 [m
     public static function find($slug)[m
     {[m
[31m-        if (!file_exists($path = resource_path("posts/{$slug}.html"))) {[m
[31m-            throw new ModelNotFoundException();[m
[31m-        }[m
[31m-[m
[31m-        return cache()->remember("posts.{$slug}", 1200, fn() => file_get_contents($path));[m
[32m+[m[32m        return static::all()->firstWhere('slug', $slug);[m
     }[m
[31m-}[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/composer.json b/composer.json[m
[1mindex 3eb4e18..612d076 100644[m
[1m--- a/composer.json[m
[1m+++ b/composer.json[m
[36m@@ -11,7 +11,8 @@[m
         "laravel/framework": "^8.75",[m
         "laravel/sanctum": "^2.11",[m
         "laravel/tinker": "^2.5",[m
[31m-        "laravel/ui": "3.4.6"[m
[32m+[m[32m        "laravel/ui": "3.4.6",[m
[32m+[m[32m        "spatie/yaml-front-matter": "^2.0"[m
     },[m
     "require-dev": {[m
         "facade/ignition": "^2.5",[m
[1mdiff --git a/composer.lock b/composer.lock[m
[1mindex 323e0a4..576eeac 100644[m
[1m--- a/composer.lock[m
[1m+++ b/composer.lock[m
[36m@@ -4,7 +4,7 @@[m
         "Read more about it at https://getcomposer.org/doc/01-basic-usage.md#installing-dependencies",[m
         "This file is @generated automatically"[m
     ],[m
[31m-    "content-hash": "4bcbe32fb7d886cd1b1828faf0d06cfc",[m
[32m+[m[32m    "content-hash": "c92c02418043671ee9fac13798e94c7c",[m
     "packages": [[m
         {[m
             "name": "asm89/stack-cors",[m
[36m@@ -3058,6 +3058,68 @@[m
             ],[m
             "time": "2024-04-27T21:32:50+00:00"[m
         },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "spatie/yaml-front-matter",[m
[32m+[m[32m            "version": "2.0.9",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/spatie/yaml-front-matter.git",[m
[32m+[m[32m                "reference": "cbe67e1cdd0a29a96d74ccab9400fe663e078392"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/spatie/yaml-front-matter/zipball/cbe67e1cdd0a29a96d74ccab9400fe663e078392",[m
[32m+[m[32m                "reference": "cbe67e1cdd0a29a96d74ccab9400fe663e078392",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0|^8.0",[m
[32m+[m[32m                "symfony/yaml": "^3.0|^4.0|^5.0|^6.0|^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Spatie\\YamlFrontMatter\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian De Deyne",[m
[32m+[m[32m                    "email": "sebastian@spatie.be",[m
[32m+[m[32m                    "homepage": "https://spatie.be",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A to the point yaml front matter parser",[m
[32m+[m[32m            "homepage": "https://github.com/sebastiandedeyne/yaml-front-matter",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "front matter",[m
[32m+[m[32m                "jekyll",[m
[32m+[m[32m                "spatie",[m
[32m+[m[32m                "yaml"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/spatie/yaml-front-matter/tree/2.0.9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://spatie.be/open-source/support-us",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/spatie",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2024-06-13T10:20:51+00:00"[m
[32m+[m[32m        },[m
         {[m
             "name": "swiftmailer/swiftmailer",[m
             "version": "v6.3.0",[m
[36m@@ -5223,6 +5285,78 @@[m
             ],[m
             "time": "2024-05-31T14:33:22+00:00"[m
         },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/yaml",[m
[32m+[m[32m            "version": "v6.4.8",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/yaml.git",[m
[32m+[m[32m                "reference": "52903de178d542850f6f341ba92995d3d63e60c9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/yaml/zipball/52903de178d542850f6f341ba92995d3d63e60c9",[m
[32m+[m[32m                "reference": "52903de178d542850f6f341ba92995d3d63e60c9",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=8.1",[m
[32m+[m[32m                "symfony/deprecation-contracts": "^2.5|^3",[m
[32m+[m[32m                "symfony/polyfill-ctype": "^1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/console": "<5.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "symfony/console": "^5.4|^6.0|^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "Resources/bin/yaml-lint"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Yaml\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Loads and dumps YAML files",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/yaml/tree/v6.4.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2024-05-31T14:49:08+00:00"[m
[32m+[m[32m        },[m
         {[m
             "name": "tijsverkoyen/css-to-inline-styles",[m
             "version": "v2.2.7",[m
[36m@@ -7742,78 +7876,6 @@[m
             ],[m
             "time": "2020-09-28T06:39:44+00:00"[m
         },[m
[31m-        {[m
[31m-            "name": "symfony/yaml",[m
[31m-            "version": "v6.4.8",[m
[31m-            "source": {[m
[31m-                "type": "git",[m
[31m-                "url": "https://github.com/symfony/yaml.git",[m
[31m-                "reference": "52903de178d542850f6f341ba92995d3d63e60c9"[m
[31m-            },[m
[31m-            "dist": {[m
[31m-                "type": "zip",[m
[31m-                "url": "https://api.github.com/repos/symfony/yaml/zipball/52903de178d542850f6f341ba92995d3d63e60c9",[m
[31m-                "reference": "52903de178d542850f6f341ba92995d3d63e60c9",[m
[31m-                "shasum": ""[m
[31m-            },[m
[31m-            "require": {[m
[31m-                "php": ">=8.1",[m
[31m-                "symfony/deprecation-contracts": "^2.5|^3",[m
[31m-                "symfony/polyfill-ctype": "^1.8"[m
[31m-            },[m
[31m-            "conflict": {[m
[31m-                "symfony/console": "<5.4"[m
[31m-            },[m
[31m-            "require-dev": {[m
[31m-                "symfony/console": "^5.4|^6.0|^7.0"[m
[31m-            },[m
[31m-            "bin": [[m
[31m-                "Resources/bin/yaml-lint"[m
[31m-            ],[m
[31m-            "type": "library",[m
[31m-            "autoload": {[m
[31m-                "psr-4": {[m
[31m-                    "Symfony\\Component\\Yaml\\": ""[m
[31m-                },[m
[31m-                "exclude-from-classmap": [[m
[31m-                    "/Tests/"[m
[31m-                ][m
[31m-            },[m
[31m-            "notification-url": "https://packagist.org/downloads/",[m
[31m-            "license": [[m
[31m-                "MIT"[m
[31m-            ],[m
[31m-            "authors": [[m
[31m-                {[m
[31m-                    "name": "Fabien Potencier",[m
[31m-                    "email": "fabien@symfony.com"[m
[31m-                },[m
[31m-                {[m
[31m-                    "name": "Symfony Community",[m
[31m-                    "homepage": "https://symfony.com/contributors"[m
[31m-                }[m
[31m-            ],[m
[31m-            "description": "Loads and dumps YAML files",[m
[31m-            "homepage": "https://symfony.com",[m
[31m-            "support": {[m
[31m-                "source": "https://github.com/symfony/yaml/tree/v6.4.8"[m
[31m-            },[m
[31m-            "funding": [[m
[31m-                {[m
[31m-                    "url": "https://symfony.com/sponsor",[m
[31m-                    "type": "custom"[m
[31m-                },[m
[31m-                {[m
[31m-                    "url": "https://github.com/fabpot",[m
[31m-                    "type": "github"[m
[31m-                },[m
[31m-                {[m
[31m-                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[31m-                    "type": "tidelift"[m
[31m-                }[m
[31m-            ],[m
[31m-            "time": "2024-05-31T14:49:08+00:00"[m
[31m-        },[m
         {[m
             "name": "theseer/tokenizer",[m
             "version": "1.2.3",[m
[1mdiff --git a/resources/posts/my-first-post.html b/resources/posts/my-first-post.html[m
[1mindex a35fa43..cd9d669 100644[m
[1m--- a/resources/posts/my-first-post.html[m
[1m+++ b/resources/posts/my-first-post.html[m
[36m@@ -1,5 +1,13 @@[m
[31m-<h1>My Firts Post</h1>[m
[32m+[m[32m---[m
[32m+[m
[32m+[m[32mtitle: My Frist Post[m
[32m+[m[32mslug: my-first-post[m
[32m+[m[32mexcerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit.[m
[32m+[m[32mdate: 2023-10-16[m
[32m+[m
[32m+[m[32m---[m
 [m
 <p>[m
[31m-    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
[32m+[m[32m    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium[m
[32m+[m[32m    qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
 </p>[m
\ No newline at end of file[m
[1mdiff --git a/resources/posts/my-fourth-post.html b/resources/posts/my-fourth-post.html[m
[1mindex 3d240d0..681ae4b 100644[m
[1m--- a/resources/posts/my-fourth-post.html[m
[1m+++ b/resources/posts/my-fourth-post.html[m
[36m@@ -1,11 +1,13 @@[m
 ---[m
[31m-tittle: My Fourth Post[m
[31m-excerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit[m
[31m-date: 2024-07-17[m
[31m----[m
 [m
[31m-<h1>My Fourth Post</h1>[m
[32m+[m[32mtitle: My Fourth Post[m
[32m+[m[32mslug: my-fourth-post[m
[32m+[m[32mexcerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit.[m
[32m+[m[32mdate: 2023-10-16[m
[32m+[m
[32m+[m[32m---[m
 [m
 <p>[m
[31m-    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
[32m+[m[32m    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium[m
[32m+[m[32m    qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
 </p>[m
\ No newline at end of file[m
[1mdiff --git a/resources/posts/my-second-post.html b/resources/posts/my-second-post.html[m
[1mindex 0647a22..3a38c21 100644[m
[1m--- a/resources/posts/my-second-post.html[m
[1m+++ b/resources/posts/my-second-post.html[m
[36m@@ -1,5 +1,13 @@[m
[31m-<h1>My Second Post</h1>[m
[32m+[m[32m---[m
[32m+[m
[32m+[m[32mtitle: My Second Post[m
[32m+[m[32mslug: my-second-post[m
[32m+[m[32mexcerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit.[m
[32m+[m[32mdate: 2023-10-16[m
[32m+[m
[32m+[m[32m---[m
 [m
 <p>[m
[31m-    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
[32m+[m[32m    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium[m
[32m+[m[32m    qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
 </p>[m
\ No newline at end of file[m
[1mdiff --git a/resources/posts/my-third-post.html b/resources/posts/my-third-post.html[m
[1mindex f7a8710..2964c8c 100644[m
[1m--- a/resources/posts/my-third-post.html[m
[1m+++ b/resources/posts/my-third-post.html[m
[36m@@ -1,5 +1,13 @@[m
[31m-<h1>My Third Post</h1>[m
[32m+[m[32m---[m
[32m+[m
[32m+[m[32mtitle: My Third Post[m
[32m+[m[32mslug: my-third-post[m
[32m+[m[32mexcerpt: Lorem ipsum dolor sit amet consectetur adipisicing elit.[m
[32m+[m[32mdate: 2023-10-16[m
[32m+[m
[32m+[m[32m---[m
 [m
 <p>[m
[31m-    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
[32m+[m[32m    Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sapiente nesciunt iure, dolore delectus, laudantium[m
[32m+[m[32m    qui nihil aperiam cum incidunt odio, asperiores quisquam hic! Maxime voluptatibus quibusdam sit provident optio.[m
 </p>[m
\ No newline at end of file[m
[1mdiff --git a/resources/views/post.blade.php b/resources/views/post.blade.php[m
[1mindex 0dba8f6..8827d18 100644[m
[1m--- a/resources/views/post.blade.php[m
[1m+++ b/resources/views/post.blade.php[m
[36m@@ -1,16 +1,23 @@[m
 <!DOCTYPE html>[m
 <html lang="en">[m
[32m+[m
 <head>[m
     <meta charset="UTF-8">[m
     <meta name="viewport" content="width=device-width, initial-scale=1.0">[m
[31m-    <link rel= "stylesheet" href="/app.css">[m
[32m+[m[32m    <link rel="stylesheet" href="/app.css">[m
     <title>My Blog</title>[m
 </head>[m
[32m+[m
 <body>[m
[31m-    <?php foreach ( $posts as $post ) : ?>[m
     <article>[m
[31m-        <?= $post; ?>[m
[32m+[m[32m        <h1><?= $post->title; ?></h1>[m
[32m+[m
[32m+[m[32m        <div>[m
[32m+[m[32m            <?= $post->body; ?>[m
[32m+[m[32m        </div>[m
     </article>[m
[31m-    <?php endforeach; ?>[m
[32m+[m
[32m+[m[32m    <a href="/">Go back</a>[m
 </body>[m
[32m+[m
 </html>[m
\ No newline at end of file[m
[1mdiff --git a/resources/views/posts.blade.php b/resources/views/posts.blade.php[m
[1mindex 4289877..696cdee 100644[m
[1m--- a/resources/views/posts.blade.php[m
[1m+++ b/resources/views/posts.blade.php[m
[36m@@ -11,7 +11,16 @@[m
 <body>[m
     <?php foreach ($posts as $post) : ?>[m
         <article>[m
[31m-            <?= $post; ?>[m
[32m+[m[32m            <h1>[m
[32m+[m[32m                <a href="/posts/<?= $post->slug; ?>">[m
[32m+[m[32m                    <?= $post->title; ?>[m
[32m+[m[32m                </a>[m
[32m+[m
[32m+[m[32m            </h1>[m
[32m+[m
[32m+[m[32m            <div>[m
[32m+[m[32m                <?= $post->excerpt; ?>[m
[32m+[m[32m            </div>[m
         </article>[m
     <?php endforeach; ?>[m
 </body>[m
[1mdiff --git a/routes/web.php b/routes/web.php[m
[1mindex 785c192..46a8dee 100644[m
[1m--- a/routes/web.php[m
[1m+++ b/routes/web.php[m
[36m@@ -1,7 +1,9 @@[m
 <?php[m
 [m
 use App\Models\Post;[m
[32m+[m[32muse Illuminate\Support\Facades\File;[m
 use Illuminate\Support\Facades\Route;[m
[32m+[m[32muse Spatie\YamlFrontMatter\YamlFrontMatter;[m
 [m
 /*[m
 |--------------------------------------------------------------------------[m
