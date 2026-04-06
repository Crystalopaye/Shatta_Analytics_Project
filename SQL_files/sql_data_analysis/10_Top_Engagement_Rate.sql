SELECT
title,
EXTRACT(YEAR FROM release_date) AS year,
audio,
video,
views,
likes,
comments,

-- Calculate engagement rate as percentage
ROUND(CAST((likes + comments) AS DECIMAL) / NULLIF(views, 0) * 100, 2) AS engagement_rate

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

WHERE views > 0 -- Avoids division by zero

ORDER BY engagement_rate DESC

LIMIT 10;

-- ANALYSIS
-- Engagement Rate	            Interpretation
-- > 10%	                    Very high engagement (viral content)
-- 5% - 10%	                    Good engagement
-- 1% - 5%	                    Average engagement
-- < 1%	                        Low engagement
-- NULL	                        No views (can't calculate)

-- Most of the top 10 songs with very high engagement rate are songs from 2026, signifying a shift in fan behavior. Fans are now actively engaging with songs like never before. Could be associated to the consolidation efforts of the fanbases.


/*
-- INSIGHTS
1. 2026 is exceptional – 9 of top 10 highest-engagement songs are from 2026, suggesting a recent surge in fan connection
2. Audio dominates – Only "48Hrs (Visualizer)" is a visual format; audio slides drive higher engagement
3. "Money Man (Party Vibe)" stands out – The only 2024 song in top 10, proving longevity in fan engagement
4. Extremely high rates – Industry average is ~4%; Shatta Wale's top songs are 3-4x higher
NB: Shatta Wale's top tracks are performing at viral engagement levels – his core audience is highly active and invested.

Recommendation:
- Double down on the 2026 audio slide format – Fans are clearly engaging deeply with this content type
- Study "4Lyf - Freestyle" – At 16.07%, it's the benchmark for what drives fan interaction

*/