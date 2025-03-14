# 🏆 Club Member Data Cleaning (SQL)

## 📌 Project Overview

This project focuses on **cleaning and standardizing** a dataset containing club member information. The goal is to **remove inconsistencies, handle missing values, and optimize data formatting** for better accuracy and usability.

---

## 🛠️ Data Cleaning Steps

✅ **1. Cleaning Member Names**

- Trimmed whitespace and **standardized names to lowercase**.
- Removed special characters from `full_name`.
- Separated `full_name` into **first name and last name** for better structure.

✅ **2. Fixing Age Entry Errors**

- Identified incorrect values where **ages exceeded 99**.
- Fixed entries by **removing duplicate digits** in age values.

✅ **3. Splitting Address Data**

- Separated `full_address` into **street, city, and state** for better usability.

✅ **4. Handling Missing & Blank Values**

- Converted blank values in `martial_status`, `phone`, and `job_title` columns to **NULL**.

✅ **5. Fixing Membership Date Errors**

- Corrected **incorrect year formatting (1900s → 2000s)** in `membership_date`.

✅ **6. Removing Duplicates**

- Used **window functions (ROW_NUMBER)** to detect and remove duplicate records.

✅ **7. Dropping Unnecessary Columns**

- Removed `full_name` and `full_address` as they were **split into multiple columns**.

---

## 🛠️ Technologies Used

- **SQL (MySQL / PostgreSQL / SQL Server)**
- **String Functions** for text formatting
- **Date Functions** for membership date corrections
- **Window Functions (ROW_NUMBER)** for duplicate handling

---

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]
