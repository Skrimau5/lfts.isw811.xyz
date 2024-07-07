[< Volver al Indice](/Docs/readme.md/)

# Automatic Password Hashing With Mutators

Vamos a ingresar a `User.php`, vamos crear la siguiente función debajo del atributo `$casts`.

```php
public function setPasswordAttribute($password)
    {
        $this->attributes['password'] = bcrypt($password);
    }
```

Ahora vamos a la pagina web y creamos un usuario

Y lo verificamos en la base de datos.

![verificar usuario con la contraseña encriptada](./images/45.1%20usercry.png)