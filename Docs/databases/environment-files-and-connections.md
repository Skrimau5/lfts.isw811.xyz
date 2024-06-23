[< Volver al Indice](/Docs/readme.md/)

# Environment Files and Database Connections

Cada aplicación requiere una cierta cantidad de configuración específica del entorno. Ejemplos de esto pueden ser el nombre de la base de datos a la que te estás conectando, o qué host de correo y puerto usa tu aplicación, o incluso claves especiales y tokens secretos que te proporcionan las API de terceros. 

Se puede almacenar la configuración de esta manera dentro de su archivo .env, que se encuentra en la raíz de su proyecto. 

![Vista del .env](images/17.1%20direcc.png)

Vamos a ver los elementos esenciales de los archivos de entorno, y luego pasaremos a conectarnos a una base de datos MySQL 

Primero nos iremos a nuestra maquina virtual y instalamos el mysql con el siguiente comando:

```bash
brew install mysql
```

Luego nos conectamos a mysql con el siguiente comando:

```bash
mysql -u laravel -h 192.168.56.11 -p
```

Le van a pedir un contraseña la cual es la que tienen en su archivo punto .env en la parte de `DB_PASSWORD`, en este ejemplo seria `secret`

Despues, creamos la base de datos y le llamamos `lfts` con el siguiente comando:

```bash
create database lfts;
```

Ahora nos salimos de mysql y volvemos a la maquina virtual para migrar tablas a la base de datos.

Una vez en la maquina virtual ejecutamos el siguiente comando:

```bash
php artisan migrate;
```

Volvemos a conectarnos otra vez al mysql y ejecutamos el siguiente comando para usar nuestra base de datos ya creada:

```bash
use lfts;
```

Y después, ejecutamos el siguiente comando para ver la tablas en nuestra base de datos:

```bash
show tables;
```

Ahora nos iremos a internet y instalaremos una aplicación de base de datos, puede ser `Sequel Pro`, `Mysql Workbench` o `TablePlus`.

En este caso, utilizaremos `TablePlus`.

Una vez instalada la aplicación, la abrimos y presionamos click derecho del mouse, seleccionamos `new` y seguidamente `MySQL`

![TablePlus crear database](images/17.2sql.png)

Nos saldrá una ventana y escribiremos los datos que concuerden con los que tenemos en el .env, en mi caso sería así:

![Creando database](images/17.3crea.png)

Después, presionamos en el botón que dice `Test` y nos tiene que salir el siguiente mensaje mencionando que todo esta correcto:

![Testiando](images/17.4ok.png)

Seguidamente, presionamos el botón `save` y abrimos nuestra base dando doble click sobre nuestra base de datos creada.

![Database](images/17.5%20enter.png)