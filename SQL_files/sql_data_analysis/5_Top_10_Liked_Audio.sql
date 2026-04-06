SELECT
title,
platform_name,
audio,
likes

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.audio = TRUE AND likes IS NOT NULL

ORDER BY likes DESC

LIMIT 10;

/*
--INSIGHTS
1. Clear winner – "Ain't Nobody" has significantly higher likes than all other audio tracks
2. Strong engagement – Top 10 all have 10,000+ likes, showing loyal fan base
3. Different leader than views – Unlike the "Most Viewed" chart where "Freedom" was #1, this chart has a different top song, suggesting "Ain't Nobody" drives stronger emotional connection despite potentially lower reach

Recommendation:
- "Ain't Nobody" has exceptional like-to-view ratio potential – worth analyzing its engagement metrics further
- Consider promoting this song more heavily since fans actively show appreciation through likes
*/
