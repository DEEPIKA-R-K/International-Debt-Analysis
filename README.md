[README.TXT.md](https://github.com/user-attachments/files/28678068/README.TXT.md)
# 🌍 International Debt Analysis

A complete end-to-end data analytics project using the **World Bank International Debt Statistics (IDS)** dataset — covering data cleaning, MySQL database integration, SQL analysis, and Power BI visualization.

---

## 📌 Project Overview

This project analyzes international debt data across **134+ countries** and **26 indicators** spanning multiple decades. The goal is to uncover patterns in global debt distribution, identify top debtor nations, and understand which debt indicators dominate across regions and income groups.

---

## 🗂️ Dataset

**Source:** [World Bank — International Debt Statistics (IDS)](https://www.worldbank.org/en/programs/debt-statistics/ids)

| File | Description |
|---|---|
| `IDS_ALLCountries_Data.csv` | Main debt data — all countries, indicators, and years |
| `IDS_CountryMetaData.csv` | Country-level metadata (region, income group, currency) |
| `IDS_SeriesMetaData.csv` | Indicator/series definitions and topics |
| `IDS_FootNoteMetaData.csv` | Data footnotes and annotations per country/year |
| `Country-Series - Metadata.csv` | Country-to-series mapping metadata |

**Scale:** ~2 million records after melting wide → long format

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Python 3 | Data cleaning & analysis |
| Pandas | Data wrangling and transformation |
| SQLAlchemy + PyMySQL | MySQL connection from Jupyter |
| MySQL Workbench | Database management & query execution |
| Jupyter Notebook | Interactive analysis environment |
| Power BI | Dashboard and visualization |

---

## 📁 Project Structure

```
International-Debt-Analysis/
│
├── data/
│   ├── IDS_ALLCountries_Data.csv
│   ├── IDS_CountryMetaData.csv
│   ├── IDS_SeriesMetaData.csv
│   ├── IDS_FootNoteMetaData.csv
│   └── Country-Series - Metadata.csv
│
├── notebooks/
│   └── International_Debt_MySQL_Analysis.ipynb   # Main notebook (clean + load + 30 queries)
│
├── dashboard/
│   └── International_Dept_Analysis.pbix          # Power BI dashboard file
│
└── README.md
```

---

## ⚙️ Setup & Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/international-debt-analysis.git
cd international-debt-analysis
```

### 2. Install Python Dependencies
```bash
pip install pandas sqlalchemy pymysql cryptography matplotlib seaborn
```

### 3. Set Up MySQL Database
Open **MySQL Workbench** and run:
```sql
CREATE DATABASE international_debt;
```

### 4. Configure Connection
In the notebook, update the credentials block:
```python
USER     = 'root'
PASSWORD = 'your_password'   # URL-encode special chars (@ → %40)
HOST     = 'localhost'
PORT     = 3306
DATABASE = 'international_debt'
```

### 5. Run the Notebook
Place all CSV files in the same folder as the notebook, then run all cells top to bottom.

---

## 🔄 Data Pipeline

```
Raw CSV Files (wide format)
        ↓
  Python / Pandas
  • Drop future year columns (2025–2032)
  • Drop unnecessary columns
  • Melt wide → long format (one row per country/indicator/year)
  • Handle nulls & duplicates
        ↓
  MySQL Database (international_debt)
  • international_debt     ← main fact table
  • country_metadata       ← dimension table
  • series_metadata        ← dimension table
  • footnote_metadata      ← annotation table
  • country_series         ← mapping table
        ↓
  30 SQL Analytical Queries
        ↓
  Power BI Dashboard
```

---

## 📊 SQL Analysis — 30 Queries

### 🔹 Basic (Q1–Q10)
Covers foundational exploration — distinct countries, total records, global debt sum, min/max/avg values, and filtering.

### 🔹 Intermediate (Q11–Q20)
Covers aggregations — total/average debt per country and indicator, top/bottom rankings, indicator counts, and comparisons against global averages.

### 🔹 Advanced (Q21–Q30)
Covers window functions, CTEs, views, cumulative debt, percentage contributions, debt categorization (High / Medium / Low), and dominant indicator identification per country.

---

## 📈 Power BI Dashboard

Three dashboard pages built in Power BI Desktop:

**Page 1 — Overview**
- Total Global Debt KPI card
- Total Countries, Records, Indicators
- Debt sum by year (bar chart)
- Country distribution by income group (pie chart)

**Page 2 — Country-wise Analysis**
- Top countries by total debt (bar chart)
- Country distribution by region and income group

**Page 3 — Indicator-wise Analysis**
- Debt sum by series/indicator
- Indicator count by topic (pie chart)
- Full indicator reference table

**Page 4 — Footnote Analysis**
- Count of indicators by Government Accounting concept (bar chart)
- Country-wise footnote distribution (pie chart)
- Footnote count by year (bar chart)

---

## 💡 Key Findings

- **Total Global Debt:** ~$1.23 × 10¹⁶ USD across all years
- **Top Debtor:** China, Brazil, India, and Mexico lead among individual nations
- **Dominant Indicator:** GNI (current US$) contributes ~20% of total value
- **Income Group Split:** Upper-middle income countries account for the largest share (~36%) of records
- **Debt Growth:** Clear upward trend from 2000 to 2024 visible in year-wise analysis
- Only a small number of countries contribute more than 5% each to total global debt

---

## 🚀 How to Run the Full Project

| Step | Action |
|---|---|
| 1 | Create `international_debt` database in MySQL Workbench |
| 2 | Open `International_Debt_MySQL_Analysis.ipynb` in Jupyter |
| 3 | Run all cells — cleans data, loads all 5 tables, runs 30 queries |
| 4 | Open `International_Dept_Analysis.pbix` in Power BI Desktop to explore the dashboard |

---

## 👩‍💻 Author

**Deepika**  
Data Analyst & Software Engineer  
📍 Bengaluru, India  
🔗 [www.linkedin.com/in/deepikark-be] | [https://github.com/DEEPIKA-R-K](#)
