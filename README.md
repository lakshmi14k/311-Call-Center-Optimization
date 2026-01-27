**311 Call Center Optimization (Kansas)**

**Problem Statement**: Kansas City's 311 call center handles 390,000+ annual service requests across 27 departments with inconsistent resolution times (ranging from 1.4 to 175 days). Leaders lack visibility into channel efficiency, workgroup performance, and seasonal patterns, resulting in trapped operational capacity and unknown cost savings opportunities.

**Proposed Solution**: A BI analytics pipeline that cleans messy call center data, calculates efficiency metrics across departments/workgroups/channels, and delivers interactive dashboards identifying high-impact optimization opportunities for resource reallocation and process improvements.

**Key Findings**
- 11x efficiency gap between automated BOT (4.4 days) and phone channels (47.3 days)
- 270K requests trapped in single bottleneck workgroup averaging 175 days (73x slower than best performers)
- Public Works turnaround: 54% efficiency improvement (28.3 → 13 days) over 2 years
- 10% digital migration could save 5.1M request-days annually
- Clear action plan: Channel Migration (120K requests), Workgroup Rebalancing (NHS), Categorization Audit (610 outliers)

**Dataset Overview:** Kansas City 311 Service Request System

- **Total Records:** 1,563,215 service requests
- **Time Period:** 4 years (January 2018 - October 2021)
- **Departments:** 27 municipal departments
- **Workgroups**: 146 distinct work teams
- **Channels**: Phone (77%), Web (14%), BOT (<1%), Walk-in, Email
- **Data Quality:** 0 duplicates, <1% critical nulls, validated date logic

**Tech Stack**
- ComponentTechnology:
- ETL/Profiling: Alteryx Designer
- Database: SQL Server Analytics(T-SQL)- (CTEs, window functions, LAG/LEAD)
- Visualization: Tableau 

**Project Structure**

├── data/                          # Raw and processed datasets 

(https://data.kcmo.org/311/311-Call-Center-Service-Requests-2007-March-2021/7at3-sxhp/about_data)

│   ├── raw/                       # Original TSV (339 MB)

│   ├── processed/                 # Cleaned/staged CSV (447 MB)

│   └── validation/                # Data quality checks

├── etl/                           # Alteryx ETL workflows

│   └── workflow.yxmd              # Data profiling + cleaning

├── sql/                           # SQL Server analysis scripts

│   ├── results/                   # Query outputs (6 analysis CSVs)

│   ├── basics.sql

│   ├── cohort_analysis.sql

│   ├── master_data_source.sql

│   ├── priority_requests.sql

│   ├── seasonality_pattern.sql

│   ├── source_efficiency.sql

│   ├── validations.sql

│   └── workgroup_benchmarking.sql

├── dashboards/                    # Visualizations

│   ├── tableau/                   # Tableau workbook

│   └── powerbi/                   # PowerBI file

├── docs/                          # Documentation

│   └── key_findings.docx          # Executive summary

└── README.md

**Data Lineage**

**Raw TSV** (1.56M rows) → **Alteryx ETL** (profiling, cleaning, date standardization) → **SQL Server **(stg_kansascityrequests) →  **T-SQL Analytics** (cohort, seasonality, efficiency, benchmarking) → **Tableau Dashboards **(executive overview, dept performance, efficiency)

**Installation Steps:**

**1. Database Setup:**
- sql CREATE DATABASE KansasCityRequests;
- Import TSV using SQL Server Import Wizard

**2. Run Analysis Queries:**
- bashcd 03_sql_analysis
- Execute 01-07 in SSMS

**3. Build Tableau Dashboard:**
- Tableau Public

**Results:**
- 5.1M request-days recoverable through channel migration
- NHS-Neighborhood Preservation: 270K requests, 175-day avg (immediate optimization target)
- Best-in-class performers: NHS-Animal (92K requests, 1.4 days), Public Works-Solid Waste (99K requests, 2.9 days)

_Built with Alteryx, SQL Server, and Tableau_

See **key findings** for detailed analysis.


