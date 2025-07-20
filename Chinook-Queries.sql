-- tables breakdown

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- content breakdown

SELECT * FROM customer
LIMIT 10;

SELECT * FROM invoice
LIMIT 10;

SELECT * FROM track
LIMIT 10;

SELECT * FROM artist
LIMIT 10;

SELECT * FROM album
LIMIT 10;

SELECT * FROM employee
LIMIT 10;

SELECT * FROM genre
LIMIT 10;

SELECT * FROM playlist
LIMIT 10;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'artist';

--  Top 5 genres by total sales

SELECT 
    g.name AS genre,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_sales
FROM 
    genre g
JOIN 
    track t ON g.genre_id = t.genre_id
JOIN 
    invoice_line il ON t.track_id = il.track_id
GROUP BY 
    g.name
ORDER BY 
    total_sales DESC
LIMIT 5;

-- Top 5 Customers by Total Spend

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(i.total), 2) AS total_spent
FROM 
    customer c
JOIN 
    invoice i ON c.customer_id = i.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC
LIMIT 5;

-- Monthly Revenue Trend

SELECT 
    TO_CHAR(i.invoice_date, 'YYYY-MM') AS month,
    ROUND(SUM(i.total), 2) AS monthly_revenue
FROM 
    invoice i
GROUP BY 
    TO_CHAR(i.invoice_date, 'YYYY-MM')
ORDER BY 
    month;

-- Top 5 Countries by Revenue

SELECT 
    billing_country,
    ROUND(SUM(total), 2) AS revenue
FROM 
    invoice
GROUP BY 
    billing_country
ORDER BY 
    revenue DESC
LIMIT 5;

-- Most Popular Artists by Track Sales
	
SELECT 
    ar.name AS artist_name,
    COUNT(il.invoice_line_id) AS total_tracks_sold
FROM 
    artist ar
JOIN 
    album al ON ar.artist_id = al.artist_id
JOIN 
    track t ON al.album_id = t.album_id
JOIN 
    invoice_line il ON t.track_id = il.track_id
GROUP BY 
    ar.name
ORDER BY 
    total_tracks_sold DESC
LIMIT 5;

-- Average Invoice Total per Country

SELECT 
    billing_country,
    ROUND(AVG(total), 2) AS avg_invoice_amount
FROM 
    invoice
GROUP BY 
    billing_country
ORDER BY 
    avg_invoice_amount DESC;

-- Top 5 Tracks by Revenue

SELECT 
    t.name AS track_name,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM 
    track t
JOIN 
    invoice_line il ON t.track_id = il.track_id
GROUP BY 
    t.track_id
ORDER BY 
    total_revenue DESC
LIMIT 5;




















