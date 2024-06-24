[< Volver al Indice](/Docs/readme.md/)

# Your First Eloquent Relationship

En este episodio, nos corresponde averiguar cómo asignar una categoría a cada publicación. Para permitir esto, necesitaremos crear un nuevo modelo de Eloquent y migrarlo para representar una categoría.

Comenzaremos modificando los títulos de `My first post` , `My Second post` y `My Third post`, estos títulos los cambiaremos desde la base de datos.

Los títulos nuevos serían:  `My Family post` , `My Work post` y `My Hobby post`.

Asi quedaria el commit:

![commit](./images/24.1%20upgrade.png)

Asi se vería la pagina:

![Nuevos títulos](./images/24.2%20page.png)

Ahora, abrimos nuestra maquina virtual y nos ubicamos en `/vagrant/sites/lfts.isw811.xyz` y ejecutamos el siguiente comando para crear una tabla llamada `categories` con su respectivo model.

```bash
php artisan make:migration create_categories_table
```

Luego ejecutamos:

```bash
php artisan make:model Category -m
```

Luego de ejecutar el comando les debería de aparecer en el proyecto los siguientes archivos.

* Primero, en la carpeta `migrations` ubicada dentro de la carpeta `database`, se les debería a ver creado un nuevo archivo llamado `2024_06_24_000138_create_categories_table.php`.

* El segundo sería en la carpeta `Models`, se les debería de a ver creado un archivo llamado `Category.php`. 

Seguidamente, nos movemos al archivo `2024_06_24_000138_create_categories_table.php` para crear los atributos de esta tabla, los cuales son los siguiente:

```php
public function up()
    {
        Schema::create('categories', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug');
            $table->timestamps();
        });
    }
```

Luego, modificaremos el archivo `2024_06_23_193353_create_posts_table` para crear un atributo para llamar el id de la categoría.

```php  
$table->foreignId('category_id');
```

Ahora nos trasladamos de nuevo a la maquina virtual y ejecutamos el siguiente comando para borrar y volver a crear las tablas.

```bash
php artisan migrate:fresh
```

Verificamos que la base de datos se haya actualizado, la refrescamos y comprábamos las tablas, y sus nuevos atributos.

![Tablas actualizadas](./images/23.2%20category.png)

Creamos nuestras primeras categorías, las cuales se llaman: `Personal`, `Work` y `Hobbies`.

Vamos a posicionarnos:

```bash
use App\Models\Category
```

![category](./images/24.3%20create%20cate.png)

Ahora crearemos los posts, vamos a posicionarnos en:

```bash
use App\Models\Post;
```

Ahora si, creamos nuestros posts:

![Creación de posts](./images/24.4%20posts.png)

Ahora nos ubicamos en el archivo `Post.php` para crear nuestra primera relación con eloquent con una función llamada `category`.

```php
class Post extends Model
{
    use HasFactory;

    protected $guarded = [];
    
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
```

Para comprobar esta relación con eloquent, nos movemos a la maquina virtual y ejecutamos los siguientes comandos para que nos busque el post por categoría.

* Primero, buscamos nuestro primer post con el siguiente comando:

```bash
$post = App\Models\Post::first();
```

* Después, ejecutamos el siguiente comando para buscar la categoría correspondiente de ese post:

```bash
$post->category;
```

Y por ultimo podemos ver todo junto, el post con la categoría correspondiente mediante el siguiente comando:

```bash
$post
```

Y ya para finalizar para poder observar la categoría de cada post en la pagina, agregamos la siguiente linea de código a los archivos: `posts.blade.php` y `post.blade.php`.

```php
<p>
    <a href="#">{{$post->category->name}}</a>
</p>
```