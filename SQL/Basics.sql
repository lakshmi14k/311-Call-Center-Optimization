SELECT TOP 100 *
FROM dbo.stg_kansascityrequests;

SELECT COUNT(*) AS total_rows
FROM stg_kansascityrequests;

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'stg_kansascityrequests'
ORDER BY ORDINAL_POSITION;

SELECT *
FROM dbo.stg_kansascityrequests;
