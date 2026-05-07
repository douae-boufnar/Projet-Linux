<?php

namespace App\Http\Controllers;

use App\Models\Livre;
use App\Models\Category;
use Illuminate\Http\Request;
use Exception;

class BookController extends Controller
{
    // 1. Liste des livres
    public function index(Request $request)
    {
        $query = Livre::with('category');
        if ($request->has('category_id')) {
            $query->where('category_id', $request->category_id);
        }
        return response()->json($query->get());
    }

    // 2. Détails d'un livre
    public function show($id)
    {
        return response()->json(Livre::with('category')->findOrFail($id));
    }

    // 3. Liste des catégories (pour ton menu déroulant)
    public function categories()
    {
        return response()->json(Category::all());
    }

    // 4. Lecture du contenu (PDF ou texte)
    public function read($id)
    {
        $livre = Livre::findOrFail($id);
        if (!$livre->contenu) {
            return response()->json(['message' => 'Contenu non disponible'], 404);
        }
        return response()->json(['contenu' => $livre->contenu]);
    }

    public function store(Request $request)
{
    try {
        $data = $request->all();

        // FORCE : Si category_id est vide ou invalide, on met NULL
        if (empty($data['category_id']) || $data['category_id'] == "undefined") {
            $data['category_id'] = null;
        }

        $livre = Livre::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Livre ajouté (catégorie optionnelle)',
            'livre' => $livre
        ], 201);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error',
            'message' => 'Erreur MySQL : ' . $e->getMessage()
        ], 500);
    }
}
}