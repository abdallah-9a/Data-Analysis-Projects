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
    
