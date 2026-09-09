# Power BI Dashboard Specification

The `.pbix` file is intentionally not included because Power BI Desktop creates it locally. This specification defines the exact dashboard to build.

## Page 1 — Executive Overview

### KPI Cards
- Total Transactions
- Approved Transactions
- Rejection Rate %
- Total Approved Withdrawals (HNL)
- Average Latency (sec)

### Visuals
- Line chart: approved withdrawal HNL by date
- Column chart: transactions by hour
- Bar chart: approved withdrawal HNL by city
- Bar chart: rejection rate by ATM
- Table: ATM, city, transactions, rejection rate, average latency

### Slicers
- Date
- City
- Branch
- ATM
- Transaction Type
- Status

## Page 2 — Operational Monitoring

- Heatmap: day of week × hour
- Scatter plot: rejection rate vs average latency
- Ranking: ATMs by withdrawal volume
- Table: operational priority list

## DAX Measures

```DAX
Total Transactions = COUNTROWS(ATM_Transactions)

Approved Transactions =
CALCULATE(
    [Total Transactions],
    ATM_Transactions[status] = "Aprobada"
)

Rejected Transactions =
CALCULATE(
    [Total Transactions],
    ATM_Transactions[status] = "Rechazada"
)

Rejection Rate =
DIVIDE([Rejected Transactions], [Total Transactions])

Total Withdrawals HNL =
CALCULATE(
    SUM(ATM_Transactions[amount_hnl]),
    ATM_Transactions[transaction_type] = "Retiro",
    ATM_Transactions[status] = "Aprobada"
)

Average Latency =
AVERAGE(ATM_Transactions[latency_sec])
```

## Business objective

The dashboard should help an operations team answer:
1. When is ATM demand highest?
2. Which cities/branches handle the most cash?
3. Which ATMs have unusually high rejection rates?
4. Which ATMs combine high rejection and latency?
5. Where should maintenance/cash logistics be prioritized?
