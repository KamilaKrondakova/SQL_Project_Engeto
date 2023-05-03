-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


-- vytvoření tabulky t_kamila_krondakova_project_SQL_primary_final 

SELECT 
	AVG(cpri.value) AS value, 
	cpri.category_code,
	YEAR(cpri.date_from) AS year_price 
FROM czechia_price cpri
WHERE cpri.region_code IS NULL
GROUP BY cpri.category_code, YEAR(cpri.date_from);



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
-- Převod mezi roky 2006 a 2018

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