--1. Who is the senior most employee based on job title?

select * from Employee  
where levels in (select max(levels) from Employee)


--2. Which countries have the most Invoices?

select  count(*),BillingCountry from invoice
group by BillingCountry
order by 1 desc

--3. What are top 3 values of total invoice?

select top 3 Total from Invoice
order by Total desc

--4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

select BillingCity,sum(Total) as 'Invoice Total' from Invoice
group by BillingCity
order by [Invoice Total] desc

--5. Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

select top 1  c.CustomerId,c.FirstName,c.LastName,sum(Total) as ToatlInvoice from Customer c
join Invoice i on c.CustomerId=i.CustomerId
group by c.CustomerId,c.FirstName,c.LastName
order by ToatlInvoice desc


-------------------------------------------Moderate Questions-------------------------------------

---1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A

select distinct c.Email,c.FirstName,c.LastName,g.Name from Customer c
join Invoice i on c.CustomerId=i.CustomerId
join InVoiceLine il on i.InvoiceId=il.InVoiceId
join Track t on il.TrackId=t.TrackId
join Genre g on t.GenreId=g.Genre
where g.Name = 'Rock' 
order by c.Email asc


--2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock band

select at.Name,count(t.TrackId) as TotalNoOfSongs from Genre g
join Track t on g.Genre=t.GenreId
join Album a on t.AlbumId=a.AlbumId
join Artist at on a.ArtistId=at.ArtistId
where g.Name='Rock'
group by at.Name
order by 2 desc


--3. Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

select Name,MilliSeconds from Track 
where MilliSeconds>= (select AVG(MilliSeconds) from Track)
order by MilliSeconds desc


--1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent

with best_selling_Artist AS (
  Select top 1  at.ArtistId,at.Name as ArtistName,sum(il.Quantity*il.UnitPrice) as TotalSpent
  from InVoiceLine il 
  join Track t on il.TrackId=t.TrackId
  join Album al on t.AlbumId=al.AlbumId
  join Artist at on al.ArtistId=at.ArtistId
  group by at.ArtistId,at.Name
  order by 3 desc
)

select c.CustomerId,c.FirstName,c.LastName,bsa.ArtistName,sum(il.Quantity*il.UnitPrice) as TotalSpent
from Customer c
join Invoice i on c.CustomerId=i.CustomerId
join InVoiceLine il on i.InvoiceId=il.InVoiceId
join Track t on il.TrackId=t.TrackId
join Album al on t.AlbumId=al.AlbumId
join best_selling_Artist bsa on al.ArtistId=bsa.ArtistId
group by c.CustomerId,c.FirstName,c.LastName,bsa.ArtistName
order by 5 desc

--2. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres

--Method 1
WITH popular_genre AS 
(
    SELECT COUNT(invoiceline.quantity) AS purchases, customer.country, genre.name, genre.genre ,
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoiceline.quantity) DESC) AS RowNo 
    FROM invoiceline 
	JOIN invoice ON invoice.invoiceid = invoiceline.invoiceid
	JOIN customer ON customer.customerid = invoice.customerid
	JOIN track ON track.trackid = invoiceline.trackid
	JOIN genre ON genre.genre = track.GenreId
	GROUP BY  customer.country, genre.name, genre.genre
)
SELECT * FROM popular_genre WHERE RowNo <= 1 order by Country asc,purchases desc

--Merhod 2
WITH 
	sales_per_country AS(
		SELECT COUNT(InVoiceLine.Quantity) AS purchases_per_genre, customer.country, genre.name, genre.Genre
		FROM InVoiceLine
		JOIN invoice ON invoice.InvoiceId = InVoiceLine.InVoiceId
		JOIN customer ON customer.CustomerId = invoice.CustomerId
		JOIN track ON track.TrackId = InVoiceLine.TrackId
		JOIN genre ON genre.Genre = track.GenreId
		GROUP BY customer.country, genre.name, genre.Genre
	),
	max_genre_per_country AS (SELECT MAX(purchases_per_genre) AS max_genre_number, country
		FROM sales_per_country
		GROUP BY Country)

SELECT sales_per_country.* 
FROM sales_per_country
JOIN max_genre_per_country ON sales_per_country.country = max_genre_per_country.country
WHERE sales_per_country.purchases_per_genre = max_genre_per_country.max_genre_number;


--3. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount

with Top_Customer as (
select c.CustomerId,c.FirstName,c.LastName,i.BillingCountry,sum(i.Total) as TotalSpent,ROW_NUMBER()over(  partition by i.BillingCountry order by sum(i.Total) desc ) as RowNum from Customer c
join Invoice i on c.CustomerId=i.CustomerId
group by c.CustomerId,c.FirstName,c.LastName,i.BillingCountry
)

select * from Top_Customer where RowNum<=1





