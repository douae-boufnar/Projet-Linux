<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('livres', function (Blueprint $table) {
            $table->increments('id');
            $table->string('titre', 255);
            $table->string('auteur', 255);
            $table->text('description')->nullable();
            $table->string('image', 500)->nullable();
            $table->string('contenu', 500)->nullable();
            $table->unsignedInteger('category_id');
            $table->timestamp('created_at')->useCurrent();

            $table->foreign('category_id')->references('id')->on('categories')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('livres');
    }
};
