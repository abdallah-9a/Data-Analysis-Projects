# Data Science Job Salaries Analysis

## Description

This project explores a dataset containing information about data science job salaries and related details. The goal is to uncover trends in the field of data through comprehensive analysis.

## Project Overview

- Analyze salary distributions across different job titles, locations, and experience levels.
- Identify trends and insights in the data science job market.
- Visualize patterns to better understand salary dynamics in the field.

## Technologies Used

- **Programming Language:** Python
- **Libraries:** pandas, numpy, matplotlib, seaborn

## 🛠️ Data Cleaning Steps

To ensure data consistency and accuracy, the following cleaning tasks were performed:

**Column Renaming & Dropping:**

- Renamed columns for clarity (`id`, `salary`, `work_type`).
- Dropped redundant columns (`salary` and `salary_currency`).

**Standardizing Remote Ratio:**

- Mapped remote ratio values to categories: In-Site, Hybrid, and Remote.

**Outlier Handling:**

- Identified salary outliers using the IQR method.
- Separated data into two sets:
  - `cleaned_ds` – Dataset without salary outliers, suitable for analyzing general salary trends without extreme values skewing the insights.
  - `outliers` – Dataset containing the salary outliers, preserved to investigate rare but significant cases in the data science job market.

**Quality Checks:**

- Verified no missing or duplicate values.

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]
