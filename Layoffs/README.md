# 🏢 Layoffs Data Cleaning (SQL)  

## 📌 Project Overview  
This project focuses on cleaning and preparing a dataset containing company layoffs data. The goal is to **remove inconsistencies, standardize formats, and handle missing values** to ensure high-quality data for further analysis.  

---

## 🛠️ Data Cleaning Steps  
✅ **1. Remove Duplicates**  
- Used **window functions (ROW_NUMBER)** to detect and remove duplicate rows.  
- Added an **ID column** for efficient duplicate removal.  

✅ **2. Standardize Data**  
- Trimmed whitespace and corrected formatting in **company, industry, and country** columns.  
- Converted **date format** to SQL `DATE` type.  

✅ **3. Handle NULL & Blank Values**  
- Replaced blanks with **NULL values** for consistency.  
- Filled missing industry values using existing company data.  

✅ **4. Remove Unwanted Data**  
- Deleted rows where **layoff numbers were completely missing**.   

---

## 🛠️ Technologies Used  
- **SQL (MySQL / PostgreSQL / SQL Server)**  
- **Window Functions** for duplicate handling  
- **String Functions** for standardization  

---

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]