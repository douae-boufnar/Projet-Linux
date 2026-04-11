import { Component } from '@angular/core';
import { BookService } from '../../services/book.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-book-list',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './book-list.html'
})
export class BookListComponent {

  books: any[] = [];

  constructor(private bookService: BookService) {
    this.books = this.bookService.getBooks();
  }
}