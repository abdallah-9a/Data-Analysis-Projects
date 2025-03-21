# Mall Customers Data Cleaning and Visualization Project

## 📄 Project Description

This project focuses on cleaning and visualizing customer data from a mall dataset. It aims to preprocess messy data, handle outliers, and provide meaningful visualizations for better business insights.

## 🛠️ Tools and Technologies

- **Python:** Core language for data analysis
- **pandas:** Data manipulation and cleaning
- **NumPy:** Numerical computations
- **Matplotlib:** Static visualizations
- **Seaborn:** Advanced data visualization

## ⚙️ Key Features

- **Data Import:** Load and explore the dataset to understand its structure.
- **Data Cleaning:**
  - Detect and handle missing data.
  - Remove outliers using the Interquartile Range (IQR) method.
  - **Standardize Column Names and Values:** Ensure consistent naming conventions by converting column names to lowercase, replacing spaces with underscores, and removing special characters. \
    Standardize categorical values by converting text to lowercase, removing extra spaces, and unifying similar categories
- **Data Visualization:** Analyze customer spending patterns and visualize relationships between key features.

## 📊 Visualizations Included

- Distribution plots for customer segments
- Box plots to detect and visualize outliers
- Heatmaps for feature correlations

## 🚀 How to Run the Project

1. Clone this repository:
   ```bash
   git clone <repository_link>
   ```
2. Navigate to the project directory:

   ```bash
   cd Mall_Customers
   ```

3. Install the required libraries: (pandas, seaborn, numpy, matplotlib)

   ```bash
   pip install -r requirements
   ```

4. Run the Jupyter Notebook:
   ```bash
   jupyter notebook Mall_Customers.ipynb
   ```

## 📈 Key Insights

1. **Outliers as Meaningful Data Points:**

   - Outliers in the dataset represent rare but valuable situations that provide meaningful insights, rather than data errors that need removal.

2. **Age-Based Spending Patterns:**

   - The most frequent customers belong to the 26–35 age group, exhibiting higher spending patterns compared to other groups.
   - Customers aged 36–45 have the highest annual income, likely due to their greater work experience.

3. **Weak Income-Spending Correlation:**
   - The weak correlation between annual income and spending score suggests other factors may influence customer spending behavior that the current dataset does not capture.

## 🥇 Contributing

Feel free to fork this repository and submit pull requests to improve the project.

## ✨ Author

[Abdallah Rabie Fayez]\
[https://github.com/abdallah-9a]
