select *
from nashville_housing
;
-- Rename Columns to easy access 
alter table nashville_housing
RENAME Column UniqueID to id,
Rename Column ParcelID to parcel_id,
Rename Column LandUse to land_use,
Rename Column PropertyAddress to property_address,
Rename Column SaleDate to sale_date,
Rename Column SalePrice to sale_price,
Rename Column LegalReference to legal_reference,
Rename Column SoldAsVacant to sold_as_vacant,
Rename Column OwnerName to owner_name,
Rename Column OwnerAddress to owner_address,
Rename Column Acreage to acreage,
Rename Column TaxDistrict to tax_district,
Rename Column LandValue to land_value,
Rename Column BuildingValue to building_value,
Rename column TotalValue to total_value,
Rename Column YearBuilt to built_year,
Rename Column Bedrooms to bedrooms,
Rename Column FullBath to full_bath,
Rename Column HalfBath to half_bath;

-- property_address must be spilt into address, and city

alter table nashville_housing
add column property_street varchar(50),
add column property_city varchar(50);

-- modify the position of columns

ALTER TABLE nashville_housing
MODIFY COLUMN property_street VARCHAR(50) AFTER property_address;

ALTER TABLE nashville_housing
MODIFY COLUMN property_city VARCHAR(50) AFTER property_street;

-- street 
select property_address , substring_index(property_address , ',' , 1) as street
from nashville_housing;

update nashville_housing
set property_street = substring_index(property_address , ',' , 1);

-- city 
select property_address , substring_index(property_address ,',' ,-1) as city
from nashville_housing;

update nashville_housing
set property_city = substring_index(property_address ,',' ,-1);

-- owner_address must be spilt into street, city , and state
alter table nashville_housing
add column owner_street varchar(50) after owner_address,
add column owner_city varchar(50) after owner_street,
add column owner_state varchar(50) after owner_city ;

-- Street
select owner_address , substring_index(owner_address , ',' , 1) as street
from nashville_housing ;

update nashville_housing
set owner_street = substring_index(owner_address , ',' , 1) ;

-- city 
select owner_address , substring_index(substring_index(owner_address , ',' , 2) , ',' ,-1 ) as city
from nashville_housing ;

update nashville_housing
set owner_city = substring_index(substring_index(owner_address , ',' , 2) , ',' ,-1 );

-- state 
select owner_address , substring_index(owner_address , ',' , -1) as state
from nashville_housing ;

update nashville_housing
set owner_state = substring_index(owner_address , ',' , -1) ;

-- standardize sold_as_vacant column 
select distinct sold_as_vacant 
from nashville_housing ;

-- change Y to Yes
update nashville_housing
set sold_as_vacant = 'Yes'
where sold_as_vacant = 'Y';

-- change N to No
update nashville_housing
set sold_as_vacant = 'No'
where sold_as_vacant = 'N';

-- Remove duplicates

-- Finding Duplicates By CTE
WITH duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY parcel_id, land_use, sale_date, sale_price, legal_reference 
               ORDER BY parcel_id
           ) AS row_num
    FROM nashville_housing
)
select *
from duplicates
where row_num >1 ;

-- Deleting Duplicates
WITH duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY parcel_id, land_use, sale_date, sale_price, legal_reference 
               ORDER BY parcel_id
           ) AS row_num
    FROM nashville_housing
)
DELETE FROM nashville_housing
WHERE id IN (
    SELECT id FROM duplicates WHERE row_num > 1
);

-- Delete columns that has been refined
alter table nashville_housing
drop column property_address , 
drop column owner_address;

-- Remove Missing values

-- Dataset has some missing values in some column --> so deleting these rows is most efficient method
select *
from nashville_housing
where owner_name = ''
and owner_street = ''
and  owner_city = ''
and owner_state = ''
and acreage = ''
and tax_district = ''
and land_value = '';

delete
from nashville_housing
where owner_name = ''
and owner_street = ''
and  owner_city = ''
and owner_state = ''
and acreage = ''
and tax_district = ''
and land_value = '';

select *
from nashville_housing;


-- Standardize Columns and their Data types
 
   -- sold_as_vacant column is about (Yes/No) --> so can convert to binary type (1/0)
 update nashville_housing
 set sold_as_vacant = case
	when sold_as_vacant = 'Yes' then 1
    when sold_as_vacant = 'No' then 0
    END;
-- Standardize sale_price column -->  remove $ sign from column
update nashville_housing
set sale_price = replace(sale_price,'$','');

UPDATE nashville_housing 
SET sale_price = REPLACE(sale_price, ',', '');


-- Standardize Empty values to NULL
update nashville_housing
set built_year = null
where built_year = '';

update nashville_housing
set property_street = null
where property_street = '';

update nashville_housing
set property_city = null
where property_city = '';

update nashville_housing
set owner_name = null
where owner_name = '';

update nashville_housing
set bedrooms = null
where bedrooms = '';

update nashville_housing
set full_bath = null
where full_bath = '';

update nashville_housing
set half_bath = null
where half_bath = '';

	-- Change columns' Data types
 alter table nashville_housing
 modify column land_use varchar(50),
 modify column sale_date date,
 modify column sale_price int,
 modify column legal_reference varchar(50),
 modify column sold_as_vacant TINYINt(1),
 modify column owner_name varchar(100),
 modify column acreage decimal(5,2),
 modify column tax_district varchar(50),
 modify column land_value int,
 modify column building_value int,
 modify column total_value int,
 modify column built_year int,
 modify column bedrooms int,
 modify column full_bath int,
 modify column half_bath int;
 