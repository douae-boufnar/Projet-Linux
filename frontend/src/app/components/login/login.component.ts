import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  credentials = { email: '', password: '' };
  error: string | null = null;
  loading = false;

  constructor(private authService: AuthService, private router: Router) {}

  onSubmit() {
    this.loading = true;
    this.error = null;
    this.authService.login(this.credentials).subscribe({
      next: () => {
        this.loading = false;
        this.router.navigate(['/catalog']);
      },
      error: (err) => {
        this.loading = false;
        if (err.status === 0) {
          this.error = 'Impossible de contacter le serveur. Vérifiez que le backend est démarré.';
        } else if (err.status === 401) {
          this.error = 'Email ou mot de passe incorrect.';
        } else {
          this.error = err.error?.message || 'Erreur de connexion. Réessayez.';
        }
      }
    });
  }
}
