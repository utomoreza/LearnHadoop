-- Find movies with highest average rating --
-- only consider movies with > 20 ratings --

CREATE VIEW moviesRating AS
SELECT movieid, AVG(rating) AS avgRating, COUNT(rating) AS numRating
FROM ratings
GROUP BY movieid;

SELECT n.title AS 'Movie Title', mr.avgRating AS 'Average Rating'
FROM names AS n JOIN moviesRating AS mr
ON n.movieid = mr.movieid
WHERE mr.numRating > 20
ORDER BY mr.avgRating DESC
LIMIT 10;