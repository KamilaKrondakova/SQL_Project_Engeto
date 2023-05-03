# Projekt ENGETO - datová analýza


 


----

## Zadání projektu


Na analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jsme se dohodli, že se pokusíme odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Úkolem je připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

K projektu jsou použity datové sady z Portálu otevřených dat ČR.

---
## Výzkumné otázky

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?  

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?  

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?  

## Výstup projektu
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_kamila_krondakova_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t_kamila_krondakova_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

## 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Mezi rokem 2006 - 2018 klesly nejvíce mzdy v odvětví:
- peněžnictví a pojišťovnictví v roce 2013
- výroba a rozvod elekřiny a plynu v roce 2013
- těžba a dobývání v roce 2013
Největší nárůst mezd zaznamenaly odvětví:
- výroba a rozvod elektřiny a plynu v roce 2008
- těžba a dobývají v roce 2008

## 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
-  1353 l mléka v roce 2006
- 1211 kg chleba v roce 2006
- 1616 l mléka v roce 2018
- 1321 kg chleba v roce 2018

## 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Potravina s nejnižším meziročním procentuálním nárůstem je curk krystalový. 

## 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Průměrný růst cen všech produktů nebyl nikdy o 10% vyšší než průměrný růst mezd. Nejvyšší rozdíl byl v roce 2013 o 6,14%.

## 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
HDP vzrostlo v letech 2007, 2015, 2017 a 2018.
HDP velmi kleslo  v roce 2009.
V roce 2007 je výrazný růst HDP i v růstu mezd a cen, které potom výrazně narostly i v následujícím roce. 
K nárůstu HPD došlo v roce 2015, 2017 a 2018 a mzda i v tomo období roste.
Ceny výrazně vzrostly pouze v roce 2017. 
Zhodnocení: Pokles HDP se odráží i v cenách i ve mzdách. Výška HDP má vliv na změny ve mzdách a cenách potravin. 


