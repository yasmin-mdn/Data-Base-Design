use pubs
/*1*/
SELECT top 3 p.pub_name,COUNT(p.pub_name) as number_of_emp
FROM employee e INNER JOIN publishers p ON e.pub_id=p.pub_id
GROUP by p.pub_name
ORDER by COUNT(p.pub_name) DESC
/*2*/
SELECT TOP 10  a.au_fname+a.au_lname as full_name ,a.au_id,COUNT(*) as times
FROM titleauthor ta ,authors a,sales s
WHERE a.au_id=ta.au_id and s.title_id=ta.title_id
GROUP by a.au_fname,a.au_lname,a.au_id
ORDER by COUNT(*) DESC
/*3*/
SELECT t.title
FROM titles t
WHERE t.title_id IN(
SELECT TOP 1 s.title_id
FROM sales s
GROUP by s.title_id
ORDER by COUNT(s.title_id) DESC
)
/*4*/
SELECT j.job_desc
FROM jobs j
WHERE j.job_id IN
(SELECT TOP 1 e.job_id
FROM employee e
GROUP by e.job_id
ORDER by COUNT(e.job_id) DESC)
/*5*/
SELECT st.stor_name
FROM stores st
WHERE st.stor_id IN
(SELECT TOP 1 s.stor_id
FROM sales s
GROUP by s.stor_id
ORDER by COUNT(s.stor_id) DESC)

/******************************************views******************************************/
/*1*/
CREATE VIEW PUB_INFORMATION as
WITH tmp_tbl(title_id,title,pub_id,pub_name,au_id,au_fname,au_lname) as
(
SELECT t.title_id,t.title,t.pub_id,p.pub_name,ta.au_id,a.au_fname,a.au_lname
FROM titleauthor ta INNER JOIN titles t ON t.title_id=ta.title_id
INNER JOIN publishers p ON p.pub_id=t.pub_id
INNER JOIN authors a ON ta.au_id=a.au_id
)
select t.au_fname,t.au_lname,t.pub_name,COUNT(*) as number_of_books
from tmp_tbl t
GROUP BY t.au_fname,t.au_lname,t.pub_name

SELECT * 
FROM PUB_INFORMATION


/*2*/
CREATE VIEW CHEAPBOOKS AS
SELECT T.title, T.price 
from titles T
where T.price <= (select AVG(price)
               from titles)

SELECT * 
FROM CHEAPBOOKS

/************************************************functions*******************************************/
/*1*/
CREATE FUNCTION authors_work_with(
@pub_name as varchar(40))
RETURNS TABLE
RETURN
WITH tmp_tbl(publisher_name,au_fname,au_lname) as
(
SELECT p.pub_name,a.au_fname,a.au_lname
FROM titleauthor ta INNER JOIN titles t ON t.title_id=ta.title_id
INNER JOIN publishers p ON p.pub_id=t.pub_id
INNER JOIN authors a ON ta.au_id=a.au_id
)
	SELECT *
     FROM tmp_tbl t
	WHERE t.publisher_name=@pub_name

select * FROM authors_work_with('Algodata Infosystems')

/*2*/
CREATE FUNCTION jon_in_publisher(
@pub_ID as char(4),@job_id as smallint)
RETURNS TABLE
RETURN
WITH job_tb(publisher_name,pubID,full_name,jobID,job_desc) as
(
SELECT p.pub_name,p.pub_id,e.fname +e.lname as full_name,j.job_id,j.job_desc
FROM employee e INNER JOIN  publishers p ON e.pub_id=p.pub_id
INNER JOIN jobs j ON j.job_id=e.job_id
)
	SELECT *
     FROM job_tb t
	WHERE t.pubID=@pub_ID and t.jobID=@job_id

select * FROM jon_in_publisher('1389','14')

/*3*/
CREATE FUNCTION publisher_work_with(
@a_lname as varchar(40))
RETURNS TABLE
RETURN
WITH pww(pub_name,au_lname) as
(
SELECT p.pub_name,a.au_lname
FROM titleauthor ta INNER JOIN titles t ON t.title_id=ta.title_id
INNER JOIN publishers p ON p.pub_id=t.pub_id
INNER JOIN authors a ON ta.au_id=a.au_id
)
select t.pub_name,COUNT(t.pub_name) as number_of_books
from pww t
WHERE t.au_lname=@a_lname
GROUP BY t.pub_name

select * FROM publisher_work_with('Ringer')

/*4*/
CREATE FUNCTION publisher_with_author_with_R()
RETURNS TABLE
RETURN
WITH pww(pub_name,au_lname,au_fname) as
(
SELECT p.pub_name,a.au_lname,a.au_fname
FROM titleauthor ta INNER JOIN titles t ON t.title_id=ta.title_id
INNER JOIN publishers p ON p.pub_id=t.pub_id
INNER JOIN authors a ON ta.au_id=a.au_id
)
select DISTINCT t.pub_name,t.au_lname,t.au_fname
from pww t
WHERE t.au_fname LIKE 'R%'  or t.au_lname LIKE 'R%'

select * FROM publisher_with_author_with_R()
