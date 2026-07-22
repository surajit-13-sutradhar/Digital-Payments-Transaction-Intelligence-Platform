import pandas as pd
df = pd.read_csv("./data/raw/upi_transactions_2024.csv")
print(df.shape)
print(df.head())
print(df.dtypes)

df = df.rename(columns={
    "transaction id": "transaction_id",
    "amount (INR)": "amount_inr"
})
df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")
print(df.columns.tolist())

