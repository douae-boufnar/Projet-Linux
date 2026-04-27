import { Component, OnInit } from '@angular/core';
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
  error: string | null = null;

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn();
  }

  constructor(
    private route: ActivatedRoute,
    private catalogService: CatalogService,
    private authService: AuthService,
    private router: Router,
    private sanitizer: DomSanitizer
  ) {}

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam) {
      const id = +idParam;
      this.catalogService.getBook(id).subscribe({
        next: (book) => {
          this.livre = book;
        },
        error: (err) => {
          this.error = 'Erreur lors du chargement des détails du livre.';
        }
      });
    }
  }

  onRead(): void {
    if (!this.authService.isLoggedIn()) {
      // Redirect to login if not authenticated
      this.router.navigate(['/login']);
      return;
    }

    if (this.livre) {
      this.isReading = true;
      // Note: In a real app with Sanctum, just using an iframe src might not send the Authorization header.
      // A common workaround is to fetch the PDF via HttpClient as Blob, then create an object URL.
      // For simplicity here, we assume the token could be passed via query string or cookies if needed,
      // but proper way is fetching as Blob. Let's do a simple link approach or iframe.
      // Since `read` route is protected, we must send token.
      
      const token = this.authService.getToken();
      // Workaround for iframe with auth: we can't easily pass headers to iframe src.
      // The most robust way is to fetch the blob. But for this demo, we can just 
      // fetch it and open it or create a blob URL.
      
      this.fetchPdfAsBlob(this.livre.id);
    }
  }

  fetchPdfAsBlob(bookId: number): void {
    const url = this.catalogService.getReadUrl(bookId);
    const token = this.authService.getToken();
    
    fetch(url, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })
    .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.blob();
    })
    .then(blob => {
        const objectUrl = URL.createObjectURL(blob);
        this.pdfUrl = this.sanitizer.bypassSecurityTrustResourceUrl(objectUrl);
    })
    .catch(error => {
        this.error = 'Impossible de charger le contenu PDF.';
        this.isReading = false;
    });
  }
}
