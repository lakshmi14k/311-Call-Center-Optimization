USE KansasCityRequests;
GO

-- Quick validation check
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT [CASE ID]) AS unique_cases,
    COUNT(DISTINCT DEPARTMENT) AS unique_departments,
    COUNT(DISTINCT SOURCE) AS unique_sources,
    COUNT(DISTINCT STATUS) AS unique_statuses,
    MIN(DATE_CREATED) AS earliest_date,
    MAX(DATE_CREATED) AS latest_date,
    SUM(CASE WHEN DATE_CLOSED IS NULL THEN 1 ELSE 0 END) AS closed_date_nulls,
    SUM(CASE WHEN [DAYS TO CLOSE] IS NULL THEN 1 ELSE 0 END) AS days_to_close_nulls
FROM stg_kansascityrequests;