-- EDA

-- Ở đây chúng ta chỉ đơn giản là khám phá dữ liệu và tìm kiếm xu hướng, mẫu hoặc bất kỳ điều gì thú vị như outlier hay bias.


SELECT * 
FROM world_layoffs.layoffs_staging2;

-- Tìm giá trị MAX của total_laid_off

SELECT MAX(total_laid_off)
FROM world_layoffs.layoffs_staging2;






-- Xem xét tỷ lệ phần trăm để thấy quy mô của những cuộc sa thải này.
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Các công ty nào có tỷ lệ 1, tức là cơ bản 100% công ty bị sa thải?
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;
-- Có lẽ các công ty khởi nghiệp đều phá sản 

-- Sắp xếp theo funcs_raised_millions:
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- BritishVolt có vẻ là một công ty xe điện (EV) đã huy động vốn 2 tỷ và phá sản
















-- SỬ DỤNG GROUP BY--------------------------------------------------------------------------------------------------

-- Các công ty có đợt sa thải lớn nhất.

SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY 2 DESC
LIMIT 5;

-- Các công ty có tổng số sa thải nhiều nhất
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;



-- Theo khu vực
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;






-- Sửa dụng truy vấn bản phụ CTEs------------------------------------------------------------------------------------------------------------------------------------

-- Công ty có đợt layoff lớn nhất theo từng năm

WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;




-- theo tháng
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- theo ngày
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;