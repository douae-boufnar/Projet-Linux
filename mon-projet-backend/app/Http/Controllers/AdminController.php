<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function index()
    {
        $donnees = [
            ['titre' => 'Le Petit Prince', 'auteur' => 'Antoine de Saint-Exepury'],
            ['titre' => 'Les Miserables' , 'auteur' => 'Victor Hugo'],
            ['titre' => "L'etranger", 'auteur' => 'Albert Camus'],
        ];
        return response()->json($donnees);
    }
}