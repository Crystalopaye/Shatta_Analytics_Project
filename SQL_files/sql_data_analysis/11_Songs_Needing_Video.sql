-- Recommended Thresholds for Video Investment
-- Tier 1: Minimum Requirements (Consider Video)
-- Metric	            Threshold	                Rationale
-- Views	            100,000+	                Proven audience reach
-- Likes	            4,000+ (4% of views)	    Above average engagement
-- Comments	            500+ (0.5% of views)	    Strong audience interaction

-- Tier 2: Strong Candidate (Should Make Video)
-- Metric	            Threshold	                Rationale
-- Views	            250,000+	                Significant reach
-- Likes	            20,000+ (8% of views)	    High engagement
-- Comments	            1,250+ (0.5% of views)	    Active discussion

-- Tier 3: Must Make Video (High Priority)
-- Metric	            Threshold	                Rationale
-- Views	            500,000+	                Viral potential
-- Likes	            40,000+ (8%+ of views)	    Exceptional like ratio
-- Comments	            2,500+ (0.5%+ of views)	    Strong community response

-- Decision query
SELECT 
    s.title,
    p.views,
    p.likes,
    p.comments,
    ROUND(CAST(p.likes AS DECIMAL) / NULLIF(p.views, 0) * 100, 2) AS like_pct,
    ROUND(CAST(p.comments AS DECIMAL) / NULLIF(p.views, 0) * 100, 2) AS comment_pct,
    CASE 
        WHEN s.video = FALSE 
             AND (CAST(p.likes AS DECIMAL) / NULLIF(p.views, 0) * 100) >= 8
             AND (CAST(p.comments AS DECIMAL) / NULLIF(p.views, 0) * 100) >= 0.5
        THEN '🔥 HIGH PRIORITY - Make Video NOW'
        
        WHEN s.video = FALSE 
             AND (CAST(p.likes AS DECIMAL) / NULLIF(p.views, 0) * 100) >= 4
             AND (CAST(p.comments AS DECIMAL) / NULLIF(p.views, 0) * 100) >= 0.04
             AND p.views >= 100000
        THEN '✅ RECOMMENDED - Should Make Video'
        
        WHEN s.video = FALSE 
             AND p.views >= 50000
        THEN '📊 MONITOR - Consider if engagement improves'
        
        WHEN s.video = TRUE THEN '🎬 Has Video - Track Performance'
        
        ELSE '⏸️ LOW PRIORITY - Not Ready'
    END AS video_recommendation
FROM public.songs_fact s
JOIN public.platform_metrics_dim p ON s.song_id = p.song_id
WHERE p.platform_name = 'YouTube'
ORDER BY video_recommendation DESC;

/*
-- INSIGHTS
Catalog Health is Strong
1. ~45% of songs already have videos – solid foundation
2. This means nearly half your catalog is fully developed

Immediate Opportunity (15%)
1. ~15% of songs are RECOMMENDED for video creation
2. These are your lowest-hanging fruit – good engagement, no video yet
3. Prioritize these before they lose momentum

Monitoring Required (25%)
1. The largest segment after "Has Video" is MONITOR (25%)
2. These songs have potential but aren't there yet
3. Action: Re-evaluate in 30-60 days

Low Priority (15%)
1. Only 15% are truly "not ready"
2. This is good – most of your catalog has at least some potential

*/