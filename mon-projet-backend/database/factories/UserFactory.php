<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'nom' => fake()->lastName(),           // "Dupont"
            'prenom' => fake()->firstName(),        // "Jean"
            'email' => fake()->unique()->safeEmail(), // "jean@example.com"
            'password' => Hash::make('password123'),  // Hashé comme dans AuthController
            'role' => 'user',                       // Valeur par défaut
        ];
    }

    /**
     * Créer un utilisateur admin
     */
    public function admin(): static
    {
        return $this->state(fn (array $attributes) => [
            'role' => 'admin',
        ]);
    }
}
