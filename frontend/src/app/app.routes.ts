import { Routes } from '@angular/router';
import { LoginComponent } from './pages/login/login';
import { BookListComponent } from './pages/book-list/book-list';

export const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'books', component: BookListComponent },
];
