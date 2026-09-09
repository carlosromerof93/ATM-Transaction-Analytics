USE ATM_Analytics;
GO

-- KPI 1: Network overview
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status='Aprobada' THEN 1 ELSE 0 END) AS approved_transactions,
    SUM(CASE WHEN status='Rechazada' THEN 1 ELSE 0 END) AS rejected_transactions,
    CAST(100.0 * SUM(CASE WHEN status='Rechazada' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(6,2)) AS rejection_rate_pct,
    CAST(SUM(CASE WHEN transaction_type='Retiro' AND status='Aprobada'
                  THEN amount_hnl ELSE 0 END) AS DECIMAL(14,2)) AS total_withdrawal_hnl,
    CAST(AVG(latency_sec) AS DECIMAL(8,2)) AS avg_latency_sec
FROM dbo.ATM_Transactions;

-- KPI 2: Demand by hour
SELECT
    DATEPART(HOUR, timestamp) AS hour_of_day,
    COUNT(*) AS transactions
FROM dbo.ATM_Transactions
GROUP BY DATEPART(HOUR, timestamp)
ORDER BY hour_of_day;

-- KPI 3: Approved withdrawal volume by city
SELECT
    city,
    COUNT(*) AS withdrawals,
    CAST(SUM(amount_hnl) AS DECIMAL(14,2)) AS withdrawal_hnl,
    CAST(AVG(amount_hnl) AS DECIMAL(12,2)) AS avg_withdrawal_hnl
FROM dbo.ATM_Transactions
WHERE transaction_type='Retiro' AND status='Aprobada'
GROUP BY city
ORDER BY withdrawal_hnl DESC;

-- KPI 4: ATM operational performance
SELECT
    atm_id,
    city,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status='Rechazada' THEN 1 ELSE 0 END) AS rejected_transactions,
    CAST(100.0 * SUM(CASE WHEN status='Rechazada' THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(6,2)) AS rejection_rate_pct,
    CAST(AVG(latency_sec) AS DECIMAL(8,2)) AS avg_latency_sec
FROM dbo.ATM_Transactions
GROUP BY atm_id, city
HAVING COUNT(*) >= 100
ORDER BY rejection_rate_pct DESC, avg_latency_sec DESC;

-- KPI 5: Daily withdrawal series
SELECT
    CAST(timestamp AS DATE) AS transaction_date,
    COUNT(*) AS withdrawals,
    CAST(SUM(amount_hnl) AS DECIMAL(14,2)) AS withdrawal_hnl
FROM dbo.ATM_Transactions
WHERE transaction_type='Retiro' AND status='Aprobada'
GROUP BY CAST(timestamp AS DATE)
ORDER BY transaction_date;

-- KPI 6: Top 10 ATMs by cash volume
SELECT TOP 10
    atm_id,
    city,
    COUNT(*) AS withdrawals,
    CAST(SUM(amount_hnl) AS DECIMAL(14,2)) AS withdrawal_hnl
FROM dbo.ATM_Transactions
WHERE transaction_type='Retiro' AND status='Aprobada'
GROUP BY atm_id, city
ORDER BY withdrawal_hnl DESC;

-- KPI 7: Priority list for operational review
SELECT
    atm_id,
    city,
    COUNT(*) AS transactions,
    CAST(100.0 * SUM(CASE WHEN status='Rechazada' THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(6,2)) AS rejection_rate_pct,
    CAST(AVG(latency_sec) AS DECIMAL(8,2)) AS avg_latency_sec
FROM dbo.ATM_Transactions
GROUP BY atm_id, city
HAVING COUNT(*) >= 100
ORDER BY rejection_rate_pct DESC, avg_latency_sec DESC;
