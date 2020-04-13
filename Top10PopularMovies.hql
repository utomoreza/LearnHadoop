-- Top 10 Popular Movies --

-- Drop any previous views
DROP VIEW movienames;
DROP VIEW movierating;

-- Create a new view from ratings tables
-- We're only interested in movieID, average of ratings, and number of ratings
CREATE VIEW movieRating AS
SELECT movieid, AVG(rating) AS avgRating, COUNT(rating) AS numRating
FROM ratings
GROUP BY movieid;

-- Show the results of top 10 popular movies (with rating > 4.5),
-- in terms of the number of ratings
SELECT n.title, mr.avgRating, mr.numRating
FROM names AS n JOIN movieRating AS mr
ON mn.movieid = mr.movieid
WHERE mr.avgRating > 4.5
ORDER BY mr.numRating DESC
LIMIT 10;