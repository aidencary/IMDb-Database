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
    MiddleName  VARCHAR2(20) DEFAULT NULL,
    LastName    VARCHAR2(20) DEFAULT NULL,
    PlaceOfBirth VARCHAR2(40),
    Height      NUMBER(4, 1), -- Adjusted precision to accommodate larger values
    Spouse      VARCHAR2(20), -- First name only of spouse
    Bdate       DATE,
    Biography   VARCHAR2(1000),
    DateOfBirth DATE,
    DateOfDeath DATE DEFAULT NULL
);

-- Director_Awards table

CREATE TABLE Director_Awards(
    URLID   CHAR(9) CONSTRAINT Director_Awards_URLID_FK REFERENCES Director(URLID),
    Award VARCHAR2(100),
    CONSTRAINT Director_Awards_PK PRIMARY KEY (URLID, Award)
);

-- Director_Children table

CREATE TABLE Director_Children(
    URLID   CHAR(9) CONSTRAINT Director_Children_URLID_FK REFERENCES Director(URLID),
    Child VARCHAR2(100),
    CONSTRAINT Director_Children_PK PRIMARY KEY (URLID, Child)
);

-- Director_Parents table

CREATE TABLE Director_Parents(
    URLID   CHAR(9) CONSTRAINT Director_Parents_URLID_FK REFERENCES Director(URLID),
    Parent VARCHAR2(100),
    CONSTRAINT Director_Parents_PK PRIMARY KEY (URLID, Parent)
);

-- Director_Media table

CREATE TABLE Director_Media(
    URLID   CHAR(9) CONSTRAINT Director_Media_URLID_FK REFERENCES Director(URLID),
    Media VARCHAR2(100),
    CONSTRAINT Director_Media_PK PRIMARY KEY (URLID, Media)
);

-- Director_Movie junction table

CREATE TABLE Director_Movie(
    DirectorID CHAR(9),
    MovieID    CHAR(9),
    CONSTRAINT Director_Movie_PK PRIMARY KEY (DirectorID, MovieID)
);

-- Streaming table

CREATE TABLE Streaming(
    StreamingID NUMBER(2) CONSTRAINT Streaming_PK PRIMARY KEY,
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

CREATE TABLE Award(
    AwardID NUMBER(2) CONSTRAINT Award_PK PRIMARY KEY,
    Name    VARCHAR2(20)
    -- 1 = Oscar
    -- 2 = Golden Globe
    -- 3 = BAFTA
    -- 4 = Emmy
    -- 5 = Grammy
    -- 6 = Tony
    -- 7 = Cannes
    -- 8 = Berlin
    -- 9 = Venice
    -- 10 = Sundance
);

CREATE TABLE Children(
    ChildID CHAR(9) CONSTRAINT Child_PK PRIMARY KEY,
    Name   VARCHAR2(20)
);

CREATE TABLE Parents(
    ParentID CHAR(9) CONSTRAINT Parent_PK PRIMARY KEY,
    Name   VARCHAR2(20)
);

CREATE TABLE Media(
    MediaID CHAR(9) CONSTRAINT Media_PK PRIMARY KEY,
    Name   VARCHAR2(20)
);

-------------------------------------------
-- Inserts for Movie


INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('Inception', 9, TO_DATE('2010-07-16', 'YYYY-MM-DD'), 148.0, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.', 'PG-13', 'M00000001');

INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('The Matrix', 9, TO_DATE('1999-03-31', 'YYYY-MM-DD'), 136.0, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 'R', 'M00000002');

INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID)
VALUES ('The Godfather', 9, TO_DATE('1972-03-24', 'YYYY-MM-DD'), 175.0, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 'R', 'M00000003');

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

-- Inserts for Director

INSERT INTO Director (URLID, FirstName, MiddleName, LastName, PlaceOfBirth, Height, Spouse, Bdate, Biography, DateOfBirth, DateOfDeath)
VALUES ('D00000001', 'Christopher', 'Nolan', 'Nolan', 'London', 182.0, 'Emma', TO_DATE('1970-07-30', 'YYYY-MM-DD'), 'Christopher Nolan is a British-American film director, producer, and screenwriter. He is known for his distinctive visual style and complex storytelling.', TO_DATE('1970-07-30', 'YYYY-MM-DD'), NULL);

INSERT INTO Director (URLID, FirstName, MiddleName, LastName, PlaceOfBirth, Height, Spouse, Bdate, Biography, DateOfBirth, DateOfDeath)
VALUES ('D00000002', 'Steven', 'Allan', 'Spielberg', 'Cincinnati', 172.0, 'Kate', TO_DATE('1946-12-18', 'YYYY-MM-DD'), 'Steven Spielberg is an American film director, producer, and screenwriter. He is considered one of the founding pioneers of the New Hollywood era and one of the most popular directors and producers in film history.', TO_DATE('1946-12-18', 'YYYY-MM-DD'), NULL);

INSERT INTO Director (URLID, FirstName, MiddleName, LastName, PlaceOfBirth, Height, Spouse, Bdate, Biography, DateOfBirth, DateOfDeath)
VALUES ('D00000003', 'Martin', 'Charles', 'Scorsese', 'New York', 163.0, 'Helen', TO_DATE('1942-11-17', 'YYYY-MM-DD'), 'Martin Scorsese is an American film director, producer, screenwriter, and actor. He is widely regarded as one of the most significant and influential directors in film history.', TO_DATE('1942-11-17', 'YYYY-MM-DD'), NULL);

-- Insert into Director_Children table
INSERT INTO Director_Children (URLID, Child)
VALUES ('D00000001', 'Magnus Nolan');

INSERT INTO Director_Children (URLID, Child)
VALUES ('D00000002', 'Sasha Spielberg');

INSERT INTO Director_Children (URLID, Child)
VALUES ('D00000003', 'Francesca Scorsese');

-- Insert into Director_Parents table
INSERT INTO Director_Parents (URLID, Parent)
VALUES ('D00000001', 'Brendan Nolan');

INSERT INTO Director_Parents (URLID, Parent)
VALUES ('D00000002', 'Leah Adler');

INSERT INTO Director_Parents (URLID, Parent)
VALUES ('D00000003', 'Catherine Scorsese');

-- Insert into Director_Media table
INSERT INTO Director_Media (URLID, Media)
VALUES ('D00000001', 'Inception Interview');

INSERT INTO Director_Media (URLID, Media)
VALUES ('D00000002', 'Jaws Documentary');

INSERT INTO Director_Media (URLID, Media)
VALUES ('D00000003', 'Goodfellas Behind the Scenes');

----------------------------------------------------------------------

-- Director Foreign Keys

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

-- Director and Movie M:N Relationship

-- Foreign Key Director_Movie DirectorID that points to the URLID of the Director table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_director_fk FOREIGN KEY(DirectorID)
REFERENCES Director(URLID);

-- Foreign Key Director_Movie MovieID that points to the URLID of the Movie table
ALTER TABLE Director_Movie
ADD CONSTRAINT director_movie_movie_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Movie Foreign Keys

-- Foreign Key Movie GenreID that points to the GenreID of the Movie_Genre table
ALTER TABLE Movie_Genre
ADD CONSTRAINT movie_genre_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Movie GenreID that points to the GenreID of the Genre table
ALTER TABLE Movie_Genre
ADD CONSTRAINT genre_fk FOREIGN KEY(GenreID)
REFERENCES Genre(GenreID);

-- Foreign Key Movie StreamingID that points to the StreamingID of the Movie_Streaming table
ALTER TABLE Movie_Streaming
ADD CONSTRAINT movie_streaming_fk FOREIGN KEY(MovieID)
REFERENCES Movie(URLID);

-- Foreign Key Movie StreamingID that points to the StreamingID of the Streaming table
ALTER TABLE Movie_Streaming
ADD CONSTRAINT streaming_fk FOREIGN KEY(StreamingID)
REFERENCES Streaming(StreamingID);

-- Derived Attributes

-- View to calculate the Age derived attribute for each director
CREATE VIEW Director_With_Age AS
SELECT 
    D.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, D.DateOfBirth) / 12) AS Age
FROM 
    Director D;
