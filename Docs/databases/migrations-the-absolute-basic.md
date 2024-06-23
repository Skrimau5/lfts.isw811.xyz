[< Volver al Indice](/Docs/readme.md/)

# Migrations: The Absolute Basics

Ahora que nos hemos conectado correctamente a MySQL, piense en una migración como un plano técnico para una tabla de base de datos.

Vamos a empezar viendo como existe un comando para revocar las tablas de migración creadas, el cual es el siguiente:

```bash
php artisan migrate:rollback
```

También hay un comando el cual borra todas la tablas de migración y al mismo tiempo las vuelve a crear, es decir como hacer un refresh:

```bash
php artisan migrate:fresh
```

Seguidamente vamos a la carpeta database, donde vamos a ingresar a la carpeta migrations y seleccionamos el archivo 2014_10_12_000000_create_users_table.php y eliminamos la linea de codigo para verificar el correo y agregamos un boolean de si es el usuario es admin o no lo es:

```php
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('username');
            $table->string('email')->unique();  
            $table->string('password');
            $table->boolean('is_admin')->default(false);
            $table->rememberToken();
            $table->timestamps();
        });
    }
```

Luego de esto ejecutamos los siguientes comandos para establecer los cambios:

```bash
 php artisan migrate:rollback
```

Seguidamente vamos a ejecutar el siguiente comando para volver a crear las tablas de migración:

```bash
 php artisan migrate
```

Revisamos la base de datos a ver si se actualizaron los cambios:

![En producción](./images/18.1%20refresh.png)

Dentro de la base de datos podemos crear un usuario ya sea a mano o mediante código.

A mano sería presionar la tabla `user` y presionar el botón `+ Row` y ir creando el usuario atributo por atributo

![Crear usuario a mano](./images/18.2%20create%20user%201.png)

Pero también esta la opción de crear el usuario mediante un sql Query:

![Crear usuario mediante sql Query](./images/18.3%20create%20user%202.png)