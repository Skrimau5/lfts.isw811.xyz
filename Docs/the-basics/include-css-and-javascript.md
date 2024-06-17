[< Volver al Indice](/Docs/readme.md/)

# Include CSS and JavaScript

Vamos a ingresar a lo siguiente:

 ```bash
manue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver/sites/lfts.isw811.xyz (main)
$ cd resources/
manue@LAPTOP-P1D00FHN MINGW64 ~/ISW811/VMs/Webserver/sites/lfts.isw811.xyz/resources (main)
$ cd views/
INGW64 ~/ISW811/VMs/Webserver/sites/lfts.isw811.xyz/resources/views (main)
$ code welcome.blade.php
```

Luego de ingresar aqui vamos a borrar todo lo que esta en el inicio de la pagina.

Vamos a crear un archivo `/public/app.css` con el siguiente contenido.

```css
body {
    background: navy;
    color: white;
}
```

Luego de realizar eso vamos a crear el archivo `/public/app.js` con el siguiente contenido.

```javascript
alert('I am here');
```

Luego vamos a modificar el HTML

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href="/app.css">
    <script src="/app.js"></script>
    <title>My Blog</title>
</head>
<body>
    <h1>Hello World</h1>
</body>
</html>
```

Cuando refrescamos la pigina va salir el siguiente mensaje:
![Vista Inicial](images/6.1%20js.png)

Luego luego presionamos "Aceptar" nos va salir lo siguiente:
![Vista Inicial](images/6.2%20css.png)