-- List the films where the yr is 1962 [Show id, title]
SELECT
  id,
  title
FROM
  movie
WHERE
  yr = 1962;

--  Give year of 'Citizen Kane'.
SELECT
  yr
FROM
  movie
WHERE
  title = 'Citizen Kane';

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT
  id,
  title,
  yr
FROM
  movie
WHERE
  title LIKE 'Star Trek%'
ORDER BY
  yr;

-- What id number does the actor 'Glenn Close' have?
SELECT
  id
FROM
  actor
WHERE
  name = 'Glenn Close';

-- What is the id of the film 'Casablanca'
SELECT
  id
FROM
  movie
WHERE
  title = 'Casablanca';

-- Obtain the cast list for 'Casablanca'.
SELECT
  name
FROM
  casting
  JOIN actor ON (actorid = id)
WHERE
  movieid = 11768;

-- Obtain the cast list for the film 'Alien'
SELECT
  name
FROM
  casting
  JOIN actor ON (actorid = id)
  JOIN movie ON (movieid = movie.id)
WHERE
  title = 'alien';

-- List the films in which 'Harrison Ford' has appeared
SELECT
  title
FROM
  casting
  JOIN actor ON (actorid = id)
  JOIN movie ON (movieid = movie.id)
WHERE
  name = 'Harrison Ford';

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT
  title
FROM
  casting
  JOIN actor ON (actorid = id)
  JOIN movie ON (movieid = movie.id)
WHERE
  name = 'Harrison Ford'
  AND ord <> 1;

-- List the films together with the leading star for all 1962 films.
SELECT
  title,
  name
FROM
  casting
  JOIN actor ON (actorid = id)
  JOIN movie ON (movieid = movie.id)
WHERE
  yr = 1962
  AND ord = 1;

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT
  yr,
  COUNT(title)
FROM
  movie
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
WHERE
  name = 'Rock Hudson'
GROUP BY
  yr
HAVING
  COUNT(title) > 2;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT
  title,
  name
FROM
  casting
  JOIN actor ON (actorid = id)
  JOIN movie ON (movieid = movie.id)
where
  ord = 1
  AND movieid IN (
    10016,
    12354,
    12497,
    12766,
    13846,
    15145,
    15476,
    16870,
    17117,
    17445,
    17765,
    18270,
    20136,
    20136,
    20180,
    20181,
    20509,
    20627,
    21023,
    21154,
    21171,
    21483
  );

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT
  name
FROM
  casting
  JOIN actor ON (id = actorid)
WHERE
  ord = 1
GROUP BY
  name
HAVING
  SUM(ord) >= 30;

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT
  title,
  count(actorid)
FROM
  movie
  JOIN casting ON (id = movieid)
WHERE
  yr = 1978
GROUP BY
  title
ORDER BY
  count(actorid) DESC,
  title;

-- List all the people who have worked with 'Art Garfunkel'.
SELECT
  DISTINCT name
FROM
  casting
  JOIN actor ON (id = actorid)
WHERE
  actorid <> 1112
  AND movieid IN (10095, 11434, 13630);