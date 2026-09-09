# ATM Transaction Analytics — SQL + Python + Power BI

> End-to-end analytics portfolio project focused on ATM transaction behavior, operational performance and cash-demand forecasting.

![Python](https://img.shields.io/badge/Python-3.x-blue)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-red)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Status](https://img.shields.io/badge/Project-Portfolio-success)

## Executive Summary

This project analyzes a synthetic network of **30 ATMs and 12,000 transactions** over January–June 2025.

The workflow combines:

**SQL Server → Python → Power BI → Forecasting**

The goal is to transform raw ATM transactions into operational indicators that can support decisions related to demand, cash logistics, maintenance and service quality. The synthetic generator uses a realistic intraday demand profile with stronger activity during morning and evening commuting/retail periods; this is a modeling assumption, not an empirical claim about a real bank.

### Main KPIs

- **12,000** transactions
- **4.64%** rejection rate
- **HNL 8.26M** in approved withdrawals
- **7.75 sec** average transaction latency

> The dataset is synthetic. Results are a portfolio demonstration and not evidence about a real ATM network.

## Business Questions

- What are the peak transaction hours?
- Which cities generate the highest withdrawal volume?
- Which ATMs have the highest rejection rate?
- Which ATMs have the highest latency?
- Which ATMs should receive operational attention?
- Can daily cash demand be forecast?

## Technology Stack

| Tool | Role |
|---|---|
| SQL Server | Database, aggregation, KPIs, operational queries |
| Python | EDA, statistical analysis, risk scoring, forecasting |
| Power BI | Interactive executive dashboard |
| Git/GitHub | Version control and portfolio presentation |

## Project Architecture

```text
                 ┌─────────────────────┐
                 │  ATM Transactions   │
                 │    CSV / raw data   │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │     SQL Server      │
                 │ ETL / KPIs / SQL   │
                 └──────────┬──────────┘
                            │
                ┌───────────┴───────────┐
                ▼                       ▼
       ┌─────────────────┐      ┌─────────────────┐
       │      Python     │      │     Power BI    │
       │ EDA / forecasting│      │ Executive report│
       └─────────────────┘      └─────────────────┘
```

## Repository Structure

```text
ATM_Analytics_GitHub/
│
├── data/
│   ├── atm_transactions.csv
│   └── DATA_DICTIONARY.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_table.sql
│   ├── 03_load_data.sql
│   └── 04_analysis_queries.sql
│
├── python/
│   ├── atm_analysis.py
│   └── requirements.txt
│
├── powerbi/
│   └── README.md
│
├── images/
│   ├── fig1.png
│   ├── fig2.png
│   ├── fig3.png
│   ├── fig4.png
│   └── fig5.png
│
├── report/
│   └── ATM_Analytics_Report.pdf
│
├── .gitignore
├── LICENSE
└── README.md
```

## 1. SQL Server

Run the scripts in this order:

```text
01_create_database.sql
02_create_table.sql
03_load_data.sql
04_analysis_queries.sql
```

For the CSV, the easiest local method is SSMS:

**Database → Tasks → Import Flat File → `atm_transactions.csv`**

The analytical SQL calculates:
- total transactions;
- approval/rejection rate;
- withdrawal volume;
- hourly demand;
- city-level cash volume;
- ATM rejection rate;
- ATM latency;
- operational priority ranking.

## 2. Python

Create an environment and install dependencies:

```bash
pip install -r python/requirements.txt
```

Run:

```bash
python python/atm_analysis.py
```

Python generates:
- daily transaction activity;
- hourly demand;
- ATM operational-risk scatter plot;
- optional 14-day withdrawal forecast using exponential smoothing.

## 3. Power BI

Open Power BI Desktop and import the SQL Server table:

```text
ATM_Analytics → dbo.ATM_Transactions
```

Build the dashboard according to:

`powerbi/README.md`

Recommended dashboard pages:

### Executive Overview
- KPI cards
- withdrawal trend
- hourly demand
- city volume
- ATM rejection ranking

### Operational Monitoring
- demand heatmap
- rejection vs latency scatter
- ATM ranking
- operational priority table

## 4. Forecasting

The Python layer includes an optional forecasting component using exponential smoothing.

The purpose is to estimate future approved withdrawal volume and demonstrate how transaction history can become an input to **cash replenishment planning**.

In a production environment, candidate models could include:

- Exponential Smoothing
- SARIMA
- Bayesian time-series models
- Gradient boosting with calendar/operational features

Models should be evaluated using a chronological holdout and metrics such as:

- MAE
- RMSE
- MAPE

## Key Analytical Insight

The most useful operational signal is not a single KPI. Combining:

**transaction volume + rejection rate + latency**

allows the analyst to distinguish between:
- high-demand but healthy ATMs;
- low-demand ATMs;
- machines with unusually high rejection;
- machines with both service degradation and high usage.

This is the type of analysis that can support operational prioritization.

## Portfolio Report

A compact PDF report is included in:

`report/ATM_Analytics_Report.pdf`

It follows a research-report structure with:
- executive summary;
- data/objective;
- demand analysis;
- geographic analysis;
- operational risk;
- forecasting layer;
- technology workflow;
- conclusions.

## Skills Demonstrated

**SQL**
- relational data modeling
- aggregation
- conditional logic
- GROUP BY
- ranking
- operational KPIs

**Python**
- pandas
- NumPy
- matplotlib
- time-series aggregation
- risk scoring
- forecasting

**Power BI**
- dashboard design
- KPI cards
- DAX measures
- filtering
- operational visualization

**Data Analytics**
- exploratory analysis
- business-question formulation
- performance monitoring
- predictive analytics

## Resume Description

> **ATM Transaction Analytics — SQL, Python & Power BI:** Developed an end-to-end analytics solution for 12,000 synthetic ATM transactions, using SQL Server for KPI extraction and operational analysis, Python for exploratory analysis and cash-demand forecasting, and Power BI for executive dashboards. Evaluated transaction demand, withdrawal volume, rejection rates and latency to identify operational priorities.

## Author

**Carlos Eduardo Romero Figueroa**  
PhD Researcher in Physics | Data Science | Bayesian Statistics | Predictive Modeling

