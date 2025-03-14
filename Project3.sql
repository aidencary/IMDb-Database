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
    AgeRating   VARCHAR2(2),
    URLID       CHAR(9) CONSTRAINT Movie_URLID_PK PRIMARY KEY,
    GenreID     NUMBER(2),
    StreamingID NUMBER(2)
);

-- Movie_Genre table

CREATE TABLE Movie_Genre(
    GenreID     NUMBER(2) CONSTRAINT Genre_GenreID_PK PRIMARY KEY,
    GenreName   VARCHAR2(40)
);

-- Movie_Streaming table

CREATE TABLE Movie_Streaming(
    StreamingID   NUMBER(2) CONSTRAINT Streaming_StreamingID_PK PRIMARY KEY,
    StreamingName VARCHAR2(40)
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
    AwardID   NUMBER(2) CONSTRAINT Award_AwardID_PK PRIMARY KEY,
    URLID     CHAR(9),
    AwardName VARCHAR2(100),
    Year      NUMBER(4)
);

-- Director_Children table

CREATE TABLE Director_Children(
    ChildID   NUMBER(2) CONSTRAINT Child_ChildID_PK PRIMARY KEY,
    URLID     CHAR(9),
    ChildName VARCHAR2(100)
);

-- Director_Parents table

CREATE TABLE Director_Parents(
    ParentID   NUMBER(2) CONSTRAINT Parent_ParentID_PK PRIMARY KEY,
    URLID      CHAR(9),
    ParentName VARCHAR2(100)
);

-- Director_Media table

CREATE TABLE Director_Media(
    MediaID   NUMBER(2) CONSTRAINT Media_MediaID_PK PRIMARY KEY,
    URLID     CHAR(9),
    MediaType VARCHAR2(50),
    MediaURL  VARCHAR2(200)
);

-- Director_Movie junction table

CREATE TABLE Director_Movie(
    DirectorID CHAR(9),
    MovieID    CHAR(9),
    CONSTRAINT Director_Movie_PK PRIMARY KEY (DirectorID, MovieID)
);

-------------------------------------------

-- Foreign Key Movie GenreID that points to the GenreID of the Movie_Genre table
ALTER TABLE Movie
ADD CONSTRAINT movie_genre_fk FOREIGN KEY(GenreID)
REFERENCES Movie_Genre(GenreID);

-- Foreign Key Movie StreamingID that points to the StreamingID of the Movie_Streaming table
ALTER TABLE Movie
ADD CONSTRAINT movie_streaming_fk FOREIGN KEY(StreamingID)
REFERENCES Movie_Streaming(StreamingID);

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

-- View to calculate the Age derived attribute for each director
CREATE VIEW Director_With_Age AS
SELECT 
    D.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, D.DateOfBirth) / 12) AS Age
FROM 
    Director D;

-------------------------------------------------------------

-- Movie inserts

INSERT INTO Movie (Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID, GenreID, StreamingID)
VALUES 
('Inception', 9, TO_DATE('2010-07-16', 'YYYY-MM-DD'), 148, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 'PG-13', 'MOV000001', 1, 1),
('The Matrix', 8, TO_DATE('1999-03-31', 'YYYY-MM-DD'), 136, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 'R', 'MOV000002', 2, 2),
('Interstellar', 9, TO_DATE('2014-11-07', 'YYYY-MM-DD'), 169, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 'PG-13', 'MOV000003', 1, 3);

-- Director inserts

INSERT INTO Director (URLID, FirstName, MiddleName, LastName, PlaceOfBirth, Height, Spouse, Bdate, Biography, DateOfBirth, DateOfDeath)
VALUES 
('DIR000001', 'Christopher', 'Edward', 'Nolan', 'London, England', 182.9, 'Emma', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 'Christopher Nolan is a British-American film director, producer, and screenwriter.', TO_DATE('1970-07-30', 'YYYY-MM-DD'), NULL),
('DIR000002', 'Lana', '', 'Wachowski', 'Chicago, Illinois', 179.8, 'Karin', TO_DATE('1991-01-01', 'YYYY-MM-DD'), 'Lana Wachowski is an American film director, screenwriter, and producer.', TO_DATE('1965-06-21', 'YYYY-MM-DD'), NULL),
('DIR000003', 'Steven', 'Allan', 'Spielberg', 'Cincinnati, Ohio', 172.7, 'Kate', TO_DATE('1991-10-12', 'YYYY-MM-DD'), 'Steven Spielberg is an American film director, producer, and screenwriter.', TO_DATE('1946-12-18', 'YYYY-MM-DD'), NULL);
