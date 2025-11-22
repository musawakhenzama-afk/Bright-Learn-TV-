--- Left Join Viewership and Split Time Stamp


WITH viewership_split AS (
    SELECT
        v.userid,
        v.channel2,
        v.recorddate2,
        SPLIT_PART(v.recorddate2::STRING, ' ', 1) AS record_date,
        SPLIT_PART(v.recorddate2::STRING, ' ', 2) AS record_time,
        v.duration2
    FROM
        "BRIGHTLEARNTV"."PUBLIC"."VIEWERSHIP" v
)

SELECT
    u.userid,
    u.name,
    u.surname,
    u.age,
    u.gender,
    u.province,
    vs.channel2,
    vs.recorddate2,
    vs.record_date,
    vs.record_time,
    vs.duration2,
    COUNT(DISTINCT vs.userid) OVER (PARTITION BY u.province) AS total_viewers_by_province
FROM
    "BRIGHTLEARNTV"."PUBLIC"."USERPROFILES" u
LEFT JOIN
    viewership_split vs
ON
    u.userid = vs.userid
ORDER BY
    total_viewers_by_province DESC;
