-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


-- Kód 5958 = kód pro mzdy

-- vytvoření tabulky t_kamila_krondakova_project_SQL_primary_final 

SELECT 
	AVG(cpri.value) AS value, 
	cpri.category_code,
	YEAR(cpri.date_from) AS year_price 
FROM czechia_price cpri
WHERE cpri.region_code IS NULL
GROUP BY cpri.category_code, YEAR(cpri.date_from);

SELECT *
FROM czechia_price_category cpc
WHERE name LIKE '%mléko%' OR name LIKE '%chléb%';

CREATE OR REPLACE TABLE czechia_payroll_new AS
	SELECT
		AVG(cpay.value) AS salary,
		cpay.industry_branch_code,
		cpib.name AS industry,
		cpay.payroll_year AS year_salary
	FROM czechia_payroll cpay 
	LEFT JOIN czechia_payroll_industry_branch cpib 
		ON cpay.industry_branch_code = cpib.code 
	WHERE cpay.value_type_code = 5958
	GROUP BY cpay.industry_branch_code, cpay.payroll_year
	ORDER BY cpay.payroll_year, cpay.industry_branch_code;
	
SELECT *
FROM czechia_payroll_new cpn;

CREATE OR REPLACE TEMPORARY TABLE czechia_prices_new AS
	SELECT 
		AVG(cpri.value) AS value, 
		cpri.category_code,
		cpc.name AS item,
		YEAR(cpri.date_from) AS year_price 
	FROM czechia_price cpri
	JOIN czechia_price_category cpc 
		ON cpri.category_code = cpc.code 
	WHERE cpri.region_code IS NULL
	GROUP BY cpri.category_code, YEAR(cpri.date_from);

SELECT *
FROM czechia_prices_new;
	

CREATE TABLE IF NOT EXISTS t_kamila_krondakova_project_SQL_primary_final AS
	SELECT *
	FROM czechia_payroll_new cpn 
	JOIN czechia_prices_new cpn2 
		ON cpn.year_salary = cpn2.year_price;
		
	SELECT *
	FROM t_kamila_krondakova_project_sql_primary_final tkkpspf;
	
-- Tabulka 2
-- Vytvoření tabulky t_kamila_krondakova_project_SQL_secondary_final AS

CREATE OR REPLACE TABLE t_kamila_krondakova_project_SQL_secondary_final AS
	SELECT 
		e.country,
		e.`year`,
		e.GDP,
		e.population,
		e.gini
	FROM economies e 
	JOIN countries c 
		ON e.country = c.country 
	WHERE c.continent = 'Europe'
		AND e.`year` BETWEEN 2006 AND 2018
	ORDER BY e.country, e.`year`;
	
-- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH salaries AS (
	SELECT DISTINCT 
		year_salary,
		industry_branch_code,
		industry,
		salary
	FROM t_kamila_krondakova_project_SQL_primary_final tms
	WHERE industry_branch_code IS NOT NULL
	)
SELECT 
	*,
	LAG(salary) OVER (PARTITION BY industry_branch_code ORDER BY year_salary) AS salary_prev,
	ROUND((salary - LAG(salary) OVER (PARTITION BY industry_branch_code ORDER BY year_salary)) * 100 / LAG(salary) OVER (PARTITION BY industry_branch_code ORDER BY year_salary), 2) AS salary_growth
FROM salaries
ORDER BY salary_growth;

-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	salary,
	industry,
	year_salary,
	value,
	item,
	FLOOR(salary / value) AS value_entry
FROM t_kamila_krondakova_project_sql_primary_final tkkpspf 
WHERE year_salary IN (2006, 2018)
	AND (item LIKE '%mléko%' OR item LIKE '%chléb%')
	AND industry_branch_code IS NULL;
	
-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

	
SELECT 
	y.*,
	ROUND((y.value - y.previous_price) * 100 / y.previous_price, 2) AS price_result
FROM (
	SELECT 
		x.*,
		ROUND(LAG(value) OVER (PARTITION BY category_code ORDER BY year_price), 3) AS previous_price
	FROM (
		SELECT DISTINCT 
			year_price,
			value,
			category_code,
			item
		FROM t_kamila_krondakova_project_sql_primary_final tkkpspf 
		) x
	) y
WHERE y.previous_price IS NOT NULL
ORDER BY price_result;

-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT
	*,
	LAG(salary) OVER (ORDER BY year_salary) AS previous_salary
FROM (
	SELECT DISTINCT 
		year_salary,
		salary
	FROM t_kamila_krondakova_project_sql_primary_final tkkpspf 
	WHERE industry_branch_code IS NULL
	) x;
	
-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

SELECT 
	`year`,
	GDP,
	LAG(GDP) OVER (ORDER BY `year`) AS previous_GDP,
	ROUND((GDP - (LAG(GDP) OVER (ORDER BY `year`))) * 100 / (LAG(GDP) OVER (ORDER BY `year`)), 2) AS GDP_growth
FROM t_kamila_krondakova_project_sql_secondary_final tkkpssf
WHERE country = 'Czech Republic';