import pandas as pd
df = pd.read_csv("./data/raw/upi_transactions_2024.csv")
print(df.shape)
print(df.head())
print(df.dtypes)

print(df['fraud_flag'].value_counts())
print(df['transaction_status'].value_counts())
print(df['sender_state'].nunique(), df['sender_state'].unique())