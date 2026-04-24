<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\InteractionController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Routes publiques (Membre 1 et Membre 2)
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/books', [BookController::class, 'index']);
Route::get('/books/{id}', [BookController::class, 'show']);

// Routes protégées par Sanctum (Utilisateurs connectés)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    
    // Membre 3
    Route::post('/favorites/{bookId}', [InteractionController::class, 'toggleFavorite']);
    Route::get('/my-favorites', [InteractionController::class, 'myFavorites']);
    Route::post('/books/{bookId}/reviews', [InteractionController::class, 'addReview']);

    // Membre 4 (Idéalement, ajouter un middleware 'isAdmin' ici)
    Route::post('/admin/books', [AdminController::class, 'storeBook']);
    Route::delete('/admin/books/{id}', [AdminController::class, 'destroyBook']);
    Route::get('/admin/stats', [AdminController::class, 'dashboardStats']);
});
