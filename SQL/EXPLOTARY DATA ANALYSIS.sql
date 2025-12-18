
-- Exploratory Data Analysis (EDA)
-- Dataset: Global Layoffs (2020–2023)
-- Author: Pelin Güzey


SELECT *
FROM layoffs_staging2;

SELECT max(total_laid_off)
FROM layoffs_staging2;

SELECT min(total_laid_off)
FROM layoffs_staging2;


SELECT max(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT min(`DATE`), max(`DATE`)
FROM layoffs_staging2;

SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY year(`date`)
ORDER BY 1 DESC;

SELECT STAGE, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY STAGE
ORDER BY 2 DESC;


SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT substring(`DATE`, 1, 7) AS `MONTH` , sum(total_laid_off)
FROM layoffs_staging2
WHERE substring(`DATE`, 1, 7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC ;


WITH Rolling_Total AS
(
SELECT substring(`DATE`, 1, 7) AS `MONTH` , sum(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`DATE`, 1, 7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC 
)
SELECT `MONTH` , total_off, sum(total_off) OVER(order by `MONTH`) AS Rolling_Total
FROM Rolling_Total;



SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company, YEAR(`date`)
ORDER BY company ASC;

SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company, YEAR(`date`)
ORDER BY 3 DESC;


WITH COMPANY_YEAR (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company, YEAR(`date`)
),
Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT* 
FROM Company_Year_Rank
WHERE Ranking <= 5;






















































