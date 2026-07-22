
CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date TEXT NOT NULL,
    year INTEGER,
    month INTEGER,
    month_name TEXT,
    day_name TEXT,
    is_weekend INTEGER,
    quarter INTEGER,
    week_of_year INTEGER
);

CREATE TABLE dim_geography (
    sender_state_key INTEGER PRIMARY KEY,
    sender_state TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_merchant_category (
    merchant_category_key INTEGER PRIMARY KEY,
    merchant_category TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_transaction_type (
    transaction_type_key INTEGER PRIMARY KEY,
    transaction_type TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_device (
    device_type_key INTEGER PRIMARY KEY,
    device_type TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_network (
    network_type_key INTEGER PRIMARY KEY,
    network_type TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_age_group (
    age_group_key INTEGER PRIMARY KEY,
    age_group TEXT NOT NULL UNIQUE
);

CREATE TABLE fact_transactions (
    transaction_key INTEGER PRIMARY KEY,
    transaction_id TEXT NOT NULL UNIQUE,
    date_key INTEGER NOT NULL,
    hour_of_day INTEGER,
    sender_state_key INTEGER,
    merchant_category_key INTEGER,
    transaction_type_key INTEGER,
    device_type_key INTEGER,
    network_type_key INTEGER,
    age_group_key INTEGER,
    amount_inr NUMERIC NOT NULL,
    transaction_status TEXT NOT NULL,
    fraud_flag INTEGER NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (sender_state_key) REFERENCES dim_geography(sender_state_key),
    FOREIGN KEY (merchant_category_key) REFERENCES dim_merchant_category(merchant_category_key),
    FOREIGN KEY (transaction_type_key) REFERENCES dim_transaction_type(transaction_type_key),
    FOREIGN KEY (device_type_key) REFERENCES dim_device(device_type_key),
    FOREIGN KEY (network_type_key) REFERENCES dim_network(network_type_key),
    FOREIGN KEY (age_group_key) REFERENCES dim_age_group(age_group_key)
);

CREATE INDEX idx_fact_date ON fact_transactions(date_key);
CREATE INDEX idx_fact_state ON fact_transactions(sender_state_key);
CREATE INDEX idx_fact_status ON fact_transactions(transaction_status);
CREATE INDEX idx_fact_fraud ON fact_transactions(fraud_flag);
