# Sales Dashboard - ng2-charts Bar Chart

A comprehensive Angular application displaying sales data for top 10 distributors using ng2-charts with Chart.js.

## Features

- **Interactive Bar Charts**: Two separate charts for sales volume (Kg) and sales amount (₹)
- **Comprehensive Data Display**: Shows both primary and secondary sales data
- **Responsive Design**: Mobile-friendly layout that adapts to different screen sizes
- **Data Summary Table**: Detailed tabular view of all sales data
- **Key Metrics**: Total calculations for all sales categories
- **Modern UI**: Beautiful gradient backgrounds and hover effects

## Data Metrics

The dashboard displays the following metrics for the top 10 distributors:

1. **Secondary Sales Kg** - Weight-based secondary sales data
2. **Primary Sales Kg** - Weight-based primary sales data  
3. **Secondary Sales Amount (₹)** - Revenue from secondary sales
4. **Primary Sales Amount (₹)** - Revenue from primary sales

## Sample Data

The application includes realistic sample data for 10 distributors:

- Metro Distribution Co.
- Global Supply Chain Ltd.
- Regional Sales Partners
- Prime Distributors Inc.
- Alliance Trading Corp.
- Elite Distribution Network
- Supreme Sales Solutions
- Universal Trading Co.
- Premium Distribution Hub
- Strategic Sales Partners

## Installation

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start the development server:**
   ```bash
   npm start
   ```

3. **Open your browser and navigate to:**
   ```
   http://localhost:4200
   ```

## Dependencies

- **Angular 17+** - Framework
- **ng2-charts 5.0.4** - Chart library wrapper
- **Chart.js 4.4.0** - Core charting library
- **TypeScript** - Language support

## Project Structure

```
src/
├── app/
│   ├── sales-chart.component.ts    # Main chart component logic
│   ├── sales-chart.component.html  # Chart template
│   ├── sales-chart.component.css   # Chart styles
│   ├── app.component.ts            # Root component
│   └── app.module.ts               # App module configuration
├── index.html                      # Main HTML file
├── main.ts                         # Bootstrap file
└── styles.css                      # Global styles
```

## Chart Configuration

The charts are configured with:

- **Responsive design** - Automatically adapts to container size
- **Interactive tooltips** - Hover effects with formatted data
- **Legend display** - Color-coded data series identification
- **Custom color schemes** - Distinct colors for each data series
- **Rotated labels** - 45-degree angle for better readability

## Customization

### Adding New Data

To update the chart data, modify the `salesData` object in `sales-chart.component.ts`:

```typescript
salesData = {
  secondarySalesKg: [/* your data */],
  primarySalesKg: [/* your data */],
  secondarySalesAmount: [/* your data */],
  primarySalesAmount: [/* your data */]
};
```

### Styling

Customize the appearance by modifying:
- `sales-chart.component.css` - Component-specific styles
- `src/styles.css` - Global styles

### Chart Options

Modify chart behavior in the `barChartOptions` and `barChartOptionsAmount` objects in the component.

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## License

MIT License