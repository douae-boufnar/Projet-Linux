import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent implements OnInit {
  user: any = null;

  constructor(private authService: AuthService, private router: Router) {}

  ngOnInit() {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    this.user = this.authService.getStoredUser();
    
    // Refresh user data from API
    this.authService.getUser().subscribe({
      next: (data) => this.user = data,
      error: () => this.logout()
    });
  }

  logout() {
    this.authService.logout().subscribe({
      always: () => this.router.navigate(['/login'])
    } as any);
    // Force redirect even if API call fails
    this.router.navigate(['/login']);
  }
}
