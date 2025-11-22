---Best Performing Channels by Day of the Week

WITH viewership_clean AS (
    SELECT
        v.userid,
        v.channel2,
        v.recorddate2,
        TO_DATE(SPLIT_PART(v.recorddate2::STRING, ' ', 1), 'YYYY/MM/DD') AS record_dt
    FROM "BRIGHTLEARNTV"."PUBLIC"."VIEWERSHIP" v
    WHERE v.recorddate2 IS NOT NULL
      AND v.userid IS NOT NULL
      AND v.channel2 IS NOT NULL
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
),

-- Count unique viewers per channel per weekday
weekday_channel_viewers AS (
    SELECT
        weekday_name,
        channel2,
        COUNT(DISTINCT userid) AS unique_viewers
    FROM viewership_time
    GROUP BY weekday_name, channel2
)

-- Rank channels within each weekday
SELECT
    weekday_name,
    channel2,
    unique_viewers,
    RANK() OVER (PARTITION BY weekday_name ORDER BY unique_viewers DESC) AS rank_in_weekday
FROM weekday_channel_viewers
ORDER BY 
    CASE weekday_name
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END,
    rank_in_weekday;
