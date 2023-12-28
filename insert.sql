-- Жанры
INSERT INTO Genre VALUES (1, 'Жанр 1');
INSERT INTO Genre VALUES (2, 'Жанр 2');
INSERT INTO Genre VALUES (3, 'Жанр 3');

-- Исполнители
INSERT INTO Artist VALUES (1, 'Артист 1');
INSERT INTO Artist VALUES (2, 'Артист2');
INSERT INTO Artist VALUES (3, 'Артист 3');
INSERT INTO Artist VALUES (4, 'Артист 4');
INSERT INTO Artist VALUES (5, 'Артист 5');
INSERT INTO Artist VALUES (6, 'Артист6');
INSERT INTO Artist VALUES (7, 'Артист7');

-- Альбомы
INSERT INTO Album VALUES (1, 'Альбом 1', 2018);
INSERT INTO Album VALUES (2, 'Альбом 2', 2019);
INSERT INTO Album VALUES (3, 'Альбом 3', 2018);
INSERT INTO Album VALUES (4, 'Альбом 4', 2020);
INSERT INTO Album VALUES (5, 'Альбом 5', 2019);

-- Треки
INSERT INTO Track VALUES (1, 'Трек 1', 10, 1);
INSERT INTO Track VALUES (2, 'Трек 2', 20, 2);
INSERT INTO Track VALUES (3, 'Мой трек 3', 30, 4);
INSERT INTO Track VALUES (4, 'My track 4', 50, 3);
INSERT INTO Track VALUES (5, 'My track 5', 15, 5);
INSERT INTO Track VALUES (6, 'Трек 6', 40, 2);
INSERT INTO Track VALUES (7, 'Трек 7', 15, 1);

-- Сборники
INSERT INTO Mix VALUES (1, 'Сборник 1', 2020);
INSERT INTO Mix VALUES (2, 'Сборник 2', 2020);
INSERT INTO Mix VALUES (3, 'Сборник 3', 2019);
INSERT INTO Mix VALUES (4, 'Сборник 4', 2018);

-- Жанры - Исполнители
INSERT INTO GenreArtist VALUES(1, 1);
INSERT INTO GenreArtist VALUES(2, 1);
INSERT INTO GenreArtist VALUES(2, 2);
INSERT INTO GenreArtist VALUES(3, 5);
INSERT INTO GenreArtist VALUES(1, 4);
INSERT INTO GenreArtist VALUES(1, 3);
INSERT INTO GenreArtist VALUES(1, 5);

-- Исполнители - Альбомы
INSERT INTO ArtistAlbum VALUES(1, 5);
INSERT INTO ArtistAlbum VALUES(2, 5);
INSERT INTO ArtistAlbum VALUES(3, 1);
INSERT INTO ArtistAlbum VALUES(4, 5);
INSERT INTO ArtistAlbum VALUES(1, 1);
INSERT INTO ArtistAlbum VALUES(2, 4);
INSERT INTO ArtistAlbum VALUES(3, 5);
INSERT INTO ArtistAlbum VALUES(3, 2);

-- Сборники - Треки
INSERT INTO MixTrack VALUES(1, 1);
INSERT INTO MixTrack VALUES(1, 6);
INSERT INTO MixTrack VALUES(2, 1);
INSERT INTO MixTrack VALUES(3, 1);
INSERT INTO MixTrack VALUES(2, 2);
INSERT INTO MixTrack VALUES(2, 6);
INSERT INTO MixTrack VALUES(4, 6);
INSERT INTO MixTrack VALUES(1, 2);
INSERT INTO MixTrack VALUES(3, 4);
INSERT INTO MixTrack VALUES(3, 3);
INSERT INTO MixTrack VALUES(4, 5);
INSERT INTO MixTrack VALUES(3, 2);
INSERT INTO MixTrack VALUES(2, 4);
