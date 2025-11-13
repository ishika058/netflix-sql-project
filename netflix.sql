create database netflix_db;

-- Netflix Project

create table netflix(
show_id varchar(6),
type varchar(10),
title varchar(250),
director varchar(250),
cast text,
country varchar(150),
date_added varchar(50),
release_year smallint,
rating varchar(10),
duration varchar(150),
listed_in varchar(250),
description varchar(250));   


SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv'
INTO TABLE netflix
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

select * from netflix; 

-- Count the number of Movies vs TV Shows 

select distinct type,count(title) as total 
from netflix
group by type;

-- Find the most common rating for movies and TV shows.

with common_rating as (
select type, rating,
dense_rank()over(partition by type order by count(*) desc) as rnk
from netflix
group by type, rating)
select distinct type,rating
from common_rating
where rnk = 1; 

-- List all movies released in a specific year (e.g.,2020)

select title 
from netflix
where release_year = 2020;

-- Find the top 5 countries with the most content on Netflix.

with most_content as (
select country,count(title) as content_count
from netflix
group by country)
select country,content_count
from most_content
order by content_count desc
limit 5;

-- Identify the longest movie or TV show duration.

-- For movies
select title,duration
from netflix
where type = 'Movie'
AND CAST(REPLACE(duration, ' min', '') AS UNSIGNED) = (
    select MAX(CAST(REPLACE(duration, ' min', '') AS UNSIGNED))
    from netflix
    where type = 'Movie'); 
                  
-- For TV shows (estimated duration)
select title, duration,
    CAST(TRIM(REPLACE(REPLACE(duration, 'Seasons', ''), 'Season', '')) AS SIGNED) * 45 AS estimated_minutes
from netflix
where type = 'TV Show'
order by estimated_minutes desc
limit 1;

-- Find content added in the last 5 years.
select title, type,date_added
from netflix
where STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR
order by STR_TO_DATE(date_added, '%M %d, %Y') desc;

-- Find all the Movies/TV show by director 'Rajiv Chilaka'

select title,director 
from netflix 
where director = 'Rajiv Chilaka';

-- List all TV shows with more than 5 seasons.

select title,duration
from netflix
where type = 'TV Show' AND duration >= '5 Seasons';
				
-- Count the number of content items in each genre.

select listed_in AS genre,
    COUNT(*) AS total_content
from netflix
group by listed_in
order by total_content desc;

-- Find the average release year for content produced in a specific country.

select country,type,ROUND(AVG(release_year), 1) AS avg_release_year
from netflix
where country IS NOT NULL
group by country, type
order by avg_release_year desc;

-- List all movies that are documentries.

select title, listed_in
from netflix
where type = 'Movie' AND listed_in = 'Documentaries';

-- Find all content without a director.

select *
from netflix
where director IS NULL 
OR TRIM(director) = '';


-- Find how many movies actor 'Salman Khan' appeared in last 10 years.

select
    COUNT(*) AS total_movies
from netflix
where type = 'Movie'
AND cast LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10; 
  
-- Find the top 10 actors who have appeared in the highest number of movies produced in India.

WITH RECURSIVE actor_split AS (
    -- Step 1: take the first actor name
    SELECT 
        show_id,
        TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
        SUBSTRING(cast, LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2) AS remaining
    FROM netflix
    WHERE type = 'Movie' AND country LIKE '%India%' AND cast IS NOT NULL

    UNION ALL

    -- Step 2: keep splitting until no more names left
    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS actor,
        SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2)
    FROM actor_split
    WHERE remaining <> ''
)
SELECT 
    actor,
    COUNT(DISTINCT show_id) AS movie_count
FROM actor_split
GROUP BY actor
ORDER BY movie_count DESC
LIMIT 10; 

-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. 
-- Count how many items fall into each category.


SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS total_items
FROM netflix
GROUP BY content_category;  