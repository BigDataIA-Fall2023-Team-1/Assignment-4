USE ROLE HOL_ROLE;
USE WAREHOUSE HOL_WH1;

-- Step 1 to execute
CREATE TABLE HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS AS
SELECT
  COUNTRY,
  TOTAL_CASES,
  CASES_NEW,
  DEATHS,
  DEATHS_NEW,
  TRANSMISSION_CLASSIFICATION,
  DAYS_SINCE_LAST_REPORTED_CASE,
  COUNTRY_REGION,
  DATE,
  SITUATION_REPORT_NAME,
  LAST_UPDATE_DATE,
  LAST_REPORTED_FLAG
FROM COVID19_DATA.PUBLIC.WHO_SITUATION_REPORTS;

-- Step 2: Insert cleaned data into the new table
INSERT INTO HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS
SELECT
  COUNTRY,
  TOTAL_CASES,
  CASES_NEW,
  DEATHS,
  DEATHS_NEW,
  TRANSMISSION_CLASSIFICATION,
  DAYS_SINCE_LAST_REPORTED_CASE,
  COUNTRY_REGION,
  DATE,
  SITUATION_REPORT_NAME,
  LAST_UPDATE_DATE,
  LAST_REPORTED_FLAG
FROM COVID19_DATA.PUBLIC.WHO_SITUATION_REPORTS;


-- Step 3: Add a new column for the division result (assuming it's the 13th column)
-- ALTER TABLE HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS
-- ADD COLUMN MORTALITY DECIMAL(18, 4); -- Adjust precision and scale as needed

-- Step 4: Update the new column with the division result, handling division by zero
UPDATE HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS
SET MORTALITY = CASE WHEN TOTAL_CASES <> 0 THEN DEATHS / TOTAL_CASES ELSE NULL END;

SELECT * from HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS limit 1000;

-- Optional: If you want to make the new column NOT NULL, you can alter the table again
-- ALTER TABLE HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS
-- MODIFY COLUMN MORTALITY DECIMAL(18, 4) NOT NULL; -- Adjust precision and scale as needed





-- For checking if the data is correct or not
-- SELECT * FROM COVID19_DATA.PUBLIC.WHO_SITUATION_REPORTS LIMIT 100;
-- SELECT * from HOL_DB1.COVID_WORLDWIDE.CLEANED_WORLD_HEALTH_TESTS limit 1000;


