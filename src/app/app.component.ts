import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div class="app">
      <app-sales-chart></app-sales-chart>
    </div>
  `,
  styles: [`
    .app {
      min-height: 100vh;
      background-color: #f8f9fa;
    }
  `]
})
export class AppComponent {
  title = 'sales-dashboard';
}