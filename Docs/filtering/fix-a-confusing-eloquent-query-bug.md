[< Volver al Indice](/Docs/readme.md/)

# Fix a Confusing Eloquent Query Bug

Lo que haremos solamente es irnos al archivo `Post.php` y modificar en la función `scopeFilter` el filtro de `search`.

```php
 $query->when($filters['search'] ?? false, fn ($query, $search) =>
        $query->where(fn($query)=>
            $query->where('title', 'like', '%' . $search . '%')
            ->orWhere('body', 'like', '%' . $search . '%')));
```
