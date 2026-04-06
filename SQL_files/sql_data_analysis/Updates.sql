-- Update audio and video entries for songs
UPDATE songs_fact
SET audio = FALSE,
    video = TRUE

WHERE song_id IN (438, 526, 429, 361, 484, 488, 334, 388)

-- Check results
SELECT
song_id,
title,
audio,
video

FROM songs_fact

-- WHERE song_id = 388

WHERE song_id IN (479, 496, 438, 526, 429, 361, 484, 488, 334, 388);

-- update for new songs
UPDATE songs_fact
SET audio = FALSE,
    video = TRUE

WHERE song_id = 388

-- Using one code to correct all the errors with audio and video entries
UPDATE songs_fact
SET audio = FALSE,
    video = TRUE

WHERE title ILIKE '%video%' OR
      title ILIKE '%visualizer%';