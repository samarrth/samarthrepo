import { Component, OnInit } from '@angular/core';
import { ChartConfiguration, ChartOptions, ChartType } from 'chart.js';

@Component({
  selector: 'app-sales-chart',
  templateUrl: './sales-chart.component.html',
  styleUrls: ['./sales-chart.component.css']
})
export class SalesChartComponent implements OnInit {

  // Sample data for top 10 distributors
  distributors = [
    'Metro Distribution Co.',
    'Global Supply Chain Ltd.',
    'Regional Sales Partners',
    'Prime Distributors Inc.',
    'Alliance Trading Corp.',
    'Elite Distribution Network',
    'Supreme Sales Solutions',
    'Universal Trading Co.',
    'Premium Distribution Hub',
    'Strategic Sales Partners'
  ];

  // Sample sales data
  salesData = {
    secondarySalesKg: [1250, 980, 875, 750, 680, 620, 580, 520, 480, 420],
    primarySalesKg: [1400, 1100, 950, 850, 750, 700, 650, 600, 550, 500],
    secondarySalesAmount: [125000, 98000, 87500, 75000, 68000, 62000, 58000, 52000, 48000, 42000],
    primarySalesAmount: [140000, 110000, 95000, 85000, 75000, 70000, 65000, 60000, 55000, 50000]
  };

  public barChartLegend = true;
  public barChartPlugins = [];

  public barChartData: ChartConfiguration<'bar'>['data'] = {
    labels: this.distributors,
    datasets: [
      {
        label: 'Secondary Sales Kg',
        data: this.salesData.secondarySalesKg,
        backgroundColor: 'rgba(54, 162, 235, 0.6)',
        borderColor: 'rgba(54, 162, 235, 1)',
        borderWidth: 1
      },
      {
        label: 'Primary Sales Kg',
        data: this.salesData.primarySalesKg,
        backgroundColor: 'rgba(255, 99, 132, 0.6)',
        borderColor: 'rgba(255, 99, 132, 1)',
        borderWidth: 1
      }
    ]
  };

  public barChartDataAmount: ChartConfiguration<'bar'>['data'] = {
    labels: this.distributors,
    datasets: [
      {
        label: 'Secondary Sales Amount (₹)',
        data: this.salesData.secondarySalesAmount,
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      },
      {
        label: 'Primary Sales Amount (₹)',
        data: this.salesData.primarySalesAmount,
        backgroundColor: 'rgba(255, 206, 86, 0.6)',
        borderColor: 'rgba(255, 206, 86, 1)',
        borderWidth: 1
      }
    ]
  };

  public barChartOptions: ChartConfiguration<'bar'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      x: {
        ticks: {
          maxRotation: 45,
          minRotation: 45
        }
      },
      y: {
        beginAtZero: true
      }
    },
    plugins: {
      legend: {
        display: true,
        position: 'top'
      },
      tooltip: {
        mode: 'index',
        intersect: false
      }
    }
  };

  public barChartOptionsAmount: ChartConfiguration<'bar'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      x: {
        ticks: {
          maxRotation: 45,
          minRotation: 45
        }
      },
      y: {
        beginAtZero: true,
        ticks: {
          callback: function(value: any) {
            return '₹' + value.toLocaleString();
          }
        }
      }
    },
    plugins: {
      legend: {
        display: true,
        position: 'top'
      },
      tooltip: {
        mode: 'index',
        intersect: false,
        callbacks: {
          label: function(context: any) {
            return context.dataset.label + ': ₹' + context.parsed.y.toLocaleString();
          }
        }
      }
    }
  };

  public barChartType: ChartType = 'bar';

  constructor() { }

  ngOnInit(): void {
    // Initialize any additional data or configurations here
  }

  // Method to update chart data dynamically
  updateChartData() {
    // This method can be called to update the chart with new data
    this.barChartData = { ...this.barChartData };
    this.barChartDataAmount = { ...this.barChartDataAmount };
  }

  // Methods for calculating totals
  getTotalSecondaryKg(): number {
    return this.salesData.secondarySalesKg.reduce((total, value) => total + value, 0);
  }

  getTotalPrimaryKg(): number {
    return this.salesData.primarySalesKg.reduce((total, value) => total + value, 0);
  }

  getTotalSecondaryAmount(): number {
    return this.salesData.secondarySalesAmount.reduce((total, value) => total + value, 0);
  }

  getTotalPrimaryAmount(): number {
    return this.salesData.primarySalesAmount.reduce((total, value) => total + value, 0);
  }
}