import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-admin-dashboard',
  standalone: true, // <-- Ajout obligatoire pour votre version d'Angular
  imports: [CommonModule, FormsModule], // <-- Ajout pour faire fonctionner le formulaire et le tableau
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit {
  // L'URL de ton backend Laravel (Docker)
  apiUrl = 'http://localhost:8000/api/books'; 
  
  livres: any[] = [];
  loading = false;

  // Modèle vide pour le formulaire
  newBook = {
    titre: '',
    auteur: '',
    description: '',
    image: '',
    contenu: '',
    category_id: 1 
  };

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.loadBooks();
  }

  // Récupérer la liste depuis la base de données
  loadBooks() {
    this.http.get<any[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.livres = data;
      },
      error: (err) => {
        console.error('Erreur lors du chargement des livres', err);
      }
    });
  }

  // Envoyer le nouveau livre à la base de données
  addBook() {
    if (!this.newBook.titre || !this.newBook.auteur) {
      alert('Veuillez remplir le titre et l\'auteur');
      return;
    }

    this.loading = true;
    this.http.post(this.apiUrl, this.newBook).subscribe({
      next: (res: any) => {
        alert('Livre ajouté avec succès !');
        this.loadBooks(); // On rafraîchit le tableau
        this.resetForm(); // On vide les cases
        this.loading = false;
      },
      error: (err) => {
        console.error('Erreur lors de l\'ajout', err);
        alert('Erreur lors de l\'ajout du livre');
        this.loading = false;
      }
    });
  }

  resetForm() {
    this.newBook = { titre: '', auteur: '', description: '', image: '', contenu: '', category_id: 1 };
  }

  getCategoryName(id: number | string): string {
    const categories: { [key: number]: string } = {
      1: 'Informatique',
      2: 'Sciences',
      3: 'Littérature',
      4: 'Histoire',
      5: 'Economie'
    };
    return categories[Number(id)] || 'Inconnue';
  }
}