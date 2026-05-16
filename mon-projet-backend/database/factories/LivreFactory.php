<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class LivreFactory extends Factory
{
    public function definition(): array
    {
        return [
            'titre' => $this->faker->sentence(3),
            'auteur' => $this->faker->name(),
            'description' => $this->faker->paragraph(),
            'image' => null,
            'contenu' => null,
            'category_id' => 1,
        ];
    }
}
