-- Questions

--1. What is the gender breadown of employees in the company?
SELECT gender, count(*) as Number FROM hr WHERE age >=18 and termdate is NULL GROUP BY gender
--2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, count(*) as Number FROM hr WHERE age >=18 and termdate is NULL GROUP BY race ORDER BY count(*) DESC
--3. What is the age distribution of employees in the company?
SELECT 
min(age) as youngest,
max(age) as oldest
FROM hr WHERE age >=18 and termdate is NULL

UPDATE hr
SET age_groups= CASE
	      WHEN age>=18 and age<=24 THEN '18-24'
		  WHEN age>=25 and age<=34 THEN '25-34'
		  WHEN age>=35 and age<=44 THEN '35-44'
		  WHEN age>=45 and age<=54 THEN '45-54'
		  WHEN age>=55 and age<=64 THEN '55-64'
		  ELSE '+65'
	   END

SELECT age_groups, count(*) as Number FROM hr
WHERE age >=18 and termdate is NULL
GROUP BY age_groups
ORDER BY age_groups

SELECT age_groups, gender, count(*) as Number FROM hr
WHERE age >=18 and termdate is NULL
GROUP BY age_groups, gender
ORDER BY age_groups, gender

--4. How many employees work at headquarters versus remote locations?
SELECT location,count(*) AS number FROM hr
WHERE age>=18 and termdate is NULL
GROUP BY location

--5. What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(YEAR,hire_date,termdate)),2) AS Average_length_employment FROM hr
WHERE termdate <= GETDATE() AND termdate IS NOT NULL AND age>=18

--6. How does the gender distribution vary across departments and job titles?
SELECT department, jobtitle, gender,COUNT(gender) AS number FROM hr
WHERE age>=18 and termdate is NULL
GROUP BY department, jobtitle, gender
ORDER BY department, jobtitle, gender

-- Only to select department total
SELECT department, gender, COUNT(gender) as number FROM hr
WHERE age>=18 and termdate is NULL
GROUP BY department, gender
ORDER BY department

--7. What is the distribution of job titles in the company?
SELECT jobtitle, gender, COUNT(gender) as number FROM hr
WHERE age>=18 and termdate is NULL
GROUP BY jobtitle, gender
ORDER BY jobtitle

--8. Which department has the highest turnover rate?
SELECT department, total_count, total_terminated, total_terminated/total_count AS termination_rate
FROM (SELECT department,
COUNT(*) AS total_count,
SUM(CASE WHEN termdate<=GETDATE() AND termdate IS NOT NULL THEN 1.0 ELSE 0 END) AS total_terminated
FROM hr
WHERE age>=18 
GROUP BY department
) AS subquery
ORDER BY termination_rate desc

--9: What is the distribution of employees across location by city and state? 
SELECT location_state,location_city, COUNT(*) AS number FROM hr
WHERE age>=18 AND termdate is NULL OR termdate>= GETDATE()
GROUP BY location_state, location_city
ORDER BY location_state, location_city

--10. How has the company's employee count changed over time based on hire and term dates?
SELECT year, hires, terminations, hires-terminations as net_change, round(((hires-terminations)/hires)*100,2) AS net_change_percent
FROM (
SELECT
YEAR(hire_date) as year,
COUNT(hire_date) as hires,
SUM(CASE WHEN termdate IS NOT NULL AND termdate<=GETDATE() THEN 1.0 ELSE 0 END) AS terminations
FROM hr
WHERE age>=18
GROUP BY YEAR(hire_date)
) as subquery
ORDER BY year

--11. What is the tenure distribution for each department?
SELECT department, AVG(DATEDIFF(YEAR,hire_date,termdate)) as avg_tenure
FROM hr
WHERE termdate<=GETDATE() and termdate IS NOT NULL AND age>=18
GROUP BY department
ORDER BY avg_tenure DESC
