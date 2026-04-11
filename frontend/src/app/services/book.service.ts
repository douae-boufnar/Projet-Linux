import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  constructor() {}

  getBooks() {
    return [
      { id: 1, title: 'Book 1', available: true },
      { id: 2, title: 'Book 2', available: false }
    ];
  }
}