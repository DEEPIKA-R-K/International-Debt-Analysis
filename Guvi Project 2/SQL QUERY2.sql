-- Q11. Total debt for each country
SELECT `Country Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Total_Debt DESC;

-- Q12. Top 10 countries with highest total debt
SELECT `Country Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Total_Debt DESC
LIMIT 10;

-- Q13. Average debt per country
SELECT `Country Name`, AVG(Value) AS Avg_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Avg_Debt DESC;

-- Q14. Total debt for each indicator
SELECT `Series Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Series Name`
ORDER BY Total_Debt DESC;

-- Q15. Indicator with highest total debt
SELECT `Series Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Series Name`
ORDER BY Total_Debt DESC
LIMIT 1;

-- Q16. Country with lowest total debt
SELECT `Country Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
HAVING Total_Debt > 0
ORDER BY Total_Debt ASC
LIMIT 1;

-- Q17. Total debt for each country + indicator combination
SELECT `Country Name`, `Series Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`, `Series Name`
ORDER BY Total_Debt DESC;

-- Q18. Count of indicators per country
SELECT `Country Name`, COUNT(DISTINCT `Series Name`) AS Indicator_Count
FROM international_debt.debt_data
GROUP BY `Country Name`
ORDER BY Indicator_Count DESC;

-- Q19. Countries whose total debt is above the global average
SELECT `Country Name`, SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
HAVING Total_Debt > (
    SELECT AVG(country_total)
    FROM (
        SELECT SUM(Value) AS country_total
        FROM international_debt.debt_data
        WHERE Value IS NOT NULL
        GROUP BY `Country Name`
    ) AS sub
)
ORDER BY Total_Debt DESC;

-- Q20. Rank countries by total debt (highest to lowest)
SELECT
    RANK() OVER (ORDER BY SUM(Value) DESC) AS Debt_Rank,
    `Country Name`,
    SUM(Value) AS Total_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL
GROUP BY `Country Name`
ORDER BY Debt_Rank;
