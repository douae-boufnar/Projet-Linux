import { Component, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent {
  user = { nom: '', prenom: '', email: '', password: '', password_confirmation: '' };
  error: string | null = null;
  loading = false;

  constructor(
    private authService: AuthService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {}

  onSubmit() {
    if (this.user.password !== this.user.password_confirmation) {
      this.error = 'Les mots de passe ne correspondent pas.';
      return;
    }
    this.loading = true;
    this.error = null;
    this.cdr.detectChanges();

    this.authService.register(this.user).subscribe({
      next: () => {
        this.ngZone.run(() => {
          this.loading = false;
          this.router.navigate(['/login']);
        });
      },
      error: (err) => {
        this.ngZone.run(() => {
          this.loading = false;
          if (err.status === 0) {
            this.error = 'Impossible de contacter le serveur.';
          } else if (err.status === 422) {
            const messages = err.error?.errors;
            if (messages) {
              this.error = Object.values(messages).flat().join(' ');
            } else {
              this.error = err.error?.message || 'Données invalides.';
            }
          } else {
            this.error = err.error?.message || 'Erreur lors de l\'inscription.';
          }
          this.cdr.detectChanges();
        });
      }
    });
  }
}
