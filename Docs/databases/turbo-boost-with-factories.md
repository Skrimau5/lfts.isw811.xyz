[< Volver al Indice](/Docs/readme.md/)

# Turbo Boost With Factories

Vamos a integrar las fábricas de modelos para generar sin problemas cualquier número de registros en la base de datos.

Primero conoceremos el siguiente comando con el cual podemos crear los usuarios que queramos, dentro del método `factory()` digitamos los usuarios a crear:

```bash
App\Models\User::factory()->create();
```

En la maquina virtual ejecutamos el siguiente comando para crear un arhivo `PostFactory` para poder generar post cuantos posts queramos en la base de datos.

```bash
php artisan make:factory PostFactory
```

Luego de haber creado dicho archivo, nos ubicaremos en el y agregamos la siguiente función para poder crear los posts.

```php
<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'user_id' => User::factory(),
            'category_id' => Category::factory(),
            'title' => $this->faker->sentence,
            'slug' => $this->faker->slug,
            'excerpt' => $this->faker->sentence,
            'body' => $this->faker->paragraph
        ];
    }
}
```

Volvemos a la maquina virtual y ejecutamos el siguiente comando para borrar y crear las tablas:

```bash
php artisan migrate:fresh
```

Seguidamente ejecutamos el siguiente comando para crear un archivo `CategoryFactory`, para poder genera las categorías que necesitemos.

```bash
php artisan make:factory CategoryFactory
```

Nos vamos al archivo creado y agregamos el siguiente código.

```php
<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->word,
            'slug' => $this->faker->slug
        ];
    }
}
```

Después de esto, volvemos a la maquina virtual y ingresamos al browser con el siguiente comando:

```bash
php artisan tinker
```

Ejecutamos el siguiente comando para crear los post:

```bash
App\Models\Post::factory()->create();
```

Ahora para probar, nos iremos al archivo `DatabaseSeeder.php` y modificaremos la función `run()` para crear un solo usuario para 5 posts: 

```php
public function run()
    {
        $user = User::factory()->create([
            'name' => 'Manuel Chavarria'
        ]);


        Post::factory(5)->create([
            'user_id' => $user->id
        ]);
    }
```

Nos iremos a la maquina virtual para ejecutar el siguiente comando que borra, refresca y crea con datos las tablas de la base de datos:

```bash
php artisan migrate:fresh --seed
```

Esto lo podemos verificar en la base de datos:

![Usuario con 5 post](./images/28.1%20create.png)

Así se vería la pagina web:

![Pagina Web](./images/28.2%20posts.png)

![Pagina Web](./images/28.3post.png)