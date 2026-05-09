import { Component, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CatalogService } from '../../services/catalog.service';
import { AuthService } from '../../services/auth.service';
import { Livre } from '../../models/livre.model';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
  selector: 'app-book-details',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './book-details.component.html',
  styleUrl: './book-details.component.css'
})
export class BookDetailsComponent implements OnInit {
  livre: Livre | null = null;
  pdfUrl: SafeResourceUrl | null = null;
  isReading = false;
  loadingPdf = false;
  error: string | null = null;
  loadingBook = true;
  bookId: string | null = null;

  constructor(
    private route: ActivatedRoute,
    private catalogService: CatalogService,
    private authService: AuthService,
    private router: Router,
    private sanitizer: DomSanitizer,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      this.bookId = params.get('id');
      console.log('Paramètres de route reçus, ID:', this.bookId);
      
      if (this.bookId && this.bookId !== 'undefined') {
        this.loadingBook = true;
        this.cdr.detectChanges(); // Forcer l'affichage du spinner

        this.catalogService.getBook(+this.bookId).subscribe({
          next: (book) => { 
            this.ngZone.run(() => {
              this.livre = book; 
              this.loadingBook = false; 
              this.cdr.detectChanges(); // Forcer l'affichage du livre
            });
          },
          error: (err) => { 
            this.ngZone.run(() => {
              console.error('Erreur API:', err);
              this.error = 'Impossible de trouver ce livre.'; 
              this.loadingBook = false; 
              this.cdr.detectChanges();
            });
          }
        });
      } else {
        this.error = 'Erreur : Aucun identifiant de livre trouvé.';
        this.loadingBook = false;
      }
    });
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn();
  }

  downloadPdf(): void {
    if (!this.livre || !this.livre.contenu) return;
    
    const fileUrl = this.livre.contenu;
    const fileName = `${this.livre.titre.replace(/ /g, '_')}.pdf`;
    
    this.loadingPdf = true;
    
    // On force le téléchargement en créant un lien invisible
    fetch(fileUrl)
      .then(response => response.blob())
      .then(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = fileName;
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);
        this.loadingPdf = false;
      })
      .catch(err => {
        console.error('Erreur de téléchargement:', err);
        // Fallback simple si le blob échoue (CORS)
        window.open(fileUrl, '_blank');
        this.loadingPdf = false;
      });
  }
}
