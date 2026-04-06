SELECT
    TO_CHAR(songs_fact.release_date, 'Mon') AS month_name,
    EXTRACT(MONTH FROM songs_fact.release_date) AS month_number,
    ROUND(AVG(platform_metrics_dim.views)::DECIMAL, 0) AS average_views,
    COUNT(DISTINCT platform_metrics_dim.song_id) AS songs_released,
    SUM(platform_metrics_dim.views) AS total_views

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE release_date IS NOT NULL
  AND views IS NOT NULL

GROUP BY TO_CHAR(songs_fact.release_date, 'Mon'), EXTRACT(MONTH FROM songs_fact.release_date)

ORDER BY ROUND(AVG(platform_metrics_dim.views)::DECIMAL, 0) DESC;

/*
-- INSIGHTS
1.Best month for release is March – It delivers the highest total views (72.4M) and strong average views (852K) from 85 releases, 
making it the most reliable and consistent performer.
2. April has the highest average views (1.1M) but lower release volume – This suggests high potential, but the small sample size 
(58 songs) means results may be driven by outliers.
3. Avoid November and October – November has the worst average views (162K) despite being the most active month (126 releases), 
making it the least effective time to drop new music.
4. January has the most releases but poor returns – With 96 songs released (highest volume) but only 214K average views, this month 
represents low efficiency and wasted potential.
5. March, April, July, and May are the top 5 months – Schedule major releases in these windows for the best combination of reach, engagement, 
and total view accumulation.

*/