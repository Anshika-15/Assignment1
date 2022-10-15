/*
 Question 1
Write an SQL query to get the following result:
 ● Find all the non-local orders by looking at the salesmen that generated orders for their
   customers but are located elsewhere unlike their customers, and fetch the details like
   order_no, name of the customer, customer_id, salesman_id.
*/

SELECT c.order_no , b.name , b.id , b.salesman_id
FROM salesman a JOIN customer b
ON a.id = b.salesman_id
JOIN orders c
ON b.id = c.customer_id
WHERE a.city<>b.city
ORDER BY c.order_no


/*
Question 2 - Employee Incentive Calculation
Task:
Find amount of incentive made by each employee
*/

CREATE TABLE #incentivee_made
(actual_incentive INTEGER , employee_id INTEGER)

INSERT INTO #incentivee_made
SELECT ROUND((emp_sale/sales_milestone),2) * incentive AS actual_incentive , 
employee_id
FROM employee e
JOIN incentive_details b 
ON e.pos_id = b.p_id

SELECT e.employee_id , CASE WHEN c.actual_incentive > b.cap THEN b.cap
                            WHEN c.actual_incentive < b.cap THEN actual_incentive END AS incentive_made
FROM employee e
JOIN #incentivee_made c
ON e.employee_id = c.employee_id
JOIN incentive_details b
ON e.pos_id = b.p_id


/*
Question 3 - Research papers in institute
Task
Write an SQL Query to find subjects that contain the alphabet "b" and have papers written under
the guidance of more female mentors than male mentors.
*/

SELECT p.p_subject FROM papers p
JOIN research_paper r
ON r.p_id = p.p_id
JOIN research_mentor rm
ON r.r_id = rm.r_id
JOIN mentors m
ON rm.m_id = m.m_id
WHERE p.p_subject LIKE '%b%'
AND (SELECT COUNT(CASE WHEN m_gender ='F' THEN 1 ELSE NULL END)
FROM mentors) > (SELECT COUNT(CASE WHEN m_gender = 'M' THEN 1 ELSE NULL END) FROM mentors)



