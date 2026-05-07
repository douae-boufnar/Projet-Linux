<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    public function test_register_user()
    {
        $response = $this->postJson('/api/register', [
            'nom' => 'Test',
            'prenom' => 'User',
            'email' => 'test@example.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        // ton API peut renvoyer 201 OU 200 selon ton controller
        $response->assertStatus(201);

        $this->assertDatabaseHas('users', [
            'email' => 'test@example.com',
            'nom' => 'Test',
        ]);
    }

    public function test_login_user()
    {
        User::create([
            'nom' => 'Test',
            'prenom' => 'User',
            'email' => 'login@example.com',
            'password' => Hash::make('password123'),
            'role' => 'user'
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'login@example.com',
            'password' => 'password123',
        ]);

        $response->assertStatus(200);
        $this->assertTrue(true);
    }

    public function test_login_fail()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'fake@example.com',
            'password' => 'wrong',
        ]);

        $response->assertStatus(401);
    }
}
