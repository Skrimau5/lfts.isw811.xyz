[< Volver al Indice](/Docs/readme.md/)

# Toy Chests and Contracts

Primero nos vamos para `Newsletter.php` y editamos con el siguiente codigo

```php
<?php

namespace App\Services;

use MailchimpMarketing\ApiClient;

class Newsletter
{

    public function __construct(protected ApiClient $client)
    {
        //
    }

    public function subscribe(string $email, string $list = null)
    {
        $list ??= config('services.mailchimp.lists.subscribers');

        return $this->client()->lists->addListMember($list, [
            'email_address' => $email,
            'status' => 'subscribed'
        ]);
    }

    protected function client()
    {
        return $this->client->setConfig([
            'apiKey' => config('services.mailchimp.key'),
            'server' => 'us17'
        ]);
    }
}
```

Luego nos dirigimos al archivo `AppServiceProvider.php` agregando el siguiente código en la función `register()`.

```php
app()->bind(Newsletter::class, function () {

            $client = (new ApiClient)->setConfig([
                'apiKey' => config('services.mailchimp.key'),
                'server' => 'us17'
            ]);


            return new Newsletter($client);
        });
```

Después, nos vamos al archivo `Newsletter.php` y eliminamos la función `client()`

Seguidamente, le cambiamos el nombre al archivo `Newsletter.php` por `MailchimpNewsletter.php`.

Además, creamos dos archivos nuevos en la carpeta de `Services` llamados `ConvertKitNewsletter.php` y `Newsletter.php`

Y volvemos al archivo `MailchimpNewsletter.php` y le implementamos a la clase el archivo `Newsletter.php`.

```php
class MailchimpNewsletter implements Newsletter
```

Ahora primero, nos vamos al archivo nuevo creado `Newsletter.php` y agregamos lo siguiente.

```php
<?php

namespace App\Services;


interface Newsletter
{
    public function subscribe (string $email, string $list = null);
}
```

Y después, nos vamos al archivo `MailchimpNewsletter.php` y `ConvertKitNewsletter.php` y agregamos lo siguiente.

```php

class nameclass implements Newsletter

```

Y para finalizar, nos vamos al archivo `AppServiceProvider.php` y editamos el return.

```php
 return new MailchimpNewsletter($client);
```