# Sales Chart Examples

This document provides examples of how to use and customize the Sales Chart component.

## Basic Usage

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  template: `
    <app-sales-chart></app-sales-chart>
  `
})
export class DashboardComponent {
}
```

## Using with Sales Data Service

```typescript
import { Component, OnInit } from '@angular/core';
import { SalesDataService, SalesDataResponse } from './sales-data.service';

@Component({
  selector: 'app-dynamic-chart',
  template: `
    <div class="dashboard">
      <button (click)="loadRandomData()">Generate Random Data</button>
      <app-sales-chart [salesData]="chartData"></app-sales-chart>
    </div>
  `
})
export class DynamicChartComponent implements OnInit {
  chartData: any;

  constructor(private salesService: SalesDataService) {}

  ngOnInit() {
    this.loadData();
  }

  loadData() {
    this.salesService.getTop10DistributorsSalesData().subscribe(
      (data: SalesDataResponse) => {
        this.chartData = this.transformDataForChart(data);
      }
    );
  }

  loadRandomData() {
    this.salesService.generateRandomSalesData().subscribe(
      (data: SalesDataResponse) => {
        this.chartData = this.transformDataForChart(data);
      }
    );
  }

  private transformDataForChart(data: SalesDataResponse) {
    return {
      distributors: data.distributors.map(d => d.name),
      secondarySalesKg: data.distributors.map(d => d.secondarySalesKg),
      primarySalesKg: data.distributors.map(d => d.primarySalesKg),
      secondarySalesAmount: data.distributors.map(d => d.secondarySalesAmount),
      primarySalesAmount: data.distributors.map(d => d.primarySalesAmount)
    };
  }
}
```

## Custom Chart Colors

```typescript
// In your component
export class CustomColorsChartComponent {
  
  // Custom color scheme
  public customBarChartData: ChartConfiguration<'bar'>['data'] = {
    labels: this.distributors,
    datasets: [
      {
        label: 'Secondary Sales Kg',
        data: this.salesData.secondarySalesKg,
        backgroundColor: 'rgba(46, 125, 50, 0.6)',     // Green
        borderColor: 'rgba(46, 125, 50, 1)',
        borderWidth: 2
      },
      {
        label: 'Primary Sales Kg',
        data: this.salesData.primarySalesKg,
        backgroundColor: 'rgba(229, 57, 53, 0.6)',     // Red
        borderColor: 'rgba(229, 57, 53, 1)',
        borderWidth: 2
      }
    ]
  };
}
```

## Responsive Chart Options

```typescript
public responsiveChartOptions: ChartConfiguration<'bar'>['options'] = {
  responsive: true,
  maintainAspectRatio: false,
  scales: {
    x: {
      ticks: {
        maxRotation: 90,
        minRotation: 45,
        font: {
          size: window.innerWidth < 768 ? 10 : 12
        }
      }
    },
    y: {
      beginAtZero: true,
      ticks: {
        font: {
          size: window.innerWidth < 768 ? 10 : 12
        }
      }
    }
  },
  plugins: {
    legend: {
      position: window.innerWidth < 768 ? 'bottom' : 'top',
      labels: {
        font: {
          size: window.innerWidth < 768 ? 10 : 12
        }
      }
    }
  }
};
```

## Loading Data from API

```typescript
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiSalesService {
  
  constructor(private http: HttpClient) {}

  getSalesData() {
    return this.http.get<any>('/api/distributors/top10/sales');
  }
}

// In your component
export class ApiChartComponent implements OnInit {
  
  constructor(private apiService: ApiSalesService) {}

  ngOnInit() {
    this.apiService.getSalesData().subscribe(
      (response) => {
        // Transform API response to chart format
        this.updateChartWithApiData(response);
      },
      (error) => {
        console.error('Error loading sales data:', error);
        // Fallback to sample data
        this.loadSampleData();
      }
    );
  }
}
```

## Chart with Animation

```typescript
public animatedChartOptions: ChartConfiguration<'bar'>['options'] = {
  responsive: true,
  animation: {
    duration: 2000,
    easing: 'easeInOutQuart'
  },
  transitions: {
    active: {
      animation: {
        duration: 400
      }
    }
  },
  // ... other options
};
```

## Custom Tooltip Format

```typescript
public customTooltipOptions: ChartConfiguration<'bar'>['options'] = {
  // ... other options
  plugins: {
    tooltip: {
      backgroundColor: 'rgba(0, 0, 0, 0.8)',
      titleColor: '#fff',
      bodyColor: '#fff',
      borderColor: '#fff',
      borderWidth: 1,
      callbacks: {
        title: function(context: any) {
          return 'Distributor: ' + context[0].label;
        },
        label: function(context: any) {
          const label = context.dataset.label || '';
          if (label.includes('Amount')) {
            return label + ': ₹' + context.parsed.y.toLocaleString('en-IN');
          } else {
            return label + ': ' + context.parsed.y.toLocaleString('en-IN') + ' Kg';
          }
        },
        footer: function(tooltipItems: any) {
          let total = 0;
          tooltipItems.forEach(function(tooltipItem: any) {
            total += tooltipItem.parsed.y;
          });
          return 'Total: ' + total.toLocaleString('en-IN');
        }
      }
    }
  }
};
```

## Multiple Chart Types

```typescript
// Horizontal Bar Chart
public horizontalBarChartType: ChartType = 'bar';
public horizontalBarChartOptions: ChartConfiguration<'bar'>['options'] = {
  indexAxis: 'y',
  responsive: true,
  // ... other options
};

// Stacked Bar Chart
public stackedBarChartOptions: ChartConfiguration<'bar'>['options'] = {
  responsive: true,
  scales: {
    x: {
      stacked: true,
    },
    y: {
      stacked: true
    }
  }
};
```

## Export Chart as Image

```typescript
import { ViewChild, ElementRef } from '@angular/core';
import { BaseChartDirective } from 'ng2-charts';

export class ExportableChartComponent {
  @ViewChild(BaseChartDirective) chart: BaseChartDirective | undefined;

  exportChart() {
    if (this.chart) {
      const canvas = this.chart.chart?.canvas;
      if (canvas) {
        const url = canvas.toDataURL('image/png');
        const link = document.createElement('a');
        link.download = 'sales-chart.png';
        link.href = url;
        link.click();
      }
    }
  }
}
```

## Real-time Data Updates

```typescript
export class RealTimeChartComponent implements OnInit, OnDestroy {
  private updateInterval: any;

  ngOnInit() {
    // Update chart every 30 seconds
    this.updateInterval = setInterval(() => {
      this.loadFreshData();
    }, 30000);
  }

  ngOnDestroy() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
  }

  loadFreshData() {
    this.salesService.getLatestSalesData().subscribe(
      (data) => {
        this.updateChartData(data);
      }
    );
  }
}
```