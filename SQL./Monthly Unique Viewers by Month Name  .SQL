Monthly Unique Viewers by Month Name


WITH viewership_clean AS (
    SELECT
        v.userid,
        v.recorddate2,
        TO_DATE(SPLIT_PART(v.recorddate2::STRING, ' ', 1), 'YYYY/MM/DD') AS record_dt
    FROM "BRIGHTLEARNTV"."PUBLIC"."VIEWERSHIP" v
    WHERE v.recorddate2 IS NOT NULL
      AND v.userid IS NOT NULL
),

viewership_time AS (
    SELECT
        vc.userid,
        vc.record_dt,
        TO_CHAR(vc.record_dt, 'YYYY') AS year_value,
        TO_CHAR(vc.record_dt, 'MM') AS month_number,
        TRIM(TO_CHAR(vc.record_dt, 'Month')) AS month_name
    FROM viewership_clean vc
)

SELECT
    year_value AS year,
    month_name,
    month_number,
    COUNT(DISTINCT userid) AS monthly_unique_viewers
FROM viewership_time
GROUP BY year_value, month_name, month_number
ORDER BY year_value, month_number;
