USE ATM_Analytics;
GO

-- Recommended for local portfolio use:
-- 1. Open SQL Server Management Studio (SSMS).
-- 2. Right-click database ATM_Analytics.
-- 3. Tasks > Import Flat File.
-- 4. Select data/atm_transactions.csv.
-- 5. Load into dbo.ATM_Transactions.
--
-- BULK INSERT is also possible, but the SQL Server service must have
-- access to the file path on your machine. Example:
--
-- BULK INSERT dbo.ATM_Transactions
-- FROM 'C:\path\to\atm_transactions.csv'
-- WITH (
--     FORMAT='CSV',
--     FIRSTROW=2,
--     FIELDQUOTE='"',
--     TABLOCK
-- );
