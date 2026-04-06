-- Querying info across all tables.
SELECT
songs_fact.title AS song_title,
project_dim.title AS project_title,
views,
likes,
comments



FROM songs_fact 

INNER JOIN platform_metrics_dim ON songs_fact.song_id = platform_metrics_dim.song_id
INNER JOIN project_dim ON songs_fact.project_id = project_dim.project_id

WHERE project_dim.project_id IN (6, 10);

