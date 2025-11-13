🎬 Netflix SQL Data Analysis Project
📘 Overview

This project explores a Netflix dataset using SQL to extract meaningful insights about movies and TV shows available on the platform.
It focuses on understanding content distribution by type, rating, genre, country, release year, and more.

The goal is to demonstrate how SQL can be used for data exploration, aggregation, and insight generation in real-world entertainment data.

🗄️ Database Information

Database name: netflix_db

Table name: netflix

Column Name	    Data Type	                   Description

show_id	       VARCHAR(6)	               Unique identifier for each show

type	         VARCHAR(10)	             Type of content (Movie or TV Show)

title	         VARCHAR(250)	             Title of the show

director	     VARCHAR(250)	             Director of the show

cast	         TEXT	                     Main cast members

country	       VARCHAR(150)	             Country of production

date_added	   VARCHAR(50)	             Date the show was added to Netflix

release_year	 SMALLINT	                 Year of release

rating	       VARCHAR(10)	             Content rating (e.g., PG, TV-MA)

duration	     VARCHAR(150)	             Duration (in minutes or seasons)

listed_in	     VARCHAR(250)	             Genre/category

description	   VARCHAR(250)	             Short description of the show

SQL Questions & Queries

Here’s what this project covers:

--Count the number of Movies and TV Shows

--Find the most common rating for Movies and TV Shows

--List all Movies released in a specific year

--Find the top 5 countries with the most Netflix content

--Identify the longest Movie or TV Show

--Find content added in the last 5 years

--Find all Movies/TV Shows by director ‘Rajiv Chilaka’

--List all TV Shows with more than 5 seasons

--Count the number of content items in each genre

--Find the average release year for content produced in a specific country

--List all Movies that are Documentaries

--Find all content without a director

--Find how many movies actor 'Salman Khan' appeared in last 10 years.

--Find the top 10 actors who have appeared in the highest number of movies produced in India.

-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. 
-- Count how many items fall into each category.



🧰 Tools & Technologies Used

SQL (MySQL)

Database: netflix_db

Environment: MySQL Workbench

📊 Insights You Can Gain

Country-wise content availability

Popular genres and ratings

Directors contributing most to Netflix content

Trends in release years and durations

Data quality (missing values like no director)
