[< Volver al Indice](/Docs/readme.md/)

# Table Consistency and Foreign Key Constraints

Para comenzar vamos a abrir nuestra maquina virtual ubicándonos en `/vagrant/sites/lfts.isw811.xyz` para ejecutar el siguiente comando para crear el model, la tabla de migración, el factory y el controller de los `comment` .

```bash
php artisan make:model Comment -mfc
```

Ahora, nos vamos al archivo nuevo creado llamado `2024_07_05_171403_create_comments_table.php` y agregamos los siguientes atributos al `Schema::create`

```php
Schema::create('comments', function (Blueprint $table) {
    $table->id();
    $table->foreignId('post_id')->constrained()->cascadeOnDelete();
    $table->foreignId('user_id')->constrained()->cascadeOnDelete();
    $table->text('body');
    $table->timestamps();
});
```

Seguidamente, nos vamos al archivo `2024_06_23_193353_create_posts_table.php` y editamos dentro del `Schema` el atributo `user_id`.

```php
$table->foreignId('user_id')->constrained()->cascadeOnDelete();
```

Ahora volvemos a nuestra maquina virtual y ejecutamos el siguiente comando para migrar la nueva tabla de comments creada a la base de datos.

```bash
php artisan migrate
```

Verificamos en la base de datos la nueva tabla creada `comments`:

![Nueva tabla comments](./images/53.1%20comments_table.png)