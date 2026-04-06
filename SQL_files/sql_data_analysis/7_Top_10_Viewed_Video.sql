SELECT
title,
platform_name,
video,
views

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.video = TRUE AND views IS NOT NULL

ORDER BY views DESC

LIMIT 10;

/*
-- INSIGHTS
1. Tight competition at the top – The top 2 videos are separated by only ~475,000 views (less than 2% difference)
2. Strong catalog depth – All top 10 videos have 6.8M+ views, with 6 videos crossing 10M+
3. Consistent video performance – Unlike audio where "Freedom" dominated, video views are more evenly distributed
4. Collaboration appeal – "Taking Over" (featuring Joint 77, Addi Self) and "Forgetti" (multiple features) rank highly, suggesting features boost video reach

Recommendation:
- "On God" and "Taking Over" are in a dead heat – pushing either with additional promotion could secure the #1 spot
- The tight race suggests a playlist or compilation of top 5 videos could drive significant cross-engagement

*/