import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Livre } from '../models/livre.model';
import { Category } from '../models/category.model';

@Injectable({
  providedIn: 'root'
})
export class CatalogService {
  private apiUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  getBooks(categoryId?: number): Observable<Livre[]> {
    let params = new HttpParams();
    if (categoryId) {
      params = params.set('category_id', categoryId.toString());
    }
    return this.http.get<Livre[]>(`${this.apiUrl}/books`, { params });
  }

  getBook(id: number): Observable<Livre> {
    return this.http.get<Livre>(`${this.apiUrl}/books/${id}`);
  }

  getCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(`${this.apiUrl}/categories`);
  }

  getReadUrl(id: number): string {
    return `${this.apiUrl}/books/${id}/read`;
  }
}
