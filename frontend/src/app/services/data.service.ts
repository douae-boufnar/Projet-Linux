import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  // L'adresse de ton API Laravel qu'on a testée tout à l'heure
  private apiUrl = '/api/admin/donnees';

  constructor(private http: HttpClient) { }

  // Cette fonction va chercher les livres
  getLivres(): Observable<any> {
    return this.http.get(this.apiUrl);
  }
}