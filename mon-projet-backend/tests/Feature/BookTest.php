<?php

namespace Tests\Feature;

use App\Models\Livre;
use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class BookTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        // Créer une catégorie par défaut car LivreFactory utilise category_id = 1
        Category::factory()->create(['id' => 1]);
    }

    /** @test */
    public function it_can_list_all_books()
    {
        Livre::factory()->count(3)->create();

        $response = $this->getJson('/api/books');

        $response->assertStatus(200)
                 ->assertJsonCount(3);
    }

    /** @test */
    public function it_can_show_a_single_book()
    {
        $book = Livre::factory()->create();

        $response = $this->getJson("/api/books/{$book->id}");

        $response->assertStatus(200)
                 ->assertJsonPath('titre', $book->titre);
    }

    /** @test */
    public function it_can_create_a_book()
    {
        Storage::fake('public');

        $data = [
            'titre' => 'Nouveau Livre',
            'auteur' => 'Auteur Test',
            'description' => 'Une description de test',
            'category_id' => 1,
            'image' => UploadedFile::fake()->image('cover.jpg'),
            'contenu' => UploadedFile::fake()->create('book.pdf', 100)
        ];

        $response = $this->postJson('/api/books', $data);

        $response->assertStatus(201)
                 ->assertJsonPath('livre.titre', 'Nouveau Livre');

        $this->assertDatabaseHas('livres', [
            'titre' => 'Nouveau Livre',
            'auteur' => 'Auteur Test'
        ]);
    }

    /** @test */
    public function it_can_update_a_book()
    {
        $book = Livre::factory()->create();

        $data = [
            'titre' => 'Titre Modifié',
            'auteur' => 'Auteur Modifié',
        ];

        // Le contrôleur utilise POST pour l'update pour gérer les fichiers
        $response = $this->postJson("/api/books/{$book->id}", $data);

        $response->assertStatus(200)
                 ->assertJsonPath('livre.titre', 'Titre Modifié');

        $this->assertDatabaseHas('livres', [
            'id' => $book->id,
            'titre' => 'Titre Modifié'
        ]);
    }

    /** @test */
    public function it_can_delete_a_book()
    {
        $book = Livre::factory()->create();

        $response = $this->deleteJson("/api/books/{$book->id}");

        $response->assertStatus(200);
        $this->assertDatabaseMissing('livres', ['id' => $book->id]);
    }

    /** @test */
    public function guest_cannot_access_protected_read_route()
    {
        $book = Livre::factory()->create();

        $response = $this->getJson("/api/books/{$book->id}/read");

        $response->assertStatus(401);
    }

    /** @test */
    public function authenticated_user_can_access_protected_read_route()
    {
        $user = User::factory()->create();
        $book = Livre::factory()->create(['contenu' => 'http://example.com/book.pdf']);

        $response = $this->actingAs($user, 'sanctum')
                         ->getJson("/api/books/{$book->id}/read");

        $response->assertStatus(200)
                 ->assertJsonPath('url', 'http://example.com/book.pdf');
    }
}
