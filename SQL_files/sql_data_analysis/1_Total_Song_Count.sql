-- Find the unique song count
SELECT COUNT(DISTINCT title) as unique_song_count
FROM songs_fact;


-- Find the total song count
-- SELECT COUNT(title) as song_count
-- FROM songs_fact;