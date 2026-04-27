<?php

namespace App\Http\Controllers;

use App\Models\Livre;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BookController extends Controller
{
    // Récupérer la liste des livres (avec filtre optionnel par catégorie)
    public function index(Request $request)
    {
        $query = Livre::with('category');

        if ($request->has('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        $livres = $query->get();
        return response()->json($livres);
    }

    // Récupérer les détails d'un livre
    public function show($id)
    {
        $livre = Livre::with('category')->findOrFail($id);
        return response()->json($livre);
    }

    // Consulter le contenu du livre (lecture en ligne PDF)
    public function read($id)
    {
        $livre = Livre::findOrFail($id);

        if (!$livre->contenu) {
            return response()->json(['message' => 'Contenu non disponible pour ce livre.'], 404);
        }

        $path = storage_path('app/public/' . $livre->contenu);

        if (!file_exists($path)) {
            return response()->json(['message' => 'Fichier introuvable.'], 404);
        }

        return response()->file($path, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . basename($path) . '"'
        ]);
    }

    // Récupérer toutes les catégories pour le filtre
    public function categories()
    {
        $categories = Category::all();
        return response()->json($categories);
    }
}
