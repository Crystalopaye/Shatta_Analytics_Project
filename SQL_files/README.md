# Introduction
This project addresses a critical challenge faced by Ghanaian dancehall artist **Shatta Wale**: his music catalog is scattered across multiple streaming platforms with no centralized tracking system. Songs exist on some platforms but not others, making it impossible to understand his complete digital footprint.

I built a relational database from scratch to consolidate **song metadata, project information, and platform performance metrics**. Using SQL, I transformed raw, fragmented data into actionable business intelligence that answers questions about **catalog completeness, platform strategy, fan engagement, and revenue optimization**.

Key Deliverable: A normalized, query-ready database that enables Shatta Wale to finally see his complete musical legacy in one place.


# Background
This SQL project analyzes the metadata to answer these key questions:

1. Total song count – Complete discography size

2. Total album/project count – Complete project inventory

3. Songs by release year – Career growth trends

4. Top 10 most viewed (audio) – Biggest audio-only hits

5. Top 10 most liked (audio) – Fan-favorite audio tracks

6. Top 10 most commented (audio) – Most controversial/viral audio

7. Top 10 most viewed (video) – Biggest video hits

8. Top 10 most liked (video) – Most engaging music videos

9. Top 10 most commented (video) – Most viral music videos

10. Top 10 highest engagement rate – Most loyal fan bases

11. Songs needing video – Tiered priority list for video production

12. Undervalued songs – Quality songs that missed exposure

13. Best month for releases – Optimal release timing by average views

SQL queries? Check them out here: [Sql_Data_Analysis](/SQL_files/sql_data_analysis/)



# 🧰Tools I Used
I analyzed the data using a streamlined tech stack:

| Tool | Purpose |
|------|---------|
| PostgreSQL | Primary database management system for storing and querying the complete music catalog |
| SQL | Data definition (DDL), data manipulation (DML), and complex analytics queries to answer 13 business questions |
| Visual Studio Code | Developed, edited, and tested SQL scripts in a streamlined coding environment with syntax highlighting and version control integration |
| Excel | Initial data inspection, validation, and pivot tables with pivot charts for building visual representations of key metrics such as views by platform, engagement rates, and release trends |
| GitHub | Version control and project documentation for portfolio sharing |



# 🏗 Database Architecture
I designed a star schema optimized for analytical queries. This structure balances normalization (avoiding data duplication) with query performance.

## Entity Relationship Diagram

![E.R.D](/SQL_files/insights/images/ERD.jpg)


## Table Descriptions
1.**project_dim** (Dimension Table)

Stores information about albums, EPs, mixtapes, and singles. One project can contain many songs.

|Column | Description |
|--------|-------------|
|project_id | Unique identifier for each project |
| title |Project name (e.g., "SAFA", "Konekt")
| release_date | When the project was released |
| type_of_project | Classification: Album, EP, Mixtape, Single |
| track_count | Number of tracks on the project |


2.**songs_fact** (Fact Table)

The central table containing every unique song in Shatta Wale's catalog.

|Column|Description|
|------|-----------|
|song_id|Unique identifier for each song|
|project_id|Links to the parent project|
|title|Song title|
|artiste_name|Primary artist name|
|audio|Boolean: Does an audio version exist?|
|video|Boolean: Does a video version exist?|
|release_date|When the song was released|
|producers|Producer(s) of the song|
|genre|Music genre classification|
|duration|Song length (TIME format)|
|notes|Additional metadata (diss tracks, special context)|


3.**platform_metrics_dim** (Metrics Table)

Tracks platform-specific performance. One song can have multiple rows—one for each platform it exists on.

|Column|Description|
|------|-----------|
|id|Unique row identifier (surrogate key)|
|song_id|Links to the song in songs_fact|
|platform_name|YouTube, Spotify, Apple Music, Audiomack, etc.|
|platform_url|Direct link to the song on the platform|
|views|Number of views or streams|
|likes|Number of likes/favorites|
|comments|Number of comments|

Why this design? A song may exist on 1 platform or 10 platforms. This flexible structure handles missing data elegantly and enables platform-specific analysis.


## 📇Indexes Created for Performance
I implemented 15 strategic indexes to ensure sub-second query response times even as the catalog grows:

|Index|Purpose|
|-----|-------|
|idx_songs_project_id|Fast joins between songs and projects|
|idx_songs_release_date|Time-based filtering|
|idx_songs_title|Quick song lookups|
|idx_songs_genre|Genre categorization|
|idx_platform_song_id|Fast joins between metrics and songs|
|idx_platform_name|Platform-specific filtering|
|idx_platform_views_desc|Top 10 ranking queries|
|idx_unique_song_platform|Prevents duplicate platform entries|



# 📊The Analysis
I structured my analysis around 13 business questions organized into 5 categories. Below are representative queries and results.

### 🗃 Catalog Management
1. What is the total song count?
```sql
-- Find the unique song count
SELECT COUNT(DISTINCT title) as unique_song_count
FROM songs_fact;
```

Insights:
Shatta Wale has released atleast 965 songs (audio & video)

2. What is the total album/project count?
```sql 
SELECT COUNT(project_id) as count_of_project
FROM project_dim;
```

Insights:
Shatta wale has released a total of 17 projects (albums, EPs, mixtapes, etc.) 


3. What is the breakdown of songs by release year?
```sql
-- Show how many songs were released per year
SELECT
COUNT(title) as count_of_songs,

EXTRACT(YEAR FROM release_date) as release_year

FROM songs_fact

WHERE release_date IS NOT NULL AND (audio = TRUE OR video = TRUE) -- use both audio and video because 2013, 2014 and 2015 had songs released with video that didnt have an audio

GROUP BY release_year

ORDER BY count_of_songs DESC;

```
Insights:

Shatta Wale's music output has been remarkably consistent over the last decade, with a significant peak in 2016.
- Peak Year (2016) : 190 songs – This was his most prolific year by a wide margin.
- Consistent Output (2013-2025) : Apart from the 2016 peak, his annual release count has typically ranged between 50 and 95 songs, showing a steady work rate.
- Recent Stability (2020-2026) : Since 2020, his output has stabilized between 55 and 75 songs per year, indicating a mature and consistent release schedule.

[Pivot Table & Chart](/SQL_files/insights/pivot_tables%20&%20Charts/3_Songs_by_Year.xlsx)

![Songs By Year](/SQL_files/insights/images/3.jpg)
*Bar chart comparing song releases by year*


### 🎯Performance Rankings
4. What is the most viewed audio music?
```sql
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

```

Insights:

1.Top-heavy performance – Only 3 songs crossed the 1 million views mark for audio tracks

2.Consistent floor – All 10 songs have at least 600,000+ views

3.Fan favorites span multiple years – These aren't all recent releases, showing catalog depth

Recommendation:
- "Freedom" should be considered for additional promotion or a video remake given its strong audio performance
- The gap between #1 and #2 suggests "Freedom" has unique appeal worth analyzing further

[Pivot Chart & Pivot Table](/SQL_files/insights/pivot_tables%20&%20Charts/4_Top_10_Viewed_Audio.xlsx)

![Top Viewed Audio](/SQL_files/insights/images/4.jpg)
*Horizontal Bar chart showing the views for the top audio songs*


5. What is the most liked audio music?
```sql
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

```

Insights:

1.Clear winner – "Ain't Nobody" has significantly higher likes than all other audio tracks

2.Strong engagement – Top 10 all have 10,000+ likes, showing loyal fan base

3.Different leader than views – Unlike the "Most Viewed" chart where "Freedom" was #1, this chart has a different top song, suggesting "Ain't Nobody" drives stronger emotional connection despite potentially lower reach

Recommendation:
- "Ain't Nobody" has exceptional like-to-view ratio potential – worth analyzing its engagement metrics further
- Consider promoting this song more heavily since fans actively show appreciation through likes
*/

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/5_Top_10_Liked_Audio.xlsx)

![Top Liked Audio](/SQL_files/insights/images/5.jpg)
*Horizontal Bar  chart showing the likes for the top audio songs*


6. What audio music has the most comments?
```sql
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

```

Insights:

1.Dominant leader – "Ain't Nobody" has 2x more comments than the #2 song, indicating strong fan discussion and emotional connection
2.Diss tracks generate conversation – "Little Tip [Sarkodie Diss]" ranks #6, showing controversial content drives engagement
3.Consistent performer – "Jail Man" and "On God" appear across all engagement metrics (views, likes, comments), proving they are fan favorites

Recommendation:
- "Ain't Nobody" is not just liked but actively discussed – invest in promoting this song further (video, remix, or live performance)
- Diss tracks clearly drive comments – consider strategic releases to spark conversation when appropriate

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/6_Top_10_Comment_Audio.xlsx)

![Top Comments Audio](/SQL_files/insights/images/6.jpg)
*Horizontal Bar chart showing the audio music with the most comments*


7. What is the most viewed music video?
```sql
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

```

Insights:

1.Tight competition at the top – The top 2 videos are separated by only ~475,000 views (less than 2% difference)

2.Strong catalog depth – All top 10 videos have 6.8M+ views, with 6 videos crossing 10M+

3.Consistent video performance – Unlike audio where "Freedom" dominated, video views are more evenly distributed

4.Collaboration appeal – "Taking Over" (featuring Joint 77, Addi Self) and "Forgetti" (multiple features) rank highly, suggesting features boost video reach

Recommendation:
- "On God" and "Taking Over" are in a dead heat – pushing either with additional promotion could secure the #1 spot
- The tight race suggests a playlist or compilation of top 5 videos could drive significant cross-engagement

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/7_Top_10_Viewed_Video.xlsx)

![Top Viewed Music Video](/SQL_files/insights/images/7.jpg)
*Horizontal Bar chart showing the top viewed music video*

8. What is the most liked video?
```sql
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

```

Insights:

1.Clear leader – "On God" has 75% more likes than #2, a much wider gap than the view count race

2.Consistent top performer – The same 3 videos (On God, Taking Over, Ayoo) rank top 3 in both views and likes

3.Strong engagement correlation – The likes ranking closely mirrors the views ranking, suggesting genuine engagement (not just passive views)

4.Collaboration impact – "Hajia Bintu" (featuring Ara B & Captan) and "1 Don" rank well, showing features drive like engagement

Recommendation:
- "On God" is the undisputed fan-favorite video – consider creating a remastered, behind-the-scenes, or live version to capitalize on its popularity
- The strong correlation between views and likes indicates organic reach – these numbers reflect real fan appreciation, not just algorithmic promotion

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/8_Top_10_Liked_Video.xlsx)

![Top Liked Video](/SQL_files/insights/images/8.jpg)
*Horizontal Bar chart showing the most liked music videos*


9. What music video has the most comments?
```sql
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

```

Insights:

1."On God" dominates all metrics – #1 in views, likes, AND comments (trifecta)

2.Collaborations drive conversation – "Accra" (featuring 8+ artists) and "Hajia Bintu" (featuring Ara B & Captan) rank high in comments, suggesting features spark discussion

3."Street Crown" overperforms – #3 in comments but not in top 10 views/likes, indicating this song sparks unique conversation

4.Lyric video engagement – "Cash Out (Official Lyric Video)" made the top 10, showing lyric videos can drive comment activity

Recommendation:
- "Accra" has strong conversation potential – consider promoting it further or creating a follow-up collaboration
- "Street Crown" deserves investigation – why are fans commenting more than liking/viewing? Could be controversy, questions, or emotional connection


[Pivot Tables & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/9_Top_10_Comment_Video.xlsx)

![Top Comments Video](/SQL_files/insights/images/9.jpg)
*Horizontal Bar chart showing the music video with the most comments*

10. Which music has the best engagement?
```sql
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

```

Insights:

1.2026 is exceptional – 9 of top 10 highest-engagement songs are from 2026, suggesting a recent surge in fan connection

2.Audio dominates – Only "48Hrs (Visualizer)" is a visual format; audio slides drive higher engagement

3."Money Man (Party Vibe)" stands out – The only 2024 song in top 10, proving longevity in fan engagement

4.Extremely high rates – Industry average is ~4%; Shatta Wale's top songs are 3-4x higher
NB: Shatta Wale's top tracks are performing at viral engagement levels – his core audience is highly active and invested.

Recommendation:
- Double down on the 2026 audio slide format – Fans are clearly engaging deeply with this content type
- Study "4Lyf - Freestyle" – At 16.07%, it's the benchmark for what drives fan interaction

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/10_Top_Engagement_Rate.xlsx)

![Top Engagement Rate](/SQL_files/insights/images/10.jpg)
*Horizontal Bar chart showing music with the best engagement rate*

### 🎬 Production Planning
11. Which songs need a music video?
```sql
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

```

Insights:

**Catalog Health is Strong**

1.~45% of songs already have videos – solid foundation

2.This means nearly half your catalog is fully developed

**Immediate Opportunity (15%)**

1.~15% of songs are RECOMMENDED for video creation

2.These are your lowest-hanging fruit – good engagement, no video yet

3.Prioritize these before they lose momentum

**Monitoring Required (25%)**

1.The largest segment after "Has Video" is MONITOR (25%)

2.These songs have potential but aren't there yet

3.Action: Re-evaluate in 30-60 days

**Low Priority (15%)**

1.Only 15% are truly "not ready"

2.This is good – most of your catalog has at least some potential

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/11_Songs_Needing_Video.xlsx)

![Need Video](/SQL_files/insights/images/11.jpg)
*Donaught chart showing the video recommendations of the catalog*


### 📈 Marketing & Promotion
12. Which music needs a boost?
```sql
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

```

Insights:

1.Majority are Undervalued: A massive 60% of your catalog are "Hidden Gems" – songs with high engagement but low reach. 
This represents your single biggest opportunity for growth.

2.Vast Promotion Opportunity: In total, 84% of your catalog (High + Medium priority) needs some form of promotional support 
to reach its potential audience.

3.Small Success Rate: Only 16% of your songs are "Not a priority," meaning they have already found their audience or have low potential. 
This highlights that discovery, not quality, is the primary bottleneck.


[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/12_Under-Valued_Songs.xlsx)

![Need A Boost](/SQL_files/insights/images/12.jpg)
*Donaught chart showing music that need promotion*

### Timing & Seasonality
13. Which month are listeners the most active?
```sql
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

```

Insights:

1.Best month for release is March – It delivers the highest total views (72.4M) and strong average views (852K) from 85 releases, 
making it the most reliable and consistent performer.

2.April has the highest average views (1.1M) but lower release volume – This suggests high potential, but the small sample size 
(58 songs) means results may be driven by outliers.

3.Avoid November and October – November has the worst average views (162K) despite being the most active month (126 releases), 
making it the least effective time to drop new music.

4.January has the most releases but poor returns – With 96 songs released (highest volume) but only 214K average views, this month 
represents low efficiency and wasted potential.

5.March, April, July, and May are the top 5 months – Schedule major releases in these windows for the best combination of reach, engagement, 
and total view accumulation.

[Pivot Table & Pivot Chart](/SQL_files/insights/pivot_tables%20&%20Charts/13_Best_Month_For_Release.xlsx)

![Best Month](/SQL_files/insights/images/13.jpg)
*Horizontal Bar chart showing the months with the most active listeners*


# What I learned

### Technical Skills

|Skill|What I Practiced|
|-----|----------------|
|Database Design|Star schema, normalization, foreign key relationships|
|DDL (Data Definition Language)|CREATE TABLE, ALTER TABLE, constraints|
|DML (Data Manipulation Language)|INSERT, UPDATE, DELETE operations|
|Advanced SQL|JOINs (INNER, LEFT, FULL), subqueries, CTEs, window functions|
|Query Optimization|Strategic indexing, EXPLAIN ANALYZE, partial indexes|
|Data Integrity|UNIQUE constraints, foreign key actions (CASCADE, SET NULL)|

### Real-World Lessons
1.Star schemas are powerful for analytics. Separating facts from dimensions made complex queries simple to write and fast to execute.

2.Surrogate keys matter. The id column in platform_metrics_dim seemed redundant initially but proved essential for handling multiple rows per song.

3.Indexes are not optional. Queries that took 2 seconds without indexes ran in 50ms after proper indexing.

4.Business questions drive database design. Understanding what Shatta Wale needed to know shaped every table and relationship.

5.Data quality is the hardest part. Inconsistent naming, missing release dates, and duplicate entries required significant cleaning before analysis.


# Conclusion
This project transformed fragmented, messy music metadata into a structured, queryable asset that delivers real business intelligence.

**For Shatta Wale**:

- Data-backed answers about where to focus video production
- Understanding of which platforms drive views vs revenue
- Historical context for strategic release planning

**For me**:

- Demonstrated ability to design and implement a production database
- Applied advanced SQL to solve real business problems
- Created a portfolio project with measurable outcomes

