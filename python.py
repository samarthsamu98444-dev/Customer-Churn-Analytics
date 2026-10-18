import pandas as pd 
import numpy as np 
import sqlite3
df=pd.read_csv(r"C:\Users\samar\OneDrive\Desktop\Telco-Customer-Churn.csv")
conn=sqlite3.connect('churn.db')
df.to_sql('churn', conn, if_exists='replace', index=False)


print(df.head(6))
print(df.shape)
df=df.fillna('unknown' )
print(df.isnull().sum())
print(df.describe())

print(df.isnull().sum())


print(df['Churn'].value_counts(dropna=False))