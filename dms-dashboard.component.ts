import { Component, OnInit, HostListener } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { Chart, ChartConfiguration, ChartOptions } from 'chart.js';
import ChartDataLabels from 'chartjs-plugin-datalabels';

interface DropdownModel {
  name: string;
  value: string;
}

@Component({
  selector: 'app-dms-dashboard',
  templateUrl: './dms-dashboard.component.html',
  styleUrls: ['./dms-dashboard.component.scss']
})
export class DmsDashboardComponent implements OnInit {
  constructor() {}

  // Separate popover toggles for each container
  public showOverallFilter = false;
  public showBifurcationFilter = false;
  public showTrendsFilter = false;
  public showTop10Filter = false;

  @HostListener('document:click', ['$event'])
  onClickOutside(event: MouseEvent) {
    const target = event.target as HTMLElement;

    // Close both if clicked outside any popover
    if (!target.closest('.overall-filter-popover')) {
      this.showOverallFilter = false;
    }
    if (!target.closest('.bifurcation-filter-popover')) {
      this.showBifurcationFilter = false;
    }
    if (!target.closest('.trends-filter-popover')) {
      this.showTrendsFilter = false;
    }
    if (!target.closest('.top10-filter-popover')) {
      this.showTop10Filter = false;
    }
  }

  formgroup = new FormGroup({
    periodtype: new FormControl<{ name: string; value: string } | null>({
      name: 'Months',
      value: '2',
    }),
    periodvalue: new FormControl<{ name: string; value: string } | null>({
      name: '30 Days',
      value: '1',
    }),
    view: new FormControl<{ name: string; value: string } | null>({
      name: 'Graph',
      value: 'graph',
    }),
    region: new FormControl<{ name: string; value: string } | null>(null),
    state: new FormControl<{ name: string; value: string } | null>(null),
    productGroup: new FormControl<{ name: string; value: string } | null>(null),
    distributor: new FormControl<{ name: string; value: string } | null>(null),
  });

  // Form for Trends section
  trendsForm = new FormGroup({
    periodtype: new FormControl<DropdownModel | null>({ name: 'Months', value: '2' }),
    periodvalue: new FormControl<DropdownModel | null>({ name: 'This Month', value: '4' }),
    region: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    state: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    productGroup: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    distributor: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    view: new FormControl({ name: 'Graph', value: 'graph' }),
    graphType: new FormControl({ name: 'Bar Chart', value: 'bar' }),
  });

  // Form for Distribution Data Bifurcation section
  bifurcationForm = new FormGroup({
    periodtype: new FormControl<DropdownModel | null>({ name: 'Months', value: '2' }),
    periodvalue: new FormControl<DropdownModel | null>({ name: 'This Month', value: '4' }),
    region: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    state: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    productGroup: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    distributor: new FormControl<DropdownModel | null>({ name: 'ALL', value: 'all' }),
    view: new FormControl({ name: 'Graph', value: 'graph' }),
    graphType: new FormControl({ name: 'Pie Chart', value: 'pie' }),
  });

  graphTypeOptions = [
    { name: 'Pie Chart', value: 'pie' },
    { name: 'Donut Chart', value: 'donut' },
    { name: 'Bar Chart', value: 'bar' },
    { name: 'Line Chart', value: 'line' },
  ];

  toptendistributorForm = new FormGroup({
    periodtype: new FormControl<DropdownModel | null>(null, []),
    periodvalue: new FormControl<DropdownModel | null>(null, []),
    region: new FormControl<DropdownModel | null>(null),
    state: new FormControl<DropdownModel | null>(null),
    productGroup: new FormControl<DropdownModel | null>(null),
    distributor: new FormControl<DropdownModel | null>(null),
    view: new FormControl({ name: 'Graph', value: 'graph' }),
  });

  ngOnInit() {
    // Register ChartDataLabels plugin
    Chart.register(ChartDataLabels);
    
    this.trendsForm.valueChanges.subscribe(() => {
      this.updateTrendsChartData();
    });

    // Subscribe to bifurcation form changes to update currentFilters and chart data
    this.bifurcationForm.valueChanges.subscribe((formValues) => {
      this.currentFilters = {
        region: formValues.region?.value || 'all',
        state: formValues.state?.value || 'all',
        productGroup: formValues.productGroup?.value || 'all',
        distributor: formValues.distributor?.value || 'all',
        periodType: formValues.periodtype?.value || '2',
        periodValue: formValues.periodvalue?.value || '4',
        graphType: formValues.graphType?.value || 'pie'
      };
      this.updateBifurcationChartData();
    });

    // Initialize the donut charts
    this.toptendistributorForm.valueChanges.subscribe(() => {
      this.updatetopDistributor();
    });

    // Initialize currentFilters with default form values
    this.currentFilters = {
      region: this.bifurcationForm.get('region')?.value?.value || 'all',
      state: this.bifurcationForm.get('state')?.value?.value || 'all',
      productGroup: this.bifurcationForm.get('productGroup')?.value?.value || 'all',
      distributor: this.bifurcationForm.get('distributor')?.value?.value || 'all',
      periodType: this.bifurcationForm.get('periodtype')?.value?.value || '2',
      periodValue: this.bifurcationForm.get('periodvalue')?.value?.value || '4',
      graphType: this.bifurcationForm.get('graphType')?.value?.value || 'pie'
    };

    // Initialize the bifurcation pie chart with default data
    this.updateBifurcationChartData();
    
    // Initialize trends chart data
    this.updateTrendsChartData();
  }

  tableHeaders = [
    { key: 'category', label: '' },
    { key: 'typeOfLeave', label: 'Region' },
    { key: 'description', label: 'State' },
    { key: 'leaveDays', label: 'Product Group' },
    { key: 'isActive', label: 'Distributor' },
  ];

  tableData = [
    {
      category: 'Primary Sales',
      region: '',
      state: '',
      productGroup: '',
      distributor: '',
    },
    {
      category: 'Secondary Sales',
      region: '',
      state: '',
      productGroup: '',
      distributor: '',
    },
    {
      category: 'Distributor Inventory',
      region: '',
      state: '',
      productGroup: '',
      distributor: '',
    },
  ];

  periodTypeOptions = [
    { name: 'Days', value: '1' },
    { name: 'Months', value: '2' },
  ];

  periodValueDayOptions = [
    { name: '30 Days', value: '1' },
    { name: '60 Days', value: '2' },
    { name: '90 Days', value: '3' },
  ];

  periodValueMonthOptions = [
    { name: 'This Month', value: '4' },
    { name: 'Last Month', value: '5' },
    { name: '3 Months', value: '6' },
  ];

  // This is what the UI binds to
  periodValueOptions = [...this.periodValueMonthOptions];

  viewOptions = [
    { name: 'Graph', value: 'graph' },
    { name: 'List', value: 'list' },
  ];

  regionOptions = [
    { name: 'ALL', value: 'all' },
    { name: 'North', value: 'north' },
    { name: 'South', value: 'south' },
    { name: 'East', value: 'east' },
    { name: 'West', value: 'west' },
  ];

  stateOptions = [
    { name: 'ALL', value: 'all' },
    { name: 'Maharashtra', value: 'maharashtra' },
    { name: 'Karnataka', value: 'karnataka' },
    { name: 'Delhi', value: 'delhi' },
    { name: 'Gujarat', value: 'gujarat' },
    { name: 'Tamil Nadu', value: 'tamilnadu' },
    { name: 'Kerala', value: 'kerala' },
    { name: 'Andhra Pradesh', value: 'andhrapradesh' },
    { name: 'Telangana', value: 'telangana' },
    { name: 'Uttar Pradesh', value: 'uttarpradesh' },
    { name: 'Punjab', value: 'punjab' },
    { name: 'Haryana', value: 'haryana' },
    { name: 'Rajasthan', value: 'rajasthan' },
  ];

  productGroupOptions = [
    { name: 'ALL', value: 'all' },
    { name: 'Dairy', value: 'dairy' },
    { name: 'Bakery', value: 'bakery' },
    { name: 'Snacks', value: 'snacks' },
  ];

  distributorOptions = [
    { name: 'ALL', value: 'all' },
    { name: 'Distributor A', value: 'a' },
    { name: 'Distributor B', value: 'b' },
    { name: 'Distributor C', value: 'c' },
  ];

  selectedPeriodType = 'Days';
  selectedPeriodValue = 30;
  selectedView = 'graph';
  selectedRegion = 'North';
  selectedState = 'Maharashtra';
  selectedProductGroup = '';
  selectedDistributor = '';

  // Store individual metric values
  primarySalesValue = 0;
  secondarySalesValue = 0;
  distributorInventoryValue = 0;

  // Add properties to track current filters
  public currentFilters = {
    region: 'all',
    state: 'all',
    productGroup: 'all',
    distributor: 'all',
    periodType: '2',
    periodValue: '4',
    graphType: 'pie'
  };

  // Consolidated Trends Chart Data (instead of separate charts for each metric)
  public trendsBarChartData: ChartConfiguration<'bar'>['data'] = {
    labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
    datasets: [
      {
        label: 'Amount (₹)',
        data: [1250000, 975000, 320000],
        backgroundColor: '#3B82F6',
        borderColor: '#2563EB',
        borderWidth: 1,
        barThickness: 40,
      },
      {
        label: 'Quantity (Kg)',
        data: [3200, 2850, 1250],
        backgroundColor: '#10B981',
        borderColor: '#059669',
        borderWidth: 1,
        barThickness: 40,
      },
    ],
  };

  public trendsBarChartOptions: ChartConfiguration<'bar'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'top',
        labels: {
          font: { size: 14, weight: 'bold' },
          padding: 20,
        },
      },
      tooltip: {
        callbacks: {
          label: (context) => {
            const dataset = context.dataset;
            const value = context.parsed.y;
            return `${dataset.label}: ${value.toLocaleString('en-IN')}`;
          },
        },
      },
    },
    scales: {
      x: {
        grid: { display: false },
        ticks: { font: { weight: 'bold' } },
      },
      y: {
        beginAtZero: true,
        grid: { color: '#e5e7eb' },
        ticks: {
          callback: function(value) {
            return value.toLocaleString('en-IN');
          }
        }
      },
    },
    elements: {
      bar: {
        borderRadius: 8,
      },
    },
  };

  public trendsPieChartData: ChartConfiguration<'pie'>['data'] = {
    labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
    datasets: [
      {
        data: [1250000, 975000, 320000],
        backgroundColor: [
          '#6366F1', // Indigo
          '#22C55E', // Green
          '#F59E0B', // Amber
        ],
        borderColor: [
          '#4F46E5',
          '#16A34A',
          '#D97706',
        ],
        borderWidth: 2,
      },
    ],
  };

  public trendsPieChartOptions: ChartConfiguration<'pie'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          padding: 20,
          usePointStyle: true,
          pointStyle: 'circle',
          font: { size: 14, weight: 'bold' },
        },
      },
      tooltip: {
        callbacks: {
          label: (context) => {
            const label = context.label || '';
            const value = context.parsed;
            const total = context.dataset.data.reduce((a: number, b: number) => a + b, 0);
            const percentage = ((value / total) * 100).toFixed(1);
            return `${label}: ₹${value.toLocaleString('en-IN')} (${percentage}%)`;
          },
        },
      },
    },
  };

  public trendsDonutChartData: ChartConfiguration<'doughnut'>['data'] = {
    labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
    datasets: [
      {
        data: [1250000, 975000, 320000],
        backgroundColor: [
          '#6366F1',
          '#22C55E',
          '#F59E0B',
        ],
        borderColor: '#fff',
        borderWidth: 2,
      },
    ],
  };

  public trendsDonutChartOptions: ChartConfiguration<'doughnut'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          font: { size: 14 },
          padding: 20,
        },
      },
      tooltip: {
        callbacks: {
          label: (context) => {
            const label = context.label || '';
            const value = context.parsed;
            const total = context.dataset.data.reduce((a: number, b: number) => a + b, 0);
            const percentage = ((value / total) * 100).toFixed(1);
            return `${label}: ₹${value.toLocaleString('en-IN')} (${percentage}%)`;
          },
        },
      },
    },
    cutout: '60%',
  };

  public trendsLineChartData: ChartConfiguration<'line'>['data'] = {
    labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
    datasets: [
      {
        label: 'Amount (₹)',
        data: [1250000, 975000, 320000],
        borderColor: '#6366F1',
        backgroundColor: 'rgba(99, 102, 241, 0.2)',
        fill: true,
        tension: 0.4,
        pointBackgroundColor: '#6366F1',
        pointBorderColor: '#fff',
        pointBorderWidth: 2,
        pointRadius: 6,
      },
      {
        label: 'Quantity (Kg)',
        data: [3200, 2850, 1250],
        borderColor: '#10B981',
        backgroundColor: 'rgba(16, 185, 129, 0.2)',
        fill: true,
        tension: 0.4,
        pointBackgroundColor: '#10B981',
        pointBorderColor: '#fff',
        pointBorderWidth: 2,
        pointRadius: 6,
      },
    ],
  };

  public trendsLineChartOptions: ChartConfiguration<'line'>['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'top',
        labels: {
          font: { size: 14, weight: 'bold' },
          padding: 20,
        },
      },
      tooltip: {
        callbacks: {
          label: (context) => {
            const dataset = context.dataset;
            const value = context.parsed.y;
            return `${dataset.label}: ${value.toLocaleString('en-IN')}`;
          },
        },
      },
    },
    scales: {
      x: {
        grid: { display: false },
        ticks: { font: { weight: 'bold' } },
      },
      y: {
        beginAtZero: true,
        grid: { color: '#e5e7eb' },
        ticks: {
          callback: function(value) {
            return value.toLocaleString('en-IN');
          }
        }
      },
    },
  };

  public trendsTableHeaders: Array<{ key: string, label: string }> = [
    { key: 'metric', label: 'Metric' },
    { key: 'amount', label: 'Amount (₹)' },
    { key: 'kg', label: 'Quantity (Kg)' },
  ];
  public trendsTableData: any[] = [];

  updateTrendsChartData() {
    const periodType = this.trendsForm.get('periodtype')?.value?.value;
    const periodValue = this.trendsForm.get('periodvalue')?.value?.value;
    const region = this.trendsForm.get('region')?.value?.value;
    const state = this.trendsForm.get('state')?.value?.value;
    const productGroup = this.trendsForm.get('productGroup')?.value?.value;
    const distributor = this.trendsForm.get('distributor')?.value?.value;

    // Use the same base values and multipliers as updateBifurcationChartData
    let basePrimaryAmount = 1250000;
    let baseSecondaryAmount = 975000;
    let baseDistributorAmount = 320000;
    let basePrimaryKg = 3200;
    let baseSecondaryKg = 2850;
    let baseDistributorKg = 1250;

    // Apply region filtering (only if not "all")
    if (region && region !== 'all') {
      const regionMultiplier = this.getRegionMultiplier(region);
      basePrimaryAmount *= regionMultiplier;
      baseSecondaryAmount *= regionMultiplier;
      baseDistributorAmount *= regionMultiplier;
      basePrimaryKg *= regionMultiplier;
      baseSecondaryKg *= regionMultiplier;
      baseDistributorKg *= regionMultiplier;
    }

    // Apply state filtering (only if not "all" and region is selected)
    if (state && state !== 'all' && region && region !== 'all') {
      const stateMultiplier = this.getStateMultiplier(state);
      basePrimaryAmount *= stateMultiplier;
      baseSecondaryAmount *= stateMultiplier;
      baseDistributorAmount *= stateMultiplier;
      basePrimaryKg *= stateMultiplier;
      baseSecondaryKg *= stateMultiplier;
      baseDistributorKg *= stateMultiplier;
    }

    // Apply product group filtering (only if not "all")
    if (productGroup && productGroup !== 'all') {
      const productMultiplier = this.getProductMultiplier(productGroup);
      basePrimaryAmount *= productMultiplier;
      baseSecondaryAmount *= productMultiplier;
      baseDistributorAmount *= productMultiplier;
      basePrimaryKg *= productMultiplier;
      baseSecondaryKg *= productMultiplier;
      baseDistributorKg *= productMultiplier;
    }

    // Apply distributor filtering (only if not "all")
    if (distributor && distributor !== 'all') {
      const distributorMultiplier = this.getDistributorMultiplier(distributor);
      basePrimaryAmount *= distributorMultiplier;
      baseSecondaryAmount *= distributorMultiplier;
      baseDistributorAmount *= distributorMultiplier;
      basePrimaryKg *= distributorMultiplier;
      baseSecondaryKg *= distributorMultiplier;
      baseDistributorKg *= distributorMultiplier;
    }

    // Apply period filtering
    if (periodType && periodValue) {
      const periodMultiplier = this.getPeriodMultiplier(periodType, periodValue);
      basePrimaryAmount *= periodMultiplier;
      baseSecondaryAmount *= periodMultiplier;
      baseDistributorAmount *= periodMultiplier;
      basePrimaryKg *= periodMultiplier;
      baseSecondaryKg *= periodMultiplier;
      baseDistributorKg *= periodMultiplier;
    }

    // Round the values
    const primaryAmount = Math.round(basePrimaryAmount);
    const secondaryAmount = Math.round(baseSecondaryAmount);
    const distributorAmount = Math.round(baseDistributorAmount);
    const primaryKg = Math.round(basePrimaryKg);
    const secondaryKg = Math.round(baseSecondaryKg);
    const distributorKg = Math.round(baseDistributorKg);

    const amountData = [primaryAmount, secondaryAmount, distributorAmount];
    const kgData = [primaryKg, secondaryKg, distributorKg];

    // Update all chart types with consolidated data
    // Bar Chart
    this.trendsBarChartData = {
      labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
      datasets: [
        {
          label: 'Amount (₹)',
          data: amountData,
          backgroundColor: '#3B82F6',
          borderColor: '#2563EB',
          borderWidth: 1,
          barThickness: 40,
        },
        {
          label: 'Quantity (Kg)',
          data: kgData,
          backgroundColor: '#10B981',
          borderColor: '#059669',
          borderWidth: 1,
          barThickness: 40,
        },
      ],
    };

    // Pie Chart (showing only amounts)
    this.trendsPieChartData = {
      labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
      datasets: [
        {
          data: amountData,
          backgroundColor: ['#6366F1', '#22C55E', '#F59E0B'],
          borderColor: ['#4F46E5', '#16A34A', '#D97706'],
          borderWidth: 2,
        },
      ],
    };

    // Donut Chart (showing only amounts)
    this.trendsDonutChartData = {
      labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
      datasets: [
        {
          data: amountData,
          backgroundColor: ['#6366F1', '#22C55E', '#F59E0B'],
          borderColor: '#fff',
          borderWidth: 2,
        },
      ],
    };

    // Line Chart
    this.trendsLineChartData = {
      labels: ['Primary Sales', 'Secondary Sales', 'Distributor Inventory'],
      datasets: [
        {
          label: 'Amount (₹)',
          data: amountData,
          borderColor: '#6366F1',
          backgroundColor: 'rgba(99, 102, 241, 0.2)',
          fill: true,
          tension: 0.4,
          pointBackgroundColor: '#6366F1',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          pointRadius: 6,
        },
        {
          label: 'Quantity (Kg)',
          data: kgData,
          borderColor: '#10B981',
          backgroundColor: 'rgba(16, 185, 129, 0.2)',
          fill: true,
          tension: 0.4,
          pointBackgroundColor: '#10B981',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          pointRadius: 6,
        },
      ],
    };

    // Table/List view data
    this.trendsTableData = [
      {
        metric: 'Primary Sales',
        amount: primaryAmount.toLocaleString('en-IN'),
        kg: primaryKg.toLocaleString('en-IN'),
      },
      {
        metric: 'Secondary Sales',
        amount: secondaryAmount.toLocaleString('en-IN'),
        kg: secondaryKg.toLocaleString('en-IN'),
      },
      {
        metric: 'Distributor Inventory',
        amount: distributorAmount.toLocaleString('en-IN'),
        kg: distributorKg.toLocaleString('en-IN'),
      },
    ];
  }

  private getRegionMultiplier(region: string): number {
    const multipliers: { [key: string]: number } = {
      north: 1.2,
      south: 1.1,
      east: 0.9,
      west: 1.3,
    };
    return multipliers[region] || 1;
  }

  private getStateMultiplier(state: string): number {
    const multipliers: { [key: string]: number } = {
      maharashtra: 1.4,
      karnataka: 1.2,
      delhi: 1.1,
      gujarat: 1.3,
      tamilnadu: 1.1,
      kerala: 0.9,
      andhrapradesh: 1.0,
      telangana: 1.2,
      uttarpradesh: 1.5,
      punjab: 1.1,
      haryana: 1.0,
      rajasthan: 1.2,
    };
    return multipliers[state] || 1;
  }

  private getProductMultiplier(productGroup: string): number {
    const multipliers: { [key: string]: number } = {
      dairy: 1.5,
      bakery: 1.2,
      snacks: 0.8,
    };
    return multipliers[productGroup] || 1;
  }

  private getDistributorMultiplier(distributor: string): number {
    const multipliers: { [key: string]: number } = {
      a: 1.3,
      b: 1.1,
      c: 0.9,
    };
    return multipliers[distributor] || 1;
  }

  private getPeriodMultiplier(periodType: string, periodValue: string): number {
    if (periodType === '1') {
      // Days
      const dayMultipliers: { [key: string]: number } = {
        '1': 1.0, // 30 Days
        '2': 1.5, // 60 Days
        '3': 2.0, // 90 Days
      };
      return dayMultipliers[periodValue] || 1;
    } else if (periodType === '2') {
      // Months
      const monthMultipliers: { [key: string]: number } = {
        '4': 1.2, // This Month
        '5': 1.0, // Last Month
        '6': 2.5, // 3 Months
      };
      return monthMultipliers[periodValue] || 1;
    }
    return 1;
  }

  onPeriodTypeChange(formType: 'trends' | 'overall' | 'bifurcation' | 'top10') {
    let form: FormGroup;
    if (formType === 'bifurcation') {
      form = this.bifurcationForm;
    } else if (formType === 'trends') {
      form = this.trendsForm;
    } else if (formType === 'top10') {
      form = this.toptendistributorForm;
    } else {
      form = this.formgroup;
    }
    const periodType = form.get('periodtype')?.value?.value;
    if (periodType === '1') {
      // Days selected
      form.get('periodvalue')?.setValue({ name: '30 Days', value: '1' });
    } else {
      // Months selected
      form.get('periodvalue')?.setValue({ name: 'This Month', value: '4' });
    }
    if (formType === 'bifurcation') this.updateBifurcationChartData();
    if (formType === 'trends') {
      form.get('graphType')?.setValue({ name: 'Bar Chart', value: 'bar' });
      this.updateTrendsChartData();
    }
    if (formType === 'top10') this.updatetopDistributor();
  }

  onClear() {
    this.trendsForm.reset({
      periodtype: { name: 'Months', value: '2' },
      periodvalue: { name: 'This Month', value: '4' },
      region: { name: 'ALL', value: 'all' },
      state: { name: 'ALL', value: 'all' },
      productGroup: { name: 'ALL', value: 'all' },
      distributor: { name: 'ALL', value: 'all' },
      view: { name: 'Graph', value: 'graph' },
      graphType: { name: 'Bar Chart', value: 'bar' },
    });
    this.updateTrendsChartData();
  }

  // Placeholder methods for other functionality
  updateBifurcationChartData() {
    // Implementation for bifurcation charts
  }

  updatetopDistributor() {
    // Implementation for top distributor charts
  }
}