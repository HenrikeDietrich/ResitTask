ALTER TABLE movies ADD lexemesGenre tsvector; 
UPDATE movies SET lexemesGenre = to_tsvector(Genre);
SELECT url FROM movies WHERE lexemesGenre @@ to_tsquery('horror');
ALTER TABLE movies ADD rank float4; 
UPDATE movies SET rank = ts_rank(lexemesGenre,plainto_tsquery(( SELECT Genre FROM movies WHERE url='incarnate'))); 
CREATE TABLE recommendationsBasedOnGenreField11 AS SELECT url, rank FROM movies WHERE rank > 0.005  ORDER BY rank DESC LIMIT 50;


\copy (SELECT * FROM recommendationsBasedOnGenreField11) to '/home/pi/RSL/top50recommendationsHorror.csv' WITH csv;
