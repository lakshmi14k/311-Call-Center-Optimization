USE KansasCityRequests;
GO

-- Priority Request Analysis - Long-Running Cases
WITH request_metrics AS (
    SELECT 
        [CASE ID],
        DEPARTMENT,
        [WORK GROUP],
        TYPE,
        CATEGORY1,
        NEIGHBORHOOD,
        [DAYS TO CLOSE],
        STATUS,
        NTILE(100) OVER (ORDER BY [DAYS TO CLOSE] DESC) AS percentile_rank
    FROM stg_kansascityrequests
    WHERE [DAYS TO CLOSE] IS NOT NULL
)
SELECT 
    DEPARTMENT,
    CATEGORY1,
    COUNT(*) AS request_count,
    ROUND(AVG([DAYS TO CLOSE]), 1) AS avg_days_to_close,
    MAX([DAYS TO CLOSE]) AS max_days_to_close,
    SUM(CASE WHEN percentile_rank <= 10 THEN 1 ELSE 0 END) AS top_10_pct_slowest_count,
    ROUND(
        SUM(CASE WHEN percentile_rank <= 10 THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(COUNT(*), 0),
        1
    ) AS pct_in_slowest_10
FROM request_metrics
GROUP BY DEPARTMENT, CATEGORY1
HAVING COUNT(*) >= 100  -- Only substantial volumes
ORDER BY avg_days_to_close DESC;