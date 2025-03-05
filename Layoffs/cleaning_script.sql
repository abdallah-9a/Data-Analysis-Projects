-- Data Cleaning
-- 1. Remove Duplicates
-- 2. Standardizing Date
-- 3. NULL or blanks Values
-- 4. Remove unwanted columns

-- create copy of the table to avoid any mistakes in the raw table
create table layoffs_copy
like layoffs;
insert into layoffs_copy
select *
from layoffs;
select * 
from layoffs_copy;

-- Remove Duplicates

-- Identify Duplicates
 select * ,
		row_number() over(partition by company , location ,
							industry , total_laid_off , percentage_laid_off , date ,stage,
							country,funds_raised_millions) AS row_num  -- Make the partition by all columns because there is not a primary key or a unique column
 from layoffs_copy;
 
 with cte_duplicates AS
 (
 select * ,
		row_number() over(partition by company , location ,
				industry , total_laid_off , percentage_laid_off , date ,stage,
				country,funds_raised_millions) AS row_num 
 from layoffs_copy
 )
 select * 
 from cte_duplicates
 where row_num > 1;
 
 -- Delete Duplicates
 -- Option 1 --> it doesn't efficient because there are NULLs in some columns
 WITH cte_duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, 
                            percentage_laid_off, date, stage, country, funds_raised_millions
           ) AS row_num
    FROM layoffs_copy
)
DELETE FROM layoffs_copy
WHERE (company, location, industry, total_laid_off, percentage_laid_off, 
       date, stage, country, funds_raised_millions) IN (
    SELECT company, location, industry, total_laid_off, percentage_laid_off, 
           date, stage, country, funds_raised_millions
    FROM cte_duplicates
    WHERE row_num > 1
);

-- Option 2 -->  add id columns to can delete duplicates easliy
ALTER TABLE layoffs_copy ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY First;

-- More efficient way to delete all duplicates
delete from layoffs_copy
where id IN 
(
	WITH cte_duplicates AS (
		SELECT *,
			   ROW_NUMBER() OVER (
				   PARTITION BY company, location, industry, total_laid_off, 
								percentage_laid_off, date, stage, country, funds_raised_millions
			   ) AS row_num
		FROM layoffs_copy
	)
	select id from cte_duplicates where row_num > 1
);


-- Standrdizing Data   with another words --> Make all data the same 

--  Standardize company column
select distinct company
 from layoffs_copy
 order by 1;
 
 -- Delete white spaces 
 update layoffs_copy
 set company = trim(company);
 
 
 -- standardize the industry column
 select distinct industry
 from layoffs_copy
 order by 1;
 
 -- standardize ('Crypto Currency', 'CryptoCurrency') to 'Crypto', as all of them are the same
 update layoffs_copy
 set industry = 'Crypto'
 where industry like 'Crypto%';

-- Standrdize country column
select  Distinct country
from layoffs_copy
order by 1;

-- Remove '.' 
update layoffs_copy
set country = 'United States'
where country like 'United States%';


-- Date  ---> modify the data type 
select date , str_to_date(date , '%m/%d/%Y') AS DATE
from layoffs_copy;

-- Update values
update layoffs_copy
set date = str_to_date(date , '%m/%d/%Y');

-- Change data type to DATE
alter table layoffs_copy
modify date DATE;

-- Change data type to 'total_laid_off' column
alter table layoffs_copy
modify total_laid_off int;

-- Change data type to 'percentage_laid_off' column
alter table layoffs_copy
modify percentage_laid_off float;

-- Change data type to 'funds_raised_millions' column
alter table layoffs_copy
modify funds_raised_millions int;

-- NULL and blanks values

select * 
from layoffs_copy;

-- update Blanks with NULLs
update layoffs_copy
set industry = NULL
where industry like '';

select *
from layoffs_copy
where industry is NULL ;

-- Fill missing values (NULL) in inustry column
select t1.industry , t2.industry, t1.company
from layoffs_copy AS t1
join layoffs_copy AS t2
on t1.company = t2.company
where t1.industry is null 
and t2.industry is not null;

-- As Each comapny has unique industry, then can fill NULL values by Non-NULL values that have the same company

UPDATE layoffs_copy AS t1
JOIN layoffs_copy AS t2 
ON t1.company = t2.company  
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


-- Remove the unusable or Rows

-- If the laid-off and percentage of laid-off is missing then this row will be meaningless

select *
from layoffs_copy
where total_laid_off is null 
and percentage_laid_off is null;

-- then delete these rows
delete
from layoffs_copy
where total_laid_off is null 
and percentage_laid_off is null;

select *
from layoffs_copy;

-- Id column isn't useful now, but no problem to be found
