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

  constructor(private catalogService: CatalogService) {}

  ngOnInit(): void {
    this.loadCategories();
    this.loadBooks();
  }

  loadCategories(): void {
    this.catalogService.getCategories().subscribe(cats => {
      this.categories = cats;
    });
  }

  loadBooks(): void {
    this.catalogService.getBooks(this.selectedCategoryId).subscribe(books => {
      this.livres = books;
    });
  }

  onFilterChange(): void {
    this.loadBooks();
  }
}
