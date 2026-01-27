-- Ultra-simple workgroup view
SELECT TOP 20
    DEPARTMENT,
    [WORK GROUP],
    COUNT(*) AS requests,
    AVG([DAYS TO CLOSE]) AS avg_days
FROM stg_kansascityrequests
WHERE [DAYS TO CLOSE] IS NOT NULL
GROUP BY DEPARTMENT, [WORK GROUP]
ORDER BY COUNT(*) DESC;