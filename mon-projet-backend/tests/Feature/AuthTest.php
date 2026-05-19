<?php
namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    public function register_user()
    {
        $response = $this->postJson('/api/register', [
            'nom'                  => 'Test',
            'prenom'               => 'User',
            'email'                => 'test@example.com',
            'password'             => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('users', [
            'email' => 'test@example.com',
            'nom'   => 'Test',
        ]);
    }


    public function login_user()
    {
        // Mot de passe en clair car votre controller
        // utilise WHERE password = valeur (pas Hash::check)
        User::create([
            'nom'      => 'Test',
            'prenom'   => 'User',
            'email'    => 'login@example.com',
            'password' => 'password123',   
            'role'     => 'user',
        ]);

        $response = $this->postJson('/api/login', [
            'email'    => 'login@example.com',
            'password' => 'password123',
        ]);

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'user'
        ]);
    }

 
    public function login_fail()
    {
        $response = $this->postJson('/api/login', [
            'email'    => 'wrong@example.com',
            'password' => 'wrongpass',
        ]);

        $response->assertStatus(401);
    }
}
