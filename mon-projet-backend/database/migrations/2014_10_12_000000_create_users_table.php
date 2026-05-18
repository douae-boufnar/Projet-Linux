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
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            // Champs adaptés à ton projet
            $table->string('nom');
            $table->string('prenom')->nullable();

            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');

            // Comme dans ton SQL dump
            $table->enum('role', ['admin', 'user'])->default('user');

            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->nullable();

            // Laravel auth optionnel
            $table->rememberToken();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
