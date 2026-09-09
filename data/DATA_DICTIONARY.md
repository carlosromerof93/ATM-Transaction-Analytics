# Data Dictionary

| Column | Type | Description |
|---|---|---|
| transaction_id | integer | Unique transaction identifier |
| timestamp | datetime | Transaction date and time |
| atm_id | string | ATM identifier |
| city | string | City where the ATM is located |
| branch | string | Branch/location label |
| transaction_type | string | Retiro, Consulta, Depósito or Transferencia |
| status | string | Aprobada or Rechazada |
| amount_hnl | decimal | Transaction amount in Honduran lempiras |
| latency_sec | decimal | Processing latency in seconds |
| balance_before_hnl | decimal | ATM cash balance before transaction |
| balance_after_hnl | decimal | ATM cash balance after transaction |

The dataset is synthetic and intended for portfolio/learning purposes.
