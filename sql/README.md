# SQL & Database Analysis Module

**Author:** R. Prathap (SQL & Database Analyst)  
**Project:** Sportradar Tennis Data Pipeline & Business Intelligence  

---

* [Data_schema.sql](./Data_schema.sql) – DDL scripts for table structures, primary keys, and relational constraints.
* [business_queries.sql](./business_queries.sql) – Comprehensive collection of executable analytical SQL queries.

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
```

### Result Data
* **Full Query Output:** [`../outputs/q1_List_all_competitions_along_with_their_category_name.csv`](../outputs/q1_List_all_competitions_along_with_their_category_name.csv)

### Business Insights
The dataset contains 2,000 competitions mapped across 10 unique category names, heavily dominated by lower-tier developmental tours.ITF Men (59.6%) and ITF Women (24.2%) form the vast majority (83.8%) of all listed competitions, while elite professional categories like ATP and WTA account for less than 4% combined. Additionally, the coverage is evenly split between singles (49.9%) and doubles (50.1%) events, though male competitions dominate the overall dataset (72.2%)

---
## 2. Count the number of competitions in each category

### Business Question
What is the volume distribution of competitions across each category in the dataset?

### SQL Query
```sql
select cg.category_name,
count(ct.competition_id) as no_of_competitions from categories cg 
left join competitions ct on cg.category_id=ct.category_id 
group by cg.category_name; 
```

### Result Data
* **Full Query Output:** [`../outputs/q2_Count_the_number_of_competitions_in_each_category.csv`](../outputs/q2_Count_the_number_of_competitions_in_each_category.csv)

### Business Insights
The ITF Men (2,198) and ITF Women (2,032) categories dominate tournament volume, accounting for 63.2% of all 6,689 listed competitions, followed by Challenger events at 15.9% (1,065). Elite main-tour categories (ATP and WTA) comprise just 7.2% (484 competitions) combined, while team/exhibition events like the Davis Cup, Billie Jean King Cup, and Hopman Cup operate as single standalone fixtures.

---
## 3. Find All Competitions of Type 'Doubles'

### Business Question
What proportion of doubles competitions are represented across genders within the retrieved dataset?

### SQL Query
```sql
SELECT * 
FROM competitions
WHERE type = 'doubles'; 
```

### Result Data
* **Full Query Output:** [`../outputs/q3_Find_all_competitions_of_type_doubles.csv`](../outputs/q3_Find_all_competitions_of_type_doubles.csv)

### Business Insights
The query retrieves 2,000 doubles competitions, confirming that all records in the dataset strictly belong to the doubles event type. Men's events make up 55.95% (1,119) of the total doubles competitions, while women's events account for the remaining 44.05% (881).

---
## 4. Get Competitions That Belong to a Specific Category (ITF Men)

### Business Question
What is the internal distribution between singles and doubles formats within the ITF Men category?

### SQL Query
```sql
SELECT 
    ct.competition_name, 
    cg.category_name 
FROM competitions ct
LEFT JOIN categories cg ON ct.category_id = cg.category_id
WHERE cg.category_name = 'ITF Men'; 
```

### Result Data
* **Full Query Output:** [`../outputs/q4_Get_competitions_that_belong_to_a_specific_category_e.g_ITF_Men.csv`](../outputs/q4_Get_competitions_that_belong_to_a_specific_category_e.g_ITF_Men.csv)

### Business Insights
The output retrieves all 2,000 competitions filtered specifically under the ITF Men category. The filtered dataset shows an almost perfect 1:1 balance between event formats, containing 1,000 doubles and 999 singles competitions across international circuit locations.
