-- Some Insights from Data

-- How many olympics games have been held?
select count(distinct games) as Total_Olympics_Games
from athlete_events;

-- List down all Olympics games held so far
select distinct Year , season, city
from athlete_events
order by Year;

-- Mention the total No. of nations who participated in each olympics game?
select Games , count(distinct NOC) as Total_nations
from athlete_events
group by Games
order by Games;

-- Which year saw the highest and lowest No. of countries participating in olympics ?
with Participations as
(
select Games , count(distinct NOC) as Total_nations
from athlete_events
group by Games
order by Games
)
select distinct
concat( first_value(Games)over(order by Total_nations )  ," - ", first_value(Total_nations) over(order by Total_nations)) as Lowest_nations , 
concat( first_value(Games)over(order by Total_nations desc)  ," - ", first_value(Total_nations) over(order by Total_nations desc)) as Highest_nations 
from Participations
;

-- Which nation has participated in all of the olympic games
select region , count(distinct games) as Total_participations
from athlete_events a
join noc_regions b
on a.noc = b .noc
group by region
having  Total_participations = (select count(distinct games) from athlete_events);

--  Identify the sports which were played in all summer olympics.
with t1 as
(
select  count(distinct games) as Total_participations
from athlete_events 
where season = "Summer")
, t2 as 
(
select distinct sport , games
from athlete_events 
where Season = "summer" order by games),
t3 as (
select sport,count(games) no_of_games
from t2
group by sport
)
select *
from t3 
join t1 on t3.no_of_games= t1.Total_participations  ;

-- OR
select sport , count(distinct games) as total_participations
from athlete_events
where season = "Summer"
group by sport
having total_participations = (select count(distinct games) from athlete_events where season = "Summer");


--  Which Sports were just played only once in the olympics.
select sport , count(distinct games) as total_participations 
from athlete_events
group by sport 
having total_participations = 1;


-- Fetch the total No. of sports played in each olympic games.
select games , count(distinct sport) as total_sports
from athlete_events
group by games
order by games;

-- Find the Oldest Olympic gold medalist 
select name, sex, age, team, games, city, sport, event, medal
from athlete_events
where medal = "Gold" and age = (select max(age) from athlete_events where medal = "Gold");
-- OR
SELECT name, sex, age, team, games, city, sport, event, medal
FROM athlete_events
WHERE medal = "Gold"
ORDER BY age DESC
LIMIT 1;


-- Find the Ratio of male and female athletes participated in all olympic games.

with male as
(select count(sex) as male
from athlete_events 
where sex= 'Male'
),
female as
(select count(sex) as female
from athlete_events 
where sex= 'Female'
)
select male/female as 'Ratio(Male/Female)'
from male 
join female;

-- Fetch the top 5 athletes who have won the most gold medals.
with gold_count as
(
select name , team ,count(medal) as total_gold_medals
from athlete_events
where medal = "Gold"
group by name , team
order by total_gold_medals desc
),
ranked_athlete as
(select *,dense_rank()over(order by total_gold_medals desc) as rn
from gold_count
)
select name, team,total_gold_medals
from ranked_athlete
where rn <= 5;


-- Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
with medals_count as
(
select name, team ,count(medal) as total_medals
from athlete_events
where medal = 'Gold' or medal = 'Silver' or medal = 'Bronze'
group by name, team
order by total_medals desc
),
ranked_athlete as
(select * , dense_rank()over(order by total_medals desc) as rn
from medals_count
)
select name, team ,total_medals
from ranked_athlete
where rn <= 5;


-- Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won
with medals_count as
(
select NOC , count(medal) as total_medals 
from athlete_events
where medal in ('Gold','Silver','Bronze')
group by NOC
order by total_medals desc
),
ranked_countries as
( select * , dense_rank()over(order by total_medals desc) rnk
from medals_count
)
select region , total_medals,rnk
from ranked_countries as rc
join noc_regions n
on rc.NOC = n.NOC
where rnk <= 5;


-- List down total gold, silver and bronze medals won by each country.

with gold_count as
(
select NOC , count(medal) as Gold
from athlete_events
where medal = "Gold"
group by NOC
),
silver_count as
( 
select NOC , count(medal) as Silver
from athlete_events
where medal = "Silver"
group by NOC
),
bronze_count as
(
select NOC , count(medal) as Bronze
from athlete_events
where medal = "Bronze"
group by NOC
),
medals as
( select g.NOC , Gold , Silver , Bronze
from gold_count as g join silver_count as s on g.NOC = s.NOC
join bronze_count as b on g.NOC = b.NOC
order by Gold desc , silver desc , bronze desc
)
select region , Gold , Silver , Bronze
from medals as m
join noc_regions n
on m.NOC = n.NOC
order by Gold desc , silver desc , bronze desc;


-- List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

with gold_count as
(
select games , NOC , count(medal) as Gold
from athlete_events
where medal = 'Gold'
group by games , NOC 
),
silver_count as
(
select games , NOC , count(medal) as Silver
from athlete_events
where medal = 'Silver'
group by games , NOC 
),
bronze_count as 
(
select games , NOC , count(medal) as Bronze
from athlete_events
where medal = 'Bronze'
group by games , NOC 
),
medals as
(
select g.games , g.NOC ,Gold,Silver ,Bronze
from gold_count as g join silver_count as s on g.NOC = s.NOC and g.games = s.games
join bronze_count as b on g.NOC = b.NOC and g.games = b.games
order by games , NOC
)
select games , region , Gold , Silver , Bronze
from medals as m join noc_regions
on m.NOC = noc_regions.NOC
order by games , region ;


-- Identify which country won the most gold, most silver and most bronze medals in each olympic games.

WITH gold_medal_count AS (
    SELECT games, NOC, COUNT(medal) AS gold_count
    FROM athlete_events
    WHERE medal = "Gold"
    GROUP BY NOC, games
),
gold_ranked AS (
    SELECT *, RANK() OVER (PARTITION BY games ORDER BY gold_count DESC) AS rank_gold
    FROM gold_medal_count
),
gold_winners AS (
    SELECT games, region, gold_count
    FROM gold_ranked 
    JOIN noc_regions ON gold_ranked.NOC = noc_regions.NOC
    WHERE rank_gold = 1
),
gold_summary AS (
    SELECT games, CONCAT(region, " - ", gold_count) AS max_gold
    FROM gold_winners
    ORDER BY games
),

silver_medal_count AS (
    SELECT games, NOC, COUNT(medal) AS silver_count
    FROM athlete_events
    WHERE medal = "Silver"
    GROUP BY games, NOC
),
silver_ranked AS (
    SELECT *, RANK() OVER (PARTITION BY games ORDER BY silver_count DESC) AS rank_silver
    FROM silver_medal_count
),
silver_winners AS (
    SELECT games, region, silver_count
    FROM silver_ranked 
    JOIN noc_regions ON silver_ranked.NOC = noc_regions.NOC
    WHERE rank_silver = 1
),
silver_summary AS (
    SELECT games, CONCAT(region, " - ", silver_count) AS max_silver
    FROM silver_winners
    ORDER BY games
),

bronze_medal_count AS (
    SELECT games, NOC, COUNT(medal) AS bronze_count
    FROM athlete_events
    WHERE medal = "Bronze"
    GROUP BY games, NOC
),
bronze_ranked AS (
    SELECT *, RANK() OVER (PARTITION BY games ORDER BY bronze_count DESC) AS rank_bronze
    FROM bronze_medal_count
),
bronze_winners AS (
    SELECT games, region, bronze_count
    FROM bronze_ranked 
    JOIN noc_regions ON bronze_ranked.NOC = noc_regions.NOC
    WHERE rank_bronze = 1
),
bronze_summary AS (
    SELECT games, CONCAT(region, " - ", bronze_count) AS max_bronze
    FROM bronze_winners
    ORDER BY games
),

final_result AS (
    SELECT G.games, G.max_gold, S.max_silver, B.max_bronze
    FROM gold_summary G 
    JOIN silver_summary S ON G.games = S.games
    JOIN bronze_summary B ON G.games = B.games
)
SELECT * FROM final_result;


-- Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games
with medals_count as 
(
select games , NOC , count(medal) as Total_medals
from athlete_events
where medal in ("Gold","Silver","Bronze")
group by games , NOC
),
ranked_medals as
(
select games , NOC , total_medals,dense_rank()over(partition by games order by Total_medals desc) as rn
from medals_count
group by games , NOC
order by games
),
medals_winners as 
(
select games , region , Total_medals
from ranked_medals as rm join noc_regions on rm.NOC = noc_regions.NOC
where rn = 1
order by games
)
, 
result as
(
select games , concat(region , " - " , Total_medals) as max_Medals
from medals_winners
order by games
)
select *
 from result;
 
 
 -- Which countries have never won gold medal but have won silver/bronze medals?
 with total_medals as
 (
select NOC,
		sum(case when medal = 'Gold' then 0 else 1 end) as gold_medals,
        sum(case when medal = 'Silver' then 0 else 1 end) as silver_medals,
        sum(case when medal = 'Bronze' then 0 else 1 end) as bronze_medals
from athlete_events
where medal in ('Gold','Silver','Bronze')
group by NOC 
)
select region, silver_medals,bronze_medals
from total_medals as m join noc_regions as n 
on m.NOC = n.NOC
where gold_medals = 0 and (silver_medals > 0 OR bronze_medals > 0)
order by (silver_medals + bronze_medals) desc ;


--  In which Sport/event, Egypt has won highest medals.

with egypt_medals as
(
select sport , count(medal) as medals
from athlete_events
where NOC = "Egy" and medal in ("Gold","Silver","Bronze")
group by sport
), 
ranked_medals as
(
select * , dense_rank()over(order by medals desc) as rn
from egypt_medals
)
select sport , medals
from ranked_medals
where rn = 1;


-- Break down all olympic games where India won medal for Hockey and how many medals in each olympic games
select games , team ,sport , count(medal) as medals
from athlete_events
where team = "india" and medal in ("Gold" , "Silver" , "Bronze") and sport = 'Hockey'
group by games , team , sport 
order by games 
;