WITH viewership_clean AS (
    SELECT
        v.userid,
        v.channel2,
        v.recorddate2,
        TO_DATE(SPLIT_PART(v.recorddate2::STRING, ' ', 1), 'YYYY/MM/DD') AS record_dt
    FROM "BRIGHTLEARNTV"."PUBLIC"."VIEWERSHIP" v
    WHERE v.recorddate2 IS NOT NULL
      AND v.userid IS NOT NULL
),

viewership_time AS (
    SELECT
        vc.userid,
        vc.channel2,
        vc.record_dt,
        TO_CHAR(vc.record_dt, 'YYYY') AS year_value,
        TO_CHAR(vc.record_dt, 'MM') AS month_value,
        TO_CHAR(vc.record_dt, 'Month') AS month_name  -- FULL MONTH NAME
    FROM viewership_clean vc
)

SELECT
    year_value AS year,
    TRIM(month_name) AS month_name,
    month_value AS month_number,
    COUNT(DISTINCT userid) AS monthly_unique_viewers
FROM viewership_time
GROUP BY year_value, month_name, month_value
ORDER BY year_value, month_value;

---Weekly Viewership 

WITH viewership_clean AS (
    SELECT
        v.userid,
        v.channel2,
        v.recorddate2,
        TO_DATE(SPLIT_PART(v.recorddate2::STRING, ' ', 1), 'YYYY/MM/DD') AS record_dt
    FROM "BRIGHTLEARNTV"."PUBLIC"."VIEWERSHIP" v
    WHERE v.recorddate2 IS NOT NULL
      AND v.userid IS NOT NULL
),

viewership_time AS (
    SELECT
        vc.userid,
        vc.channel2,
        vc.record_dt,
        CASE DAYOFWEEK(vc.record_dt)
            WHEN 1 THEN 'Sunday'
            WHEN 2 THEN 'Monday'
            WHEN 3 THEN 'Tuesday'
            WHEN 4 THEN 'Wednesday'
            WHEN 5 THEN 'Thursday'
            WHEN 6 THEN 'Friday'
            WHEN 7 THEN 'Saturday'
        END AS weekday_name
    FROM viewership_clean vc
)

SELECT
    weekday_name,
    COUNT(DISTINCT userid) AS unique_viewers
FROM viewership_time
GROUP BY weekday_name
ORDER BY 
    CASE weekday_name     -- ensures correct calendar order
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;
