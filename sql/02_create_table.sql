USE ATM_Analytics;
GO

CREATE TABLE dbo.ATM_Transactions (
    transaction_id BIGINT PRIMARY KEY,
    timestamp DATETIME2 NOT NULL,
    atm_id VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL,
    amount_hnl DECIMAL(14,2) NOT NULL,
    latency_sec DECIMAL(8,2) NOT NULL,
    balance_before_hnl DECIMAL(14,2) NOT NULL,
    balance_after_hnl DECIMAL(14,2) NOT NULL
);
GO
