-- First we modify the column birthday because there were different format with the dates, for example some rows had "dd/mm/yyy" and other had "dd-mm-yyyy" so in order to get
--an appropiate representation we standarized the format as follow and then we changed the type of variable, from a text variable to a date variable in the same columns

update dbo.hr
SET birthdate = CASE 
                WHEN birthdate LIKE '%/%' THEN (select CONVERT(date, birthdate))
                WHEN birthdate LIKE '%-%' THEN (select CONVERT(date, birthdate))
				ELSE NULL
                END
select * from dbo.hr;
-- As you can see, here we changed the variable type from text to date
ALTER TABLE dbo.hr
ALTER COLUMN birthdate DATE;

--We have to standarize this column as well in a date format
update dbo.hr
SET hire_date = CASE 
                WHEN hire_date LIKE '%/%' THEN (select CONVERT(date, hire_date))
                WHEN hire_date LIKE '%-%' THEN (select CONVERT(date, hire_date))
				ELSE NULL
                END
ALTER TABLE dbo.hr
ALTER COLUMN hire_date DATE;

--We changed the format of this column from 'yyyy-mm-dd hh:ii:ss UTC' first removing the 'UTC' parameter and then changed the format to our standarized format of date

UPDATE DBO.hr
set termdate= CASE
	  when termdate is not null then CONVERT(VARCHAR(10), CONVERT(DATETIME, REPLACE(termdate, ' UTC', '')), 120)
	  else null
	  end
select * from hr

ALTER TABLE dbo.hr
ALTER COLUMN termdate DATE;
--Finally we evaluate our tipe of variables, where our columns birthdates, hire_date and termdate now are date type
EXEC sp_help 'hr'

-- We are going to add a new column for the age of each in row, go to table > desing > we add the column and then save
UPDATE hr
SET age = DATEDIFF(YEAR, birthdate, GETDATE())
select birthdate, age from hr
SELECT 
min(age),max(age)
FROM hr

SELECT COUNT(*) FROM hr WHERE age < 18