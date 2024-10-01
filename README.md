# Maven Toys Sales & Inventory Analysis

## Project Summary
This project is based on sales and inventory data for a fictitious chain of toy stores in Mexico called **Maven Toys**. The data includes information about products, stores, daily transactions, and current inventory levels at each location. The goal is to perform a detailed analysis of sales performance, product categories, inventory, and profitability using advanced SQL queries.

## Project Overview
The purpose of this project is to use SQL to perform comprehensive sales and inventory analysis. Key objectives include identifying which product categories drive the most revenue, uncovering seasonal trends in sales, evaluating stock levels, and analyzing store performance.

## Tasks Performed
1. **Data Acquisition:**
   - Downloaded the following datasets from Maven Analytics:
     - Inventory
     - Products
     - Sales
     - Stores

You can download the `.csv` files from this repository.
     

2. **Database Setup:**
   - Imported the files into **Microsoft SQL Server Management Studio (SSMS)**.
   - Created a new database called `MavenToysData`.
   - Loaded the datasets into the appropriate tables.

3. **Data Inspection:**
   - Checked the structure and content of each dataset.
   - No additional cleaning or transformation was necessary as the data was well-organized.

4. **Business Analysis Areas:**
   The analysis focused on six key areas:
   - **Product and Category Analysis**
   - **Sales Performance Analysis**
   - **Inventory Management**
   - **Performance Comparison by Store and City**
   - **Profitability Analysis**
   - **Top-Selling Products**

5. **SQL Querying:**
   - Used Microsoft SSMS to run queries addressing the defined business questions.
   - Advanced SQL techniques such as window functions, CTEs, and subqueries were applied to uncover insights.

## Querying the Data
The SQL queries used in this project were designed to answer the business questions outlined in the analysis. For a detailed view of all queries, please refer to the [SQL script](https://github.com/DaCruzEmanuel/SQL_Sales-analysis/blob/main/SQL_MavenToys%20Sales%20analysis.sql) in the repository.

## SQL Statements/Functions Used
- `SELECT`: To retrieve data from the database.
- `COUNT`: To count records or distinct values.
- `SUM`: To calculate the total of specified columns.
- `Joins`: To combine data from multiple tables.
- `GROUP BY`: To aggregate data based on specific columns.
- `ORDER BY`: To sort query results.
- `AVG`: To calculate average values.
- `MAX` and `MIN`: To identify maximum and minimum values.
- `CASE`: To implement conditional logic.
- Window functions: `ROW_NUMBER`, `RANK`, `LAG` for ranking and calculating differences.
- `WITH` (CTE): To structure queries more efficiently.

## Key Findings and Conclusion

### 1. Product Insights
Maven Toys offers 35 products across five main categories:
- Art & Crafts
- Electronics
- Games
- Sports & Outdoors
- Toys

The product prices range from $2.99 to $39.99.

### 2. Sales and Profitability Analysis
- **Sales Growth**: Sales and revenue increased consistently through most months in 2022 and continued growing in 2023.
- **Top Sellers**: The best-selling products were "Colorbuds" in 2022 and "Barrel O’Slime" in 2023.
- **Revenue Drivers**: Despite the high sales volume of "Colorbuds," the product that generated the most revenue in both years was "Lego Bricks."
- **Profitability**: "Colorbuds" was the most profitable product overall, contributing significantly to the company's profit.
- **Store Performance**: Store X emerged as the top-performing location in terms of revenue generation.

## Available Resources
- **Datasets**: All raw data files are available in the repository [here](https://github.com/DaCruzEmanuel/SQL_Sales-analysis/upload/main/Datasets).
- **SQL Script**: A complete script containing all SQL queries used in this project is available [here](https://github.com/DaCruzEmanuel/SQL_Sales-analysis/blob/main/SQL_MavenToys%20Sales%20analysis.sql).
- **Tutorial**: A guide on how to create the database and import the datasets using Microsoft SQL Server Management Studio (SSMS) is also included [here](https://github.com/DaCruzEmanuel/SQL_Sales-analysis/blob/main/Tutorial%20-%20SQL%20database%20and%20import%20files.pdf).

## Conclusion
This project helped uncover valuable insights into Maven Toys' sales and inventory data. By leveraging advanced SQL techniques, I was able to identify top-performing products, assess stock levels, and analyze store profitability. The detailed analysis and SQL queries are accessible in the repository for further exploration.
