ALTER TABLE movies ADD lexemesStarring tsvector; 
UPDATE movies SET lexemesStarring = to_tsvector(Starring);
SELECT url FROM movies WHERE lexemesStarring @@ to_tsquery('Scarlett-Johansson');
ALTER TABLE movies ADD rank float4; 
UPDATE movies SET rank = ts_rank(lexemesStarring,plainto_tsquery(( SELECT Starring FROM movies WHERE url='avengers-age-of-ultron'))); 
CREATE TABLE recommendationsBasedOnStarringField3 AS SELECT url, rank FROM movies WHERE rank > 0.005 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnStarringField3) to '/home/pi/RSL/top50recommendations8.csv' WITH csv;
