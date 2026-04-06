-- Find songs with LOW views but HIGH engagement (hidden gems)
SELECT
    title,
    artiste_name,
    video,
    audio,
    views,
    likes,
    comments,
    ROUND(CAST(likes AS DECIMAL) / NULLIF(views, 0) * 100, 2) AS like_pct,
    ROUND(CAST(comments AS DECIMAL) / NULLIF(views, 0) * 100, 2) AS comment_pct,
    ROUND(CAST((likes + comments) AS DECIMAL) / NULLIF(views, 0) * 100, 2) AS engagement_rate,
    
    -- Identify undervalued songs
    CASE
        -- HIGH VALUE: Great engagement, low views (Hidden Gem)
        WHEN views BETWEEN 10000 AND 250000
            AND ROUND(CAST(likes AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 8
            AND ROUND(CAST(comments AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 0.5
        THEN '🔥 HIGH PRIORITY - Hidden Gem, Needs Promotion'
        
        -- MEDIUM VALUE: Good engagement, moderate views (Growth Opportunity)
        WHEN views BETWEEN 50000 AND 500000
            AND ROUND(CAST(likes AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 5
            AND ROUND(CAST(comments AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 0.2
        THEN '📈 MEDIUM PRIORITY - Growth Opportunity'
        
        -- LOW VALUE: Very low views but decent engagement (Test the waters)
        WHEN views < 50000
            AND ROUND(CAST(likes AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 10
            AND ROUND(CAST(comments AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 0.5
        THEN '🎯 LOW PRIORITY - Test with small budget'
        
        -- Already successful (not undervalued)
        WHEN views >= 500000
            AND ROUND(CAST(likes AS DECIMAL) / NULLIF(views, 0) * 100, 2) >= 8
        THEN '✅ Already Successful - Maintain momentum'
        
        ELSE 'Not a priority'
    END AS promotion_priority

FROM platform_metrics_dim

LEFT JOIN songs_fact ON platform_metrics_dim.song_id = songs_fact.song_id

ORDER BY promotion_priority DESC;


/*
-- INSIGHTS
1. Majority are Undervalued: A massive 60% of your catalog are "Hidden Gems" – songs with high engagement but low reach. 
This represents your single biggest opportunity for growth.
2. Vast Promotion Opportunity: In total, 84% of your catalog (High + Medium priority) needs some form of promotional support 
to reach its potential audience.
3.Small Success Rate: Only 16% of your songs are "Not a priority," meaning they have already found their audience or have low potential. 
This highlights that discovery, not quality, is the primary bottleneck.

*/