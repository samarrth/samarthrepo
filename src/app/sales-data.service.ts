import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

export interface DistributorSalesData {
  name: string;
  secondarySalesKg: number;
  primarySalesKg: number;
  secondarySalesAmount: number;
  primarySalesAmount: number;
}

export interface SalesDataResponse {
  distributors: DistributorSalesData[];
  totalSecondaryKg: number;
  totalPrimaryKg: number;
  totalSecondaryAmount: number;
  totalPrimaryAmount: number;
}

@Injectable({
  providedIn: 'root'
})
export class SalesDataService {

  constructor() { }

  // Sample data - replace with actual API call
  private sampleData: DistributorSalesData[] = [
    {
      name: 'Metro Distribution Co.',
      secondarySalesKg: 1250,
      primarySalesKg: 1400,
      secondarySalesAmount: 125000,
      primarySalesAmount: 140000
    },
    {
      name: 'Global Supply Chain Ltd.',
      secondarySalesKg: 980,
      primarySalesKg: 1100,
      secondarySalesAmount: 98000,
      primarySalesAmount: 110000
    },
    {
      name: 'Regional Sales Partners',
      secondarySalesKg: 875,
      primarySalesKg: 950,
      secondarySalesAmount: 87500,
      primarySalesAmount: 95000
    },
    {
      name: 'Prime Distributors Inc.',
      secondarySalesKg: 750,
      primarySalesKg: 850,
      secondarySalesAmount: 75000,
      primarySalesAmount: 85000
    },
    {
      name: 'Alliance Trading Corp.',
      secondarySalesKg: 680,
      primarySalesKg: 750,
      secondarySalesAmount: 68000,
      primarySalesAmount: 75000
    },
    {
      name: 'Elite Distribution Network',
      secondarySalesKg: 620,
      primarySalesKg: 700,
      secondarySalesAmount: 62000,
      primarySalesAmount: 70000
    },
    {
      name: 'Supreme Sales Solutions',
      secondarySalesKg: 580,
      primarySalesKg: 650,
      secondarySalesAmount: 58000,
      primarySalesAmount: 65000
    },
    {
      name: 'Universal Trading Co.',
      secondarySalesKg: 520,
      primarySalesKg: 600,
      secondarySalesAmount: 52000,
      primarySalesAmount: 60000
    },
    {
      name: 'Premium Distribution Hub',
      secondarySalesKg: 480,
      primarySalesKg: 550,
      secondarySalesAmount: 48000,
      primarySalesAmount: 55000
    },
    {
      name: 'Strategic Sales Partners',
      secondarySalesKg: 420,
      primarySalesKg: 500,
      secondarySalesAmount: 42000,
      primarySalesAmount: 50000
    }
  ];

  /**
   * Get top 10 distributors sales data
   * In a real application, this would make an HTTP call to your API
   */
  getTop10DistributorsSalesData(): Observable<SalesDataResponse> {
    const totalSecondaryKg = this.sampleData.reduce((sum, item) => sum + item.secondarySalesKg, 0);
    const totalPrimaryKg = this.sampleData.reduce((sum, item) => sum + item.primarySalesKg, 0);
    const totalSecondaryAmount = this.sampleData.reduce((sum, item) => sum + item.secondarySalesAmount, 0);
    const totalPrimaryAmount = this.sampleData.reduce((sum, item) => sum + item.primarySalesAmount, 0);

    const response: SalesDataResponse = {
      distributors: this.sampleData,
      totalSecondaryKg,
      totalPrimaryKg,
      totalSecondaryAmount,
      totalPrimaryAmount
    };

    return of(response);
  }

  /**
   * Generate random sales data for testing/demo purposes
   */
  generateRandomSalesData(): Observable<SalesDataResponse> {
    const distributorNames = [
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

    const randomData: DistributorSalesData[] = distributorNames.map(name => ({
      name,
      secondarySalesKg: Math.floor(Math.random() * 1000) + 500,
      primarySalesKg: Math.floor(Math.random() * 1200) + 600,
      secondarySalesAmount: Math.floor(Math.random() * 100000) + 50000,
      primarySalesAmount: Math.floor(Math.random() * 120000) + 60000
    }));

    // Sort by secondary sales amount (descending)
    randomData.sort((a, b) => b.secondarySalesAmount - a.secondarySalesAmount);

    const totalSecondaryKg = randomData.reduce((sum, item) => sum + item.secondarySalesKg, 0);
    const totalPrimaryKg = randomData.reduce((sum, item) => sum + item.primarySalesKg, 0);
    const totalSecondaryAmount = randomData.reduce((sum, item) => sum + item.secondarySalesAmount, 0);
    const totalPrimaryAmount = randomData.reduce((sum, item) => sum + item.primarySalesAmount, 0);

    const response: SalesDataResponse = {
      distributors: randomData,
      totalSecondaryKg,
      totalPrimaryKg,
      totalSecondaryAmount,
      totalPrimaryAmount
    };

    return of(response);
  }

  /**
   * Example method for real API integration
   * Replace with your actual API endpoint
   */
  // getSalesDataFromAPI(): Observable<SalesDataResponse> {
  //   return this.http.get<SalesDataResponse>('/api/sales/top-distributors');
  // }
}