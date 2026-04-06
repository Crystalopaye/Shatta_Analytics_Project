SELECT
title,
platform_name,
audio,
comments

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.audio = TRUE AND comments IS NOT NULL

ORDER BY comments DESC

LIMIT 10;

/*
--INSIGHTS
1. Dominant leader – "Ain't Nobody" has 2x more comments than the #2 song, indicating strong fan discussion and emotional connection
2. Diss tracks generate conversation – "Little Tip [Sarkodie Diss]" ranks #6, showing controversial content drives engagement
3. Consistent performer – "Jail Man" and "On God" appear across all engagement metrics (views, likes, comments), proving they are fan favorites

Recommendation:
- "Ain't Nobody" is not just liked but actively discussed – invest in promoting this song further (video, remix, or live performance)
- Diss tracks clearly drive comments – consider strategic releases to spark conversation when appropriate

*/