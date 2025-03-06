-- Cleaning Data 

select *
from warehouse_and_retail_sales;

-- Change columns Names to easliy access
ALTER TABLE warehouse_and_retail_sales
 Rename COLUMN YEAR to year,
 RENAME COLUMN MONTH TO month ,
 RENAME COLUMN SUPPLIER TO supplier ,
 RENAME COLUMN `ITEM CODE` TO item_code ,
 RENAME COLUMN `ITEM DESCRIPTION` TO item_description ,
 RENAME COLUMN `ITEM TYPE` TO item_type ,
 RENAME COLUMN `RETAIL SALES` TO retail_sales ,
 RENAME COLUMN `RETAIL TRANSFERS` TO retail_transfers ,
 RENAME COLUMN `WAREHOUSE SALES` TO warehouse_sales  ;

-- Check For Blanks 

SELECT supplier 
from warehouse_and_retail_sales 
WHERE supplier = '';

select * 
from warehouse_and_retail_sales
where item_type = '';
-- Handle Blanks
update warehouse_and_retail_sales
set supplier = null
WHERE supplier = '';

update warehouse_and_retail_sales
set item_type = null
WHERE item_type = '';
-- Check for Missing Values
select *
from warehouse_and_retail_sales
where supplier is null;
 
-- delete missing values 
delete 
from warehouse_and_retail_sales
where supplier is null;

-- Check for Negative values in (retail_sales, retail_transfers, warehouse_sales) columns

-- Count Negative values in each column
SELECT 
    SUM(CASE WHEN retail_sales < 0 THEN 1 ELSE 0 END) AS negative_retail_sales,
    SUM(CASE WHEN retail_transfers < 0 THEN 1 ELSE 0 END) AS negative_retail_transfers,
    SUM(CASE WHEN warehouse_sales < 0 THEN 1 ELSE 0 END) AS negative_warehouse_sales
FROM warehouse_and_retail_sales;

-- Identify all data that have Negative Values
select *
from warehouse_and_retail_sales
where retail_sales < 0 or retail_transfers < 0 or warehouse_sales < 0;

-- Handle Negative values
-- As there is No enough data to detect if Negative values have meaning, so consider the reason for them is Data entry Error
-- we can handle them by take absolute for each value

update warehouse_and_retail_sales
set retail_sales = abs(retail_sales)
where retail_sales < 0;

update warehouse_and_retail_sales
set retail_transfers = abs(retail_transfers)
where retail_transfers < 0;

update warehouse_and_retail_sales
set warehouse_sales = abs(warehouse_sales)
where warehouse_sales < 0;

-- Check for Duplicates
with cte_duplicates as
(
select *, row_number()over(partition by year , month , supplier , item_code , item_description , item_type , retail_sales , retail_transfers , warehouse_sales ) as row_num
from warehouse_and_retail_sales
)
select *
from cte_duplicates
where row_num > 1;

-- No Duplicates

-- ----------------------------------------------------------------------------
