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
  apiUrl = '/api/books'; 
  
  livres: any[] = [];
  loading = false;

  // Modèle vide pour le formulaire
  newBook = {
    titre: '',
    auteur: '',
    description: '',
    category_id: 1,
    image_url: '',
    pdf_url: ''
  };

  selectedImage: File | null = null;
  selectedPdf: File | null = null;

  isEditing = false;
  editingBookId: number | null = null;

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.loadBooks();
  }

  // Gérer la sélection de l'image
  onImageSelected(event: any) {
    this.selectedImage = event.target.files[0];
  }

  // Gérer la sélection du PDF
  onPdfSelected(event: any) {
    this.selectedPdf = event.target.files[0];
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
  submitForm() {
    if (!this.newBook.titre || !this.newBook.auteur) {
      alert('Veuillez remplir au moins le titre et l\'auteur.');
      return;
    }

    this.loading = true;

    // Utilisation de FormData pour envoyer les fichiers
    const formData = new FormData();
    formData.append('titre', this.newBook.titre);
    formData.append('auteur', this.newBook.auteur);
    formData.append('description', this.newBook.description);
    formData.append('category_id', this.newBook.category_id.toString());
    formData.append('image_url', this.newBook.image_url);
    formData.append('pdf_url', this.newBook.pdf_url);
    
    if (this.selectedImage) {
      formData.append('image', this.selectedImage);
    }
    
    if (this.selectedPdf) {
      formData.append('contenu', this.selectedPdf);
    }

    const url = this.isEditing ? `${this.apiUrl}/${this.editingBookId}` : this.apiUrl;
    
    this.http.post(url, formData).subscribe({
      next: (res: any) => {
        alert(this.isEditing ? 'Livre mis à jour !' : 'Livre ajouté !');
        this.loadBooks();
        this.cancelEdit();
        this.loading = false;
      },
      error: (err) => {
        console.error('Erreur', err);
        const errorMsg = err.error?.message || 'Erreur inconnue';
        alert('Erreur : ' + errorMsg);
        this.loading = false;
      }
    });
  }

  editBook(book: any) {
    this.isEditing = true;
    this.editingBookId = book.id;
    this.newBook = {
      titre: book.titre,
      auteur: book.auteur,
      description: book.description || '',
      category_id: book.category_id,
      image_url: book.image,
      pdf_url: book.contenu
    };
    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  cancelEdit() {
    this.isEditing = false;
    this.editingBookId = null;
    this.resetForm();
  }

  deleteBook(id: number) {
    if (!confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')) return;

    this.http.delete(`${this.apiUrl}/${id}`).subscribe({
      next: () => {
        alert('Livre supprimé !');
        this.loadBooks();
      },
      error: (err) => {
        console.error('Erreur suppression', err);
        alert('Erreur lors de la suppression');
      }
    });
  }

  resetForm() {
    this.newBook = { titre: '', auteur: '', description: '', category_id: 1, image_url: '', pdf_url: '' };
    this.selectedImage = null;
    this.selectedPdf = null;
    // Note: les inputs file ne peuvent pas être reset facilement via ngModel, 
    // il faudrait une référence locale si on voulait vraiment les vider visuellement.
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