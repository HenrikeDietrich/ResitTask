ALTER TABLE movies ADD lexemestitle tsvector; 
UPDATE movies SET lexemestitle = to_tsvector(title);
SELECT url FROM movies WHERE lexemestitle @@ to_tsquery('death');
ALTER TABLE movies ADD rank float4; 
UPDATE movies SET rank = ts_rank(lexemestitle,plainto_tsquery(( SELECT title FROM movies WHERE url='a-band-called-death'))); 
CREATE TABLE recommendationsBasedOntitleField12 AS SELECT url, rank FROM movies WHERE rank -1 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOntitleField9) to '/home/pi/RSL/top50recommendations5.csv' WITH csv;
