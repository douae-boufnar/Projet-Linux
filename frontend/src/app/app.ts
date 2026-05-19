import { Component, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
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
  title = 'Biblio GI';
  showNavbar = false;
  userName = '';
  userRole = ''; 

  constructor(
    private router: Router,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
    private ngZone: NgZone
  ) {}

  ngOnInit(): void {
    this.router.events
      .pipe(filter(event => event instanceof NavigationEnd))
      .subscribe((event: any) => {
        this.ngZone.run(() => {
          const publicRoutes = ['/login', '/register', '/'];
          this.showNavbar = !publicRoutes.includes(event.urlAfterRedirects);
          
          const user = this.authService.getStoredUser();
          if (user) {
            this.userName = user.prenom || user.nom || 'Lecteur';
            this.userRole = user.role; 
          }
          this.cdr.detectChanges();
        });
      });
  }

  logout(): void {
    this.authService.logout().subscribe({
      next: () => this.ngZone.run(() => this.router.navigate(['/login'])),
      error: () => this.ngZone.run(() => {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        this.router.navigate(['/login']);
      })
    });
  }
}