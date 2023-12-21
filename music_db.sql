-- Таблица "Жанры"
CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица "Исполнители"
CREATE TABLE IF NOT EXISTS Artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL    
);

-- Таблица "Альбомы"
CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    year_issue SMALLINT NOT NULL    
);

-- Таблица "Треки"
CREATE TABLE IF NOT EXISTS Track (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    long SMALLINT NOT NULL,
    album_id INTEGER NOT NULL REFERENCES Album(id)
);

-- Таблица "Жанры-Исполнители"
CREATE TABLE IF NOT EXISTS GenreArtist (
	genre_id INTEGER REFERENCES Genre(id),
	artist_id INTEGER REFERENCES Artist(id),
	CONSTRAINT pk PRIMARY KEY (genre_id, artist_id)
);

-- Таблица "Исполнители-Альбомы"
CREATE TABLE IF NOT EXISTS ArtistAlbum (
	artist_id INTEGER REFERENCES Artist(id),
	album_id INTEGER REFERENCES Album(id),
	CONSTRAINT pk1 PRIMARY KEY (artist_id, album_id)
);

-- Таблица "Сборники"
CREATE TABLE IF NOT EXISTS Mix (
	id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    year_issue SMALLINT NOT NULL    
);

-- Таблица "Сборники-Треки"
CREATE TABLE IF NOT EXISTS MixTrack (
	mix_id INTEGER REFERENCES Mix(id),
	track_id INTEGER REFERENCES Track(id),
	CONSTRAINT pk2 PRIMARY KEY (mix_id, track_id)
);