import { Component, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { CatalogService } from '../../services/catalog.service';
import { Livre } from '../../models/livre.model';
import { Category } from '../../models/category.model';

@Component({
  selector: 'app-catalog',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './catalog.component.html',
  styleUrl: './catalog.component.css'
})
export class CatalogComponent implements OnInit {
  livres: Livre[] = [];
  categories: Category[] = [];
  selectedCategory: Category | null = null;
  viewMode: 'categories' | 'books' = 'categories';
  loading = false;
  error: string | null = null;

  constructor(
    private catalogService: CatalogService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {}

  ngOnInit(): void {
    this.loading = true;
    this.error = null;
    this.catalogService.getCategories().subscribe({
      next: (cats) => {
        this.ngZone.run(() => {
          this.categories = cats;
          this.loading = false;
          this.cdr.detectChanges();
        });
      },
      error: (err) => {
        this.ngZone.run(() => {
          this.error = 'Impossible de charger les catégories. Vérifiez la connexion.';
          this.loading = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  selectCategory(cat: Category): void {
    this.selectedCategory = cat;
    this.viewMode = 'books';
    this.loading = true;
    this.livres = [];
    this.cdr.detectChanges();

    this.catalogService.getBooks(cat.id).subscribe({
      next: (books) => {
        this.ngZone.run(() => {
          this.livres = books;
          this.loading = false;
          this.cdr.detectChanges();
        });
      },
      error: () => {
        this.ngZone.run(() => {
          this.error = 'Impossible de charger les livres.';
          this.loading = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  back(): void {
    this.viewMode = 'categories';
    this.selectedCategory = null;
    this.livres = [];
    this.cdr.detectChanges();
  }

  getCategoryColor(index: number): string {
    const colors = ['#dbeafe', '#d1fae5', '#fef9c3', '#fed7aa', '#ede9fe'];
    return colors[index % colors.length];
  }

  getCategoryIconColor(index: number): string {
    const colors = ['#3b82f6', '#10b981', '#f59e0b', '#f97316', '#8b5cf6'];
    return colors[index % colors.length];
  }

  getCategoryIcon(name: string): string {
    const map: Record<string, string> = {
      'Informatique': '💻',
      'Sciences': '🔬',
      'Littérature': '📚',
      'Histoire': '🏛️',
      'Economie': '📈',
    };
    return map[name] || '📁';
  }
}
