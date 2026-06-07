CREATE DATABASE if not exists international_debt;
select * from international_debt.countries
select * from international_debt.series_metadata
select * from international_debt.country_series
select * from international_debt.debt_data
select * from international_debt.footnote_data

SELECT DISTINCT `Country Name` as Country_Name
FROM international_debt.debt_data
ORDER BY Country_Name;

SELECT COUNT(DISTINCT `Country Name`) as Total_countries
FROM international_debt.debt_data

SELECT COUNT(DISTINCT `Indicator Name`) AS Total_Indicators
FROM international_debt.series_metadata;

SELECT *
FROM international_debt.debt_data
LIMIT 10;

SELECT SUM(Value) AS Total_Global_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL;

SELECT `Country Name` as Country_Name, COUNT(*) AS Record_Count
FROM international_debt.debt_data
GROUP BY Country_Name
ORDER BY Record_Count DESC;

SELECT `Country Name`, `Series Name`, Year, Value
FROM international_debt.debt_data
WHERE Value > 1000000000
ORDER BY Value DESC;

SELECT
    MIN(Value) AS Min_Debt,
    MAX(Value) AS Max_Debt,
    AVG(Value) AS Avg_Debt
FROM international_debt.debt_data
WHERE Value IS NOT NULL;

SELECT COUNT(*) AS Total_Records
FROM international_debt.debt_data;
