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

---
## 5. Identify Parent Competitions and Their Sub-Competitions

### Business Question
Are there hierarchical structural dependencies where sub-competitions are mapped under parent tournaments?

### SQL Query
```sql
SELECT
    parent.competition_id AS parent_competition_id,
    parent.competition_name AS parent_competition_name,
    sub.competition_id AS sub_competition_id,
    sub.competition_name AS sub_competition_name,
    sub.type AS sub_competition_type
FROM competitions sub
JOIN competitions parent ON sub.parent_id = parent.competition_id
ORDER BY parent.competition_name, sub.competition_name;
```

### Result Data
* **Full Query Output:** [`../outputs/q5_Identify_parent_competitions_and_their_sub_competitions.csv`](../outputs/q5_Identify_parent_competitions_and_their_sub_competitions.csv)

### Business Insights
The output identifies a single parent-child tournament relationship in the dataset, linking ITF Romania F9, Men Singles as the parent event to ITF Romania F9, Men Doubles as its sub-competition. This single record highlights a structural dependency where the doubles event is configured as a secondary tournament under the primary singles competition format.

---
## 6. Analyze the distribution of competition types by category

### Business Question
How do match format types (singles, doubles, mixed) vary across category groups?

### SQL Query
```sql
SELECT 
    cg.category_name, 
    ct.type, 
    COUNT(*) AS total 
FROM categories cg
LEFT JOIN competitions ct ON cg.category_id = ct.category_id
GROUP BY cg.category_name, ct.type;
```

### Result Data
* **Full Query Output:** [`../outputs/q6_Analyze_the_distribution_of_competition_types_by_category.csv`](../outputs/q6_Analyze_the_distribution_of_competition_types_by_category.csv)

### Business Insights
Standard circuit categories (ITF Men/Women, Challenger, WTA, ATP) maintain a near-perfect 1:1 balance between singles and doubles events, whereas UTR competitions operate exclusively as singles formats. Mixed and mixed doubles competitions are exceptionally rare across the dataset (18 total events, <0.3%), appearing almost entirely within special exhibition, ATP, and international team events (e.g., Hopman Cup, United Cup).

---
## 7. List all competitions with no parent (top-level competitions)

### Business Question
Which tournaments operate as top-level standalone fixtures without parent hierarchies?

### SQL Query
```sql
SELECT 
    competition_id, 
    competition_name, 
    parent_id 
FROM competitions
WHERE parent_id = 'Root';
```

### Result Data
* **Full Query Output:** [`../outputs/q7_List_all_competitions_with_no_parent_(top-level_competitions).csv`](../outputs/q7_List_all_competitions_with_no_parent_(top-level_competitions).csv)

### Business Insights
The dataset identifies 603 top-level competitions marked with parent_id as ROOT, representing standalone events operating independently without a parent tournament hierarchy. Universal Tennis Rating (UTR) events heavily dominate this category at 92.5% (558 competitions), while the remaining 7.5% comprises international team cups (e.g., Davis Cup, United Cup, Hopman Cup) and select exhibition or tour fixtures.

---
## 8. List all venues along with their associated complex name

### Business Question
How are individual venue courts mapped to physical tennis complexes?

### SQL Query
```sql
SELECT 
    v.venue_name, 
    c.complex_name 
FROM venues v
LEFT JOIN complexes c ON v.complex_id = c.complex_id;
```

### Result Data
* **Full Query Output:** [`../outputs/q8_List_all_venues_along_with_their_associated_complex_name.csv`](../outputs/q8_List_all_venues_along_with_their_associated_complex_name.csv)

### Business Insights
The dataset maps 2,000 venue records across 342 unique tennis complexes, with generic court labels like "Court 1" and "Court 2" representing the most frequent venue names. Major multi-court hubs like the National Tennis Center (48 venues) and Buenos Aires Lawn Tennis Club (28 venues) contain the highest concentration of individual court mappings.

---
## 9. Count the number of venues in each complex

### Business Question
Which tennis complexes possess the highest concentration of mapped venues and courts?

### SQL Query
```sql
SELECT 
    c.complex_name, 
    COUNT(v.venue_id) AS total 
FROM complexes c
LEFT JOIN venues v ON c.complex_id = v.complex_id
GROUP BY c.complex_id, c.complex_name
ORDER BY COUNT(v.venue_id) DESC;
```

### Result Data
* **Full Query Output:** [`../outputs/q9_Count_the_number_of_venues_in_each_complex.csv`](../outputs/q9_Count_the_number_of_venues_in_each_complex.csv)

### Business Insights
Across 778 tennis complexes, the dataset accounts for 4,124 total venues, led by major multi-court facilities such as Buenos Aires Lawn Tennis Club (29 venues), Melbourne Park (28 venues), and Queensland Tennis Centre (25 venues). Most active complexes feature between 3 and 6 individual courts (39.3% of complexes), while 161 complexes (20.7%) currently have zero mapped courts recorded.

---
## 10. Get details of venues in a specific country (e.g., Chile)

### Business Question
What is the geographic spread, court naming convention, and timezone configuration for venues located in Chile?

### SQL Query
```sql
SELECT * 
FROM venues
WHERE country_name = 'chile';
```

### Result Data
* **Full Query Output:** [`../outputs/q10_Get_details_of_venues_in_a_specific_country_(e.g_Chile).csv`](../outputs/q10_Get_details_of_venues_in_a_specific_country_(e.g_Chile).csv)

### Business Insights
Santiago serves as the primary host location, accounting for 30 of Chile's 65 venues (46.2%) across 7 cities, with a single major complex holding nearly 30% of all mapped courts. The venues feature a blend of Spanish and English naming conventions (e.g., "Cancha Central" vs. "Centre Court"), with all 65 facilities operating within the unified America/Santiago timezone.

---
## 11. Identify all venues and their timezones

### Business Question
How are global venue facilities distributed across regional timezones?

### SQL Query
```sql
SELECT 
    venue_name, 
    timezone 
FROM venues;
```

### Result Data
* **Full Query Output:** [`../outputs/q11_Identify_all_venues_and_their_timezones.csv`](../outputs/q11_Identify_all_venues_and_their_timezones.csv)

### Business Insights
The dataset maps 2,000 venue listings across 77 unique global timezones, spanning major international tennis regions. North American (America/New_York with 176 venues) and Asian (Asia/Shanghai with 167 venues) timezones hold the largest venue counts, followed closely by key European hubs such as Europe/Paris (158) and Europe/Rome (112).

---
## 12. Find complexes that have more than one venue

### Business Question
Which multi-venue complexes exhibit high infrastructure capacity with multiple courts?

### SQL Query
```sql
SELECT 
    c.complex_name, 
    COUNT(v.venue_id) AS total 
FROM complexes c
LEFT JOIN venues v ON c.complex_id = v.complex_id
GROUP BY c.complex_id, c.complex_name
HAVING COUNT(v.venue_id) > 1
ORDER BY COUNT(v.venue_id) DESC;
```

### Result Data
* **Full Query Output:** [`../outputs/q12_Find_complexes_that_have_more_than_one_venue.csv`](../outputs/q12_Find_complexes_that_have_more_than_one_venue.csv)

### Business Insights
A total of 589 multi-venue complexes account for 4,096 individual courts, averaging approximately 7 venues per complex (ranging between 2 and 29). Premier facilities like the Buenos Aires Lawn Tennis Club (29 venues), Melbourne Park (28 venues), and Queensland Tennis Centre (25 venues) lead the dataset in multi-court infrastructure capacity.

---
## 13.  List venues grouped by country

### Business Question
Which host nations contain the largest concentration of tennis venue infrastructure globally?

### SQL Query
```sql
SELECT 
    country_name, 
    venue_name 
FROM venues
GROUP BY country_name, venue_name
ORDER BY country_name;
```

### Result Data
* **Full Query Output:** [`../outputs/q13_List_venues_grouped_by_country.csv`](../outputs/q13_List_venues_grouped_by_country.csv)

### Business Insights
The dataset spans 2,000 venue entries across 75 unique countries, led by the USA (187 venues, 9.4%), France (109 venues), and Italy (104 venues). Together, these top three host nations account for 20.0% (400 venues) of all listed facilities, while countries like Saudi Arabia (1), Israel (2), and the Philippines (3) sit at the lower end of venue counts.

---
## 14. Find all venues for a specific complex (e.g., Nacional)

### Business Question
How many mapped courts are registered under the Nacional complex?

### SQL Query
```sql
SELECT 
    v.venue_id, 
    v.venue_name, 
    c.complex_name 
FROM venues v
LEFT JOIN complexes c ON v.complex_id = c.complex_id
WHERE c.complex_name = 'Nacional';
```

### Result Data
* **Full Query Output:** [`../outputs/q14_Find_all_venues_for_a_specific_complex_(e.g_Nacional).csv`](../outputs/q14_Find_all_venues_for_a_specific_complex_(e.g_Nacional).csv)

### Business Insights
The query returns a single venue entry (Cancha Central, ID sr:venue:70045) associated with the Nacional complex. This indicates that within the dataset, the Nacional complex has only one recorded and mapped court facility available.
