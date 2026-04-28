import { Component, OnInit } from '@angular/core';
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

  constructor(private catalogService: CatalogService) {}

  ngOnInit(): void {
    this.loading = true;
    this.catalogService.getCategories().subscribe({
      next: (cats) => {
        this.categories = cats;
        this.loading = false;
      },
      error: (err) => {
        this.error = 'Impossible de charger les catégories. Vérifiez la connexion au serveur.';
        this.loading = false;
      }
    });
  }

  selectCategory(cat: Category): void {
    this.selectedCategory = cat;
    this.viewMode = 'books';
    this.loading = true;
    this.livres = [];
    this.catalogService.getBooks(cat.id).subscribe({
      next: (books) => {
        this.livres = books;
        this.loading = false;
      },
      error: () => {
        this.error = 'Impossible de charger les livres.';
        this.loading = false;
      }
    });
  }

  back(): void {
    this.viewMode = 'categories';
    this.selectedCategory = null;
    this.livres = [];
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
