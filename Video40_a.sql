SELECT m.title AS 'Title', AVG(r.rating) AS 'Average Rating', COUNT(r.rating) AS 'Num of Rating' FROM movies m INNER JOIN ratings r ON m.id = r.movie_id GROUP BY m.title ORDER BY 'Num of Rating';
