SELECT 
    [CASE ID],
    DEPARTMENT,
    [WORK GROUP],
    SOURCE,
    CATEGORY1,
    STATUS,
    DATE_CREATED,
    DATE_CLOSED,
    [DAYS TO CLOSE],
    NEIGHBORHOOD,
    YEAR(DATE_CREATED) AS creation_year,
    MONTH(DATE_CREATED) AS creation_month,
    DATENAME(MONTH, DATE_CREATED) AS month_name,
    DATEPART(QUARTER, DATE_CREATED) AS quarter
FROM stg_kansascityrequests;