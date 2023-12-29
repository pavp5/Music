-- 1. Название и продолжительность самого длительного трека
SELECT name, long
FROM Track
WHERE long = (SELECT MAX(long) FROM TRack);

-- 2, Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM Track
WHERE long >= 3.5;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM Mix
WHERE year_issue BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова
SELECT name
FROM Artist
WHERE NOT name like '% %';

--5. Название треков, которые содержат слово «мой» или «my»
/* Ваше замечание:
В 5 запросе можно было использовать оператор iLIKE для регистронезависимого поиска
*/ 
SELECT name
FROM Track
WHERE name iLIKE '%мой%' OR name iLIKE '%my%';

-- 6. Количество исполнителей в каждом жанре
SELECT name AS genre_name, COUNT(*) AS artist_count
FROM Genre AS g
    FULL JOIN GenreArtist AS ga ON g.id = ga.genre_id
GROUP BY name
ORDER BY name;

-- 7. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT year_issue, COUNT(*) AS track_count
FROM Album AS a 
    FULL JOIN Track AS t ON a.id = t.album_id
WHERE year_issue BETWEEN 2019 AND 2020
GROUP BY year_issue
ORDER BY year_issue;

-- 8. Средняя продолжительность треков по каждому альбому
SELECT a.name, AVG(long) AS avg_long
FROM Track AS t
    LEFT JOIN Album AS a ON t.album_id = a.id
GROUP BY a.name
ORDER BY a.name;

-- 9. Все исполнители, которые не выпустили альбомы в 2020 году
-- Первоначальный вариант
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
/* Ваше замечание:
В 9 запросе можно было обойтись без вложения, 
во вложенной части стоит просто объединить альбомы с исполнителями 
и сделать отбор через where
Комментарий:
Убрал последний подзапрос.
Без первого подзапроса у меня не получается, не могу придумать условие отбора - 
исполнитель мог не выпустить альбом в 2020 году, но мог выпустить в другие годы
*/
SELECT name
FROM Artist
WHERE NOT id IN (
    SELECT s.id
    FROM (
        SELECT ar.id
        FROM ArtistAlbum ar_al
            JOIN Artist ar ON ar_al.artist_id = ar.id
            JOIN Album al ON ar_al.album_id = al.id
        WHERE al.year_issue = 2020
    ) s
);

-- 10. Названия сборников, в которых присутствует конкретный исполнитель
-- Первоначальный вариант
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
/*
Ваше замечание:
В 10 запросе вложения вообще не нужны, стоит просто объеденить 
все нужные таблицы и сделать отбор по условию
*/
SELECT DISTINCT s.name
FROM (
    SELECT m.name, ar_al.artist_id
    FROM Mix m
        JOIN MixTrack m_t ON m_t.mix_id = m.id
        JOIN Track t ON m_t.track_id = t.id
        JOIN Album al ON t.album_id = al.id
        JOIN ArtistAlbum ar_al ON ar_al.album_id = al.id
) s
WHERE s.artist_id = 2
ORDER BY 1;

-- 11. Названия альбомов, в которых присутствуют исполнители более чем одного жанра
-- Первоначальный вариант
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
/* Ваше замечание:
И в 11 запросе вложенная часть совсем не нужна, т.к. вы после всех объединений 
можете сгруппировать результат по альбомам и сделать отбор при помощи HAVING
*/
SELECT DISTINCT s.name
FROM (
    SELECT al.name, g_a.genre_id
    FROM Album al
        JOIN ArtistAlbum ar_al ON ar_al.album_id = al.id
        JOIN GenreArtist g_a ON ar_al.artist_id = g_a.artist_id
    GROUP BY al.name, g_a.genre_id
    HAVING COUNT(*) > 1
) s;

/* Ваши замечания:
Аналогично в 12 запросе, а в 13 и 14 запросе все решается через одно вложение
*/

-- 12. Наименования треков, которые не входят в сборники
-- Первоначальный вариант
SELECT name
FROM Track
WHERE NOT id IN (
    SELECT track_id
    FROM MixTrack
);
-- Новый вариант
SELECT name
FROM Track t
    LEFT JOIN MixTrack m_t ON m_t.track_id = t.id  
WHERE m_t.track_id iS NULL;

-- 13. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
-- Первоначальный вариант
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
-- Новый вариант
SELECT DISTINCT ar.name name
FROM Artist ar
    JOIN ArtistAlbum ar_al ON ar_al.artist_id = ar.id
    JOIN Track t ON t.album_id = ar_al.album_id
WHERE t.long = (
    SELECT MIN(long)
    FROM Track
    )
ORDER BY 1;

-- 14. Названия альбомов, содержащих наименьшее количество треков
-- Первоначальный вариант
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
-- Новый вариант
SELECT al.name name
FROM Album al
    JOIN Track t ON t.album_id = al.id
GROUP BY al.name
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Track
    GROUP BY album_id
    ORDER BY COUNT(*)
    LIMIT 1
)
ORDER BY 1;