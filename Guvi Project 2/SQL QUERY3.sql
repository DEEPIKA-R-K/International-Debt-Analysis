-- Q21. Top 5 indicators contributing most to global debt
SELECT
    `Series Name`,
    SUM(Value) AS Total_Debt,
    ROUND(SUM(Value) * 100.0 / SUM(SUM(Value)) OVER (), 2) AS Pct_Contribution
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Series Name`
ORDER BY Total_Debt DESC
LIMIT 5;

-- Q22. Percentage contribution of each country to global debt
SELECT
    `Country Name`,
    SUM(Value) AS Total_Debt,
    ROUND(SUM(Value) * 100.0 / SUM(SUM(Value)) OVER (), 4) AS Pct_of_Global_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Total_Debt DESC;

-- Q23. Top 3 countries for each indicator based on debt
WITH indicator_country AS (
    SELECT
        `Series Name`,
        `Country Name`,
        SUM(Value) AS Total_Debt
    FROM international_debt.debt_data
    WHERE Value IS NOT NULL
    GROUP BY `Series Name`, `Country Name`
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY `Series Name` ORDER BY Total_Debt DESC) AS rnk
    FROM indicator_country
)
SELECT `Series Name`, `Country Name`, Total_Debt, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY `Series Name`, rnk;

-- Q24. Difference between max and min debt per country
SELECT
    `Country Name`,
    MAX(Value)              AS Max_Debt,
    MIN(Value)              AS Min_Debt,
    (MAX(Value) - MIN(Value)) AS Debt_Range
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Debt_Range DESC;

-- Q25. Create a VIEW for top 10 countries with highest debt
CREATE OR REPLACE VIEW top10_countries_by_debt AS
SELECT
    `Country Name`,
    SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Total_Debt DESC
LIMIT 10;

-- Query the view
SELECT * FROM top10_countries_by_debt;

-- Q26. Categorize countries: High / Medium / Low Debt
SELECT
    `Country Name`,
    SUM(Value) AS Total_Debt,
    CASE
        WHEN SUM(Value) >= 1e14 THEN 'High Debt'
        WHEN SUM(Value) >= 1e12 THEN 'Medium Debt'
        ELSE 'Low Debt'
    END AS Debt_Category
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Total_Debt DESC;

-- Q27. Cumulative debt per country over years (window function)
SELECT
    `Country Name`,
    Year,
    SUM(Value) AS Yearly_Debt,
    SUM(SUM(Value)) OVER (
        PARTITION BY `Country Name`
        ORDER BY Year
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Cumulative_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`, Year
ORDER BY `Country Name`, Year;

-- Q28. Indicators where average debt > overall average debt
SELECT
    `Series Name`,
    AVG(Value) AS Indicator_Avg
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Series Name`
HAVING AVG(Value) > (
    SELECT AVG(Value)
    FROM international_debt.debt_data
    WHERE Value IS NOT NULL
)
ORDER BY Indicator_Avg DESC;

-- Q29. Countries contributing more than 5% of global debt
WITH country_totals AS (
    SELECT `Country Name` as Country_Name, SUM(Value) AS Total_Debt
    FROM international_debt.debt_data
    WHERE Value IS NOT NULL
    GROUP BY `Country Name`
),
global_total AS (
    SELECT SUM(Total_Debt) AS Global_Debt
    FROM country_totals
)
SELECT
    ct.Country_Name,
    ct.Total_Debt,
    ROUND(ct.Total_Debt * 100.0 / gt.Global_Debt, 2) AS Pct_of_Global
FROM country_totals ct, global_total gt
WHERE (ct.Total_Debt * 100.0 / gt.Global_Debt) > 5
ORDER BY ct.Total_Debt DESC;

-- Q30. Most dominant indicator for each country
WITH indicator_debt AS (
    SELECT
        `Country Name`,
        `Series Name`,
        SUM(Value) AS Indicator_Debt
    FROM international_debt.debt_data
    WHERE Value IS NOT NULL
    GROUP BY `Country Name`, `Series Name`
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY `Country Name` ORDER BY Indicator_Debt DESC) AS rnk
    FROM indicator_debt
)
SELECT
    `Country Name`,
    `Series Name`     AS Dominant_Indicator,
    Indicator_Debt  AS Max_Indicator_Debt
FROM ranked
WHERE rnk = 1
ORDER BY Max_Indicator_Debt DESC;
