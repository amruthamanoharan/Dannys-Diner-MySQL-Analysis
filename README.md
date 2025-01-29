# Danny's Diner Data Analysis

Welcome to my SQL-based data analysis project for **Danny's Diner**, a case study designed to showcase my skills in SQL and problem-solving for data analysis.


                    
## 📚 Project Overview
**Danny's Diner** is a fictional Japanese restaurant. The goal of this project is to analyze customer behavior, spending patterns, and menu preferences to provide actionable insights for business growth. These insights include:
- Understanding customer purchase habits.
- Evaluating the effectiveness of the loyalty program.
- Identifying popular menu items.

This analysis was completed using **MySQL**.

---

## 🗂️ Datasets
The analysis is based on the following datasets:
1. **Sales**: Customer purchases with product details.
2. **Menu**: Menu items and their prices.
3. **Members**: Loyalty program membership data.

Each dataset is structured in a relational schema, allowing for efficient querying and analysis.

---

## 🛠️ Tools Used
- **SQL Database**: MySQL
- **Query Editor**: MySQL Workbench

---

## 🔍 Key Questions Answered

Here’s a summary of the business questions and how I approached them:

### 💡 1. Total Customer Spending
```sql
SELECT 
    customer_id, 
    SUM(price) AS total_spent
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY customer_id;
```
📌 Insight: Customer A spent the most, followed by B and C.

---

### 📅 2. How Many Days Did Customers Visit?
```sql
SELECT 
    customer_id, 
    COUNT(DISTINCT order_date) AS visit_count
FROM sales
GROUP BY customer_id;
```
📌 Insight: Customer B visited the most frequently, followed by A and C.

---

### 🍣 3. Most Purchased Item
```sql
SELECT 
    product_name, 
    COUNT(*) AS total_purchases
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY product_name
ORDER BY total_purchases DESC
LIMIT 1;
```
📌 Insight: Ramen is the most purchased item.

---
### 🎁 4. Loyalty Program Effectiveness
```sql
SELECT 
    customer_id,COUNT(*) AS purchases_after_membership
FROM dannys_diner.sales s
JOIN dannys_diner.members m USING(customer_id)
WHERE order_date >= join_date
GROUP BY customer_id;
```
📌 Insight: Customers purchased more items after joining the loyalty program.

---

## 📊 Key Insights 

### 1️⃣ Customer Behavior:
- **Customer A** is the highest spender, followed by Customer B.
- **Customer A** visited the restaurant **6 times**, making them the most frequent visitor.
- **Customer C** has the least visits, presenting an opportunity to increase engagement.

### 2️⃣ Menu Popularity:
- **Ramen** is the most purchased item, with **12 total orders** across all customers.
- **Sushi** is the second most popular item, making it a strong candidate for promotions.

### 3️⃣ Loyalty Program Effectiveness:
- Customers **increase their purchase frequency after joining the loyalty program**.
- **Customer A made 4 purchases after joining**, compared to **2 before enrollment**.
- **Customer B showed similar behavior**, reinforcing the effectiveness of the loyalty program.

### 4️⃣ Recommendations for Business Growth:
  ✅ **Leverage Promotions**:  
     - Offer targeted discounts on **Ramen and Sushi** to further boost sales.  
     - Introduce a **"Ramen Lovers Club"** for repeat customers.  
  
  ✅ **Enhance Loyalty Program**:  
     - Encourage **Customer C** to join by offering an exclusive **"first-time member"** discount.  
     - Provide personalized offers to **frequent visitors (Customer A)** to ensure continued engagement.
  
  ✅ **Optimize Menu Strategy**:  
     - Consider bundling **Sushi + Ramen** into a combo meal for cross-selling opportunities.  

---
## 🚀 Next Steps
Further analysis can explore peak dining hours, average order value per visit, and seasonal trends to refine marketing strategies.

---

## 💡 Skills Demonstrated
This project highlights:
- Writing optimized SQL queries for real-world problems.
- Joining, filtering, and aggregating data to extract insights.
- Using **CASE** statements for conditional logic.
- Applying window functions for ranking and advanced analysis.

---

## 📁 Project Contents
- **`datasets/dannys_diner_data.sql`**: SQL script to recreate the database tables and insert data.
- **`queries/main_analysis.sql`**: SQL queries answering the core case study questions.
- **`queries/bonus_questions.sql`**: Advanced queries for bonus questions.
- **`outputs/:`** Key insights and CSVs summarizing results.

---

## 🚀 How to Use This Repository
1. Clone the repository:
   ```bash
   git clone https://github.com/amruthamanoharan/Dannys-Diner-MySQL-Analysis.git
   ```
2. Import the dataset:
    - Use the script in `datasets/dannys_diner_schema.sql` to create the database.
3. Run the queries:
    - Open the SQL scripts in `queries/` to explore the analysis.
---

## 🌟 Acknowledgements
This project is based on the 8-Week SQL Challenge by **Danny Ma**. It has been adapted and tailored to showcase my personal learning journey and SQL expertise.


