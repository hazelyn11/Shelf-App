CREATE DATABASE shelf_app;
GRANT ALL PRIVILEGES ON shelf_app.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE shelf_app;

CREATE TABLE book (
    ISBN VARCHAR(9) PRIMARY KEY NOT NULL,
    publisher TEXT,
    pub_date DATE,
    genre TEXT,
    title TEXT,
    avg_rating FLOAT
);

CREATE TABLE reader (
    username VARCHAR(20) PRIMARY KEY NOT NULL,
    bDate DATE,
    gender TEXT,
    first_name TEXT,
    last_name TEXT
);

CREATE TABLE author (
    username VARCHAR(20) PRIMARY KEY NOT NULL,
    bDate DATE,
    gender TEXT,
    first_name TEXT,
    last_name TEXT
);

CREATE TABLE bookstore (
    id INTEGER PRIMARY KEY NOT NULL,
    bookstore_location TEXT
);

CREATE TABLE events (
    id INTEGER PRIMARY KEY NOT NULL,
    event_time DATETIME,
    event_date DATE,
    event_description TEXT,
    bookstoreID INTEGER,
    authorUsername VARCHAR(20),
    CONSTRAINT fk_1 
        FOREIGN KEY (bookstoreID) REFERENCES bookstore (id),
    CONSTRAINT fk_2 
        FOREIGN KEY (authorUsername) REFERENCES author (username)
);

CREATE TABLE bookReader (
    readerUsername VARCHAR(20) NOT NULL,
    bookISBN VARCHAR(9) NOT NULL,
    review TEXT,
    rating INTEGER,
    end_date DATE,
    PRIMARY KEY (readerUsername, bookISBN),
    CONSTRAINT fk_3
        FOREIGN KEY (readerUsername) REFERENCES reader (username),
    CONSTRAINT fk_4
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE curBookReader (
    readerUsername VARCHAR(20),
    bookISBN VARCHAR(9),
    current_page INTEGER,
    PRIMARY KEY (readerUsername,bookISBN),
    CONSTRAINT fk_5 
        FOREIGN KEY (readerUsername) REFERENCES reader (username),
    CONSTRAINT fk_6
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE bookAuthor (
    authorUsername VARCHAR(20),
    bookISBN VARCHAR(9),
    commentary TEXT,
    PRIMARY KEY (authorUsername, bookISBN),
    CONSTRAINT fk_7 
        FOREIGN KEY (authorUsername) REFERENCES author (username),
    CONSTRAINT fk_8
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE bookstoreBooks (
    bookISBN VARCHAR(9),
    bookstoreID INTEGER,
    total_copies_in_stock INTEGER,
    PRIMARY KEY (bookISBN,bookstoreID),
    CONSTRAINT fk_9 
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN),
    CONSTRAINT fk_10 
        FOREIGN KEY (bookstoreID) REFERENCES bookstore (id)
);

CREATE TABLE shelf (
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT,
    date_created DATE,
    readerUsername VARCHAR(20),
    CONSTRAINT fk_11
        FOREIGN KEY (readerUsername) REFERENCES reader (username)
);

CREATE TABLE bookShelf (
    shelfID INTEGER,
    bookISBN VARCHAR(9),
    PRIMARY KEY (shelfID, bookISBN),
    CONSTRAINT fk_12 
        FOREIGN KEY (shelfID) REFERENCES shelf (id),
    CONSTRAINT fk_13
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE readerNote (
    readerUsername VARCHAR(20),
    bookISBN VARCHAR(9),
    note TEXT,
    PRIMARY KEY (readerUsername, bookISBN),
    CONSTRAINT fk_14
        FOREIGN KEY (readerUsername) REFERENCES reader (username),
    CONSTRAINT fk_15
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE bookRating (
    bookISBN VARCHAR(9),
    ratingID INTEGER UNIQUE,
    rating INTEGER,
    PRIMARY KEY (bookISBN, ratingID),
    CONSTRAINT fk_16
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

CREATE TABLE readerFriends (
    friend_one_username VARCHAR(20),
    friend_two_username VARCHAR(20),
    PRIMARY KEY (friend_one_username, friend_two_username),
    CONSTRAINT fk_17 
        FOREIGN KEY (friend_one_username) REFERENCES reader (username),
    CONSTRAINT fk_18
        FOREIGN KEY (friend_two_username) REFERENCES reader (username)
);

CREATE TABLE readingLog (
    id INTEGER PRIMARY KEY NOT NULL,
    readerUsername VARCHAR(20),
    CONSTRAINT fk_19 
        FOREIGN KEY (readerUsername) REFERENCES reader (username)
);

CREATE TABLE logEntry (
    entryID INTEGER,
    logID INTEGER,
    entry_date DATE,
    pages_read INTEGER,
    hours_read INTEGER,
    status_update TEXT,
    bookISBN VARCHAR(9),
    PRIMARY KEY (entryID, logID),
    CONSTRAINT fk_20 
        FOREIGN KEY (logID) REFERENCES readingLog (id),
    CONSTRAINT fk_21
        FOREIGN KEY (bookISBN) REFERENCES book (ISBN)
);

INSERT INTO reader
VALUES
('hazelyna11', '2003-04-20', 'female', 'Hazelyn', 'Aroian');

INSERT INTO reader
VALUES
('ehutnick', '2002-12-05', 'female', 'Ella', 'Hutnick');

INSERT INTO reader
VALUES
('eward99', '2002-12-04', 'female', 'Ellie', 'Ward');

INSERT INTO book
VALUES
('100000001', 'Faber & Faber', '2018-08-30', 'Fiction', 'Normal People', 5.0);

INSERT INTO book
VALUES
('100000002', 'Faber & Faber', '1994-09-24', 'Script', 'Arcadia', 5.0);

INSERT INTO book
VALUES
('100000003', 'Verso', '2022-05-03', 'Nonfiction/Manifesto', 'Internet for the People', 5.0);

INSERT INTO book
VALUES
('100000004', 'Verso', '2022-05-03', 'Nonfiction/Manifesto', 'Test', 5.0);

INSERT INTO readerFriends
VALUES
('hazelyna11', 'ehutnick');

INSERT INTO readerFriends
VALUES
('eward99', 'ehutnick');

INSERT INTO author
VALUES
('srooney', '1991-02-20', 'female', 'Sally', 'Rooney');

INSERT INTO author
VALUES
('btarnoff', '1990-01-01', 'male', 'Ben', 'Tarnoff');

INSERT INTO author
VALUES
('tstoppard', '1937-07-03', 'male', 'Tom', 'Stoppard');

INSERT INTO bookstore
VALUES
(01, 'Maynard, Massachusetts');

INSERT INTO bookstore
VALUES
(02, 'Boston, Massachusetts');

INSERT INTO bookstore
VALUES
(03, 'Woodstock, NY');

INSERT INTO events
VALUES
(001, '2022-12-12 12:00:00', '2022-12-12', 'Sally Rooney gives a talk on the television adaptation of Conversations with Friends', 01, 'srooney');

INSERT INTO events
VALUES
(002, '2022-11-23 12:00:00', '2022-11-23', 'Ben Tarnoff speaks about Internet policy', 03, 'btarnoff');

INSERT INTO bookReader
VALUES
('hazelyna11', '100000001', 'I wrote a paper on this book for a class this semester!', 5, '2022-08-31');

INSERT INTO bookReader
VALUES
('hazelyna11', '100000002', 'One of my favorites', 4, '2022-08-31');

INSERT INTO bookReader
VALUES
('hazelyna11', '100000003', 'Thought provoking', 4, '2022-08-31');

INSERT INTO bookReader
VALUES
('ehutnick', '100000002', 'Good book', 5, '2022-09-30');

INSERT INTO curBookReader
VALUES
('eward99', '100000001', 112);

INSERT INTO curBookReader
VALUES
('eward99', '100000003', 78);

INSERT INTO bookAuthor
VALUES
('srooney', '100000001', 'I wrote this!');

INSERT INTO bookAuthor
VALUES
('tstoppard', '100000002', 'I wrote this!');

INSERT INTO bookAuthor
VALUES
('btarnoff', '100000003', 'I wrote this!');

INSERT INTO bookstoreBooks
VALUES
('100000001', 01, 15);

INSERT INTO bookstoreBooks
VALUES
('100000001', 02, 6);

INSERT INTO bookstoreBooks
VALUES
('100000001', 03, 10);

INSERT INTO shelf
VALUES
(01, 'Hazelyns Favorites', '2022-11-21', 'hazelyna11');

INSERT INTO shelf
VALUES
(02, 'Fiction', '2022-11-21', 'eward99');

INSERT INTO bookShelf
VALUES
(01, '100000001');

INSERT INTO bookShelf
VALUES
(01, '100000002');

INSERT INTO bookShelf
VALUES
(02, '100000001');

INSERT INTO readerNote
VALUES
('hazelyna11', '100000001', 'one of my favorite books!');

INSERT INTO readerNote
VALUES
('hazelyna11', '100000002', 'would like to reread this one soon');

INSERT INTO bookRating
VALUES
('100000001', 01, 5);

INSERT INTO bookRating
VALUES
('100000001', 02, 5);

INSERT INTO bookRating
VALUES
('100000002', 03, 5);

INSERT INTO readingLog
VALUES
(01, 'hazelyna11');

INSERT INTO readingLog
VALUES
(02, 'eward99');

INSERT INTO logEntry
VALUES
(01, 01, '2022-11-21', 20, 1, 'excited to have more time to read over break!', '100000002');

INSERT INTO logEntry
VALUES
(01, 02, '2022-11-21', 80, 2, 'taking a break from midterms', '100000001');

DELETE FROM bookShelf;

