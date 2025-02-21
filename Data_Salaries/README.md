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

## 📊 Key Insights

### **From the Cleaned Data:**

✔ **Salaries have increased over the years.**  
✔ **Executive-level roles earn the highest average salaries.**  
✔ **Part-time and full-time employees receive the highest salaries.**  
✔ **Medium and large companies offer the highest salaries, but small companies are not far behind.**  
✔ **Remote and in-site jobs have the highest average salaries.**  
✔ **Companies exist across multiple countries, but Russia has the highest average salary.**  
✔ **Principal Data Engineer is the highest-paying job title.**

### **From the Outliers Data:**

✔ **Most outliers are remote employees.**  
✔ **Large companies employ the majority of high-salary outliers.**  
✔ **Full-time contracts dominate among high-salary employees.**  
✔ **Unlike the cleaned dataset, there are no executive-level employees in the outliers.**  
✔ **Only full-time and part-time jobs appear in the outliers.**  
✔ **All outlier companies are based in the USA.**  
✔ **Outlier salaries show a sudden increase in 2021, followed by a decline in 2022.**  
✔ **Principal Data Engineer is the highest-paying job title among outliers.**

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]
