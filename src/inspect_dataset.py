# ==========================================
# INDUSTRIAL PREDICTIVE MAINTENANCE PROJECT
# Lesson: Understanding our dataset
# ==========================================

import pandas as pd

# 1. Load the dataset
file_path = "data/raw/ai4i2020.csv"

df = pd.read_csv(file_path)

# 2. Display dataset dimensions
print("\n--- DATASET DIMENSIONS ---")
print("Rows:", df.shape[0])
print("Columns:", df.shape[1])

# 3. Display column names
print("\n--- COLUMN NAMES ---")
print(df.columns.tolist())

# 4. Display first five records
print("\n--- FIRST FIVE RECORDS ---")
print(df.head())

# 5. Display dataset information
print("\n--- DATASET INFORMATION ---")
df.info()

# 6. Check missing values
print("\n--- MISSING VALUES ---")
print(df.isnull().sum())

# 7. Check machine failure distribution
print("\n--- MACHINE FAILURE DISTRIBUTION ---")
print(df["Machine failure"].value_counts())

print("\n--- DATASET INSPECTION COMPLETED ---")





# Additional dataset verification

print("\n--- COMPLETE DATASET SUMMARY ---")

print("Dataset shape:", df.shape)

print("\nMissing values across all columns:")
print(df.isnull().sum().to_string())

print("\nTotal missing values:")
print(df.isnull().sum().sum())

print("\nFailure percentages:")
print(
    df["Machine failure"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)