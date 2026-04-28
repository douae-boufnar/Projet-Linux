import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterOutlet, RouterModule, NavigationEnd } from '@angular/router';
import { AuthService } from './services/auth.service';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterModule],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App implements OnInit {
  title = 'BiblioDigitale';
  showNavbar = false;
  userName = '';

  constructor(private router: Router, private authService: AuthService) {}

  ngOnInit(): void {
    this.router.events
      .pipe(filter(event => event instanceof NavigationEnd))
      .subscribe((event: any) => {
        const publicRoutes = ['/login', '/register', '/'];
        this.showNavbar = !publicRoutes.includes(event.urlAfterRedirects);
        const user = this.authService.getStoredUser();
        this.userName = user ? (user.prenom || user.nom || 'Lecteur') : '';
      });
  }

  logout(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    this.router.navigate(['/login']);
  }
}