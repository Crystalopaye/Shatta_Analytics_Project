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
- [How to Reproduce This Project](#how-to-reproduce-this-project)
- [Connect With Me](#connect-with-me)



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



# Tools & Technologies Used

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

## Project Workflow
