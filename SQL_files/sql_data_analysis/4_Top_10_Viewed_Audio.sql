SELECT
title,
platform_name,
audio,
views

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.audio = TRUE AND views IS NOT NULL

ORDER BY views DESC

LIMIT 10;

/*
-- INSIGHT
1. Top-heavy performance – Only 3 songs crossed the 1 million views mark for audio tracks
2. Consistent floor – All 10 songs have at least 600,000+ views
3. Fan favorites span multiple years – These aren't all recent releases, showing catalog depth

Recommendation:
- "Freedom" should be considered for additional promotion or a video remake given its strong audio performance
- The gap between #1 and #2 suggests "Freedom" has unique appeal worth analyzing further
*/



