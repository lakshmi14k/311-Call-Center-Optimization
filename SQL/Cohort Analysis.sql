USE KansasCityRequests;
GO

-- Cohort Analysis: Year-over-Year Department Performance
WITH yearly_metrics AS (
    SELECT 
        DEPARTMENT,
        YEAR(DATE_CREATED) AS request_year,
        COUNT(*) AS total_requests,
        AVG([DAYS TO CLOSE]) AS avg_closure_days,
        SUM(CASE WHEN STATUS IN ('Closed', 'Resolved') THEN 1 ELSE 0 END) AS closed_requests,
        SUM(CASE WHEN STATUS = 'Open' THEN 1 ELSE 0 END) AS open_requests
    FROM stg_kansascityrequests
    WHERE YEAR(DATE_CREATED) BETWEEN 2018 AND 2021
        AND DEPARTMENT IS NOT NULL
    GROUP BY DEPARTMENT, YEAR(DATE_CREATED)
),
year_over_year AS (
    SELECT 
        DEPARTMENT,
        request_year,
        total_requests,
        avg_closure_days,
        closed_requests,
        LAG(total_requests) OVER (PARTITION BY DEPARTMENT ORDER BY request_year) AS prev_year_requests,
        LAG(avg_closure_days) OVER (PARTITION BY DEPARTMENT ORDER BY request_year) AS prev_year_closure_days
    FROM yearly_metrics
)
SELECT 
    DEPARTMENT,
    request_year,
    total_requests,
    prev_year_requests,
    CASE 
        WHEN prev_year_requests IS NOT NULL 
        THEN ROUND(((total_requests - prev_year_requests) * 100.0 / prev_year_requests), 2)
        ELSE NULL 
    END AS request_growth_pct,
    ROUND(avg_closure_days, 1) AS avg_days_to_close,
    ROUND(prev_year_closure_days, 1) AS prev_year_avg_days,
    CASE 
        WHEN prev_year_closure_days IS NOT NULL 
        THEN ROUND(((avg_closure_days - prev_year_closure_days) * 100.0 / prev_year_closure_days), 2)
        ELSE NULL 
    END AS closure_time_change_pct,
    closed_requests,
    ROUND((closed_requests * 100.0 / NULLIF(total_requests, 0)), 1) AS closure_rate_pct
FROM year_over_year
ORDER BY DEPARTMENT, request_year;
