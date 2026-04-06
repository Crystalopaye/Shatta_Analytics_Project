-- Grouping of songs by year
SELECT
title,
release_date,

EXTRACT(YEAR FROM release_date) as release_year

FROM songs_fact

WHERE release_date IS NOT NULL

ORDER BY release_year DESC;

-- Show how many songs were released per year
SELECT
COUNT(title) as count_of_songs,

EXTRACT(YEAR FROM release_date) as release_year

FROM songs_fact

WHERE release_date IS NOT NULL AND (audio = TRUE OR video = TRUE) -- use both audio and video because 2013, 2014 and 2015 had songs released with video that didnt have an audio

GROUP BY release_year

ORDER BY count_of_songs DESC;

-- INSIGHT
/*
Shatta Wale's music output has been remarkably consistent over the last decade, with a significant peak in 2016.
- Peak Year (2016): 190 songs – This was his most prolific year by a wide margin.
- Consistent Output (2013-2025): Apart from the 2016 peak, his annual release count has typically ranged between 50 and 95 songs, showing a steady work rate.
- Recent Stability (2020-2026): Since 2020, his output has stabilized between 55 and 75 songs per year, indicating a mature and consistent release schedule.
*/