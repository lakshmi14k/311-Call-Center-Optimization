USE KansasCityRequests;
GO

-- Source Channel Efficiency Analysis
SELECT 
    SOURCE,
    COUNT(*) AS total_requests,
    ROUND(AVG([DAYS TO CLOSE]), 1) AS avg_days_to_close,
    MIN([DAYS TO CLOSE]) AS min_days,
    MAX([DAYS TO CLOSE]) AS max_days,
    SUM(CASE WHEN STATUS IN ('Closed', 'Resolved') THEN 1 ELSE 0 END) AS closed_count,
    ROUND(
        SUM(CASE WHEN STATUS IN ('Closed', 'Resolved') THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(COUNT(*), 0), 
        1
    ) AS closure_rate_pct,
    SUM(CASE WHEN [DAYS TO CLOSE] <= 30 THEN 1 ELSE 0 END) AS closed_within_30_days,
    ROUND(
        SUM(CASE WHEN [DAYS TO CLOSE] <= 30 THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(SUM(CASE WHEN STATUS IN ('Closed', 'Resolved') THEN 1 ELSE 0 END), 0),
        1
    ) AS pct_closed_within_30_days
FROM stg_kansascityrequests
WHERE SOURCE IS NOT NULL
GROUP BY SOURCE
ORDER BY total_requests DESC;