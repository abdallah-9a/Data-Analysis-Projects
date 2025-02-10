# Superstore Sales and Profit Analysis Project 📊

## 📄 Project Description

This project analyzes sales, profit, and discount patterns from the Superstore dataset. It focuses on data cleaning, memory optimization, and insightful visualizations to assist in understanding business trends and decision-making.

---

## 🎯 Objectives

- Preprocess messy data and reduce memory usage.
- Explore sales and profit relationships across various features.
- Visualize trends to provide actionable business insights.

---

## 🛠️ Tools and Technologies

- **Python:** Core language for data analysis
- **pandas:** Data manipulation and cleaning
- **NumPy:** Numerical computations
- **Seaborn:** Advanced data visualization
- **Matplotlib:** Static visualizations

---

## ⚙️ Data Cleaning Steps

- Renamed columns for better readability.
- Reduced memory usage by changing data types (`int32`, `float16`, `category`).
- Converted date columns to `datetime` format for proper analysis.

---

## 📊 Key Visualizations and Insights

### 1. **Sales and Profit by Category**

- The **Technology** category has the highest average sales and the largest share of profit.

### 2. **Segment Analysis**

- All segments have similar average sales and profit distributions, indicating equal engagement across customer segments.

### 3. **Ship Mode Analysis**

- Ship modes exhibit similar sales and profit patterns.

### 4. **Regional Analysis**

- East and West regions show higher profit margins despite similar sales levels across regions.

### 5. **Sub-Category Analysis**

- **Copiers** stand out with the highest sales and profit, indicating their importance to the business.

### 6. **Correlation Heatmap**

- Sales and profit have a moderate positive correlation (0.48), suggesting that other factors, such as category type, may influence this relationship.
- Discounts show weak relationships with other factors, indicating minimal impact on overall sales and profits.

---

## 🧩 Recommendations

- **Invest in Technology:** Increase inventory or marketing efforts for the technology category due to its high profitability.
- **Target Regional Growth:** Focus on boosting sales in regions with lower profit margins.
- **Further Analyze Discounts:** Investigate why discounts have minimal influence on sales or profit and adjust strategies accordingly.
- **Copiers Sub-Category:** Leverage the success of this sub-category through targeted promotions and optimized supply chains.

---

## 🚀 How to Run the Project

1. Clone this repository:
   ```bash
   git clone <repository_link>
   ```
2. Navigate to the project directory:

   ```bash
   cd super_store
   ```

3. Install the required libraries: (pandas, seaborn, numpy, matplotlib)

   ```bash
   pip install -r requirements
   ```

4. Run the Jupyter Notebook:
   ```bash
   jupyter notebook super_store.ipynb
   ```

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]
