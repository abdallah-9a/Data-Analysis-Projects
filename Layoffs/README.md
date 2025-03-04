# 🏢 Layoffs Data Cleaning (SQL)  

## 📌 Project Overview  
This project focuses on cleaning and preparing a dataset containing company layoffs data. The goal is to **remove inconsistencies, standardize formats, and handle missing values** to ensure high-quality data for further analysis.  

---

## 🛠️ Data Cleaning Steps  
The following cleaning operations were performed:  

### ✅ **1. Remove Duplicates**  
- Created a backup table to **preserve raw data**.  
- Identified duplicates using **window functions (ROW_NUMBER)**.  
- Removed duplicate rows to ensure data integrity.  

### ✅ **2. Standardizing Data**  
- **Trimmed whitespace** from company names.  
- **Normalized industry and country names** to maintain consistency.  
- **Converted date format** to standard SQL `DATE` type.  

### ✅ **3. Handling NULL & Blank Values**  
- Replaced missing values in **Industry** by filling from other matching records.  
- Removed rows where both `total_laid_off` and `percentage_laid_off` were NULL.  

### ✅ **4. Removing Unwanted Columns**  
- Dropped the `row_num` column (used for duplicate removal).  

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