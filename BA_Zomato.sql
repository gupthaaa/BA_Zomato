#step1 (connecting both the tables with country code , and joining the country column in zomato table)
SELECT *
FROM zomato
LIMIT 5;

SELECT *
FROM `country-code`
LIMIT 5;


SELECT COUNT(*) AS total_zomato_rows
FROM zomato;

SELECT COUNT(*) AS total_country_rows
FROM `country-code`;


select
	z.`Restaurant ID`,
	z.`Restaurant Name`,
	z.city,
	z.`Country Code`,
    c.Country
from zomato as z
join `country-code` as c
	on z.`Country Code`=c.`Country Code`
limit 10;


create or replace view zomato_with_country as 
select 
	z.*,
    c.Country
from zomato as z
join `country-code` as c
	on z.`Country Code`=c.`Country Code`;

select * from zomato_with_country
limit 5;


#step 2

select count(distinct `country code`) as total_countries
from zomato;

select count(distinct city) as total_cities
from zomato;

select count(distinct cuisines) as total_cuisines_types
from zomato;


select `has online delivery` , count(*) as total_resturants
from zomato
group by `has online delivery`;

select `price range` , count(*) as total
from zomato
group by `Price range`
order by total desc;


#step 3

select city , count(*) as total_restaurants
from zomato
group by city
order by total_restaurants desc
limit 10;


select country, avg(`aggregate rating`) as avg_rating, count(*) as total
from zomato_with_country
group by country 
order by avg_rating desc;

select country, count(*) as total_resturants
from zomato_with_country
group by country
order by total_resturants desc;

select `price range`, avg(`aggregate rating`) as avg_rating, count(*) as total
from zomato
group by `price range`
order by `price range`;

select `has online delivery`, avg(`aggregate rating`) as avg_rating, count(*) as total
from zomato
group by `has online delivery`;


#step 4
select country, city, `aggregate rating`, votes, `restaurant name`
from zomato_with_country
order by `aggregate rating` desc, votes desc
limit 10;

select country ,city, `restaurant name`,`aggregate rating`,votes
from zomato_with_country
where `aggregate rating` >3
order by `aggregate rating` asc
limit 10;

select cuisines, count(*) as toatl_listing, sum(votes) as toatl_votes
from zomato_with_country
group by cuisines
order by toatl_votes desc
limit 10;


select city,
		sum(case when `has online delivery` ='Yes' then 1 else 0 end) as delivery_yes,
		sum(case when `has online delivery` ='No' then 1 else 0 end) as delivery_no,
		count(*) as total,
		round(sum(case when `has online delivery`='Yes' then 1 else 0 end)/count(*)*100,2) as delivery_pct
from zomato_with_country
group by city
order by delivery_pct asc
limit 10;


select `price range`, sum(votes) as total_votes, avg(`aggregate rating`) as avg_rating, count(*) total_restaurants
from zomato_with_country
group by `price range`
order by total_restaurants desc;

#step 5
select count(*) as total_restaurants,
    count(distinct country) as total_countries,
    count(distinct city) as total_cities,
    round(avg(`aggregate rating`),2) as avg_rating_overall,
    sum(case when `has online delivery`='Yes' then 1 else 0 end) as resturants_with_delivery,
    round(sum(case when `has online delivery`='Yes' then 1 else 0 end)) as pct_with_delivery
from zomato_with_country;