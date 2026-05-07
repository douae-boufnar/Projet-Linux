import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BookService {
  private apiUrl = 'http://localhost:8000/api/livres'; // L'adresse de ton backend Laravel

  constructor(private http: HttpClient) { }

  // Cette fonction est celle que ton dashboard appelle
  createBook(bookData: any): Observable<any> {
    return this.http.post(this.apiUrl, bookData);
  }

  // Optionnel : pour afficher la liste plus tard
  getBooks(): Observable<any> {
    return this.http.get(this.apiUrl);
  }
}