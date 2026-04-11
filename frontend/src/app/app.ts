import { Component } from '@angular/core';
import { BookListComponent } from './pages/book-list/book-list';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [BookListComponent],
  templateUrl: './app.html'
})
export class App {}