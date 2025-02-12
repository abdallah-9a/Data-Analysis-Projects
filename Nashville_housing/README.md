# 📌 Nashville Housing Data Cleaning Project

## 📄 Project Description

This project focuses on cleaning a Nashville housing dataset using SQL. The goal is to standardize and preprocess the data, ensuring accuracy and consistency for further analysis.

---

## 🛠️ Tools & Technologies

- **SQL (MySQL / PostgreSQL / SQL Server)**
- **Database Management System (DBMS)**

---

## ⚙️ Data Cleaning Steps

### 1️⃣ Splitting Address Columns

- **Property Address** → Separated into `property_address` and `property_city`.
- **Owner Address** → Separated into `owner_address`, `owner_city`, and `owner_state`.

### 2️⃣ Standardizing Categorical Data

- Converted `sold_as_vacant`:
  - `'Y' → 'Yes'`
  - `'N' → 'No'`

### 3️⃣ Handling Duplicates

- Identified and removed duplicate rows based on `parcel_id`, `land_use`, `sale_date`, `sale_price`, and `legal_reference`.

### 4️⃣ Dropping Unnecessary Columns

- Removed original **`property_address`** and **`owner_address`** columns after extracting relevant details.

### 5️⃣ Renaming Columns

- `owner_address1` → `owner_address`
- `property_street` → `property_address`

---
