-- 01 Identify the artists whose paintings are displayed in multiple countries--------------------------------
select artist_id, COUNT(mus.country) as most_display_paintings
from works as wrk join museum$ as mus
on wrk.museum_id=mus.museum_id
group by wrk.artist_id
having COUNT(mus.country) >1
order by most_display_paintings desc;


-- 02 Retrieve the top 10 most popular themes of artwork.-------------------------------
select *
from subjects$
order by subjectt  desc
limit 10;


-- 03 Identify the artworks with a selling price less than half of their listed price.-------------------
select wrk.name_$
from works as wrk join product_size as prz 
on wrk.work_id=prz.work_id
where prz.sale_price<(prz.regular_price*0.5)
group by wrk.name_$;

--04 Remove duplicate entries from the artwork, product_dimensions, theme, and image tables----------------------
delete from works
where work_id in (
select work_id
from works
group by work_id, name_$, artist_id, style, museum_id
having COUNT(*)>1
);


-- 05 Identify the museums which are open on both Sunday and Monday. Display museum name, city.--------------------------
select name_$, city 
from museum$ as mus join museum_hours as mush
on mus.museum_id=mus.museum_id
where day_s in ('monday','sunday')
group by name_$, city;


-- 06 How many galleries are open every day of the week?------------------------------------------------------
select day_s, count(name_$) as single_daily_count 
from museum$ as mus join museum_hours as mush 
on mus.museum_id=mus.museum_id
group by day_s
order by single_daily_count;


-- 07 Which canvas size has the highest cost?-------------------------------------------------------------------
SELECT  MAX(sale_price) as sales_price
FROM canvas_size cs JOIN product_size ps
ON cs.size_id = ps.size_id
group by label
ORDER BY sales_price DESC
LIMIT 1;


-- 08 Are there any galleries that do not have any artworks on display?-------------------------------------------
select distinct name_$
from works
where museum_id is null;


-- 09 Identify the galleries with incorrect city information in the dataset------------------------------------------------------------
select name_$, city
from museum$
where city not like '(a-z)%';


-- 10. Which gallery has the highest number of artworks in the most popular style?----------------------------------------------------
select mus.name_$, COUNT(wrk.style) as popular_painting_style
from works wrk join museum$ mus
on wrk.museum_id=mus.museum_id
group by mus.name_$
order by popular_painting_style desc
limit 1;


-- 11. Which are the top 5 most visited galleries? (Popularity is based on the number of artworks displayed in a gallery)-------------------------------
select mus.name_$, COUNT(wrk.name_$) as popular_painting 
from works wrk join museum$ mus
on wrk.museum_id=mus.museum_id
group by mus.name_$
order by popular_painting desc
limit 5;

-- 12. How many artworks have a selling price higher than their listed price?-------------------------------------------------------------------------------------
select wrk.name_$, COUNT(wrk.name_$)painting
from works as wrk join product_size as prz
on wrk.work_id=prz.work_id
where prz.sale_price>prz.regular_price
group by wrk.name_$
order by painting;

--13. The Gallery_Hours table has one invalid entry. Identify and delete it.--------------------------------------------------------------------------------

-- 14. Display the 3 least common canvas sizes.-------------------------------------------------------------------------------------------------------------
select * from canvas_size
order by label
limit 3;


-- 15. Who are the top 5 most prolific artists? (Popularity is based on the number of artworks created by an artist)------------------------------------------
select art.full_name, COUNT(wrk.name_$) as number_of_painting 
from works wrk join artist art
on wrk.artist_id=art.artist_id
group by art.full_name, wrk.name_$
order by number_of_painting desc
limit 5;


-- 16. Which gallery is open the longest each day? Display gallery name, state, hours open, and which day---------------------------------------------------
select mus.name_$, mus.state, mush.day_s
from museum$ mus join museum_hours mush 
on mus. museum_id= mush.museum_id;


-- 17. List all the artworks that are not currently exhibited in any galleries.-----------------------------------------------------------------------------
select distinct name_$
from works
where museum_id is null;


-- 18. Which country has the fifth-highest number of artworks?---------------------------------------------------------------------------------------
SELECT mus.country, COUNT(wrk.name_$) AS highest_painting
FROM museum$ mus
JOIN works wrk ON mus.museum_id = wrk.museum_id
GROUP BY mus.country
ORDER BY highest_painting DESC
LIMIT 5;


-- 19. Which are the 3 most popular and 3 least popular styles of artwork?-----------------------------------------------------------------------------

-- most popular 
select * from works
order by style asc
limit 3 ;

-- least popular
select * from works
order by style desc
limit 3 ;


-- 20. Display the country and city with the highest number of galleries. Output two separate columns for ------------------------------------------------
-- city and country. If there are multiple values, separate them with commas.
SELECT country, city, COUNT(name_$) AS most_no_of_museum
FROM museum$
GROUP BY country, city
HAVING COUNT(name_$) > 1
ORDER BY most_no_of_museum;


-- 21. Identify the artist and gallery with the highest and lowest priced artwork. Display artist name, sale --------------------------------------------
-- price, artwork name, gallery name, gallery city, and canvas label.

-- most expensive 
select art.full_name, max(pros.sale_price) expensive, wrk.name_$ as paint_name, mus.name_$ as museum 
from  works wrk join museum$ mus
on wrk.museum_id= mus.museum_id
join  artist art
on wrk.artist_id=art.artist_id
join  product_size pros
on wrk.work_id= pros. work_id
join canvas_size cas
on pros.size_id= cas.size_id
group by art.full_name, pros.sale_price, wrk.name_$,mus.name_$,mus.city, cas.label
order by expensive desc 
limit 1;

-- least expensive
select art.full_name, max(pros.sale_price) expensive, wrk.name_$ as paint_name, mus.name_$ as museum 
from  works wrk join museum$ mus
on wrk.museum_id= mus.museum_id
join  artist art
on wrk.artist_id=art.artist_id
join  product_size pros
on wrk.work_id= pros. work_id
join canvas_size cas
on pros.size_id= cas.size_id
group by art.full_name, pros.sale_price, wrk.name_$,mus.name_$,mus.city, cas.label
order by expensive asc
limit 1;


-- 22. Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality-----------------------
select art.full_name, COUNT(wrk.name_$) most_no_of_paintings, art.artist_id
from works wrk join artist art 
on wrk.artist_id = art.artist_id
group by art.full_name, art.artist_id
order by most_no_of_paintings desc 
limit 1;























