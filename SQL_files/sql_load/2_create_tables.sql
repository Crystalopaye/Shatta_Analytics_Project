/* DATABASE: Shatta Wale Music Database
- PURPOSE: Track songs, projects and platform metrics
- CREATED: 2026
*/

/*
- TABLE: project_dim
- PURPOSE: Stores information about projects/albums/EPs
- RELATIONSHIP: One project can have many songs
*/

CREATE TABLE public.project_dim (
    project_id INT PRIMARY KEY,     -- Unique project identifier
    title VARCHAR(255),             -- Project name (Album/EP/Mixtape)
    release_date DATE,              -- When project was released
    type_of_project VARCHAR(100),   -- Type: Album, EP, Mixtape, etc
    track_count INT                 -- Number of tracks on the project
);

/*
- TABLE: songs_fact
- PURPOSE: list of all songs
- RELATIONSHIP: Many songs belong to one project
*/

CREATE TABLE public.songs_fact(
    song_id INT PRIMARY KEY,         -- Unique song identifier
    project_id INT,                  -- Links to project_dim
    title VARCHAR(255),              -- Song title
    artiste_name VARCHAR(255),       -- Artiste name
    audio BOOLEAN DEFAULT FALSE,                   -- Has audio version
    video BOOLEAN DEFAULT FALSE,                   -- Has video version
    release_date TIMESTAMP,               -- When song was released
    producers TEXT,          -- Producer(s) of the song
    genre TEXT,              -- Music genre
    duration TIME,                   -- Song length
    notes TEXT,              -- Additional notes

    -- Foreign Key Relationship
    FOREIGN KEY (project_id) REFERENCES public.project_dim (project_id)
        ON DELETE SET NULL -- If a project is deleted, songs remain but unlinked
);

/*
- TABLE: platform_metrics_dim
- PURPOSE: Tracks platform-specific metrics for each song
- RELATIONSHIP: One song can have multiple rows in this table; one for each platfmorm it exists on
*/

CREATE TABLE platform_metrics_dim(
    id INT PRIMARY KEY,             -- Unique platform identifier
    song_id INT,                    -- Links to song
    platform_name VARCHAR(255),     -- Platform to find song
    platform_url TEXT,              -- link to song url
    views INT DEFAULT 0,                      -- number of views per platform
    likes INT DEFAULT 0,                      -- number of likes of the song
    comments INT DEFAULT 0,                   -- number of comments of the song

    -- Foreign Key Relationship
    FOREIGN KEY (song_id) REFERENCES public.songs_fact (song_id)
        ON DELETE CASCADE -- If a song is deleted, its platform data is also deleted.
);


-- Set table ownership
ALTER TABLE public.project_dim OWNER TO postgres;
ALTER TABLE public.songs_fact OWNER TO postgres;
ALTER TABLE public.platform_metrics_dim OWNER TO postgres;

-- Create indexes for better query performance
/*
- INDEXES FOR songs_fact (Fact Table)
*/

-- CRITICAL: Foreign key index for joining with project_dim
-- Without this, every join between songs and projects will be slow
CREATE INDEX idx_songs_project_id ON public.songs_fact(project_id);

-- CRITICAL: Date index for time-based analysis
-- Used for: "Show me songs released in 2024", release trends over time
CREATE INDEX idx_songs_release_date ON public.songs_fact(release_date);

-- HIGH VALUE: Title search index for finding specific songs
-- Used for: Looking up "Agenda", "My Level", etc.
CREATE INDEX idx_songs_title ON public.songs_fact(title);

-- HIGH VALUE: Genre filter for categorical analysis
-- Used for: "How many Dancehall vs Afro-Beat songs?"
CREATE INDEX idx_songs_genre ON public.songs_fact(genre);

-- MEDIUM VALUE: Composite index for common query patterns
-- Used for: "Show me all singles from 2025 ordered by title"
CREATE INDEX idx_songs_release_title ON public.songs_fact(release_date, title);

-- MEDIUM VALUE: Boolean filter for video/audio analysis
-- Used for: "Count songs WITH videos vs WITHOUT videos"
CREATE INDEX idx_songs_has_video ON public.songs_fact(video) WHERE video = true;


/*
- INDEXES FOR platform_metrics_dim (Metrics Table)
*/

-- CRITICAL: Foreign key index for joining with songs_fact
-- This is THE most important index for platform analysis
CREATE INDEX idx_platform_song_id ON public.platform_metrics_dim(song_id);

-- CRITICAL: Platform filter for platform-specific analysis
-- Used for: "Show me only YouTube metrics", platform comparisons
CREATE INDEX idx_platform_name ON public.platform_metrics_dim(platform_name);

-- HIGH VALUE: Views sorting for "Top 10 most viewed songs"
-- DESCENDING order because you'll always want highest first
CREATE INDEX idx_platform_views_desc ON public.platform_metrics_dim(views DESC);

-- HIGH VALUE: Composite index for grouped platform analysis
-- Used for: "Get total views per platform for 2025 releases"
CREATE INDEX idx_platform_song_views ON public.platform_metrics_dim(song_id, platform_name, views);

-- MEDIUM VALUE: Likes and comments for engagement analysis
-- Used for: "Find songs with high engagement (likes/view ratio)"
CREATE INDEX idx_platform_likes ON public.platform_metrics_dim(likes DESC);
CREATE INDEX idx_platform_comments ON public.platform_metrics_dim(comments DESC);


/*
- INDEXES FOR project_dim (Dimension Table)
*/

-- HIGH VALUE: Project type filter
-- Used for: "Count all albums vs EPs vs Singles"
CREATE INDEX idx_project_type ON public.project_dim(type_of_project);

-- HIGH VALUE: Project release date for timeline analysis
-- Used for: "Show me all projects released in 2024"
CREATE INDEX idx_project_release_date ON public.project_dim(release_date);

-- MEDIUM VALUE: Project title search
-- Used for: "Find the 'SAFA' album details"
CREATE INDEX idx_project_title ON public.project_dim(title);


/*
- PARTIAL INDEXES (For specific, frequent queries)
*/

-- Only index songs that have videos (saves space)
CREATE INDEX idx_songs_with_video ON public.songs_fact(song_id) WHERE video = true;

-- Only index high-performing songs (views > 1 million)
-- Great for "Top Hits" dashboard filters
CREATE INDEX idx_high_performance_songs ON public.platform_metrics_dim(song_id, views) 
WHERE views > 1000000;


/*
- UNIQUE INDEXES (Prevent duplicate data)
*/

-- Prevent duplicate platform entries for the same song
-- One song should only have ONE row per platform
CREATE UNIQUE INDEX idx_unique_song_platform ON public.platform_metrics_dim(song_id, platform_name);

-- Prevent duplicate song titles (optional, but useful)
--CREATE UNIQUE INDEX idx_unique_song_title ON public.songs_fact(title);


/*
- COMPOSITE INDEX FOR COMMON QUERIES
*/

-- Super index for the most expensive query pattern:
-- "Get all songs from a specific project with their YouTube views"
-- This covers the JOIN, the filter, and the sorting in one index
CREATE INDEX idx_performance_analysis ON public.songs_fact(project_id, release_date, title) 
INCLUDE (genre, duration);