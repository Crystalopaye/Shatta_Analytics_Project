# Shatta Wale Music Analytics Project

## Complete Data Analytics Portfolio: SQL → Python → Power BI


## 📌 Table of Contents

- [Project Overview](#project-overview)
- [Project Objectives](#project-objectives)
- [Tools & Technologies Used](#tools--technologies-used)
- [Project Workflow](#project-workflow)
- [Phase 1: SQL Database Architecture](#phase-1-sql-database-architecture)
- [Phase 2: Python Data Analysis](#phase-2-python-data-analysis)
- [Phase 3: Power BI Dashboard](#phase-3-power-bi-dashboard)
- [Key Findings](#key-findings)
- [Challenges & Solutions](#challenges--solutions)
- [What I Learned](#what-i-learned)
- [Repository Structure](#repository-structure)
- [Connect With Me](#connect-with-me)
- [Acknowledgements](#acknowledgments)



# Project Overview

This end-to-end data analytics project addresses a real-world business problem faced by Ghanaian dancehall artist **Shatta Wale**: his music catalog is scattered across multiple streaming platforms with no centralized tracking system.

**The Problem:** Since beginning his professional career in 2002, Shatta Wale has released hundreds of songs across YouTube, Spotify, Apple Music, Audiomack, and other platforms. Songs exist on some platforms but not others, making it impossible to understand his complete digital footprint or make data-driven decisions about video production, release timing, or catalog management.

**The Solution:** A complete data pipeline that:

1. **Structures** raw, fragmented metadata into a normalized SQL database
2. **Analyzes** performance patterns using Python statistical methods
3. **Visualizes** insights through an interactive Power BI dashboard

**The Outcome:** Shatta Wale can now see his complete catalog in one place, identify which audio-only songs need videos, determine optimal release days and months, and discover hidden gems for re-promotion.



# Project Objectives

| Objective | How It Was Achieved |
|-----------|---------------------|
| **Consolidate fragmented catalog data** | Built a 3-table star schema database (songs_fact, platform_metrics_dim, project_dim) |
| **Identify catalog gaps by platform** | Queried missing platform entries using SQL LEFT JOIN |
| **Find undervalued songs** | Calculated engagement rate (likes+comments/views) using Python to identify hidden gems |
| **Determine optimal release timing** | Analyzed release date patterns using pandas datetime operations |
| **Prioritize video production** | Created a Video Priority Score algorithm ranking songs by like percentage and comment percentage |
| **Build an interactive dashboard** | Developed 4-page Power BI report with synchronized slicers and drill-through |



# 🧰Tools & Technologies Used

## SQL (PostgreSQL)

| Skill | Application |
|-------|-------------|
| Database Design | Created 3-table star schema (fact and dimension tables) |
| DDL (Data Definition) | Wrote CREATE TABLE statements with primary and foreign keys |
| DML (Data Manipulation) | Inserted and managed 1,000+ song records |
| Complex Queries | Used LEFT JOIN, GROUP BY, aggregate functions, subqueries |
| Indexing | Created strategic indexes for query optimization |
| Data Integrity | Implemented foreign key constraints (ON DELETE CASCADE, ON DELETE SET NULL) |

## Python (Pandas, Matplotlib, Seaborn, SciPy)

| Skill | Application |
|-------|-------------|
| Data Cleaning | Parsed inconsistent date formats, handled null values |
| Statistical Analysis | Calculated z-scores to identify statistical anomalies |
| Engagement Metrics | Created engagement rate formulas to measure fan passion |
| Algorithm Development | Built Video Priority Score algorithm |
| Time Series Proxy | Used song age as proxy for growth curve analysis |
| Outlier Detection | Identified songs with z-score > 2 |
| Data Visualization | Created scatter plots, bar charts, and box plots |

## Power BI (DAX, Power Query)

| Skill | Application |
|-------|-------------|
| Data Modeling | Built star schema relationships between fact and dimension tables |
| DAX Measures | Created Total Songs, Total Views, Engagement Rate, Views Per Day, Video Priority Score |
| Power Query (M) | Standardized date formats, extracted year/month/quarter/day columns |
| Interactive Visuals | KPI cards, donut charts, horizontal bar charts, line charts, matrix tables |
| Drill-Through Pages | Configured song detail page accessible by right-clicking any song visual |
| Synchronized Slicers | Connected year and project filters across all four pages |
| Conditional Formatting | Color-coded priority scores for immediate action |
| Navigation Design | Implemented SM logo hyperlink to return to landing page |

---

# Project Workflow

![Workflow Diagram](/images/workflow%20diagram.png)


# Phase 1: SQL Database Architecture
[Click for SQL Analysis](/SQL_files/README.md)

## Database Design

I designed a **star schema** optimized for analytical queries, balancing normalization with query performance.

| Table | Type | Description | Row Count |
|-------|------|-------------|-----------|
| `songs_fact` | Fact table | Every unique song in the catalog | 969 |
| `project_dim` | Dimension | Albums, EPs, mixtapes, singles | 17 |
| `platform_metrics_dim` | Dimension | Platform-specific performance (one row per song per platform) | 900+ |


## Entity Relationship Diagram
![Entity Relationship Diagram](/SQL_files/insights/images/ERD.jpg)


## Key SQL Queries Written

| Query | Purpose |
|-------|---------|
| `CREATE INDEX idx_songs_project_id` | Optimized join performance between songs and projects |
| `CREATE UNIQUE INDEX idx_unique_song_platform` | Prevented duplicate platform entries for the same song |
| `SELECT songs missing from YouTube` | Identified distribution gaps using LEFT JOIN |
| `SELECT top 10 most viewed with engagement rate` | Calculated (likes+comments)/views × 100 |
| `SELECT songs needing video (tiered)` | Based on views, likes, and comments thresholds |

## Skills Demonstrated in SQL

| Skill | Example |
|-------|---------|
| DDL | `CREATE TABLE`, `ALTER TABLE`, `FOREIGN KEY` constraints |
| DML | `INSERT`, `UPDATE`, `DELETE` with cascade options |
| Complex Joins | `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN` |
| Aggregations | `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG` |
| Subqueries | Nested `SELECT` statements for comparative analysis |
| Indexing | `CREATE INDEX`, `CREATE UNIQUE INDEX`, partial indexes |
| Window Functions | `RANK()`, `ROW_NUMBER()` for top-N per group |



# Phase 2: Python Data Analysis

[Click for Python Analysis](/Python_files/README.md)

## The Data Limitation Challenge

**The problem:** Only current total views were available – no daily historical data, no week-by-week growth tracking.

**The adaptation:** Used **song age as a proxy** for growth and focused on comparative metrics instead of time-series predictions.

## Key Questions Answered with Python

| # | Question | Method | Key Finding |
|---|----------|--------|-------------|
| 1 | Average views growth curve by age bucket | Grouped songs by age (1-7, 8-30, 31-90, 90+ days) | Peak growth occurs in first 30 days |
| 2 | Songs with post-release growth spikes | Calculated views per day, filtered age ≥ 30 days | On God: 18,172 views/day (still growing years later) |
| 3 | Undervalued songs (high engagement, low views) | Engagement Rate = (likes+comments)/views × 100 | Rise Anyway: 7.68% engagement, only 74K views |
| 4 | Statistical anomalies (outperforming monthly peers) | Z-score calculation per month | Cocoa Season: 1,660% above monthly average |
| 5 | Optimal release day of week | Grouped by day_name, averaged views | Wednesday: 796K average views (best) |
| 6 | Seasonal patterns (best month to release) | Grouped by month, averaged views | April: 1.1M average views |
| 7 | Holiday release performance | Flagged releases within 2 days of major holidays | Easter: 3.16M average views |
| 8 | Correlation between comment rate and total views | Pearson correlation coefficient | Moderate positive correlation |

## Python Skills Demonstrated

| Skill | Application |
|-------|-------------|
| Data Loading | `pd.read_csv()` with index_col parameter |
| Date Parsing | Detected format by separator (`-` vs `/`), applied appropriate parser |
| Data Merging | `pd.merge()` with inner/left joins |
| GroupBy Operations | `groupby().agg(['mean', 'median', 'count'])` |
| Custom Functions | `def assign_age_bracket(days):` for bucketing |
| Statistical Testing | `scipy.stats.ttest_ind()` for holiday vs regular comparison |
| Z-Score Calculation | `(views - monthly_avg) / monthly_std` |
| Data Export | `df.to_csv()` for Power BI consumption |
| Visualization | Matplotlib bar charts, scatter plots, histograms |

## Code Snippet Example (Engagement Rate Calculation)

```python
# Calculate engagement rate for each song
df['engagement_rate'] = (df['likes'] + df['comments']) / df['views'] * 100

# Find undervalued songs (high engagement, low views)
avg_engagement = df['engagement_rate'].mean()
avg_views = df['views'].mean()

undervalued = df[
    (df['engagement_rate'] > avg_engagement) & 
    (df['views'] < avg_views)
].sort_values('engagement_rate', ascending=False)

print(f"Found {len(undervalued)} undervalued songs worth re-promoting")

```

# Phase 3: Power BI Dashboard

[Click for Power BI Analysis](/Power_BI_files/README.md)

## Dashboard Architecture
The dashboard contains 4 interconnected pages with synchronized filtering and drill-through capabilities.

|Page	|Purpose	|Key Visuals|
|-------|-----------|-----------|
|Page 1: Executive Overview|	High-level catalog health|	KPI cards, donut chart, top 10 bar chart, trend line, release day analysis|
|Page 2: Performance Rankings|	Identify best performers	|Top 10 audio, top 10 video, most liked, most commented, high engagement|
|Page 3: Release Strategy	|Optimize future timing|	Yearly distribution, quarter analysis, month analysis|
|Page 4: Actionable Insights	|What to do next|	Priority matrix, video recommendations, hidden gems|

## Interactive Features
|Feature|	How It Works|
|-------|---------------|
|Synchronized Slicers|	Year and Project filters on landing page affect ALL pages|
|Drill-Through	|Right-click any song → Song Detail page with rank positions|
|SM Logo Navigation	|Click logo on any page to return to landing page|
|Clear Slicers Button|	Resets all filters instantly|


## 🏠Page 1: Executive Overview (Landing Page)
Default page when opening the dashboard. All slicers selected here affect every other page.

![Landing Page](/Power_BI_files/images/landing%20page.jpg)

|Component	|What It Shows|
|-----------|-------------|
|Total Songs (969)|	Complete catalog size|
|Total Views (351M)	|Lifetime YouTube reach|
|Overall Engagement Rate (1.55%)|	Average fan interaction|
|Audio vs Video Donut|	84% Audio, 16% Video|
|Top 10 Video Songs|	Highest viewed videos|
|Views by Year Trend	|Career growth over time|
|Best Day to Release	|Wednesday peaks at ~100M|
|Views Per Day	|Currently growing songs|

## 📈Page 2: Performance Rankings
Identifies the best-performing songs across multiple metrics.

![Performance Rankings](/Power_BI_files/images/performance%20page.jpg)

|Visual	|Purpose|
|-------|-------|
|Top 10 Audio Songs	|Identify audio-only songs with high potential|
|Top 10 Most Liked Songs|	Measure fan enjoyment|
|Top 10 Most Commented Songs	|Measure conversation and virality|
|Songs with High Engagement Rate	|Find most passionate fan bases|


## 📅Page 3: Release Strategy
Optimizes future release timing based on historical performance.

![Release Strategy](/Power_BI_files/images/release%20strategy%20page.jpg)

|Visual	|What It Shows|
|-------|-------------|
|Yearly Distribution|	Number of songs released per year|
|Quarter Analysis	|Q2 (April-June) shows 591K avg views|
|Month Analysis	|April peaks at ~1.1M views|



## 🎥Page 4: Actionable Insights (Production & Promotion)
Tells Shatta Wale exactly what to do next.

![Production Page](/Power_BI_files/images/production%20page.jpg)


|Column|	Purpose|
|------|-----------|
|Total Views|	Current reach|
|Like Percentage|	Likes ÷ Views × 100|
|Comment Percentage|	Comments ÷ Views × 100|
|Video Priority Score	|Algorithmic score (higher = more urgent)|
|Video Recommendation|	HIGH PRIORITY, RECOMMENDED, MONITOR, LOW PRIORITY|


## Drill-Through: Song Detail Page
Right-click any song on any page to access detailed information.

![Drill Through](/Power_BI_files/images/drill-through%20page.jpg)


|Section	|Fields|
|-----------|------|
|Basic Info|	Title, Project, Release Date, Duration, Genre, Producers|
|Performance Metrics|	Total Views, Total Likes, Total Comments, Engagement Rate|
|Rankings|	Views Rank, Engagement Rank, Likes Rank|


```dax
// Total Views
Total Views = SUM(platform_metrics[views])

// Overall Engagement Rate
Overall Engagement Rate = 
DIVIDE(
    SUM(platform_metrics[likes]) + SUM(platform_metrics[comments]),
    SUM(platform_metrics[views]),
    0
) * 100

// Video Priority Score
Video Priority Score = 
[Like Percentage] * 10 + [Comment Percentage] * 5

// Video Recommendation (calculated column)
Video Recommendation = 
SWITCH(
    TRUE(),
    [Video Priority Score] >= 100, "HIGH PRIORITY - Make Video NOW",
    [Video Priority Score] >= 75, "RECOMMENDED - Should Make Video",
    [Video Priority Score] >= 50, "MONITOR - Consider if engagement grows",
    [Video Priority Score] > 0, "LOW PRIORITY - Not Ready",
    "Has Video - Track Performance"
)

```

## Power BI Skills Demonstrated
|Skill	|Application|
|-------|-----------|
|Data Modeling|	Created star schema relationships (1-to-many)|
|DAX Measures|	Aggregations, conditional logic, time intelligence|
|Power Query (M)|	Date parsing, column extraction, data type conversion|
|Visual Formatting|	Conditional formatting, color scales, tooltips|
|Drill-Through	|Configured song detail page with filter propagation|
|Bookmark Navigation|	SM logo hyperlink to landing page|
|Slicer Sync|	Connected year/project filters across 4 pages|
|Custom Visuals|	Horizontal bar charts, donut charts, priority matrix|


# Key Findings
## 📊 Catalog Statistics
|Metric	|Value|	Insight|
|-------|-----|--------|
|Total Songs Analyzed|	969|	Complete catalog baseline|
|Total YouTube Views|	351M	|Lifetime reach|
|Overall Engagement Rate|	1.55%	|Room for improvement (target 3%+)|
|Audio vs Video|	84% Audio, 16% Video|	Massive video production opportunity|


## 📅 Release Timing Insights
|Finding|	Strategic Action|
|-------|-------------------|
|Wednesday averages 796K views|	Schedule all major releases on Wednesday|
|April averages 1.1M views|	Target April for flagship singles|
|Monday averages only 213K views|	Avoid Monday releases|
|Easter weekend averages 3.16M views|	Prioritize Easter release windows|


## 💎 Hidden Gems (Undervalued Songs)
|Song|	Views	|Engagement Rate|	Action|
|----|----------|---------------|---------|
|Rise Anyway|	74,516	|7.68%|	Re-promote immediately|
|Abonko	|99,335|	7.78%	|Create TikTok challenge|
|1 Man 1000 Cases|	39,015|	9.26%|	HIGH PRIORITY video|


## ⭐ Statistical Anomalies (Unexpected Hits)
|Song|	Month|	vs Monthly Average|	Why It's An Anomaly|
|----|-------|--------------------|------|
|Cocoa Season|	Oct 2016|	+1,660%	|Outperformed all peers by massive margin|
|Prove You Wrong|	Sep 2016|	+1,267%	|Unexpected breakout hit|
|Wine Your Waist|	Nov 2016|	+1,084%	|Viral moment worth studying|


## Challenges & Solutions
## Challenge 1: Inconsistent Date Formats
**Problem:** The release_date column contained two different formats:

YYYY-MM-DD HH:MM:SS (e.g., 2026-03-09 01:39:22)

DD/MM/YYYY (e.g., 13/03/2026)

**Solution:** Detected format by separator (- vs /) and applied appropriate parsing method to each row. Preserved 100% of valid dates.

## Challenge 2: No Historical Time-Series Data
**Problem:** Only current total views were available – no daily, weekly, or monthly view data to show growth curves.

**Solution:** Used song age as a proxy for growth and focused on comparative metrics (engagement rate, views per day, statistical anomalies) instead of time-series predictions.


## Challenge 3: Questions That Could Not Be Answered
Due to data limitations, the following questions were deferred to future analysis:

|Question	|Why It Couldn't Be Answered|
|-----------|---------------------------|
|Predict lifetime views from first 7 days|	Requires day 7 view data|
|Days until song reaches 80% of total views|	Requires cumulative view data|
|Peak velocity (highest daily views)|	Requires daily view data|
|Engagement decay over time|	Requires engagement at multiple time points|


## Challenge 4: NULL Values in Producer and Genre Columns
**Problem:** Producer and genre data were missing for most songs (API limitations).

**Solution:** Dropped these columns from analysis and focused on metrics that were consistently available (views, likes, comments, release dates).



# What I Learned
## Technical Skills
|Skill Area|	What I Practiced|
|----------|--------------------|
|SQL|	Database design, indexing optimization, complex joins, aggregate functions|
|Python|	Data cleaning, statistical analysis (z-scores, t-tests), custom algorithm development|
|Power BI	|DAX measures, drill-through pages, synchronized slicers, conditional formatting|
|Data Engineering|	Building a complete ETL pipeline from raw CSVs to interactive dashboard|



## Problem-Solving Lessons
1. Adapt when data is limited – When daily historical data wasn't available, I used song age as a proxy and focused on comparative metrics instead of time-series predictions

2. Always inspect raw data first – The date format inconsistency would have caused major issues if not caught early

3. Star schemas are powerful – Separating facts from dimensions made complex queries simple to write and fast to execute

4. Engagement rate tells a different story than views – A song with 100K views and 10% engagement is more valuable than a song with 1M views and 1% engagement

5. Median is often more useful than mean – Mean views are skewed by outliers (megahits), while median shows what a "typical" song achieves



# Repository Structure

![Repository Strucrure](/images/repository%20structure.png)



# Connect With Me
GitHub: [https://github.com/Crystalopaye]

LinkedIn: [https://www.linkedin.com/in/crystal-opaye-210807167/]

Email: [crystalopaye1@gmail.com]

# Acknowledgments
Shatta Wale – For the inspiration to build this analytics solution around his catalog challenges

YouTube Data API – For providing the metrics that made this analysis possible

Open-source community – For pandas, matplotlib, seaborn, and all the tools that made this project feasible

Built with SQL, Python, and Power BI. Driven by data. Focused on actionable insights.

*Project Duration: 2 months | Lines of Code: 2,500+ | Questions Answered: 15+ | Dashboard Pages: 4*
