DROP TABLE Movie CASCADE CONSTRAINTS;
DROP TABLE Movie_Genre CASCADE CONSTRAINTS;
DROP TABLE Movie_Streaming CASCADE CONSTRAINTS;
DROP TABLE Director CASCADE CONSTRAINTS;
DROP TABLE Director_Awards CASCADE CONSTRAINTS;
DROP TABLE Director_Children CASCADE CONSTRAINTS;
DROP TABLE Director_Parents CASCADE CONSTRAINTS;
DROP TABLE Director_Media CASCADE CONSTRAINTS;
DROP TABLE Director_Movie CASCADE CONSTRAINTS;

-- Movie table

CREATE TABLE Movie(
    Title       VARCHAR2(40),
    Rating      NUMBER(2) DEFAULT 0, -- Rating is out of 10. Rating will eventually be changed to a derived attribute using the average of all user ratings from the MovieRatings entity
    ReleaseDate DATE,
    RunTime     NUMBER(5, 1),
    Description VARCHAR2(1000),
    AgeRating   VARCHAR2(5),
    URLID       CHAR(9) CONSTRAINT Movie_MovieID_PK PRIMARY KEY
);

-- Movie_Genre table

CREATE TABLE Movie_Genre(
    MovieID CHAR(9) CONSTRAINT Movie_Genre_MovieID_FK REFERENCES Movie(URLID),
    GenreID NUMBER CONSTRAINT Movie_Genre_GenreID_FK REFERENCES Genre(GenreID),
    CONSTRAINT Movie_Genre_PK PRIMARY KEY (MovieID, GenreID)
);

-- Movie_Streaming table

CREATE TABLE Movie_Streaming(
    MovieID     CHAR(9) CONSTRAINT Movie_Streaming_MovieID_FK REFERENCES Movie(URLID),
    StreamingID NUMBER CONSTRAINT Movie_Streaming_StreamingID_FK REFERENCES Streaming(StreamingID),
    CONSTRAINT Movie_Streaming_PK PRIMARY KEY (MovieID, StreamingID)
);

-- Director table

CREATE TABLE Director(
    URLID       CHAR(9) CONSTRAINT Director_DirectorID_PK PRIMARY KEY,
    FirstName   VARCHAR2(20),
    MiddleName  VARCHAR2(20),
    LastName    VARCHAR2(20),
    PlaceOfBirth VARCHAR2(40),
    Height      NUMBER(3, 1),
    Spouse      VARCHAR2(20), -- First name only of spouse
    Bdate       DATE,
    Biography   VARCHAR2(1000),
    DateOfBirth DATE,
    DateOfDeath DATE DEFAULT NULL
);

-- Director_Awards table

CREATE TABLE Director_Awards(
    URLID   NUMBER(2) CONSTRAINT Award_URLID_PK PRIMARY KEY,
    Award VARCHAR2(100)
);

-- Director_Children table

CREATE TABLE Director_Children(
    URLID   NUMBER(2) CONSTRAINT Child_URLID_PK PRIMARY KEY,
    Child VARCHAR2(100)
);

-- Director_Parents table

CREATE TABLE Director_Parents(
    URLID   NUMBER(2) CONSTRAINT Parent_URLID_PK PRIMARY KEY,
    Parent VARCHAR2(100)
);

-- Director_Media table

CREATE TABLE Director_Media(
    URLID   NUMBER(2) CONSTRAINT Media_URLID_PK PRIMARY KEY,
    Media VARCHAR2(100)
);

-- Director_Movie junction table

CREATE TABLE Director_Movie(
    DirectorID CHAR(9),
    MovieID    CHAR(9),
    CONSTRAINT Director_Movie_PK PRIMARY KEY (DirectorID, MovieID)
);

-- Streaming table

CREATE TABLE Streaming(
    StreamingID NUMBER CONSTRAINT Streaming_PK PRIMARY KEY,
    Name        VARCHAR2(50)
);

-- Genre table

CREATE TABLE Genre(
    GenreID NUMBER(2) CONSTRAINT Genre_PK PRIMARY KEY,
    Name    VARCHAR2(20)
    -- 1 = Sci-Fi
    -- 2 = Action
    -- 3 = Crime
    -- 4 = Drama
    -- 5 = Comedy
    -- 6 = Romance
    -- 7 = Horror
    -- 8 = Mystery
    -- 9 = Thriller
    -- 10 = Fantasy
    -- 11 = Adventure
);

-------------------------------------------
-- Inserts for Movie

-- Insert into Movie table
INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('Inception', 9, TO_DATE('2010-07-16', 'YYYY-MM-DD'), 148.0, 'Inception Description', 'PG-13', 'M00000001');

INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('The Matrix', 9, TO_DATE('1999-03-31', 'YYYY-MM-DD'), 136.0, 'The Matrix Description', 'R', 'M00000002');

INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('The Godfather', 9, TO_DATE('1972-03-24', 'YYYY-MM-DD'), 175.0, 'The Godfather Description', 'R', 'M00000003');

-- Insert into Movie_Genre table
INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000001', 1); -- Inception, Genre: Sci-Fi
INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000001', 2); -- Inception, Genre: Action

INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000002', 1); -- The Matrix, Genre: Sci-Fi
INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000002', 2); -- The Matrix, Genre: Action

INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000003', 3); -- The Godfather, Genre: Crime
INSERT INTO Movie_Genre (MovieID, GenreID)
VALUES ('M00000003', 4); -- The Godfather, Genre: Drama

-- Insert into Movie_Streaming table
INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000001', 1); -- Inception, Streaming: Netflix
INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000001', 2); -- Inception, Streaming: Amazon Prime

INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000002', 1); -- The Matrix, Streaming: Netflix
INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000002', 3); -- The Matrix, Streaming: Hulu

INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000003', 2); -- The Godfather, Streaming: Amazon Prime
INSERT INTO Movie_Streaming (MovieID, StreamingID)
VALUES ('M00000003', 3); -- The Godfather, Streaming: Hulu

----------------------------------------------------------------------

-- Foreign Key Director_Awards URLID that points to the URLID of the Director table
ALTER TABLE Director_Awards
ADD CONSTRAINT director_awards_fk FOREIGN KEY(URLID)
REFERENCES Director(URLID);

-- Foreign Key Director_Children URLID that points to the URLID of the Director table
ALTER TABLE Director_Children
ADD CONSTRAINT director_children_fk FOREIGN KEY(URLID)
REFERENCES Director(URLID);

-- Foreign Key Director_Parents URLID that points to the URLID of the Director table
ALTER TABLE Director_Parents
ADD CONSTRAINT director_parents_fk FOREIGN KEY(URLID)
REFERENCES Director(URLID);

-- Foreign Key Director_Media URLID that points to the URLID of the Director table
ALTER TABLE Director_Media
ADD CONSTRAINT director_media_fk FOREIGN KEY(URLID)
REFERENCES Director(URLID);

-- Foreign Key Director_Movie DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_director_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Movie MovieID that points to the URLID of the Movie table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_movie_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Movie GenreID that points to the GenreID of the Movie_Genre table
ALTER TABLE Movie_Genre
ADD CONSTRAINT movie_genre_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

ALTER TABLE Movie_Genre
ADD CONSTRAINT genre_fk FOREIGN KEY(GenreID)
REFERENCES Genre(GenreID);

-- Foreign Key Movie StreamingID that points to the StreamingID of the Movie_Streaming table
ALTER TABLE Movie_Streaming
ADD CONSTRAINT movie_streaming_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

ALTER TABLE Movie_Streaming
ADD CONSTRAINT streaming_fk FOREIGN KEY(StreamingID)
REFERENCES Streaming(StreamingID);

-- View to calculate the Age derived attribute for each director
CREATE VIEW Director_With_Age AS
SELECT 
    D.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, D.DateOfBirth) / 12) AS Age
FROM 
    Director D;

-------------------------------------------------------------