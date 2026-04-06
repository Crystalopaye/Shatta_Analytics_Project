SELECT
title,
platform_name,
video,
comments

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE songs_fact.video = TRUE AND comments IS NOT NULL

ORDER BY comments DESC

LIMIT 10;


/*
-- INSIGHTS
1. "On God" dominates all metrics – #1 in views, likes, AND comments (trifecta)
2. Collaborations drive conversation – "Accra" (featuring 8+ artists) and "Hajia Bintu" (featuring Ara B & Captan) rank high in comments, suggesting features spark discussion
3. "Street Crown" overperforms – #3 in comments but not in top 10 views/likes, indicating this song sparks unique conversation
4. Lyric video engagement – "Cash Out (Official Lyric Video)" made the top 10, showing lyric videos can drive comment activity

Recommendation:
- "Accra" has strong conversation potential – consider promoting it further or creating a follow-up collaboration
- "Street Crown" deserves investigation – why are fans commenting more than liking/viewing? Could be controversy, questions, or emotional connection

*/