ratings = LOAD '/user/maria_dev/ml-100k/u.data' AS (userID:int, movieID:int, rating:int, ratingTime:int);

metadata = LOAD '/user/maria_dev/ml-100k/u.item' USING PigStorage('|') AS (movieID:int, movieTitle:chararray, releaseDate:chararray, videRelease:chararray, imdbLink:chararray);

nameLookup = FOREACH metadata GENERATE movieID, movieTitle, ToUnixTime(ToDate(releaseDate, 'dd-MMM-yyyy')) AS releaseTime;

ratingsByMovie = GROUP ratings BY movieID;

aggRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings.rating) AS avgRating, COUNT(ratings.rating) AS countRating;

badMovies = FILTER aggRatings BY avgRating < 2.0;

badMoviesWithData = JOIN badMovies BY movieID, nameLookup BY movieID;

worstMovies = RANK badMoviesWithData BY badMovies::countRating;

DUMP worstMovies;

--fiveStarMovies = FILTER avgRatings BY avgRating > 4.0;

--fiveStarWithData = JOIN fiveStarMovies BY movieID, nameLookup BY movieID;

--oldestFiveStarMovies = ORDER fiveStarWithData BY nameLookup::releaseTime;

--DUMP oldestFiveStarMovies;