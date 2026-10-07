# SQL & Database Analysis Module

**Author:** R. Prathap (SQL & Database Analyst)  
**Project:** Sportradar Tennis Data Pipeline & Business Intelligence  

---

## Files in this Directory
* [`schema.sql`](./schema.sql) — DDL scripts for table structures, primary keys, and relational constraints.
* [`business_queries.sql`](./business_queries.sql) — Comprehensive collection of executable analytical SQL queries.

---

## 1. List All Competitions Along with Their Category Name

### Business Question
How are competitions distributed across different categories, and what is the balance between event formats and gender representations?

### SQL Query
```sql
SELECT 
    ct.*, 
    cg.category_name 
FROM competitions ct
LEFT JOIN categories cg ON ct.category_id = cg.category_id;
'''


### Result Data
* **Full Query Output:** [`../outputs/q1_List all competitions along with their category name`](../outputs/q1_List all competitions along with their category name)

### Business Insights
The dataset contains 2,000 competitions mapped across 10 unique category names, heavily dominated by lower-tier developmental tours.ITF Men (59.6%) and ITF Women (24.2%) form the vast majority (83.8%) of all listed competitions, while elite professional categories like ATP and WTA account for less than 4% combined. Additionally, the coverage is evenly split between singles (49.9%) and doubles (50.1%) events, though male competitions dominate the overall dataset (72.2%)

