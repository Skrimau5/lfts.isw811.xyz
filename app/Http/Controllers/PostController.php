<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;
use App\Models\Category;

class PostController extends Controller
{

public function index()
    {
        return view('posts.index', [
            'posts' => Post::latest()->filter(request(['search', 'category']))->get()
        ]);

    }

    public function show (Post $post)
    {
        return view('posts.show', [
            'post' => $post
        ]);
    }
        
}
