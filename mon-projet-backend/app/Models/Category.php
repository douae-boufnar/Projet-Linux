<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categories';
    
    // According to init.sql: id, nom, created_at
    protected $fillable = [
        'nom'
    ];

    // Disable updated_at since it's not in init.sql
    public $timestamps = false;

    public function livres()
    {
        return $this->hasMany(Livre::class, 'category_id');
    }
}
