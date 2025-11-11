# NW Realite Ltd – Data Analyst Practical Exercise

##  Context
You’ve joined **NW Realite Ltd**, a property management company overseeing assets across **Nairobi CBD, Westlands, and Kilimani**.  
Your role: Analyze **rent performance**, **occupancy**, and **arrears** using the following datasets:

- `locations`
- `properties`
- `units`
- `tenants`
- `leases`

> ⚠️ Note: The dataset contains dirty records that require cleaning and validation before analysis.

---

##  TASK 1: Data Cleaning & Preparation

###  Goal
Clean and structure the data for analysis.

###  Steps
1. **Import the data** (Python/Pandas or Excel Power Query).  
2. **Identify and document issues:**
   - Missing / NULL values (e.g., tenant emails, lease end_date)
   - Invalid values (negative rent, invalid dates)
   - Duplicates and outliers
3. **Create new columns:**
   - `lease_duration_months` → handle NULL `end_date` as ongoing to today  
   - `lease_status` → (`ongoing`, `expired`, `invalid`)  
   - `valid_lease` → `1` if `(start_date < end_date)` or `(end_date is NULL and start_date ≤ today)`, else `0`  
   - `annual_rent = rent_per_month * 12`  
   - Fix negative rent values by converting them to positive  
4. **Standardize** location names (Proper Case formatting).

###  Deliverables
- Cleaned dataset (`.csv` or `.xlsx`)  
- Short note listing:
  - Detected issues
  - Cleaning and transformation decisions  

---

##  TASK 2: Exploratory Analysis & Visualization

###  Goal
Communicate business insights visually (preferably in **Power BI**, but equivalent visual tools acceptable).

###  Required Visuals
1. **Total Rent Billed vs Total Arrears by Location**  
   - *Rent Billed = SUM(rent_per_month) for valid leases only*
2. **Occupancy Rate per Property**  
   - *Occupancy = (Units with ≥1 valid lease ÷ Total Units) × 100*
3. **Top 3 Properties by Arrears**  
   - Include both arrears and credits
4. **Average Monthly Rent** per Property and per Location  
5. *(Optional)* **Lease Validity Trend**  
   - Valid vs Invalid lease count by start month

###  Deliverables
- Power BI Dashboard (`.pbix`, 1-page)
- Short insight summary (3–5 sentences)  

---

##  TASK 3: SQL Queries

###  Goal
Test SQL reasoning and query design using the provided schema.  
Use `valid_lease = 1` to indicate occupied units.

###  Queries to Write

1. **Occupancy Underperformers**  
   - Return `property_id`, `property_name`, `occupancy_rate`  
   - Filter: `occupancy_rate < 80%`  
   - Formula: `(occupied_units ÷ total_units) × 100`

2. **Arrears by Location**  
   - Return `location`, `SUM(arrears)`  
   - Include locations with zero arrears (use `COALESCE` or `LEFT JOIN`)

3. **Collection Efficiency Leaderboard**  
   - Formula:  
     ```sql
     collection_efficiency = (1 - (SUM(arrears) / NULLIF(SUM(rent_per_month), 0))) * 100
     ```
   - Return Top 3 properties (valid leases only)

4. **Data Quality Check – Invalid Leases**  
   - List leases where `end_date < start_date` or `rent_per_month < 0`  
   - Include: `lease_id`, `property_name`, `unit_name`, `tenant_name`, `reason_flag`  
     (`'NEGATIVE_RENT'`, `'END_BEFORE_START'`)

5. **Multi-Unit Tenants**  
   - List tenants with **2+ distinct units**  
   - Show `tenant_name`, `count_units`, and comma-separated property names  

###  Deliverables
- SQL script (`.sql` or `.txt`) containing all 5 queries, well-commented  

---

##  TASK 4: Insight Communication

###  Goal
Translate analysis results into actionable recommendations.

###  Expected Output
A 150–200 word **email/memo** to the **Head of Property Management**, summarizing:
- Overall rent and occupancy performance  
- Areas with high arrears or inefficiencies  
- Recommended actions, e.g.:
  - Lease audits  
  - Arrears follow-up cadence  
  - Tenant incentives  
  - Pricing or data quality reviews  

###  Deliverable
- Memo (`.docx` or `.pdf`)

---

##  BONUS (Optional) – Predictive Modeling

###  Goal
Build a **simple linear regression model** (in Python) predicting **next month’s collection efficiency** per property using:
- Recent rent billed
- Arrears
- Occupancy

###  Deliverables
- Jupyter Notebook (`.ipynb`)
- One-paragraph model interpretation  

---

##  Folder Structure
```
NW_Realite_Data_Analyst_Exercise/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   └── analysis.ipynb
│
├── visuals/
│   └── dashboard.pbix
│
├── sql/
│   └── queries.sql
│
├── reports/
│   ├── cleaning_notes.docx
│   ├── memo_to_head.pdf
│
└── README.md
```

---

##  Summary
This practical exercise assesses your ability to:
- Clean and validate real-world property data  
- Perform analytical calculations and aggregations  
- Build visual dashboards for management insight  
- Write efficient, production-ready SQL queries  
- Communicate findings effectively to business stakeholders  
