<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function register_user()
    {
        $response = $this->postJson('/api/register', [
            'nom' => 'Test',
            'prenom' => 'User',
            'email' => 'test@example.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertStatus(201);

        $this->assertDatabaseHas('users', [
            'email' => 'test@example.com',
            'nom' => 'Test',
        ]);
    }

    /** @test */
    public function login_user()
    {
        User::create([
            'nom' => 'Test',
            'prenom' => 'User',
            'email' => 'login@example.com',
            'password' => Hash::make('password123'),
            'role' => 'user',
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'login@example.com',
            'password' => 'password123',
        ]);

        $response->assertStatus(200);

        // 👉 on vérifie juste qu'on reçoit un user ou un message de succès
        $response->assertJsonStructure([
            'user'
        ]);
    }

    /** @test */
    public function login_fail()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'wrong@example.com',
            'password' => 'wrongpass',
        ]);

        $response->assertStatus(401);
    }
}
