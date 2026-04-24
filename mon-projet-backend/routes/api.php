<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\SearchController;

// Routes publiques (sans connexion)
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/books', [BookController::class, 'index']);
Route::get('/search', [SearchController::class, 'search']);

// Routes protégées (nécessitent un Token)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/books/{id}/like', [BookController::class, 'like']);
    Route::post('/admin/books', [BookController::class, 'store']);
});
