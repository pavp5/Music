-- Название и продолжительность самого длительного трека
SELECT name, long
FROM Track
WHERE long = (SELECT MAX(long) FROM TRack);

-- Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM Track
WHERE long >= 3.5;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM Mix
WHERE year_issue BETWEEN 2018 AND 2020;

-- Исполнители, чьё имя состоит из одного слова
SELECT name
FROM Artist
WHERE NOT name like '% %';

 -- Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM Track
WHERE name LIKE '%Мой%' OR name LIKE '%My%';

-- Количество исполнителей в каждом жанре
SELECT name AS genre_name, COUNT(*) AS artist_count
FROM Genre AS g
    FULL JOIN GenreArtist AS ga ON g.id = ga.genre_id
GROUP BY name
ORDER BY name;

-- Количество треков, вошедших в альбомы 2019–2020 годов
SELECT year_issue, COUNT(*) AS track_count
FROM Album AS a 
    FULL JOIN Track AS t ON a.id = t.album_id
WHERE year_issue BETWEEN 2019 AND 2020
GROUP BY year_issue
ORDER BY year_issue;

-- Средняя продолжительность треков по каждому альбому
SELECT a.name, AVG(long) AS avg_long
FROM Track AS t
    LEFT JOIN Album AS a ON t.album_id = a.id
GROUP BY a.name
ORDER BY a.name;

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT name
FROM Artist
WHERE NOT id IN (
    SELECT artist_id 
    FROM ArtistAlbum 
    WHERE album_id IN (
        SELECT id
        FROM Album
        WHERE year_issue = 2020
    )
);

-- Названия сборников, в которых присутствует конкретный исполнитель
SELECT name
FROM Mix
WHERE id IN (
    SELECT mix_id 
    FROM MixTrack 
    WHERE track_id IN (
        SELECT id
        FROM Track
        WHERE album_id IN (
            SELECT id
            FROM Album
            WHERE id IN (
                SELECT album_id
                FROM ArtistAlbum
                WHERE artist_id = 2
            )
        )
     )
);

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT name
FROM Album
WHERE id IN (
    SELECT album_id
    FROM ArtistAlbum
    WHERE artist_id IN (
        SELECT artist_id
        FROM GenreArtist
        GROUP BY artist_id
        HAVING COUNT(*) > 1
    )
);

-- Наименования треков, которые не входят в сборники
SELECT name
FROM Track
WHERE NOT id IN (
    SELECT track_id
    FROM MixTrack
);

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
SELECT name
FROM Artist
WHERE id IN (
    SELECT artist_id
    FROM ArtistAlbum
    WHERE album_id IN (
        SELECT album_id
        FROM Track
        WHERE long = (
            SELECT MIN(long) 
            FROM Track
        )
    )
);
       
-- Названия альбомов, содержащих наименьшее количество треков
SELECT DISTINCT a.name
FROM Album AS a
    LEFT JOIN Track AS t ON t.album_id = a.id
WHERE t.album_id IN (
    SELECT album_id
    FROM Track
    GROUP BY album_id
    HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM Track
        GROUP BY album_id
        ORDER BY COUNT(*)
        LIMIT 1
    )
);
