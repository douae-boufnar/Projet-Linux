import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms'; 

// Chemins adaptés à ton arborescence : 2 niveaux pour remonter au dossier app
import { AuthService } from '../../services/auth.service';
import { BookService } from '../../services/book.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterModule, FormsModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent implements OnInit {
  user: any = null;
  
  newBook = { titre: '', auteur: '', category_id: null, description: '', image: '', contenu: '' };

  constructor(
    private authService: AuthService, 
    private bookService: BookService, 
    private router: Router
  ) {}

  ngOnInit() {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    this.user = this.authService.getStoredUser();
    
    this.authService.getUser().subscribe({
      next: (data) => this.user = data,
      error: () => this.logout()
    });
  }

  ajouterLivre() {
    if (!this.newBook.titre || !this.newBook.category_id || !this.newBook.image) {
      alert("Erreur : Les champs Titre, Catégorie et Image sont obligatoires.");
      return;
    }

    this.bookService.createBook(this.newBook).subscribe({
      next: (res) => {
        alert('Livre ajouté avec succès !');
        this.newBook = { titre: '', auteur: '', category_id: null, description: '', image: '', contenu: '' };
      },
      error: (err) => {
        alert("Erreur lors de l'ajout. Vérifie les données.");
      }
    });
  }

  logout() {
    this.authService.logout().subscribe({
      next: () => this.router.navigate(['/login']),
      error: () => this.router.navigate(['/login'])
    });
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    this.router.navigate(['/login']);
  }
}