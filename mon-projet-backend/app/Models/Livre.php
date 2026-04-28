<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Livre extends Model
{
    use HasFactory;

    protected $table = 'livres';

    // According to init.sql: id, titre, auteur, description, contenu, category_id, created_at
    protected $fillable = [
        'titre',
        'auteur',
        'description',
        'image',
        'contenu',
        'category_id'
    ];

    // Disable updated_at since it's not in init.sql
    public $timestamps = false;

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }
}
