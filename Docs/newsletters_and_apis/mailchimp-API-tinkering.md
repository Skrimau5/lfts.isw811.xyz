[< Volver al Indice](/Docs/readme.md/)

# Mailchimp API Tinkering

Comenzamos ubicándonos en el archivo `layout.blade.php` para realizar varias modificaciones, 

* Primero le añadimos un `id` al footer.

```php
<footer id="newsletter" class="bg-gray-100 border border-black border-opacity-5 rounded-xl text-center py-16 px-10 mt-16">
```

* Luego vamos y editamos el `href` del componente `<a>` del `"Suscribe for updates"`.

```php
<a href="#newsletter" class="bg-blue-500 ml-3 rounded-full text-xs font-semibold text-white uppercase py-3 px-5">
    Subscribe for Updates
</a>
```

Luego nos vamos para el encabezado del `layout.blade.php` y agregamos lo siguiente:

```php
<style>
html {
        scroll-behavior: smooth;
    }

    .clamp {
        display: -webkit-box;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .clamp.one-line {
        -webkit-line-clamp: 1;
    }
</style>
```

Seguidamente, nos vamos a la pagina [`https://us21.admin.mailchimp.com/`](https://us21.admin.mailchimp.com/)

Posteriormente vamos a crear una cuenta, nos vamos al apartado de `cuentas y facturacion` y luego al apartado de extras y seleccionamos `Claves api`

Creamos un clave api.

![Clave API creada](./images/58.1%20api.png)

Ahora nos vamos al archivo `.env` y agregamos lo siguiente al final del documento.

```bash
MAILCHIMP_KEY=189f938e5cc82e7531cbd29241c8a5e7-us22
```

Después, nos vamos a la carpeta `config` al archivo `services.php` y agregamos lo siguiente.

```php
'mailchimp' => [
        'key' => env('MAILCHIMP_KEY'),
        'lists' => [
            'subscribers' => env('MAILCHIMP_LIST_SUBSCRIBERS')
        ]
    ]
```

Ahora, abrimos nuestra maquina virtual y nos posicionamos en `/vagrant/sites/lfts.isw811.xyz` y ejecutamos el siguiente comando para instalar la librería del cliente para nuestro lenguaje.

```php
composer require mailchimp/marketing
```

Y para finalizar, nos vamos al archivo `web.php` y agregamos la siguiente ruta.

```php
Route::get('ping', function () {
    $mailchimp = new \MailchimpMarketing\ApiClient();

    $mailchimp->setConfig([
        'apiKey' => config('services.mailchimp.key'),
        'server' => 'us22'
    ]);

    $response = $mailchimp->lists->addListMember('list_id', [
        'email_address' => 'manuelchavarria528@gmail.com',
        'status' => 'subscribed'
    ]);
    print_r($response);
});
```