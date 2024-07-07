[< Volver al Indice](/Docs/readme.md/)

# Laravel Breeze Quick Peek

Vamos a modificar el `if` y el `return` del archivo `SessionController.php` de la siguiente manera.

```php
if (! auth()->attempt($attributes)) {
            throw ValidationException::withMessages([
                'email' => 'Your provided credentials could not be verified.'
            ]);
        }

        session()->regenerate();

        return redirect('/')->with('success', 'Welcome Back!');
```