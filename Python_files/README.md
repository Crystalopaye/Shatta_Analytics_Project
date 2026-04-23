# Project Overview

This Python-based analysis builds upon the SQL database created for Shatta Wale's music catalog. While the SQL phase focused on data storage and structured querying, **this Python phase focuses on deeper statistical analysis, pattern detection, and actionable insights**.

The goal was to answer 15 business questions about catalog performance, release timing, fan engagement, and hidden opportunities – using only the available data (current YouTube views, likes, comments, and release dates).



# Data Sources
|Table|Description|Key Columns|
|----|---------|-----------|
|songs_fact.csv|Master song catalog	|song_id, title, release_date, audio, video|
|platform_metrics_dim.csv|Platform performance metrics|song_id, platform_name, views, likes, comments|
|project_dim.csv|Album/EP/Project information|project_id, title, release_date, type_of_project|

**Data Coverage: YouTube metrics only (most complete data source)**



# 🧰Tools & Libraries
|Tool/Library|	Purpose|
|------------|---------|
|Python 3.9+|Core programming language|
|Pandas|Data manipulation and analysis|
|Matplotlib|	Static visualizations|
|Seaborn|	Statistical visualizations|
|SciPy|Statistical testing (t-tests, z-scores)|
|NumPy|Numerical computations|
|Datetime|Date parsing and age calculations|



# ❓Analysis Questions
Seven (7) out of the fifteen (15) questions were analyzed. We were unable to analyze all questions due to a lack of temporal data. While we attempted to create proxy data to support the missing information and produce precise, realistically applicable insights, questions that would have generated skewed or misleading results were dropped and shelved pending the availability of temporal data.

[Project Questions](/Python_files/python_data_analysis/guide.ipynb)
The following questions were analyzed:

## 📅 Time Series & Growth Pattern Analysis
1.What is the average views growth curve for a song? (Days 1-7, 8-30, 31-90, 90+)

[Click for Code](/Python_files/python_data_analysis/2_Avg_Views_Growth_Curve.ipynb)

```python
# Plot data
fig, ax = plt.subplots(2, 1)

# Set theme
sns.set_theme(style="ticks")

# Mean (Average Views) by age bracket
# sns.barplot(data=age_brac_stats, x="mean", y=age_brac_stats.index, ax=ax[0], hue="mean", palette="dark:b_r", legend=False)
mean_plot = ax[0].barh(age_brac_stats.index, age_brac_stats["mean"], color='darkblue')
ax[0].set_title("Average Views Growth Curve")
ax[0].set_ylabel("")
ax[0].set_xlabel("")
ax[0].invert_yaxis()
ax[0].xaxis.set_major_formatter(plt.FuncFormatter(lambda x, pos: f"{int(x/1000)}K"))
# ax[0].set_yticklabels(age_brac_stats.index)

# Median (Median Views) by age bracket
# sns.barplot(data=age_brac_stats, x="median", y=age_brac_stats.index, ax=ax[1], hue="median", palette="dark:b_r", legend=False)
median_plot = ax[1].barh(age_brac_stats.index, age_brac_stats["median"], color='darkblue')
ax[1].set_title("Median Views Growth Curve")
ax[1].set_ylabel("")
ax[1].set_xlabel("")
ax[1].invert_yaxis()
ax[1].xaxis.set_major_formatter(plt.FuncFormatter(lambda x, pos: f"{int(x/1000)}K"))
# ax[1].set_yticklabels(age_brac_stats.index)

fig.tight_layout()
plt.show()

```

Insight:

Average Views Growth Curve (Mean)
- Average views grow steadily from 10K in first week → 100K by 30 days → 400K+ after 90 days
- The largest percentage increase happens in the first 30 days (10x growth from week 1)
- Long-term songs average 40x more views than first-week songs

Median Views Growth Curve
- Median views peak at 80K during days 8-30, then decline to 70K and 60K
- Most songs never grow after 30 days — they actually lose momentum
- The gap between mean (400K) and median (60K) at 90+ days proves only a few hit songs drive the average up

Recommendations
- Promote aggressively in first 30 days only — median views peak here and decline after, so extra promotion beyond 30 days has diminishing returns
- Don't expect most songs to become evergreen — the median line dropping tells you only 20-30% of songs will sustain long-term growth
- Use median (not mean) for realistic expectations — the mean is misleadingly high because a few outliers dominate; base decisions on what happens to a "typical" song

![Plots](/Python_files/images/2.png)

*Horizontal (barh) charts showing the average views growth over time*



2.Which songs had "second wind" growth spikes months after release?

[Click for Code](/Python_files/python_data_analysis/3_Post_Release_Growth_Spikes.ipynb)

```python
# CREATE HORIZONTAL BAR CHART
plt.figure(figsize=(12, 10))

# Create horizontal bars
bars = plt.barh(
    range(len(top_spikes)),
    top_spikes['views_per_day'].values,
    color="darkblue",
    edgecolor='darkgreen',
    linewidth=0.5
)

# Add song titles as y-axis labels
plt.yticks(
    range(len(top_spikes)),
    top_spikes['title_clean'].values,
    fontsize=9
)

# Labels and title
plt.xlabel('Views Per Day', fontsize=12, fontweight='bold')
plt.ylabel('Song Title', fontsize=12, fontweight='bold')
plt.title(
    f'Top {len(top_spikes)} Songs with Strongest Post-Release Growth\n(30+ days old, 5,000+ views/day)',
    fontsize=14,
    fontweight='bold'
)

# Add value labels at the end of each bar
for i, (bar, val) in enumerate(zip(bars, top_spikes['views_per_day'])):
    plt.text(
        val + 500,  # Position slightly after the bar end
        i,
        f'{val:,.0f}',
        va='center',
        fontsize=8,
        fontweight='bold'
    )

# Add grid for better readability
plt.grid(axis='x', alpha=0.3, linestyle='--')
plt.gca().spines['top'].set_visible(False)
plt.gca().spines['right'].set_visible(False)

plt.tight_layout()
plt.show()

```

Insights:
- "On God" is the undisputed evergreen hit – At 18,172 views per day, it generates nearly double the daily views of the second-ranked song, proving it has maintained massive momentum long after release
- Top 3 songs dominate post-release growth – "On God," "Pancake," and "Street Crown" all exceed 10,000 views per day, making them the catalog's most valuable long-term assets
- Danger song is performing surprisingly well – Despite potentially less promotion, "Shatta Wale, DJ Mac, Crash Dummy - Danger" ranks #8 with 5,664 views/day, outperforming several major official videos

Recommendations:
- Re-promote "On God" aggressively – Use this song for TikTok challenges, remixes, or sync licensing deals since it already has proven organic momentum
- Consider a "Street Crown" remix or visual upgrade – At 11,076 views/day, this song has clear staying power; a fresh video or collaboration could amplify it further
- Investigate why "Danger" is performing so well – Analyze comments and external mentions to understand its growth source (playlist placement? dance challenge? regional trend?), then replicate that strategy


![Plots](/Python_files/images/3.png)

*Horizontal (barh) chart showing songs that had a view spike after release*


## 📈 Predictive Analytics
3.Which songs are "undervalued" (current views lower than predicted based on likes/comments)?

[Click for Code](/Python_files/python_data_analysis/4_Undervalued_Songs.ipynb)

```python
# Visualization
plt.figure(figsize=(10, 6))

# Plot all songs as blue dots
plt.scatter(df_merged['views'],df_merged['engagement_rate'], alpha=0.3, color='blue', label='All Songs')

# Highlight undervalued songs as red stars
plt.scatter(undervalued['views'], undervalued['engagement_rate'], 
            color='red', s=100, marker='*', label='Undervalued (Hidden Gems)')

# Add benchmark lines
plt.axhline(y=avg_engagement, color='green', linestyle='--', label=f'Avg Engagement: {avg_engagement:.1f}%')
plt.axvline(x=avg_views, color='orange', linestyle='--', label=f'Avg Views: {avg_views:,.0f}')

plt.xscale('log')
plt.xlabel('Views (log scale)')
plt.ylabel('Engagement Rate (%)')
plt.title('Undervalued Songs: High Engagement + Low Views')
plt.legend()
plt.tight_layout()
plt.show()

```

Insight:
- Engagement rate declines sharply as view counts increase – Songs with 10,000-20,000 views have engagement rates of 3.5% to 2.8%, while songs with over 500,000 views drop below 1% engagement
- Low-view songs show the highest fan passion – The most engaged audiences are found on songs with fewer than 100,000 views, where engagement rates range from 3.5% down to 1.2%
- High-view songs attract passive listeners – Once a song exceeds 500,000 views, engagement rate consistently falls below 0.5%, meaning the majority of viewers are casually listening without interacting

Recommendations
- Prioritize promoting undervalued songs with 10,000-100,000 views – These have the highest engagement rates (2-3.5%), proving the content resonates, but reach is still limited
- Don't expect viral hits to maintain high engagement – Massive view counts naturally dilute engagement rates; this is normal and not a sign of poor quality
- Use engagement rate (not just views) to identify re-promotion candidates – Songs with 50,000-100,000 views and 2%+ engagement are better targets for additional promotion than songs with millions of views and near-zero engagement


![Plots](/Python_files/images/6.png)

*Scatter plot showing the engagement rate of songs*


## 📊 Release Timing & Seasonality
5.What is the optimal day of week to release a song? (By 7-day, 30-day, and 90-day views)

[Click for Code](/Python_files/python_data_analysis/5_Optimal_Release_Day.ipynb)

```python
# Create horizontal bar chart
fig, ax = plt.subplots(figsize=(10, 6))

# Plot horizontal bars
bars = ax.barh(df_optimal_day.index, df_optimal_day['mean'], color='darkblue', edgecolor='black', alpha=0.8)

# Add value labels on bars
for i, (bar, value) in enumerate(zip(bars, df_optimal_day['mean'])):
    ax.text(value, bar.get_y() + bar.get_height()/2, f'{value:,.0f}', 
            va='center', ha='left', fontsize=10, fontweight='bold')

# Customize the chart
ax.set_xlabel('Average Views', fontsize=12)
ax.set_ylabel('Release Day', fontsize=12)
ax.set_title('Optimal Release Day by Average Views', fontsize=14, fontweight='bold')
ax.invert_yaxis()  # Best day at top
ax.grid(axis='x', alpha=0.3, linestyle='--')

# Despine - remove right and top spines
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

# Add a vertical line for overall average
overall_avg = df_merged['views'].mean()
ax.axvline(x=overall_avg, color='red', linestyle='--', linewidth=2, 
           label=f'Overall Average: {overall_avg:,.0f}')

# Add legend
ax.legend(loc='lower right')

plt.tight_layout()
plt.show()

```

Insight:
- Wednesday is the dominant release day – With 796,456 average views, Wednesday outperforms every other day by a significant margin (over 200,000 views ahead of Sunday)
- Sunday is the clear second-best option – At 591,505 average views, Sunday is the only other day above 500,000 views, making it a strong alternative
- Monday is consistently the weakest day – With only 213,596 average views, Monday releases underperform by nearly 4x compared to Wednesday

Recommendations
- Schedule all major releases on Wednesdays – This gives songs a full week of momentum building toward the following weekend
- Avoid Monday releases entirely – The data is clear that Monday is the worst-performing day; use Mondays for announcements, teasers, or behind-the-scenes content instead
- Use Sunday for secondary releases – If Wednesday is unavailable (e.g., holiday conflicts), Sunday is the next best option based on historical performance

![Plots](/Python_files/images/9.png)

*Horizontal (barh) chart showing the best day of the week for releases*


6.Are there seasonal patterns? (Which months historically perform best?)

[Click for Code](/Python_files/python_data_analysis/6_Seasonal_Patterns.ipynb)

```python
# Create horizontal bar chart
fig, ax = plt.subplots(figsize=(10, 6))

# Plot horizontal bars
bars = ax.barh(df_monthly_group.index, df_monthly_group['mean'], color='darkblue', edgecolor='black', alpha=0.8)

# Add value labels on bars
for i, (bar, value) in enumerate(zip(bars, df_monthly_group['mean'])):
    ax.text(value, bar.get_y() + bar.get_height()/2, f'{value:,.0f}', 
            va='center', ha='left', fontsize=10, fontweight='bold')

# Customize the chart
ax.set_xlabel('Average Views', fontsize=12)
ax.set_ylabel('Release Month', fontsize=12)
ax.set_title('What is the Pattern of Views by Month?', fontsize=14, fontweight='bold')
ax.invert_yaxis()  # Best day at top
ax.grid(axis='x', alpha=0.3, linestyle='--')

plt.xscale('log')

# Despine - remove right and top spines
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

# Add a vertical line for overall average
overall_avg = df_merged['views'].mean()
ax.axvline(x=overall_avg, color='red', linestyle='--', linewidth=2, 
           label=f'Overall Average: {overall_avg:,.0f}')

# Add legend
ax.legend(loc='lower right')

plt.tight_layout()
plt.show()

```

Insights:
- April is the strongest release month by a wide margin – With over 1.1 million average views, April outperforms the second-best month (March at 952,346) by nearly 150,000 views
- March and December form the second tier – Both months generate over 600,000 average views, making them solid alternatives to April
- November is the weakest month – At only 162,280 average views, November releases underperform by nearly 7x compared to April

Recommendations
- Schedule flagship releases in April – The data clearly shows April as the peak performing month; plan album launches and major singles for this window
- Avoid November releases – November shows the lowest average views; use this month for planning, recording, or building anticipation for December/January releases
- Use March and December for secondary releases – If April is unavailable, March and December are your next best options based on historical performance


![Plot](/Python_files/images/10.png)

*Horizontal (barh) chart showing the seasonal effect on song releases*

7.How does releasing on holidays affect performance?

[Click for Code](/Python_files/python_data_analysis/7_Holiday_Release_Performance.ipynb)

```python
# Visualization
fig, axes = plt.subplots(2, 1, figsize=(8, 8))

# Plot 1: Bar chart comparing holiday vs regular releases
ax1 = axes[0]
categories = ['Regular Releases', 'Holiday Releases']
means = [regular_performance, holiday_performance]
medians = [regular_median, holiday_median]

x = np.arange(len(categories))
width = 0.35

bars1 = ax1.bar(x - width/2, means, width, label='Average Views', color='darkblue', edgecolor='black')
bars2 = ax1.bar(x + width/2, medians, width, label='Median Views', color='lightcoral', edgecolor='black')

ax1.set_ylabel('Views')
ax1.set_title('Holiday Releases vs Regular Releases')
ax1.set_xticks(x)
ax1.set_xticklabels(categories)
ax1.legend()
ax1.set_yscale('linear')
ax1.spines['right'].set_visible(False)  # Despine - remove right and top spines 
ax1.spines['top'].set_visible(False)
ax1.grid(axis='y', alpha=0.3, linestyle='--')

# Add legend
ax1.legend(loc='upper left')

# Add value labels
for bar in bars1:
    height = bar.get_height()
    ax1.text(bar.get_x() + bar.get_width()/2, height, f'{height:,.0f}', ha='center', va='bottom', fontsize=8)
for bar in bars2:
    height = bar.get_height()
    ax1.text(bar.get_x() + bar.get_width()/2, height, f'{height:,.0f}', ha='center', va='bottom', fontsize=8)

# Plot 2: Performance by specific holiday
ax2 = axes[1]
if len(holiday_specific) > 0:
    top_holidays = holiday_specific.head(8).copy()
    bars = ax2.barh(range(len(top_holidays)), top_holidays['mean'], color='darkblue', edgecolor='black')
    ax2.set_yticks(range(len(top_holidays)))
    ax2.set_yticklabels(top_holidays.index)
    ax2.set_xlabel('Average Views')
    ax2.set_title('Performance by Specific Holiday')
    ax2.invert_yaxis()  # Best day at top
    ax2.spines['top'].set_visible(False)    # Despine - remove right and top spines 
    ax2.spines['right'].set_visible(False)
    ax2.grid(axis='x', alpha=0.3, linestyle='--')

    for bar, val in zip(bars, top_holidays['mean']):
        ax2.text(val + val*0.01, bar.get_y() + bar.get_height()/2, f'{val:,.0f}', va='center', fontsize=8)
else:
    ax2.text(0.5, 0.5, 'Insufficient holiday data', ha='center', va='center', transform=ax2.transAxes)
    ax2.set_title('Performance by Specific Holiday')

plt.tight_layout()

```

Insight:
- Holiday releases significantly outperform regular releases – Holiday releases average 658,202 views compared to 385,239 for regular releases, a 71% increase in average views
- Easter is by far the most powerful holiday – With 3,159,730 average views, Easter outperforms every other holiday by a massive margin (over 2 million views ahead of second place)
- May Day and Christmas are the next best options – Both generate over 1 million average views, making them strong secondary holiday release windows

Recommendations
- Prioritize Easter weekend for major releases – The data shows Easter is uniquely powerful; schedule album launches or biggest singles for this window
- Use May Day (May 1) and Christmas as secondary holiday targets – Both generate strong performance and can work for important but non-flagship releases
- Avoid Eid holidays and New Year for releases – With average views under 170,000, these holidays show no performance benefit over regular release days; don't rush to meet these deadlines

![Plots](/Python_files/images/11.png)

*Vertical & Horizontal Bar Charts showing the impact of holiday releases in comparison to regular days*

## 🔥 Performance Classification & Anomaly Detection
8.Which songs are statistical anomalies (significantly outperforming similar songs released same month)?

[Click for Code](/Python_files/python_data_analysis/8_Statistical_Anomalies_Surprise_hits.ipynb)

```python
# Visualization
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Hide the 4th subplot (bottom right)
axes[1, 1].set_visible(False)

fig.suptitle('Statistical Anomaly Analysis: Identifying Surprise Hits', fontsize=14, fontweight='bold')

# Plot 1: Scatter plot of all songs colored by anomaly status
ax1 = axes[0, 0]

# Plot normal songs
normal = df_mature[~df_mature['is_anomaly']]
ax1.scatter(normal['release_date'], normal['views'], alpha=0.4, s=30, c='blue', label='Normal Songs')

# Plot anomalies
if len(anomalies) > 0:
    ax1.scatter(anomalies['release_date'], anomalies['views'], alpha=0.8, s=100, c='red', marker='*', label='Anomalies (Surprise Hits)')

ax1.set_xlabel('Release Date')
ax1.set_ylabel('Views (log scale)')
ax1.set_title('All Songs by Release Date\n(Red stars = Statistical Anomalies)')
ax1.set_yscale('log')
ax1.legend()
ax1.grid(True, alpha=0.3)

# Plot 2: Z-Score distribution (histogram)
ax2 = axes[0, 1]
ax2.hist(df_mature['z_score'], bins=30, color='darkblue', edgecolor='black', alpha=0.7)
ax2.axvline(x=2, color='red', linestyle='--', linewidth=2, label='Anomaly Threshold (Z=2)')
ax2.axvline(x=-2, color='orange', linestyle='--', linewidth=2, label='Underperformer Threshold (Z=-2)')
ax2.set_xlabel('Z-Score (Standard Deviations from Monthly Average)')
ax2.set_ylabel('Number of Songs')
ax2.set_title('Distribution of Z-Scores\n(How songs perform vs monthly average)')
ax2.legend()
ax2.grid(True, alpha=0.3)

# Plot 3: Top 10 Anomalies - Horizontal Bar Chart
ax3 = axes[1, 0]
if len(anomalies) > 0:
    top_anom = anomalies.head(10).copy()
    top_anom = top_anom.sort_values('pct_above_avg', ascending=True)
    
    bars = ax3.barh(range(len(top_anom)), top_anom['pct_above_avg'], color='darkblue', edgecolor='black')
    ax3.set_yticks(range(len(top_anom)))
    ax3.set_yticklabels(top_anom['title'].str[:35])
    ax3.set_xlabel('Percentage Above Monthly Average (%)')
    ax3.set_title('Top 10 Anomalies\n(How much they outperformed peers)')
    ax3.spines['right'].set_visible(False) # despine
    ax3.spines['top'].set_visible(False)

    for bar, val in zip(bars, top_anom['pct_above_avg']):
        ax3.text(val + 5, bar.get_y() + bar.get_height()/2, f'{val:.0f}%', va='center', fontsize=8)
else:
    ax3.text(0.5, 0.5, 'No anomalies found', ha='center', va='center', transform=ax3.transAxes)
    ax3.set_title('Top 10 Anomalies')

plt.tight_layout()
plt.show()

```

Insight:
- Cocoa Season is the biggest statistical outlier in the catalog – At 1,660% above monthly average, this song dramatically outperformed every other song released in its same month by a massive margin
- The top 3 anomalies all exceeded 1,000% above average – Cocoa Season (1,660%), Prove You Wrong (1,267%), and Wine Your Waist (1,084%) represent completely unexpected breakout hits
- Most anomalies are older songs (2014-2017) – This suggests these songs may have benefited from unique circumstances (viral moments, playlist placements, or cultural events) rather than just standard promotion

Recommendations
- Investigate what made Cocoa Season explode – Analyze comments, external mentions, and timing to understand the specific driver (Was it a dance challenge? Radio play? Feature placement?) then replicate that strategy
- Study the common elements among top anomalies – Look for patterns in genre, producers, collaborators, or release timing that might explain their unexpected success
- Re-promote these anomaly songs – They have already proven they resonate with audiences; a remix, video upgrade, or social media push could generate additional momentum

![Plots](/Python_files/images/14.png)

*Scatter plot, Histogram & Horizontal bar chart showing songs that outperformed others released in the same time period*



# The Challenges & Limitations
Without daily historical view data, the analysis could only identify "what happened" (current performance) but not "how it happened" (growth patterns, peaks, or predictions), forcing several important questions to be dropped or answered with proxies.


# Key Findings
## 🏆 Top Performing Songs
|Category|	Winner	|Key Metric|
|--------|----------|----------|
|Most Viewed (Video)|	On God (Official Video)|	26.5M+ views|
|Most Viewed (Audio)|	My Level (Audio Slide)|	1.34M+ views|
|Highest Engagement Rate|	Rise Anyway (Audio Slide)|	7.68% engagement|
|Best Post-Release Growth|	On God	|18,172 views/day|


## 📅 Release Timing Insights
|Finding	|Insight|
|-----------|-------|
|Best day to release|	Wednesday (796,456 average views)|
|Worst day to release	|Monday (213,596 average views)|
|Best month to release|	April (1.1M average views)|
|Worst month to release	|November (162,280 average views)|
|Holiday releases|	71% higher average views than regular releases|
|Best holiday	|Easter (3.16M average views)|


## 💎 Hidden Gems (Undervalued Songs)
Songs with high engagement but low views – prime candidates for re-promotion:

|Song|	Views|	Engagement Rate|	Potential|
|----|-------|-----------------|-------------|
|Rise Anyway (Audio Slide)|	74,516	|7.68%	|High|
|Abonko (Audio Slide)|	99,335|	7.78%|	High|
|Tell Ya Man (Audio Slide)|	47,413	|7.22%	|High|

## ⭐ Statistical Anomalies (Unexpected Hits)
Songs that dramatically outperformed their monthly peers:

|Song|	Month|	Above Average|
|----|-------|---------------|
|Cocoa Season (Official Video)|	October 2016|	1,660%|
|Prove You Wrong (Official Video)|	September 2016|	1,267%|
|Wine Your Waist (Audio Slide)|	November 2016|	1,084%|


# Recommendations
**For Release Strategy**
|Recommendation|	Rationale|
|--------------|-------------|
|Schedule major releases on Wednesdays	|Wednesday outperforms all other days by 2-4x|
|Target April for flagship releases	|April shows highest average views of any month|
|Avoid November releases	|November is the worst-performing month|
|Prioritize Easter weekend|	Easter releases average 3.16M views|


**For Catalog Management**
|Recommendation|	Rationale|
|--------------|-------------|
|Re-promote undervalued songs	|High engagement + low views = untapped potential|
|Study the top 5 anomalies	|Understand what made them explode unexpectedly|
|Create videos for high-performing audio-only songs|	Songs like "Rise Anyway" have proven quality|



# 🔮Future Work
Once daily tracking is established, the following questions can be answered:

|Question|	Data Needed|
|--------|-------------|
|Can we predict lifetime views from first 7 days?|	Day 7 view counts|
|What is the typical peak velocity for a hit vs flop?	|Daily view data|
|How many days until a song reaches 80% of lifetime views?|	Cumulative view data|
|How does engagement rate decay over time?|	Engagement at multiple time points|
|What is the ideal gap between releases?	|Release dates + promotion data|
