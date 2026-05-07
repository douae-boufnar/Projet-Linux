<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    /**
     * TEST REGISTER SIMPLE
     */
    public function test_register_user()
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
        ]);
    }

    /**
     * TEST LOGIN SIMPLE
     */
    public function test_login_user()
    {
        User::create([
            'nom' => 'Test',
            'prenom' => 'User',
            'email' => 'login@example.com',
            'password' => Hash::make('password123'),
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'login@example.com',
            'password' => 'password123',
        ]);

        $response->assertStatus(200);
    }

    /**
     * TEST LOGIN FAIL SIMPLE
     */
    public function test_login_fail()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'fake@example.com',
            'password' => 'wrong',
        ]);

        $response->assertStatus(401);
    }
}
