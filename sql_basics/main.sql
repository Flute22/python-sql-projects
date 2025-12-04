CREATE DATABASE campusx;

use campusx;

-- smartphones table data 
SELECT * FROM smartphones 


-- Find the PPI (Pixel Per Inches) using smartphone dataset
SELECT model, 
SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size AS PPI
FROM smartphones;


-- Retrive the rating on 10 scale
SELECT model, rating/10 from smartphones;


SELECT model, 'smartphone' AS "type" FROM smartphones;


-- Finding Distinct Brands
SELECT DISTINCT(brand_name) FROM smartphones;

SELECT DISTINCT brand_name, processor_brand 
FROM smartphones;

-- Find all samsung phones
SELECT DISTINCT brand_name, processor_brand
FROM smartphones
WHERE brand_name = 'samsung';

-- Find all phones with price > 50000
SELECT DISTINCT model, price
FROM smartphones
WHERE price > 50000;


-- Find all phones in the price range of 10000 and 20000
SELECT model, price 
FROM smartphones
WHERE price between 10000 AND 20000;

-- find phones with rating > 80 and price < 25000 
SELECT model, rating
FROM smartphones
WHERE rating > 80 AND price < 25000;


-- Find all samsung phone with ram > 8gb
SELECT model, brand_name, ram_capacity
FROM smartphones
WHERE ram_capacity > 8 AND brand_name = 'samsung';


-- Find all samsung phone with snapdragon processor 
SELECT brand_name, model, processor_brand
FROM smartphones
WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon';


/* 
Execution order of query: 
	FROM -> JOIN -> WHERE -> GROUP -> HAVING -> SELECT -> DISTINCT -> ORDER
*/


-- Find brands who sell phones with price > 50000
SELECT DISTINCT brand_name
FROM smartphones
WHERE price > 50000;


-- Find the phone which have processor (snapdragon, exynos, bionic, dimensity)
SELECT * FROM smartphones
WHERE processor_brand IN ('snapdragon', 'exynos', 'bionic', 'dimensity');


-- Find the phone which not have processor (snapdragon, exynos, bionic, dimensity)
SELECT * FROM smartphones
WHERE processor_brand NOT IN ('snapdragon', 'exynos', 'bionic', 'dimensity');


-- Update the processor brand unisoc to dimensity, Where brand_name = "samsung" AND processor_brand = "unisoc" AND ram_capacity = 4.
SELECT * FROM smartphones
WHERE brand_name = 'samsung' AND processor_brand = 'dimensity' AND ram_capacity = 4;

UPDATE smartphones
SET processor_brand = 'dimensity'
WHERE brand_name = 'samsung' AND processor_brand = 'unisoc' AND ram_capacity = 4;


SELECT AVG(battery_capacity), AVG(primary_camera_rear)
FROM smartphones
WHERE price >= 100000;


/* 
    ===> ORDER BY
*/

-- Find the top 5 smasung phones with biggest screen size
SELECT TOP 10 model, screen_size FROM smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC 


-- Sort all the phones in descending order of number of total camera
SELECT TOP 10 model, num_rear_cameras + num_front_cameras as total_cameras FROM smartphones
ORDER BY total_cameras DESC


-- Sort data on the basis of PPI in descinding 
SELECT model, 
ROUND(SQRT(CAST(resolution_width AS FLOAT) * resolution_width + 
CAST(resolution_height AS FLOAT) * resolution_height)/screen_size, 1) 
AS PPI
FROM smartphones
ORDER BY PPI DESC


-- Find the phone with 2nd largest battery 
SELECT model, battery_capacity 
FROM smartphones
ORDER BY battery_capacity DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;


-- Find the name and rating of the worst rated apple phone
SELECT TOP 1 model, rating
FROM smartphones
WHERE brand_name = 'apple'
ORDER BY rating;


-- Sort phones alphabetically then on the basis of rating in desc order 
SELECT * 
FROM smartphones
ORDER BY brand_name, rating DESC;


-- Sort phones alphabetically then on the basis of price in asc order 
SELECT * 
FROM smartphones
ORDER BY brand_name, price ASC;



/* 
    ===> GROUP BY
*/

-- Group smartphones by brand and get the count, avg price, max rating, avg screen, and avg battery_capacity.
SELECT 
    brand_name, 
    count(brand_name) AS model_count,
    avg(price) AS avg_price,
    max(rating) AS max_rating,
    avg(screen_size) AS avg_screen_size,
    avg(battery_capacity) as avg_battery_capacity
FROM smartphones
GROUP BY brand_name
ORDER BY model_count DESC;


-- Group smartphones by whether they have an NFC and get the average price and rating.
SELECT 
    has_nfc, 
    ROUND(AVG(price), 1) AS avg_price, 
    ROUND(AVG(rating), 1) AS avg_rating
FROM smartphones
GROUP BY has_nfc;


SELECT 
    has_5g, 
    ROUND(AVG(price), 1) AS avg_price, 
    ROUND(AVG(rating), 1) AS avg_rating
FROM smartphones
GROUP BY has_5g;


-- Group smartphones by the extended memory available and get the average price. 
SELECT 
    extended_memory_available,
    AVG(price)
FROM smartphones
GROUP BY extended_memory_available;


-- Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear).
SELECT 
    brand_name, 
    processor_brand, 
    count(model) AS models, 
    avg(primary_camera_rear) AS avg_camera_resolution
FROM smartphones
WHERE processor_brand IS NOT NULL
GROUP BY brand_name, processor_brand;


-- Find top 5 most costly phone brands.
SELECT TOP 5 brand_name, max(price) AS max_price
FROM smartphones
GROUP BY brand_name
ORDER BY max_price DESC;


-- Which brand make the smallest screen smartphones.
SELECT TOP 1 brand_name, ROUND(MIN(screen_size), 1) AS screen_size
FROM smartphones
GROUP BY brand_name
ORDER BY screen_size;


-- Avg price of 5g phones vs avg price of non 5g phones.
SELECT 
    has_5g, 
    avg(price) AS avg_price 
FROM smartphones
GROUP BY has_5g;


-- Group smartphones by the brand, and find the brand with the highest number of model that has both NFC and an IR blater.
SELECT TOP 1 brand_name, count(model) AS no_of_models 
FROM smartphones
WHERE has_nfc = 1 AND has_ir_blaster = 1
GROUP BY brand_name
ORDER BY no_of_models DESC;


-- Find all the samsung 5g embled smartphones and find out avg price for NFC and Non-NFC phones. 
SELECT has_nfc, AVG(price) as avg_price
FROM smartphones
WHERE brand_name = 'samsung'
GROUP BY brand_name, has_nfc;


-- Find the phone name, price of the costliest phone.
SELECT TOP 1 model, price
FROM smartphones
ORDER BY price DESC;
