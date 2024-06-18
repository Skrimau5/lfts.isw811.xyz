<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/app.css">
    <title>My Blog</title>
</head>

<body>
    <article>
        <h1><?= $post->title; ?></h1>

        <div>
            <?= $post->body; ?>
        </div>
    </article>

    <a href="/">Go back</a>
</body>

</html>