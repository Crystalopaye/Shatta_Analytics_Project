COPY public.project_dim (project_id, title, release_date, type_of_project, track_count)
FROM 'C:/fiifi/Shatta_Analytics_Project/CSV_files/csv_files_utf8/project_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '')
WHERE project_id IS NOT NULL;

COPY public.songs_fact (song_id, project_id, title, artiste_name, audio, video, release_date, producers, genre, duration, notes)
FROM 'C:/fiifi/Shatta_Analytics_Project/CSV_files/csv_files_utf8/songs_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '')
WHERE song_id IS NOT NULL;  -- Skip NULL song_id rows

COPY public.platform_metrics_dim (id, song_id, platform_name, platform_url, views, likes, comments)
FROM 'C:/fiifi/Shatta_Analytics_Project/CSV_files/csv_files_utf8/platform_metrics_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '');