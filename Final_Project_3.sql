-- IMDb Database
-- M:N relationships between Movie, TV Show <---> Actor, Writer, Director
-- Multi-value relationships between Movie, TV Show <---> Movie_Genre, TV_Show_Genre, Movie_Streaming, TV_Show_Streaming, and TV_Show_Episode
-- 1:M relationships between Movie, TV Show <---> Movie_Review, TV_Show_Review

-- Movie Drop Tables
DROP TABLE Movie CASCADE CONSTRAINTS;
DROP TABLE Movie_Genre CASCADE CONSTRAINTS;
DROP TABLE Movie_Streaming CASCADE CONSTRAINTS;
DROP TABLE Movie_Review CASCADE CONSTRAINTS;

-- TV Show Drop Tables
DROP TABLE TV_Show CASCADE CONSTRAINTS;
DROP TABLE TV_Show_Episode CASCADE CONSTRAINTS;
DROP TABLE TV_Show_Genre CASCADE CONSTRAINTS;
DROP TABLE TV_Show_Streaming CASCADE CONSTRAINTS;
DROP TABLE TV_Show_Review CASCADE CONSTRAINTS;

-- Actor Drop Tables
DROP TABLE Actor CASCADE CONSTRAINTS;
DROP TABLE Actor_Children CASCADE CONSTRAINTS;
DROP TABLE Actor_Parents CASCADE CONSTRAINTS;
DROP TABLE Actor_Media CASCADE CONSTRAINTS;
DROP TABLE Actor_Movie CASCADE CONSTRAINTS;
DROP TABLE Actor_TV_Show CASCADE CONSTRAINTS;

-- Writer Drop Tables
DROP TABLE Writer CASCADE CONSTRAINTS;
DROP TABLE Writer_Children CASCADE CONSTRAINTS;
DROP TABLE Writer_Parents CASCADE CONSTRAINTS;
DROP TABLE Writer_Media CASCADE CONSTRAINTS;
DROP TABLE Writer_Movie CASCADE CONSTRAINTS;
DROP TABLE Writer_TV_Show CASCADE CONSTRAINTS;

-- Director Drop Tables
DROP TABLE Director CASCADE CONSTRAINTS;
DROP TABLE Director_Children CASCADE CONSTRAINTS;
DROP TABLE Director_Parents CASCADE CONSTRAINTS;
DROP TABLE Director_Media CASCADE CONSTRAINTS;
DROP TABLE Director_Movie CASCADE CONSTRAINTS;
DROP TABLE Director_TV_Show CASCADE CONSTRAINTS;

-- Drop views for derived attributes
DROP VIEW Director_With_Age;
DROP VIEW Actor_With_Age;
DROP VIEW Writer_With_Age;
DROP VIEW Movie_Average_Rating;
DROP VIEW TV_Show_Average_Rating;

------------------------------------------------------------

-- Movie table

CREATE TABLE Movie(
    Title       VARCHAR2(40),
    ReleaseDate DATE,
    RunTime     NUMBER(5, 1),
    Description VARCHAR2(1000),
    AgeRating   VARCHAR2(5),
    URLID       CHAR(9) CONSTRAINT Movie_MovieID_PK PRIMARY KEY
);

-- Movie_Genre table

CREATE TABLE Movie_Genre(
    MovieID CHAR(9),
    Genre   VARCHAR2(20),
    CONSTRAINT Movie_Genre_PK PRIMARY KEY (MovieID, Genre)
);

-- Example query to retrieve movies and their genres
-- SELECT MovieID, Genre FROM Movie_Genre;

-- Movie_Streaming table

CREATE TABLE Movie_Streaming(
    MovieID   CHAR(9),
    Streaming VARCHAR2(20),
    CONSTRAINT Movie_Streaming_PK PRIMARY KEY (MovieID, Streaming)
);

-- Example query to retrieve movies and their streaming platforms
-- SELECT MovieID, Streaming FROM Movie_Streaming;

-- Movie_Review table

CREATE TABLE Movie_Review (
    MovieID    CHAR(9),
    Title       VARCHAR2(40),
    Reviewer       VARCHAR2(100),
    ReviewContents VARCHAR2(1000),
    Rating     NUMBER(2) CHECK (Rating BETWEEN 0 AND 10), -- Does not allow a rating lower than 0 or higher than 10 to be inserted.
    CONSTRAINT Movie_Review_PK PRIMARY KEY (MovieID, Reviewer)
);

-- TV_Show Table

CREATE TABLE TV_Show(
    Title       VARCHAR2(40),
    ReleaseDate DATE,
    Description VARCHAR2(1000),
    AgeRating   VARCHAR2(5),
    URLID       CHAR(9) CONSTRAINT TV_Show_TV_ShowID_PK PRIMARY KEY
);

-- TV_Show_Episode table

CREATE TABLE TV_Show_Episode(
    TV_ShowID     CHAR(9),
    EpisodeNumber NUMBER(5), -- No show has more than 99,999 episodes. The Price is Right has over 10,000 episodes.
    SeasonNumber  NUMBER(2), -- No show has more than 99 seasons. The Simpsons has over 30 seasons.
    CONSTRAINT TV_Show_Episode_PK PRIMARY KEY (TV_ShowID, EpisodeNumber, SeasonNumber)
);

-- Genre table for TV_Show

CREATE TABLE TV_Show_Genre(
    TV_ShowID CHAR(9),
    Genre     VARCHAR2(20),
    CONSTRAINT TV_Show_Genre_PK PRIMARY KEY (TV_ShowID, Genre)
);

-- Streaming table for TV_Show

CREATE TABLE TV_Show_Streaming(
    TV_ShowID  CHAR(9),
    Streaming  VARCHAR2(20),
    CONSTRAINT TV_Show_Streaming_PK PRIMARY KEY (TV_ShowID, Streaming)
);

CREATE TABLE TV_Show_Review (
    TV_ShowID    CHAR(9),
    Title       VARCHAR2(40),
    Reviewer       VARCHAR2(100),
    ReviewContents VARCHAR2(1000),
    Rating     NUMBER(2) CHECK (Rating BETWEEN 0 AND 10), -- Does not allow a rating lower than 0 or higher than 10 to be inserted.
    CONSTRAINT TV_Show_Review_PK PRIMARY KEY (TV_ShowID, Reviewer)
);

-- Director table

CREATE TABLE Director(
    URLID       CHAR(9) CONSTRAINT Director_DirectorID_PK PRIMARY KEY,
    FirstName   VARCHAR2(20),
    MiddleName  VARCHAR2(20) DEFAULT NULL,
    LastName    VARCHAR2(20) DEFAULT NULL,
    PlaceOfBirth VARCHAR2(40),
    Height      NUMBER(1, 2),
    Spouse      VARCHAR2(20),
    Award       VARCHAR2(20),
    Bdate       DATE,
    Biography   VARCHAR2(1000),
    DateOfBirth DATE,
    DateOfDeath DATE DEFAULT NULL
);

-- Director_Children table

CREATE TABLE Director_Children(
    DirectorID CHAR(9),
    Child      VARCHAR2(100),
    CONSTRAINT Director_Children_PK PRIMARY KEY (DirectorID, Child)
);

-- Example query to retrieve directors and their children
-- SELECT D.FirstName, D.LastName, DC.Child
-- FROM Director D
-- JOIN Director_Children DC ON D.DirectorID = DC.DirectorID;

-- Director_Parents table

CREATE TABLE Director_Parents(
    DirectorID CHAR(9),
    Parent     VARCHAR2(100),
    CONSTRAINT Director_Parents_PK PRIMARY KEY (DirectorID, Parent)
);

-- Example query to retrieve directors and their parents
-- SELECT D.FirstName, D.LastName, DP.Parent
-- FROM Director D
-- JOIN Director_Parents DP ON D.DirectorID = DP.DirectorID;

-- Director_Media table

CREATE TABLE Director_Media(
    DirectorID CHAR(9),
    Media      VARCHAR2(100),
    CONSTRAINT Director_Media_PK PRIMARY KEY (DirectorID, Media)
);

-- Example query to retrieve directors and their media appearances
-- SELECT D.FirstName, D.LastName, DM.Media
-- FROM Director D
-- JOIN Director_Media DM ON D.DirectorID = DM.DirectorID;

-- Director_Movie junction table

CREATE TABLE Director_Movie(
    DirectorID CHAR(9),
    MovieID    CHAR(9),
    CONSTRAINT Director_Movie_PK PRIMARY KEY (DirectorID, MovieID)
);

-- Example query to retrieve directors and their movies
-- SELECT DirectorID, MovieID FROM Director_Movie;

-- Director_TV_Show junction table

CREATE TABLE Director_TV_Show(
    DirectorID CHAR(9),
    TV_ShowID  CHAR(9),
    CONSTRAINT Director_TV_Show_PK PRIMARY KEY (DirectorID, TV_ShowID)
);

-- Example query to retrieve directors and their TV shows
-- SELECT DirectorID, TV_ShowID FROM Director_TV_Show;

-- Actor table

CREATE TABLE Actor(
    URLID       CHAR(9) CONSTRAINT Actor_ActorID_PK PRIMARY KEY,
    FirstName   VARCHAR2(20),
    MiddleName  VARCHAR2(20) DEFAULT NULL,
    LastName    VARCHAR2(20) DEFAULT NULL,
    PlaceOfBirth VARCHAR2(40),
    Height      NUMBER(1, 2),
    Spouse      VARCHAR2(20),
    Award       VARCHAR2(20),
    Bdate       DATE,
    Biography   VARCHAR2(1000),
    DateOfBirth DATE,
    DateOfDeath DATE DEFAULT NULL
);

-- Actor_Children table

CREATE TABLE Actor_Children(
    ActorID CHAR(9),
    Child   VARCHAR2(100),
    CONSTRAINT Actor_Children_PK PRIMARY KEY (ActorID, Child)
);

-- Example query to retrieve actors and their children
-- SELECT ActorID, Child FROM Actor_Children;

-- Actor_Parents table

CREATE TABLE Actor_Parents(
    ActorID CHAR(9),
    Parent  VARCHAR2(100),
    CONSTRAINT Actor_Parents_PK PRIMARY KEY (ActorID, Parent)
);

-- Example query to retrieve actors and their parents
-- SELECT ActorID, Parent FROM Actor_Parents;

-- Actor_Media table

CREATE TABLE Actor_Media(
    ActorID CHAR(9),
    Media   VARCHAR2(100),
    CONSTRAINT Actor_Media_PK PRIMARY KEY (ActorID, Media)
);

-- Example query to retrieve actors and their media appearances
-- SELECT ActorID, Media FROM Actor_Media;

-- Actor_Movie junction table

CREATE TABLE Actor_Movie(
    ActorID CHAR(9),
    MovieID CHAR(9),
    CONSTRAINT Actor_Movie_PK PRIMARY KEY (ActorID, MovieID)
);

-- Example query to retrieve actors and their movies
-- SELECT ActorID, MovieID FROM Actor_Movie;

-- Actor_TV_Show junction table

CREATE TABLE Actor_TV_Show(
    ActorID   CHAR(9),
    TV_ShowID CHAR(9),
    CONSTRAINT Actor_TV_Show_PK PRIMARY KEY (ActorID, TV_ShowID)
);

-- Example query to retrieve actors and their TV shows
-- SELECT ActorID, TV_ShowID FROM Actor_TV_Show;

-- Writer table

CREATE TABLE Writer(
    URLID       CHAR(9) CONSTRAINT Writer_WriterID_PK PRIMARY KEY,
    FirstName   VARCHAR2(20),
    MiddleName  VARCHAR2(20) DEFAULT NULL,
    LastName    VARCHAR2(20) DEFAULT NULL,
    PlaceOfBirth VARCHAR2(40),
    Height      NUMBER(1, 2),
    Spouse      VARCHAR2(20),
    Award       VARCHAR2(20),
    Bdate       DATE,
    Biography   VARCHAR2(1000),
    DateOfBirth DATE,
    DateOfDeath DATE DEFAULT NULL
);

-- Writer_Children table

CREATE TABLE Writer_Children(
    WriterID CHAR(9),
    Child    VARCHAR2(100),
    CONSTRAINT Writer_Children_PK PRIMARY KEY (WriterID, Child)
);

-- Example query to retrieve writers and their children
-- SELECT WriterID, Child FROM Writer_Children;

-- Writer_Parents table

CREATE TABLE Writer_Parents(
    WriterID CHAR(9),
    Parent   VARCHAR2(100),
    CONSTRAINT Writer_Parents_PK PRIMARY KEY (WriterID, Parent)
);

-- Example query to retrieve writers and their parents
-- SELECT WriterID, Parent FROM Writer_Parents;

-- Writer_Media table

CREATE TABLE Writer_Media(
    WriterID CHAR(9),
    Media    VARCHAR2(100),
    CONSTRAINT Writer_Media_PK PRIMARY KEY (WriterID, Media)
);

-- Example query to retrieve writers and their media appearances
-- SELECT WriterID, Media FROM Writer_Media;

-- Writer_Movie junction table

CREATE TABLE Writer_Movie(
    WriterID CHAR(9),
    MovieID  CHAR(9),
    CONSTRAINT Writer_Movie_PK PRIMARY KEY (WriterID, MovieID)
);

-- Example query to retrieve writers and their movies
-- SELECT WriterID, MovieID FROM Writer_Movie;

-- Writer_TV_Show junction table

CREATE TABLE Writer_TV_Show(
    WriterID  CHAR(9),
    TV_ShowID CHAR(9),
    CONSTRAINT Writer_TV_Show_PK PRIMARY KEY (WriterID, TV_ShowID)
);

-- Example query to retrieve writers and their TV shows
-- SELECT WriterID, TV_ShowID FROM Writer_TV_Show;

----------------------------------------------------------------------

-- Director Foreign Keys

-- Foreign Key Director_Children DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Children
ADD CONSTRAINT director_children_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Parents DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Parents
ADD CONSTRAINT director_parents_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Media DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Media
ADD CONSTRAINT director_media_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Movie DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_director_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Movie MovieID that points to the URLID of the Movie table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_movie_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key for Director_TV_Show: DirectorID references Director(URLID)
ALTER TABLE Director_TV_Show
ADD CONSTRAINT director_tv_show_director_fk FOREIGN KEY (DirectorID)
REFERENCES Director(URLID);

-- Foreign Key for Director_TV_Show: TV_ShowID references TV_Show(URLID)
ALTER TABLE Director_TV_Show
ADD CONSTRAINT director_tv_show_tv_show_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID);

-- Actor Foreign Keys

-- Foreign Key Actor_Children ActorID that points to the URLID of the Actor table
ALTER TABLE Actor_Children
ADD CONSTRAINT actor_children_fk FOREIGN KEY (ActorID)
REFERENCES Actor(URLID);

-- Foreign Key Actor_Parents ActorID that points to the URLID of the Actor table
ALTER TABLE Actor_Parents
ADD CONSTRAINT actor_parents_fk FOREIGN KEY (ActorID)
REFERENCES Actor(URLID);

-- Foreign Key Actor_Media ActorID that points to the URLID of the Actor table
ALTER TABLE Actor_Media
ADD CONSTRAINT actor_media_fk FOREIGN KEY (ActorID)
REFERENCES Actor(URLID);

-- Foreign Key Actor_Movie ActorID that points to the URLID of the Actor table
ALTER TABLE Actor_Movie
ADD CONSTRAINT actor_movie_actor_fk FOREIGN KEY (ActorID)
REFERENCES Actor(URLID);

-- Foreign Key Actor_Movie MovieID that points to the URLID of the Movie table
ALTER TABLE Actor_Movie
ADD CONSTRAINT actor_movie_movie_fk FOREIGN KEY (MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Actor_TV_Show ActorID that points to the URLID of the Actor table
ALTER TABLE Actor_TV_Show
ADD CONSTRAINT actor_tv_show_actor_fk FOREIGN KEY (ActorID)
REFERENCES Actor(URLID);

-- Foreign Key Actor_TV_Show TV_ShowID that points to the URLID of the TV_Show table
ALTER TABLE Actor_TV_Show
ADD CONSTRAINT actor_tv_show_tv_show_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID);

-- Writer Foreign Keys

-- Foreign Key Writer_Children WriterID that points to the URLID of the Writer table
ALTER TABLE Writer_Children
ADD CONSTRAINT writer_children_fk FOREIGN KEY (WriterID)
REFERENCES Writer(URLID);

-- Foreign Key Writer_Parents WriterID that points to the URLID of the Writer table
ALTER TABLE Writer_Parents
ADD CONSTRAINT writer_parents_fk FOREIGN KEY (WriterID)
REFERENCES Writer(URLID);

-- Foreign Key Writer_Media WriterID that points to the URLID of the Writer table
ALTER TABLE Writer_Media
ADD CONSTRAINT writer_media_fk FOREIGN KEY (WriterID)
REFERENCES Writer(URLID);

-- Foreign Key Writer_Movie WriterID that points to the URLID of the Writer table
ALTER TABLE Writer_Movie
ADD CONSTRAINT writer_movie_writer_fk FOREIGN KEY (WriterID)
REFERENCES Writer(URLID);

-- Foreign Key Writer_Movie MovieID that points to the URLID of the Movie table
ALTER TABLE Writer_Movie
ADD CONSTRAINT writer_movie_movie_fk FOREIGN KEY (MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Writer_TV_Show WriterID that points to the URLID of the Writer table
ALTER TABLE Writer_TV_Show
ADD CONSTRAINT writer_tv_show_writer_fk FOREIGN KEY (WriterID)
REFERENCES Writer(URLID);

-- Foreign Key Writer_TV_Show TV_ShowID that points to the URLID of the TV_Show table
ALTER TABLE Writer_TV_Show
ADD CONSTRAINT writer_tv_show_tv_show_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID);

-- Movie Foreign Keys

-- Foreign Key Movie GenreID that points to the GenreID of the Movie_Genre table
ALTER TABLE Movie_Genre
ADD CONSTRAINT movie_genre_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Movie StreamingID that points to the StreamingID of the Movie_Streaming table
ALTER TABLE Movie_Streaming
ADD CONSTRAINT movie_streaming_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Movie_Review MovieID that points to the URLID of the Movie table
ALTER TABLE Movie_Review
ADD CONSTRAINT movie_review_fk FOREIGN KEY (MovieID)
REFERENCES Movie(URLID) ON DELETE CASCADE; -- ON DELETE CASCADE ensures that if a movie is deleted, all its reviews are also deleted.

-- TV Show Foreign Keys

-- Foreign Key TV_Show_Genre TV_ShowID that points to the URLID of the TV_Show table
ALTER TABLE TV_Show_Genre
ADD CONSTRAINT tv_show_genre_tv_show_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID);

-- Foreign Key TV_Show_Streaming TV_ShowID that points to the URLID of the TV_Show table
ALTER TABLE TV_Show_Streaming
ADD CONSTRAINT tv_show_streaming_tv_show_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID);

-- Foreign Key TV_Show_Review TV_ShowID that points to the URLID of the TV_Show table
ALTER TABLE TV_Show_Review
ADD CONSTRAINT tv_show_review_fk FOREIGN KEY (TV_ShowID)
REFERENCES TV_Show(URLID) ON DELETE CASCADE; -- ON DELETE CASCADE ensures that if a TV show is deleted, all its reviews are also deleted.

-- Derived Attributes/Functions

-- Example query to calculate the age of a director
-- SELECT URLID, Age FROM Director_With_Age;

-- View to calculate the Age derived attribute for each director
CREATE VIEW Director_With_Age AS
SELECT 
    D.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, D.DateOfBirth) / 12) AS Age
FROM 
    Director D;

-- Example query to calculate the age of an actor
-- SELECT URLID, Age FROM Actor_With_Age;

-- View to calculate the Age derived attribute for each actor
CREATE VIEW Actor_With_Age AS
SELECT 
    A.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, A.DateOfBirth) / 12) AS Age
FROM 
    Actor A;

-- Example query to calculate the age of a writer
-- SELECT URLID, Age FROM Writer_With_Age;

-- View to calculate the Age derived attribute for each writer
CREATE VIEW Writer_With_Age AS
SELECT 
    W.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, W.DateOfBirth) / 12) AS Age
FROM 
    Writer W;

-- View to calculate the average review rating for Movies
CREATE VIEW Movie_Average_Rating AS
SELECT 
    M.URLID AS MovieID,
    M.Title,
    NVL(AVG(R.Rating), 0) AS AverageRating -- Use NVL to handle cases where no reviews exist. Instead of NULL, we use 0.
FROM 
    Movie M
LEFT JOIN 
    Movie_Review R ON M.URLID = R.MovieID
GROUP BY 
    M.URLID, M.Title;

-- Example query to calculate the average review rating for Movies
-- SELECT MovieID, AverageRating FROM Movie_Average_Rating;

-- View to calculate the average review rating for TV shows
CREATE VIEW TV_Show_Average_Rating AS
SELECT 
    T.URLID AS TV_ShowID,
    T.Title,
    NVL(AVG(R.Rating), 0) AS AverageRating -- Use NVL to handle cases where no reviews exist. Instead of NULL, we use 0.
FROM 
    TV_Show T
LEFT JOIN 
    TV_Show_Review R ON T.URLID = R.TV_ShowID
GROUP BY 
    T.URLID, T.Title;

-- Example query to calculate the average review rating for TV Shows
-- SELECT TV_ShowID, AverageRating FROM TV_Show_Average_Rating;