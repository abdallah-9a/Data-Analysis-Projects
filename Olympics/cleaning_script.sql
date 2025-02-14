select *
from athlete_events;

-- Cleaning Process

-- Removing white spaces 
update athlete_events
set Name = trim(Name);

-- Replace M --> Male and F --> Female in Sex column
update athlete_events
set Sex = replace(Sex,'M','Male');

update athlete_events
set Sex = replace(Sex,'F','Female');

-- Convert NA --> NULL for all columns
update athlete_events
set Age = null
where Age = 'NA';

update athlete_events
set Height = null
where Height = 'NA';

update athlete_events
set Weight = null
where Weight = 'NA';

update athlete_events
set Medal = null
where Medal = 'NA';

