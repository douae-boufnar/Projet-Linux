import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { CatalogService } from '../../services/catalog.service';
import { Livre } from '../../models/livre.model';
import { Category } from '../../models/category.model';

@Component({
  selector: 'app-catalog',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './catalog.component.html',
  styleUrl: './catalog.component.css'
})
export class CatalogComponent implements OnInit {
  livres: Livre[] = [];
  categories: Category[] = [];
  selectedCategoryId: number | undefined = undefined;
  selectedCategoryName: string | undefined = undefined;
  viewMode: 'categories' | 'books' = 'categories';

  constructor(private catalogService: CatalogService) {}

  ngOnInit(): void {
    this.loadCategories();
  }

  loadCategories(): void {
    this.catalogService.getCategories().subscribe(cats => {
      this.categories = cats;
    });
  }

  selectCategory(category: Category): void {
    this.selectedCategoryId = category.id;
    this.selectedCategoryName = category.nom;
    this.loadBooks();
    this.viewMode = 'books';
  }

  backToCategories(): void {
    this.viewMode = 'categories';
    this.selectedCategoryId = undefined;
    this.selectedCategoryName = undefined;
    this.livres = [];
  }

  loadBooks(): void {
    this.catalogService.getBooks(this.selectedCategoryId).subscribe(books => {
      this.livres = books;
    });
  }

  // Map category names to icons (emojis for simplicity, but styled)
  getCategoryIcon(name: string): string {
    const icons: { [key: string]: string } = {
      'Informatique': '💻',
      'Sciences': '🔬',
      'Littérature': '📚',
      'Histoire': '🏛️',
      'Economie': '📈'
    };
    return icons[name] || '📁';
  }
}
