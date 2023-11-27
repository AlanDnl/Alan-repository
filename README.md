# HR Employee Distribution Project
## Table of contents
- [Project overview](#project-overview)
- [Data sources](#data-sources)
- [Tools](#tools)
- [Data cleaning/preparation](#data-cleaning/preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results/findings](#results/findings)
- [References](#references)

## Project overview
------

This data analysis project aims to solve business questions in order to analyze and visualize HR employees distribution along the company. Furthermore, build a visual data story or dashboard using Power BI to present to the stakeholders.

So, the methodology involves standard, clean and analyize the information due to some of the columns were in different format dates.

## Data Sources
Human Resources: The primary dataset used for this analysis is the "Human_Resources.csv" file, containing detailed information about each employee, the hire and termination dates, department and other personal information since 2000 to 2020.

## Tools
- SQL server: Data cleaning and Data analysis
- Power BI: Creating report

## Data cleaning/preparation
1. Data loading and inspection
2. Handling missing values
3. Data cleaning and formatting

## Exploratory Data Analysis

The project has to answer the next 11 questions:
1. What is the gender breadown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles in the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across location by city and state?
10. How has the company's employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

## Data Analysis
Include some interesting code/features worked with
``` sql
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
```
## Results/findings
![image](https://github.com/AlanDnl/HR-Employee-Distribution/assets/150567418/a0797a19-36de-4a6b-bb74-6a025e3098da)
![image](https://github.com/AlanDnl/HR-Employee-Distribution/assets/150567418/0d1ea895-ebb7-434d-a571-72bd7417ab19)

## References
1. SQL & PowerBI Portfolio Project for Data Analysts [https://www.youtube.com/watch?v=PzyZI9uLXvY]
2. SQL Tutorial [https://www.w3schools.com/sql/default.asp]
3. Microsoft SQL Server 2022 | date (Transact-SQL) [https://learn.microsoft.com/es-es/sql/t-sql/data-types/date-transact-sql?view=sql-server-ver16]

