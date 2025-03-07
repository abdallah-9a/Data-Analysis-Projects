-- Some Queries to investigate the data 

-- what is the total retail sales for each Supplier 
select supplier , round(sum(retail_sales),2) as Total_retail_sales
from warehouse_and_retail_sales
group by supplier 
order by Total_retail_sales desc;

-- what is the total retail sales for each Year 
select year, round(sum(retail_sales),2) as Total_retail_sales
from warehouse_and_retail_sales
group by year
order by Total_retail_sales desc;

-- what is the total retail sales for each Month 
select month, round(sum(retail_sales),2) as Total_retail_sales
from warehouse_and_retail_sales
group by month
order by Total_retail_sales desc;

-- what is the maximum warehouse sales for each item description?
select item_description, max(warehouse_sales) as Maximum_warehouse_sales
from warehouse_and_retail_sales
group by item_description
order by Maximum_warehouse_sales desc;

-- what is the average retail transfer for each month
select month, avg(retail_transfers) as Avg_retail_transfers
from warehouse_and_retail_sales
group by month 
order by avg_retail_transfers desc;

-- what is the average retail transfer for each year
select year, avg(retail_transfers) as Avg_retail_transfers
from warehouse_and_retail_sales
group by year 
order by avg_retail_transfers desc;

-- for each item description, what is the difference between the maximum and minimum retail sales? 
select item_description, (max(retail_sales) - min(retail_sales)) as Difference
from warehouse_and_retail_sales
group by item_description
order by Difference desc;

-- what is the total retail sales for each supplier, broken down by year and month
select year, month, sum(retail_sales) as Total_retail_sales
from warehouse_and_retail_sales
group by year, month
order by year, month asc;






