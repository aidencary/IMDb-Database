# IMDb-Database

IMDb-Database for Database Systems with Prof Chen

## Project Overview

This project involves creating a relational database for storing information about movies, directors, genres, streaming platforms, and related entities. The database schema is designed to capture various attributes and relationships between these entities, including many-to-many relationships and derived attributes.

## Database Schema

The database schema consists of the following tables:

1. **Movie**
    - Stores information about movies.
    - Attributes: Title, Rating, ReleaseDate, RunTime, Description, AgeRating, URLID (Primary Key).

2. **Movie_Genre**
    - Junction table for the many-to-many relationship between movies and genres.
    - Attributes: MovieID (Foreign Key), GenreID (Foreign Key), Primary Key (MovieID, GenreID).

3. **Movie_Streaming**
    - Junction table for the many-to-many relationship between movies and streaming platforms.
    - Attributes: MovieID (Foreign Key), StreamingID (Foreign Key), Primary Key (MovieID, StreamingID).

4. **Director**
    - Stores information about directors.
    - Attributes: URLID (Primary Key), FirstName, MiddleName, LastName, PlaceOfBirth, Height, Spouse, Bdate, Biography, DateOfBirth, DateOfDeath.

5. **Director_Awards**
    - Stores information about awards won by directors.
    - Attributes: URLID (Foreign Key), Award, Primary Key (URLID, Award).

6. **Director_Children**
    - Stores information about directors' children.
    - Attributes: URLID (Foreign Key), Child, Primary Key (URLID, Child).

7. **Director_Parents**
    - Stores information about directors' parents.
    - Attributes: URLID (Foreign Key), Parent, Primary Key (URLID, Parent).

8. **Director_Media**
    - Stores information about media appearances of directors.
    - Attributes: URLID (Foreign Key), Media, Primary Key (URLID, Media).

9. **Director_Movie**
    - Junction table for the many-to-many relationship between directors and movies.
    - Attributes: DirectorID (Foreign Key), MovieID (Foreign Key), Primary Key (DirectorID, MovieID).

10. **Streaming**
    - Stores information about streaming platforms.
    - Attributes: StreamingID (Primary Key), Name.

11. **Genre**
    - Stores information about genres.
    - Attributes: GenreID (Primary Key), Name.

12. **Award**
    - Stores information about awards.
    - Attributes: AwardID (Primary Key), Name.

13. **Children**
    - Stores information about children.
    - Attributes: ChildID (Primary Key), Name.

14. **Parents**
    - Stores information about parents.
    - Attributes: ParentID (Primary Key), Name.

15. **Media**
    - Stores information about media.
    - Attributes: MediaID (Primary Key), Name.

## Foreign Keys and Constraints

The schema includes several foreign keys and constraints to enforce referential integrity and ensure data consistency. These include:

- Foreign keys in `Movie_Genre`, `Movie_Streaming`, `Director_Awards`, `Director_Children`, `Director_Parents`, `Director_Media`, and `Director_Movie` tables.
- Primary keys for each table to uniquely identify records.
- Constraints to enforce relationships between tables.

## Derived Attributes

The schema includes a derived attribute for calculating the age of directors using a view:

```sql
CREATE VIEW Director_With_Age AS
SELECT 
    D.*,
    FLOOR(MONTHS_BETWEEN(SYSDATE, D.DateOfBirth) / 12) AS Age
FROM 
    Director D;
