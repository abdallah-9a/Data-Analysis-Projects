-- Cleaning Dataset
select * from club_member_info;

-- Handle and clean full_name Column

-- Remove Whitespaces
select full_name, TRIM(full_name)
from club_member_info;

update club_member_info
set full_name = TRIM(full_name);

-- Standardize all Entries (Lowercase)
select full_name , LOWER(full_name)
from club_member_info;

UPDATE club_member_info
set full_name = LOWER(full_name);

-- Remove Special Charcaters
select full_name
from club_member_info
where full_name like '%?%';

select full_name, TRIM(LEADING '?' FROM full_name) 
FROM club_member_info
where full_name like '%?%';

update club_member_info
set full_name = TRIM(LEADING '?' FROM full_name);

-- Seperate full_name into First name and Last name
ALTER TABLE club_member_info
ADD COLUMN first_name varchar(20) after full_name,
ADD COLUMN last_name varchar(20) AFTER first_name;

select full_name, substring_index(full_name,' ',1) as first_name, substring_index(full_name,' ', -1) as last_name
from club_member_info;

update club_member_info
set first_name = substring_index(full_name,' ', 1),
	last_name = substring_index(full_name,' ', -1);
    
select *
from club_member_info;

-- Handling Errors in Age Column

select age
from club_member_info
where age > 99;

-- There is extra digit is duplicate at end of each Age --> may be due to entry errors

select LEFT(age,2) as Age
from club_member_info
where age > 99;

UPDATE club_member_info
set age = LEFT(age,2)
where age > 99;

-- Seperate address Column into (Street, City, State) 

-- Add Street, City, and State columns
alter table club_member_info
add column street varchar(50) after full_address,
add column city varchar(50) after street,
add column state varchar(50) after city;

-- Street column
select full_address, substring_index(full_address,',',1) as street
from club_member_info;

update club_member_info
set street = substring_index(full_address,',',1);

-- City Column
select full_address, substring_index(substring_index(full_address, ',', 2), ',', -1) as city
from club_member_info;

UPDATE club_member_info
set city = substring_index(substring_index(full_address, ',', 2), ',', -1);

-- State Column
select full_address, substring_index(full_address, ',', -1) as state
from club_member_info;

UPDATE club_member_info
set state = substring_index(full_address,',',-1);

-- Set Empty to NULL

-- martial status Column
select  martial_status
from club_member_info
where martial_status ='';

update club_member_info
set martial_status = NULL
where martial_status like '';

-- Phone column
select  phone
from club_member_info
where phone ='';

update club_member_info
set phone = NULL
where phone like '';

-- job title column
select  job_title
from club_member_info
where job_title ='';

update club_member_info
set job_title = NULL
where job_title like '';

-- Handle Membership Date Column
select DISTINCT year(membership_date) as year
from club_member_info 
where year(membership_date) < 2000;

update club_member_info
set membership_date = replace(membership_date ,'19' , '20')
where year( membership_date) < 2000 ;

-- Add Id column as PK --> for easy handling duplicates

alter table club_member_info
add column id int Primary key serial default value first;

-- Remove Duplicates

with cte_duplicates as
(
select *, row_number()over(partition by first_name, last_name, age, martial_status, email, phone, job_title, membership_date) as row_num
from club_member_info
)
select *
from cte_duplicates
where row_num > 1;

delete 
from club_member_info
where id in 
(
with cte_duplicates as
(
select *, row_number()over(partition by first_name, last_name, age, martial_status, email, phone, job_title, membership_date) as row_num
from club_member_info
)
select id 
from cte_duplicates
where row_num > 1
);

-- Drop Useless Columns (full_name, full_address)

ALTER TABLE club_member_info
DROP full_name;

ALTER TABLE club_member_info
DROP full_address;