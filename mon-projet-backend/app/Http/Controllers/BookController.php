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
        
        // On renvoie l'URL ou le chemin du contenu
        return response()->json(['url' => $livre->contenu]);
    }

    public function store(Request $request)
    {
        try {
            $data = [];
            
            // Titre et Auteur (Obligatoires)
            $data['titre'] = $request->input('titre');
            $data['auteur'] = $request->input('auteur');
            $data['description'] = $request->input('description', '');
            
            // Catégorie
            $category_id = $request->input('category_id');
            $data['category_id'] = ($category_id && $category_id !== 'undefined') ? $category_id : 1;

            // Gestion de l'image (couverture)
            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('books/covers', $filename, 'public');
                $data['image'] = url('storage/' . $path);
            } elseif ($request->filled('image_url')) {
                $data['image'] = $request->input('image_url');
            }

            // Gestion du contenu (PDF)
            if ($request->hasFile('contenu')) {
                $file = $request->file('contenu');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('books/pdfs', $filename, 'public');
                $data['contenu'] = url('storage/' . $path);
            } elseif ($request->filled('pdf_url')) {
                $data['contenu'] = $request->input('pdf_url');
            }

            // Création dans la base de données
            $livre = Livre::create($data);

            return response()->json([
                'status' => 'success',
                'message' => 'Livre ajouté avec succès',
                'livre' => $livre
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Erreur lors de l\'ajout : ' . $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $livre = Livre::findOrFail($id);
            $data = $request->only(['titre', 'auteur', 'description', 'category_id']);

            // Gestion de l'image (couverture)
            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('books/covers', $filename, 'public');
                $data['image'] = url('storage/' . $path);
            } elseif ($request->filled('image_url')) {
                $data['image'] = $request->input('image_url');
            }

            // Gestion du contenu (PDF)
            if ($request->hasFile('contenu')) {
                $file = $request->file('contenu');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('books/pdfs', $filename, 'public');
                $data['contenu'] = url('storage/' . $path);
            } elseif ($request->filled('pdf_url')) {
                $data['contenu'] = $request->input('pdf_url');
            }

            $livre->update($data);

            return response()->json([
                'status' => 'success',
                'message' => 'Livre mis à jour avec succès',
                'livre' => $livre
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Erreur lors de la modification : ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $livre = Livre::findOrFail($id);
            $livre->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Livre supprimé avec succès'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Erreur lors de la suppression : ' . $e->getMessage()
            ], 500);
        }
    }
}