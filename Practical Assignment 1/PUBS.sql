use pubs
/*1*/
SELECT t.title
FROM titles as t
WHERE t.price>=10 and t.price<=15
/*2*/
SELECT *
FROM titles as t
WHERE t.type='business'
/*3*/
SELECT TOP 5 t.title,t.price,a.au_fname,a.au_lname
FROM titles as t, authors as a , titleauthor as ta
WHERE t.price IS NOT NULL and ta.au_id=a.au_id and ta.title_id=t.title_id
ORDER BY (t.price) DESC
/*4*/
SELECT *
FROM titles as t
WHERE t.title_id IN 
(SELECT  s.title_id
 FROM sales as s
 WHERE YEAR(s.ord_date)='1993'
)
/*5*/
SELECT *
FROM employee as e
 WHERE DATEDIFF(year,e.hire_date,GETDATE())>=30
/*6*/
SELECT p.pub_name
FROM publishers as p
WHERE  p.pub_id IN (SELECT CASE WHEN COUNT(t.pub_id)>5 THEN t.pub_id END
		FROM titles t
		GROUP BY t.pub_id
		) 

SELECT p.pub_name
FROM publishers as p
WHERE  p.pub_id IN (SELECT t.pub_id 
		FROM titles t
		GROUP BY t.pub_id
		HAVING COUNT(t.pub_id)>5
		) 


		




