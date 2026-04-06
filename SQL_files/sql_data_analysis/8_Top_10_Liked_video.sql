SELECT
title,
platform_name,
video,
likes

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.video = TRUE AND likes IS NOT NULL

ORDER BY likes DESC

LIMIT 10;

/*
--INSIGHTS
1. Clear leader – "On God" has 75% more likes than #2, a much wider gap than the view count race
2. Consistent top performer – The same 3 videos (On God, Taking Over, Ayoo) rank top 3 in both views and likes
3. Strong engagement correlation – The likes ranking closely mirrors the views ranking, suggesting genuine engagement (not just passive views)
4. Collaboration impact – "Hajia Bintu" (featuring Ara B & Captan) and "1 Don" rank well, showing features drive like engagement

Recommendation:
- "On God" is the undisputed fan-favorite video – consider creating a remastered, behind-the-scenes, or live version to capitalize on its popularity
- The strong correlation between views and likes indicates organic reach – these numbers reflect real fan appreciation, not just algorithmic promotion

*/



