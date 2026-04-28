<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\Review;
use Illuminate\Http\Request;

class InteractionController extends Controller
{
    // Ajouter ou retirer un livre des favoris (Relation Many-to-Many)
    public function toggleFavorite(Request $request, $bookId) {
        $user = $request->user(); // Récupère l'utilisateur connecté via Sanctum
        
        // La méthode toggle() ajoute l'ID s'il n'y est pas, ou l'enlève s'il y est déjà
        $user->favorites()->toggle($bookId); 
        
        return response()->json(['message' => 'Favoris mis à jour']);
    }

    // Récupérer la liste des favoris de l'utilisateur
    public function myFavorites(Request $request) {
        return response()->json($request->user()->favorites);
    }

    // Ajouter un avis sur un livre
    public function addReview(Request $request, $bookId) {
        $request->validate([
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'required|string'
        ]);

        $review = Review::create([
            'user_id' => $request->user()->id,
            'book_id' => $bookId,
            'rating' => $request->rating,
            'comment' => $request->comment
        ]);

        return response()->json(['message' => 'Avis ajouté', 'review' => $review], 201);
    }
}
