# Shatta Wale Music Analytics Dashboard

![Dashboard](/Power_BI_files/images/landing%20page.jpg)

## Power BI Dashboard: Complete Catalog Intelligence
### 📌Table of Contents
- [Project Overview](#Project-Overview)

- [Dashboard Purpose](#Dashboard-Purpose)

- [Technical Skills Showcased](#technical-skills-showcased)

- [Data Sources](#Data-Sources)

- [Dashboard Navigation](#dashboard-navigation)

- [Page 1: Executive Overview (Landing Page)](#page-1-executive-overview-landing-page)

- [Page 2: Performance Rankings](#page-2-performance-rankings)

- [Page 3: Release Strategy](#page-3-release-strategy)

- [Page 4: Actionable Insights (Production & Promotion)](#page-4-actionable-insights-production--promotion)

- [Drill-Through: Song Detail Page](#drill-through-song-detail-page)

- [Technical Specifications](#technical-specifications)

- [Limitations & Future Improvements](#limitations--future-improvements)

- [Conclusion](#conclusion)

# Project Overview
This Power BI dashboard transforms raw, fragmented music metadata into an interactive intelligence tool for Ghanaian dancehall artist Shatta Wale.

## ❓The Problem
Since beginning his professional career in 2004, Shatta Wale has released hundreds of songs across multiple streaming platforms. With no centralized tracking system, he cannot:

- Confirm which songs exist on which platforms

- Identify his most successful songs by metric

- Make data-driven decisions about video production or promotional spend

- Understand seasonal patterns in his audience's listening behavior

## The Solution
A four-page interactive Power BI dashboard with synchronized filtering and drill-through capabilities that answers three critical questions:

|Question|	Where to Find|
|--------|---------------|
|What do I have?|	Page 1: Executive Overview|
|What performs best?	|Page 2: Performance Rankings|
|When should I release?	|Page 3: Release Strategy|
|What should I do next?	|Page 4: Actionable Insights|

# Dashboard Purpose

|Stakeholder|	What They Can Learn|
|-----------|----------------------|
|Shatta Wale (Artist)|	Which songs fans love most, when to release, what needs a video|
|Manager|	Catalog gaps, performance benchmarks, promotion priorities|
|Production Team|	Which audio-only songs need videos, ranked by priority|


# 👨‍💻Technical Skills Showcased
## Data Modeling & DAX Measures
- Catalog Metrics – Total Songs, Total Views, Overall Engagement Rate calculated as (Likes + Comments) / Views × 100

- Performance Rankings – Dynamic Top 10 measures for views, likes, comments, and engagement rate that respond to slicer selections

- Priority Scoring Algorithm – Video Priority Score = (Like Percentage × 10) + (Comment Percentage × 5) to rank video production urgency

- Percentage Calculations – Like Percentage and Comment Percentage derived from raw metrics

- Age-Normalized Metrics – Views Per Day calculated as total views divided by song age in days

- Synchronized Filtering – Year and Project slicers connected across all four pages using same-report filter propagation

- Drill-Through Measures – Individual song rankings (Views Rank, Engagement Rank, Likes Rank) passed to detail page

## Data Transformation (Power Query)
- Date Standardization – Parsed inconsistent date formats (YYYY-MM-DD HH:MM:SS and DD/MM/YYYY) into unified datetime format

- Column Extraction – Derived Release Year, Release Month, Release Quarter, Release Day Name from release_date

- Data Merging – Star schema relationship mapping between songs_fact (fact table), platform_metrics_dim, and project_dim (dimension tables)

- Song Age Calculation – Created age_days column using DATEDIFF between release_date and current date

- Boolean Conversion – Transformed audio and video flags (TRUE/FALSE strings) to boolean data type

- Data Filtering – Isolated YouTube metrics only from platform_metrics_dim for consistent analysis

## Visualization & Dashboard Design
- KPI Cards – Total Songs (969), Total Views (351M), Overall Engagement Rate (1.55%) with formatted metric display

- Donut Chart – Audio vs Video percentage (84% / 16%) highlighting production gap

- Top 10 Bar Charts – Horizontal bar charts for video songs, audio songs, liked songs, and commented songs

- Engagement Rate Bar Chart – High engagement songs identified with percentage labels

- Release Timing Visuals – Day-of-week and month-over-month bar charts for strategic release planning

- Trend Line – Views by Year line chart showing career growth trajectory (2015-2026)

- Priority Matrix Table – Actionable table with Title, Views, Like %, Comment %, Priority Score, and Video Recommendation columns

- Conditional Formatting – Priority scores color-coded to highlight HIGH PRIORITY (red) vs RECOMMENDED (yellow) vs MONITOR (green)

- Drill-Through Page – Dedicated song detail page accessible by right-clicking any song visual, displaying rank positions and comparative metrics

- Navigation Design – SM logo hyperlinked to landing page across all four pages

- Synchronized Slicers – Year and Project filters placed on landing page with "Clear Slicers" reset button

- Text-Based Priority Lists – Actionable recommendations (HIGH PRIORITY, RECOMMENDED, MONITOR, LOW PRIORITY) for video production decisions


# Data Sources
|Table|	Description	|Key Columns|
|-----|-------------|-----------|
|songs_fact.csv	|Master song catalog|	song_id, title, release_date, audio, video|
|platform_metrics_dim.csv|	Platform performance|	song_id, platform_name, views, likes, comments|
|project_dim.csv|	Album/EP information|	project_id, title, type_of_project|

Data Coverage: YouTube metrics only (most complete data source)


# 🧭Dashboard Navigation
### Interactive Features
|Feature|	How It Works|
|-------|---------------|
|Synchronized Slicers	|Year and Project filters on the landing page affect ALL pages|
|SM Logo Navigation	|Click the SM logo on any page to return to the landing page|
|Drill-Through|	Right-click any song to access detailed song information|


# Page Structure
![Page Structure](/Power_BI_files/images/page%20structure.png)

# 🏠Page 1: Executive Overview (Landing Page)
This is the default page when opening the dashboard. All slicers selected here affect every other page.

![Landing Page](/Power_BI_files/images/landing%20page.jpg)

## Visual Components
|Component|	What It Shows|	Insight|
|---------|--------------|---------|
|Total Songs (969)|	Complete catalog size|	Baseline catalog metric|
|Total Views (351M)	|Lifetime YouTube reach	|Catalog valuation metric|
|Overall Engagement Rate (1.55%)|	Average fan interaction	|Catalog health indicator|
|Audio vs Video Donut|	83.9% Audio, 16.1% Video|	Significant video production opportunity|
|Top 10 Video Songs	|Highest viewed videos|	Identify most successful visual content|
|Views by Year Trend|	Career growth visualization|	Track momentum year over year|
|Best Day to Release Bar Chart	|Wednesday peaks at ~100M	|Strategic release timing|
|Views Per Day (Current Momentum)|	Songs currently growing	|Identify evergreen hits|


## Interactive Controls
|Control|	Purpose|
|-------|----------|
|Select Year (All)	|Filter data by release year|
|Select Project (All)|	Filter by album/EP/mixtape|
|Clear Slicers|	Reset all filters|


## Key Takeaways from This Page
|Insight|	Action|
|-------|---------|
|Only 16% of catalog has videos → 84% is audio-only	|Massive video production opportunity|
|Wednesday outperforms all other release days	|Schedule future releases on Wednesday|
|Views per day chart shows several songs with 10K+ daily views|	These are evergreen hits worth re-promoting|


# 📈Page 2: Performance Rankings
This page identifies the best-performing songs across multiple metrics.

![Performance page](/Power_BI_files/images/performance%20page.jpg)

## Visual Components
|Visual|	Purpose|	Example Top Result|
|------|-----------|----------------------|
|Top 10 Audio Songs|	Identify audio-only songs with high potential|	Freedom, My Level, Only One Man|
|Top 10 Most Liked Songs|	Measure fan enjoyment (pure metric)|	On God, Taking Over, Ayoo|
|Top 10 Most Commented Songs|	Measure conversation and virality|	On God, Accra, Street Crown|
|Songs with High Engagement Rate|	Find most passionate fan bases|	4Lyf Freestyle, God People, How Far|

## Key Takeaways from This Page
|Insight	|Action|
|-----------|------|
|Audio-only songs appear in top 10 lists|	These should be prioritized for video production|
|High engagement ≠ high views|	Some small songs have VERY passionate fans|
|On God dominates across multiple categories|	Clear evergreen hit, should be in every setlist|


# 📅Page 3: Release Strategy
This page optimizes future release timing based on historical performance.

![Release Strategy Page](/Power_BI_files/images/release%20strategy%20page.jpg)

## Visual Components
|Visual	|What It Shows|	Strategic Insight|
|-------|-------------|------------------|
|Yearly Distribution of Song Releases|	Number of songs released per year (2012-2026)	|Track output consistency|
|Quarter with Most Active Listeners	|Average views by quarter	|Q2 (April-June) shows 591K avg views|
|Month with Most Active Listeners|	Average views by month	|April peaks at ~1.1M views|


## Key Takeaways from This Page
| Insight|	Action|
|--------|--------|
|Peak listening occurs in Q2 (April-June)|	Schedule major releases for April|
|Monthly chart shows April as highest-performing|	Target April for flagship singles|
|Release volume peaked in 2017-2018	|Recent years show more selective output|


# 🎥Page 4: Actionable Insights (Production & Promotion)
This page tells Shatta Wale exactly what to do next.

![Production Page](/Power_BI_files/images/production%20page.jpg)

## Visual Components
|Column	|Purpose	|Values|
|-------|-----------|------|
|Title	|Song name|	All songs meeting criteria|
|Total Views	|Current reach	|Numerical|
|Like Percentage|	Likes ÷ Views × 100|	Percentage|
|Comment Percentage	|Comments ÷ Views × 100	|Percentage|
|Video Priority Score|	Algorithmic score (0-100+)|	Higher = more urgent|
|Video Recommendation|	Actionable decision	|See below|

## Priority Levels
|Recommendation|	Meaning	|Action|
|--------------|------------|------|
|HIGH PRIORITY - Make Video NOW|	Score > 100	|Immediate video production|
|RECOMMENDED - Should Make Video|	Score 75-100|	Schedule video within 3 months|
|MONITOR - Consider if engagement grows|	Score 50-75	|Track and re-evaluate monthly|
|LOW PRIORITY - Not Ready	|Score < 50|	Focus on other songs first|
|Has Video - Track Performance	|Video already exists	|Monitor view growth|

## Key Takeaways from This Page
|Insight	|Action|
|-----------|------|
|"1 Man 1000 Cases" has Priority Score 103	|🚨 HIGH PRIORITY - Make video NOW|
|Multiple songs in "RECOMMENDED" category	|Build 3-6 month video production queue|
|2023 and 2024 have Recommended status|	Recent songs with proven engagement|



# Drill-Through: Song Detail Page
Right-click any song on any page to access detailed information about that specific song.

![Drill-Through Page](/Power_BI_files/images/drill-through%20page.jpg)

## Information Displayed
|Section|	Fields|
|-------|---------|
|Basic Info	|Title, Project, Release Date, Duration, Genre, Producers|
|Performance Metrics	|Total Views, Total Likes, Total Comments, Engagement Rate|
|Rankings|	Views Rank, Engagement Rank, Likes Rank (among all songs)|


# Technical Specifications
## Data Processing
|Step|	Tool|
|----|------|
|Data extraction|	Python (pandas)|
|Data cleaning|	Python / Power Query|
|Data modeling	|Power BI (Star Schema)|
|Visualizations	|Power BI|

## Calculated Columns Created
|Column	|Formula|
|-------|-------|
|Engagement Rate|	(likes + comments) / views × 100|
|Like Percentage|	likes / views × 100|
|Comment Percentage	|comments / views × 100|
|Video Priority Score|	(like_percentage × 10) + (comment_percentage × 5)|
|Release Day Name	|FORMAT(release_date, "dddd")|
|Release Month|	FORMAT(release_date, "MMM")|
|Release Quarter	|QUARTER(release_date)|


## Dashboard File
|Metric|	Value|
|File format|	.pbix (Power BI Desktop)|
|Data source	|CSV files (static snapshot)|
|Refresh frequency	|Manual|
|Interactivity|	Slicers, drill-through, bookmarks|


# Limitations & Future Improvements

## Current Limitations (Given Data Constraints)
|Limitation	|Why It Matters|	Mitigation|
|-----------|--------------|--------------|
|No daily historical view data|	Cannot show growth curves	|Focus on current performance instead|
|YouTube only|	Other platforms not represented	|Prioritize YouTube for video decisions|
|No 7/30/90 day snapshots|	Cannot predict hit potential	|Use engagement rate as proxy|
|Static snapshot (not live)|	Data becomes outdated|	Plan quarterly manual refreshes|


# Future Improvements (With Better Data)
|Improvement	|Data Needed	|Expected Benefit|
|---------------|---------------|----------------|
|Live API connection|	YouTube Data API	|Real-time view tracking|
|Platform comparison|	Spotify, Apple Music metrics|	Cross-platform strategy|
|Predictive model	|7/30/90 day view data	|Early hit identification|
|Promotion attribution	|Campaign tracking	|ROI measurement|


# Recommended Tracking for Future Releases
What to Track	|How	|Why|
|---------------|-------|---|
|Views at day 7, 30, 90|	Manual or API	|Enable predictive models|
|Daily view counts (first 30 days)|	YouTube Analytics API	|True growth curve analysis|
|Promotion sources	|UTM parameters	|Attribution and ROI|

# Conclusion
This dashboard transforms Shatta Wale's scattered catalog into a single source of truth for strategic decision-making. **Key findings reveal that only 16% of songs have videos—creating a clear production opportunity—while Wednesday and April emerge as the optimal release day and month for maximizing viewership.The priority scoring system now provides an actionable video production queue, with "1 Man 1000 Cases" identified as the highest-priority candidate.**

**What Shatta Wale can now do that he couldn't before:**

- See his complete catalog performance in one place

- Know exactly which audio-only songs need videos first

- Schedule releases on data-backed optimal days

- Identify hidden gems with high engagement but low views

The dashboard is ready for immediate use in planning releases, prioritizing video production, and re-promoting undervalued songs.

