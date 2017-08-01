-- 1. Provide a query showing Customers 
--(just their full names, customer ID and country) who are not in the US.

select c.FirstName || ' ' || c.LastName AS "Customer Name", c.CustomerID, c.Country
FROM Customer c
WHERE c.Country != "USA";

-- 2. Provide a query only showing the Customers from Brazil.

SELECT c.FirstName || ' ' || c.LastName AS "Customer Name", c.CustomerID, c.Country
FROM Customer c
WHERE c.Country = "Brazil";

-- 3. brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are 
--from Brazil. The resultant table should show the 
--customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName || ' ' || c.LastName AS "Customer Name", i.InvoiceID, i.InvoiceDate, i.BillingCountry
FROM Customer c, Invoice i
WHERE c.Country = "Brazil";

-- 4. sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT e.FirstName || ' ' || e.LastName AS "Employee Name", e.Title
FROM Employee e
WHERE e.Title = "Sales Support Agent";

-- 5. Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry
FROM Invoice;

-- 6. Provide a query that shows the invoices associated with each sales agent. 
-- The resultant table should include the Sales Agent's full name.
SELECT i.InvoiceID, i.InvoiceDate, i.Total, e.FirstName || ' ' || e.LastName AS "Sales Agent"
FROM Invoice i, Employee e, Customer c
WHERE i.CustomerId = c.CustomerID AND c.SupportRepId = e.EmployeeId;


-- 7. invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, 
-- Country and Sale Agent name for all invoices and customers.

SELECT i. Total, c.FirstName || ' ' || c.LastName AS "Customer Name", c.Country, 
	e.FirstName || ' ' || e.LastName AS "Agent Name"
FROM Employee e, Customer c, Invoice i
WHERE c.SupportRepId = e.EmployeeId;

-- 8. How many Invoices were there in 2009 and 2011?

Select SUBSTR(i.InvoiceDate, 0, 5) as "Invoice Year", count(*) as "Number of Invoices"
FROM Invoice i
Where i.InvoiceDate like "%2011%"
OR i.InvoiceDate like "%2009%"
Group By SUBSTR(i.InvoiceDate, 0, 5);

-- 9. What are the respective total sales for each of those years?

Select SUBSTR(i.InvoiceDate, 0, 5) as "Year", sum(i.total) as "Total Sales"
FROM Invoice i
Where i.InvoiceDate like "%2011%"
OR i.InvoiceDate like "%2009%"
Group By SUBSTR(i.InvoiceDate, 0, 5);

-- 10. Looking at the InvoiceLine table, 
-- provide a query that COUNTs the number of line items for Invoice ID 37.

Select il.InvoiceID as "Invoice", count(il.InvoiceLineID)
FROM InvoiceLine il
Where il.InvoiceID = 37;

--11. Looking at the InvoiceLine table, 
--provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
Select i.InvoiceID as "Invoice", count(*)
FROM Invoice i, InvoiceLine il
Where i.InvoiceID = il.InvoiceID
Group By i.InvoiceID;

-- 12. Provide a query that includes the purchased track name with each invoice line item.
SELECT t.Name, il.InvoiceID as "Invoice", il.InvoiceLineID as "Line ID"
FROM Track t, InvoiceLine il
Where il.TrackId == t.TrackID;

SELECT t.Name as "Track", il.InvoiceId as "Invoice ID", il.InvoiceLineId as "Invoice Line Item"
FROM Track t, InvoiceLine il
WHERE t.TrackId == il.TrackId;

-- 13. Provide a query that includes the purchased track name 
-- AND artist name with each invoice line item.
SELECT t.Name as "Track", 
	a.Name as "Artist",	
	il.InvoiceId as "Invoice ID", 
	il.InvoiceLineId as "Invoice Line Item"
FROM Track t, InvoiceLine il, Album al, Artist a
WHERE t.TrackId == il.TrackId
AND t.AlbumID == al.AlbumID
AND al.ArtistID == a.ArtistID;

--14. Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT i.BillingCountry as "Country", count(*)
FROM Invoice i
Group by i.BillingCountry;

-- 15. Provide a query that shows the total number of tracks in each playlist. 
-- The Playlist name should be included on the resulant table.
SELECT p.Name as "Playlist", p.PlaylistID as "Playlist ID", count(pt.trackID) as "No. Tracks"
FROM Playlist p, PlaylistTrack pt
WHERE pt.playlistID = p.playlistID
GROUP BY p.Name;

-- 16. Provide a query that shows all the Tracks, but displays no IDs. 
-- The result should include the Album name, Media type and Genre.
SELECT t.Name as "Track", 
	al.Title as "Album", 
	mt.Name as "Media Type", 
	g.Name as "Genre"
FROM Track t, Album al, MediaType mt, Genre g
WHERE t.AlbumID == al.AlbumID
AND t.MediaTypeID == mt.MediaTypeID
AND t.GenreID == g.GenreID;

--17. Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT i.invoiceID, count(il.InvoiceLineID)
FROM Invoice i, InvoiceLine il
WHERE il.InvoiceID = i.InvoiceID
GROUP BY i.invoiceID;

--18. Provide a query that shows total sales made by each sales agent.
SELECT e.FirstName || ' ' || e.LastName AS "Sales Agent", count(i.Total)
FROM Employee e, Invoice i, Customer c
Where i.CustomerID = c.CustomerID
AND c.SupportRepID = e.EmployeeID
GROUP BY e.FirstName || ' ' || e.LastName;

--19. Which sales agent made the most in sales in 2009?
SELECT e.FirstName || ' ' || e.LastName AS "Sales Agent", sum(i.Total)
FROM Employee e, Invoice i, Customer c
Where i.CustomerID = c.CustomerID
AND c.SupportRepID = e.EmployeeID
AND i.InvoiceDate like "%2009%"
Group By e.FirstName || ' ' || e.LastName
ORDER BY sum(i.Total) DESC
LIMIT 1;

--20. Which sales agent made the most in sales over all?
SELECT e.FirstName || ' ' || e.LastName AS "Sales Agent", sum(i.Total)
FROM Employee e, Invoice i, Customer c
Where i.CustomerID = c.CustomerID
AND c.SupportRepID = e.EmployeeID
GROUP BY e.FirstName || ' ' || e.LastName
ORDER BY sum(i.Total) DESC
LIMIT 1;

--21. Provide a query that shows the count of customers assigned to each sales agent.
SELECT e.FirstName || ' ' || e.LastName as "Sales Agent", COUNT(c.SupportRepID)
FROM Employee e, Customer c
WHERE c.SupportRepID = e.EmployeeID
Group By e.FirstName || ' ' || e.LastName;

--22. Provide a query that shows the total sales per country.
SELECT i.BillingCountry as "Country", COUNT(i.invoiceID)
FROM Invoice i
GROUP BY i.BillingCountry;

--23. Which country's customers spent the most?
SELECT c.Country as "Customer Country", sum(i.Total)
FROM Customer c, Invoice i
WHERE c.CustomerID = i.CustomerID
GROUP BY c.Country
ORDER BY sum(i.Total) DESC
LIMIT 1;

--24. Provide a query that shows the most purchased track of 2013.
SELECT t.Name as "Track Name", COUNT(il.TrackID) as "Times Purchased"
FROM Track t, InvoiceLine il, Invoice i
WHERE il.TrackId = t.TrackID
AND il.InvoiceId = i.InvoiceID
AND i.InvoiceDate LIKE "%2013%"
GROUP BY t.Name
ORDER BY COUNT(il.TrackID) DESC
Limit 1;

--25. Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name as "Track Name", COUNT(il.TrackID) as "Times Purchased"
FROM Track t, InvoiceLine il, Invoice i
WHERE il.TrackId = t.TrackID
AND il.InvoiceId = i.InvoiceID
GROUP BY t.Name
ORDER BY COUNT(il.TrackID) DESC
Limit 5;

-- 26. Provide a query that shows the top 3 best selling artists.

SELECT a.Name as "Artist", SUM(i.Total) as "Total Sales"
FROM Artist a, Invoice i, Track t, InvoiceLine il, Album al
WHERE a.ArtistID = al.ArtistID
AND al.AlbumID = t.AlbumID
AND t.TrackID = il.TrackID
AND il.InvoiceID = i.InvoiceID
GROUP BY a.Name
ORDER BY SUM(i.total) DESC
Limit 3;

--27. Provide a query that shows the most purchased Media Type.

SELECT mt.Name as "Media Type", COUNT(t.MediaTypeID) as "Number Sold"
FROM MediaType mt, Track t, InvoiceLine il
WHERE t.MediaTypeID = mt.MediaTypeID
AND il.TrackID = t.TrackID
GROUP BY mt.Name
ORDER BY COUNT(T.MEDIATYPEID) DESC
LIMIT 1;


