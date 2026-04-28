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
  loadingPdf = false;
  error: string | null = null;
  loadingBook = true;

  constructor(
    private route: ActivatedRoute,
    private catalogService: CatalogService,
    private authService: AuthService,
    private router: Router,
    private sanitizer: DomSanitizer
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.catalogService.getBook(+id).subscribe({
        next: (book) => { this.livre = book; this.loadingBook = false; },
        error: () => { this.error = 'Livre introuvable.'; this.loadingBook = false; }
      });
    }
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn();
  }

  onRead(): void {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    if (!this.livre) return;

    this.loadingPdf = true;
    this.error = null;
    const token = this.authService.getToken();
    const url = this.catalogService.getReadUrl(this.livre.id);

    fetch(url, { headers: { Authorization: `Bearer ${token}` } })
      .then(res => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.blob();
      })
      .then(blob => {
        const objectUrl = URL.createObjectURL(blob);
        this.pdfUrl = this.sanitizer.bypassSecurityTrustResourceUrl(objectUrl);
        this.isReading = true;
        this.loadingPdf = false;
      })
      .catch(() => {
        this.error = 'Impossible de charger le PDF.';
        this.loadingPdf = false;
      });
  }

  closePdf(): void {
    this.isReading = false;
    this.pdfUrl = null;
  }
}
