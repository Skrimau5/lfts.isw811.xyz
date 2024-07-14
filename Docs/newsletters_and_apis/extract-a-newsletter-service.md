[< Volver al Indice](/Docs/readme.md/)

# Extract a Newsletter Service

Comenzamos creando una nueva carpeta llamada `Services` en donde crearemos un nuevo archivo llamado `Newsletter.php` y agregamos lo siguiente.

```php
<?php

namespace App\Services;

use MailchimpMarketing\ApiClient;

class Newsletter
{
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
        return (new ApiClient())->setConfig([
            'apiKey' => config('services.mailchimp.key'),
            'server' => 'us17'
        ]);
    }
}
```

Seguidamente, nos vamos al archivo `web.php` y eliminamos el código dentro de la ruta `newsletter` y la dejamos de la siguiente manera.

```php
Route::post('newsletter', NewsletterController::class);
```

Para finalizar, nos ubicamos en nuestra maquina virtual y nos vamos a la ruta del proyecto, ejecutamos el siguiente comando para crear un controller llamado `NewsletterController.php`.

```bash
php artisan make:controller NewsletterController
```

Ahora nos vamos al nuevo archivo controller creado y agregamos el siguiente código.

```php
<?php

namespace App\Http\Controllers;

use App\Services\Newsletter;
use Exception;
use Illuminate\Validation\ValidationException;

class NewsletterController extends Controller
{
    public function __invoke(Newsletter $newsletter)
    {
        request()->validate(['email' => 'required|email']);

        try {
            $newsletter->subscribe(request('email'));
        } catch (Exception $e) {
            throw ValidationException::withMessages([
                'email' => 'This email could not be added to our newsletter list.'
            ]);
        }

        return redirect('/')
            ->with('success', 'You are now signed up for our newsletter!');
    }
}
```