"""
ATM Transaction Analytics
SQL + Python + Power BI portfolio project.

Run:
    pip install -r requirements.txt
    python atm_analysis.py
"""
from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "atm_transactions.csv"
OUT = ROOT / "images"
OUT.mkdir(exist_ok=True)

df = pd.read_csv(DATA, parse_dates=["timestamp"])
df["date"] = df["timestamp"].dt.date
df["hour"] = df["timestamp"].dt.hour
df["day_of_week"] = df["timestamp"].dt.day_name()

# ---------------------------
# KPI layer
# ---------------------------
total = len(df)
approved = (df["status"] == "Aprobada").sum()
rejected = (df["status"] == "Rechazada").sum()
rejection_rate = rejected / total
withdrawals = df[(df["transaction_type"] == "Retiro") & (df["status"] == "Aprobada")]
withdrawal_hnl = withdrawals["amount_hnl"].sum()
avg_latency = df["latency_sec"].mean()

print("\n=== ATM NETWORK KPIs ===")
print(f"Transactions       : {total:,}")
print(f"Approved           : {approved:,}")
print(f"Rejected           : {rejected:,}")
print(f"Rejection rate     : {rejection_rate:.2%}")
print(f"Approved withdrawals: HNL {withdrawal_hnl:,.2f}")
print(f"Average latency    : {avg_latency:.2f} sec")

# ---------------------------
# Time analysis
# ---------------------------
hourly = df.groupby("hour").size()
daily = df.groupby("date").size()
daily_withdrawals = withdrawals.groupby("date")["amount_hnl"].sum()

# ---------------------------
# ATM risk table
# ---------------------------
atm = df.groupby(["atm_id", "city"]).agg(
    transactions=("transaction_id", "count"),
    rejection_rate=("status", lambda x: (x == "Rechazada").mean()),
    avg_latency=("latency_sec", "mean"),
    withdrawal_hnl=("amount_hnl", "sum")
).reset_index()

atm["rejection_rate_pct"] = atm["rejection_rate"] * 100
atm["risk_score"] = (
    atm["rejection_rate_pct"].rank(pct=True) +
    atm["avg_latency"].rank(pct=True)
) / 2

print("\n=== TOP 10 ATM OPERATIONAL RISK ===")
print(
    atm.sort_values("risk_score", ascending=False)
       .head(10)[["atm_id","city","transactions",
                  "rejection_rate_pct","avg_latency","risk_score"]]
       .round(2)
       .to_string(index=False)
)

# ---------------------------
# Figures
# ---------------------------
plt.figure(figsize=(10, 4))
daily.plot(linewidth=1)
plt.title("Daily ATM transaction activity")
plt.xlabel("Date")
plt.ylabel("Transactions")
plt.grid(alpha=0.18)
plt.tight_layout()
plt.savefig(OUT / "python_daily_transactions.png", dpi=180)
plt.close()

plt.figure(figsize=(9, 4))
hourly.plot(kind="bar")
plt.title("Transaction demand by hour")
plt.xlabel("Hour of day")
plt.ylabel("Transactions")
plt.tight_layout()
plt.savefig(OUT / "python_hourly_demand.png", dpi=180)
plt.close()

plt.figure(figsize=(9, 4))
plt.scatter(atm["avg_latency"], atm["rejection_rate_pct"],
            s=np.clip(atm["transactions"] / 4, 10, 100), alpha=0.65)
plt.title("ATM operational risk")
plt.xlabel("Average latency (sec)")
plt.ylabel("Rejection rate (%)")
plt.grid(alpha=0.18)
plt.tight_layout()
plt.savefig(OUT / "python_atm_risk.png", dpi=180)
plt.close()

# ---------------------------
# Optional forecasting layer
# ---------------------------
try:
    from statsmodels.tsa.holtwinters import ExponentialSmoothing

    ts = daily_withdrawals.copy()
    ts.index = pd.to_datetime(ts.index)
    ts = ts.asfreq("D").fillna(0)

    model = ExponentialSmoothing(
        ts,
        trend="add",
        seasonal=None,
        initialization_method="estimated"
    ).fit()

    forecast = model.forecast(14)

    plt.figure(figsize=(10, 4))
    plt.plot(ts.index, ts.values, label="Observed")
    plt.plot(forecast.index, forecast.values, marker="o", label="14-day forecast")
    plt.title("Approved withdrawal volume forecast")
    plt.xlabel("Date")
    plt.ylabel("HNL")
    plt.legend()
    plt.grid(alpha=0.18)
    plt.tight_layout()
    plt.savefig(OUT / "python_14day_forecast.png", dpi=180)
    plt.close()

    print("\nForecast generated: 14 days.")
except ImportError:
    print("\nOptional forecast skipped. Install statsmodels to enable it.")
