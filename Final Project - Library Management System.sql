/*
By Nisa Kayoulou
Date: 8/6/2020
FINAL PROJECT - LIBRARY MANAGEMENT SYSTEM
Most books used are from https://www.goodreads.com/list/show/1.Best_Books_Ever
*/

/*
YOU MAY CHOOSE YOUR OWN DATA TO POPULATE YOUR TABLES AS LONG AS YOUR DATABASE ENSURES THAT THE FOLLOWING CONDITIONS ARE TRUE:
There is a book called 'The Lost Tribe' found in the 'Sharpstown' branch.
There is a library branch called 'Sharpstown' and one called 'Central'.
There are at least 20 books in the BOOK table.
There are at least 10 authors in the BOOK_AUTHORS table.
Each library branch has at least 10 book titles, and at least two copies of each of those titles.
There are at least 8 borrowers in the BORROWER table, and at least 2 of those borrowers have more than 5 books loaned to them.
There are at least 4 branches in the LIBRARY_BRANCH table.
There are at least 50 loans in the BOOK_LOANS table.
There must be at least two books written by 'Stephen King' located at the 'Central' branch.
*/


/***********************************************************
	The creation of each of table
 ************************************************************/
 USE LibraryManagementSystem

CREATE TABLE tbl_library_branch (
	branch_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	branch_name VARCHAR(100) NOT NULL,
	branch_address VARCHAR(100) NOT NULL
);



CREATE TABLE tbl_publisher (
	publisher_name VARCHAR(100) PRIMARY KEY NOT NULL,
	publisher_address VARCHAR(100) NOT NULL,
	publisher_phone VARCHAR(100) NOT NULL 
);

CREATE TABLE tbl_books (
	book_id INT PRIMARY KEY NOT NULL IDENTITY (101,1),
	book_title VARCHAR(100) NOT NULL,
	publisher_name VARCHAR(100) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES tbl_publisher(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_copies (
	book_id INT NOT NULL CONSTRAINT fk_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	branch_id INT NOT NULL CONSTRAINT fk_branch_id FOREIGN KEY REFERENCES tbl_library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	number_of_copies INT NOT NULL
);

/* 
	In order to create the table below I had to rename the constraint for the 'book_id' column from 'fk_book_id' to 'fk_author_book_id' 
	or else throws an error sayying "There is already an object named 'fk_book_id' in the database"
*/
CREATE TABLE tbl_book_authors (
	book_id INT NOT NULL CONSTRAINT fk_author_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	author_name VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_borrower (
	card_number INT PRIMARY KEY NOT NULL IDENTITY (500001,1),
	borrower_name VARCHAR(100) NOT NULL,
	borrower_address VARCHAR(100) NOT NULL,
	borrower_phone VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_book_loans (
	book_id INT NOT NULL CONSTRAINT fk_loans_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	branch_id INT NOT NULL CONSTRAINT fk_loans_branch_id FOREIGN KEY REFERENCES tbl_library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	card_number INT NOT NULL CONSTRAINT fk_card_number FOREIGN KEY REFERENCES tbl_borrower(card_number) ON UPDATE CASCADE ON DELETE CASCADE,
	date_out DATE NOT NULL,
	date_due DATE NOT NULL
);

/***********************************************************
	The inserting of data into the created tables
 ************************************************************/

 INSERT INTO tbl_library_branch
	(branch_name, branch_address)
	VALUES
	('Agular', '174 East 110th Street, NYC'),
	('Battery Park City', '175 North End Avenue, NYC'),
	('Bloomingdale', '150 West 100th Street, NYC'),
	('Chatham Square', '33 East Broadway, NYC'),
	('Sharpstown', '1 Main St. Portland, OR'),
	('Central', 'Alberta St. Portland,OR')
;

SELECT * FROM tbl_library_branch;

INSERT INTO tbl_publisher
	(publisher_name, publisher_address, publisher_phone)
	VALUES
	('Scholastic', '557 Broadway, New York City, New York, U.S. 10012', '800-724-6527'),
	('HarperCollins', '195 Broadway, New York, NY 10007', '212-207-7000'),
	('Modem Library', 'New York, New York', 'N/A'),
	('Little, Brown and Company', '3 Center Plz Ste 100 Boston, MA 02108', '617-227-0730'),
	('Alfred A. Knopf', '1745 Broadway New York, NY 10019', 'N/A'),
	('NAL', 'New York, New York', 'N/A'),
	('Ballantine Books', 'New York, New York', 'N/A'),
	('Warner Books', 'New York, New York', 'N/A'),
	('Dutton Books', 'New York, New York', 'N/A'),
	('Del Rey', 'New York, New York', 'N/A'),
	('Norton', '500 5th Ave # 6, New York, NY 10110', '212-354-5500'),
	('Anchor', '1745 Broadway New York, NY 10019', '212-782-9000'),
	('Penguin Random House', 'New York, New York', 'N/A'),
	('Signet Classics', 'New York, New York', 'N/A'),
	('Carpet Bombing Culture', 'United Kingdom', 'N/A'),
	('Viking Press', 'New York, New York', 'N/A'),
	('Doubleday', '1745 Broadway New York, NY 10019', 'N/A')
;

SELECT * FROM tbl_publisher;

INSERT INTO tbl_books
	(book_title, publisher_name)
	VALUES
	('The Hunger Games', 'Scholastic'),
	('Harry Potter and the Order of the Phoenix', 'Scholastic'),
	('To Kill a Mockingbird', 'HarperCollins'),
	('Pride and Prejudice', 'Modem Library'),
	('Twilight', 'Little, Brown and Company'),
	('The Book Thief', 'Alfred A. Knopf'),
	('The Chronicles of Narnia', 'HarperCollins'),
	('Animal Farm', 'NAL'),
	('The Hobbit and The Lord of the Rings', 'HarperCollins'),
	('Gone with the Wind', 'Warner Books'),
	('The Fault in Our Stars', 'Dutton Books'),
	('The Giving Tree', 'HarperCollins'),
	('The Hitchhiker''s Guide to the Galaxy', 'Del Rey'),
	('Wuthering Heights', 'Norton'),
	('The Da Vinci Code', 'Anchor'),
	('Memoirs of a Geisha', 'Penguin Random House'),
	('Alice''s Adventures in Wonderland & Through the Looking-Glass', 'Penguin Random House'),
	('The Picture of Dorian Gray', 'Modem Library'),
	('Les Misérables', 'Signet Classics'),
	('Jane Eyre', 'Penguin Random House'),
	('The Lost Tribe', 'Carpet Bombing Culture'),
	('Divergent', 'HarperCollins'),
	('It', 'Viking Press'),
	('Pet Sematary', 'Doubleday')
;

SELECT * FROM tbl_books;


INSERT INTO tbl_book_authors
	(book_id, author_name)
	VALUES
	(101, 'Suzanne Collins'),
	(102, 'J.K. Rowling'),
	(103, 'Harper Lee'),
	(104, 'Jane Austen'),
	(105, 'Stephenie Meyer'),
	(106, 'Markus Zusak'),
	(107, 'C.S. Lewis'),
	(108, 'George Orwell'),
	(109, 'Ballantine Books'),
	(110, 'Margaret Mitchell'),
	(111, 'John Green'),
	(112, 'Shel Silverstein'),
	(113, 'Douglas Adams'),
	(114, 'Emily Brontë,  Richard J. Dunn '),
	(115, 'Dan Brown'),
	(116, 'Arthur Golden'),
	(117, 'Lewis Carroll'),
	(118, 'Oscar Wilde'),
	(119, 'Victor Hugo'),
	(120, 'Charlotte Brontë'),
	(121, 'Mark W. Lee'),
	(122, 'Veronica Roth'),
	(123, 'Stephen King'),
	(124, 'Stephen King')
;

SELECT * FROM tbl_book_authors;

INSERT INTO tbl_book_copies
	(book_id, branch_id, number_of_copies)
	VALUES
	(101, 1, 2),
	(102, 1, 5),
	(103, 2, 6),
	(104, 2, 9),
	(105, 3, 10),
	(106, 3, 8),
	(107, 4, 9),
	(108, 4, 3),
	(109, 5, 8),
	(110, 5, 4),
	(111, 6, 9),
	(112, 6, 6),
	(113, 1, 10),
	(114, 1, 2),
	(115, 2, 5),
	(116, 2, 7),
	(117, 3, 2),
	(118, 3, 3),
	(119, 4, 9),
	(120, 4, 11),
	(121, 5, 5),
	(122, 5, 3),
	(123, 6, 8),
	(124, 6, 10),

	(101, 2, 2),
	(102, 2, 5),
	(103, 3, 6),
	(104, 3, 9),
	(105, 4, 10),
	(106, 4, 8),
	(107, 5, 9),
	(108, 5, 3),
	(109, 6, 8),
	(110, 6, 4),
	(111, 1, 9),
	(112, 1, 6),
	(113, 2, 10),
	(114, 2, 2),
	(115, 3, 5),
	(116, 3, 7),
	(117, 4, 2),
	(118, 4, 3),
	(119, 5, 9),
	(120, 5, 11),
	(121, 6, 2),
	(122, 6, 3),
	(123, 1, 8),
	(124, 1, 10),

	(101, 3, 2),
	(102, 3, 5),
	(103, 4, 6),
	(104, 4, 9),
	(105, 5, 10),
	(106, 5, 8),
	(107, 6, 9),
	(108, 6, 3),
	(109, 1, 8),
	(110, 1, 4),
	(111, 2, 9),
	(112, 2, 6),
	(113, 3, 10),
	(114, 3, 2),
	(115, 4, 5),
	(116, 4, 7),
	(117, 5, 2),
	(118, 5, 3),
	(119, 6, 9),
	(120, 6, 11),
	(121, 1, 10),
	(122, 1, 3),
	(123, 2, 8),
	(124, 2, 10),

	(101, 4, 2),
	(102, 4, 5),
	(103, 5, 6),
	(104, 5, 9),
	(105, 6, 10),
	(106, 6, 8),
	(107, 1, 9),
	(108, 1, 3),
	(109, 2, 8),
	(110, 2, 4),
	(111, 3, 9),
	(112, 3, 6),
	(113, 4, 10),
	(114, 4, 2),
	(115, 5, 5),
	(116, 5, 7),
	(117, 6, 2),
	(118, 6, 3),
	(119, 1, 9),
	(120, 1, 11),
	(121, 2, 8),
	(122, 2, 3),
	(123, 3, 8),
	(124, 3, 10),

	(101, 5, 2),
	(102, 5, 5),
	(103, 6, 6),
	(104, 6, 9),
	(105, 1, 10),
	(106, 1, 8),
	(107, 2, 9),
	(108, 2, 3),
	(109, 3, 8),
	(110, 3, 4),
	(111, 4, 9),
	(112, 4, 6),
	(113, 5, 10),
	(114, 5, 2),
	(115, 6, 5),
	(116, 6, 7),
	(117, 1, 2),
	(118, 1, 3),
	(119, 2, 9),
	(120, 2, 11),
	(121, 3, 2),
	(122, 3, 3),
	(123, 4, 8),
	(124, 4, 10),

	(101, 6, 2),
	(102, 6, 5),
	(103, 1, 6),
	(104, 1, 9),
	(105, 2, 10),
	(106, 2, 8),
	(107, 3, 9),
	(108, 3, 3),
	(109, 4, 8),
	(110, 4, 4),
	(111, 5, 9),
	(112, 5, 6),
	(113, 6, 10),
	(114, 6, 2),
	(115, 1, 5),
	(116, 1, 7),
	(117, 2, 2),
	(118, 2, 3),
	(119, 3, 9),
	(120, 3, 11),
	(121, 4, 4),
	(122, 4, 3),
	(123, 5, 8),
	(124, 5, 10)
;

SELECT * FROM tbl_book_copies;


INSERT INTO tbl_borrower
	(borrower_name, borrower_address, borrower_phone)
	VALUES
	('Saul Spinney', '7435 S. Canal St. Allison Park, PA 15101', '(588) 882-3277'),
	('Millicent Mick', '7039 Edgefield St. Hudsonville, MI 49426', '(230) 984-3111'),
	('Trula Teran', '7277 Bayberry St. Perth Amboy, NJ 08861', '(910) 279-8493'),
	('Jeremiah Joiner', '401 Glen Ridge Road East Elmhurst, NY 11369', '(372) 927-2436'),
	('Bradley Blosser', '30 John St. Detroit, MI 48205', '(235) 929-3914'),
	('Tracie Torbert', '4 Leatherwood St. Birmingham, AL 35209', '(257) 695-8692'),
	('Shanon Southern', '120 Country Club St. East Northport, NY 11731', '(475) 878-8234'),
	('Wesley Waldner', '953 Heather Drive State College, PA 16801', '(867) 426-0774'),
	('Elisha Erion', '9828 Hilldale St. Warner Robins, GA 31088', '(251) 924-3099'),
	('Samara Sweeten', '842 Sussex Street Augusta, GA 30906', '(894) 552-6270')
;

SELECT * FROM tbl_borrower;

INSERT INTO tbl_book_loans
	(book_id, branch_id, card_number, date_out, date_due)
	VALUES
	--Saul Spinney(12)
	(101, 1, 500001, '2019-01-01', '2019-01-07'),
	(102, 1, 500001, '2019-01-07', '2019-01-14'),
	(103, 2, 500001, '2019-01-14', '2019-01-21'),
	(104, 2, 500001, '2019-01-21', '2019-01-28'),
	(105, 3, 500001, '2019-01-28', '2019-02-04'),
	(106, 3, 500001, '2019-02-04', '2019-02-11'),
	(107, 4, 500001, '2019-02-11', '2019-02-18'),
	(108, 4, 500001, '2019-02-18', '2019-02-25'),
	(109, 5, 500001, '2019-02-25', '2019-03-04'),
	(110, 5, 500001, '2019-03-04', '2019-03-11'),
	(111, 6, 500001, '2019-03-11', '2019-03-18'),
	(112, 6, 500001, '2019-03-18', '2019-03-25'),

	--Millicent Mick(12)
	(101, 1, 500002, '2019-01-01', '2019-01-07'),
	(102, 1, 500002, '2019-01-07', '2019-01-14'),
	(103, 2, 500002, '2019-01-14', '2019-01-21'),
	(104, 2, 500002, '2019-01-21', '2019-01-28'),
	(105, 3, 500002, '2019-01-28', '2019-02-04'),
	(106, 3, 500002, '2019-02-04', '2019-02-11'),
	(107, 4, 500002, '2019-02-11', '2019-02-18'),
	(108, 4, 500002, '2019-02-18', '2019-02-25'),
	(109, 5, 500002, '2019-02-25', '2019-03-04'),
	(110, 5, 500002, '2019-03-04', '2019-03-11'),
	(111, 6, 500002, '2019-03-11', '2019-03-18'),
	(112, 6, 500002, '2019-03-18', '2019-03-25'),

	--Trula Teran(12)
	(107, 4, 500003, '2019-01-01', '2019-01-07'),
	(108, 4, 500003, '2019-01-07', '2019-01-14'),
	(109, 5, 500003, '2019-01-14', '2019-01-21'),
	(110, 5, 500003, '2019-01-21', '2019-01-28'),
	(111, 6, 500003, '2019-01-28', '2019-02-04'),
	(112, 6, 500003, '2019-02-04', '2019-02-11'),
	(101, 1, 500003, '2019-02-11', '2019-02-18'),
	(102, 1, 500003, '2019-02-18', '2019-02-25'),
	(103, 2, 500003, '2019-02-25', '2019-03-04'),
	(104, 2, 500003, '2019-03-04', '2019-03-11'),
	(105, 3, 500003, '2019-03-11', '2019-03-18'),
	(106, 3, 500003, '2019-03-18', '2019-03-25'),

	--Jeremiah Joiner(12)
	(107, 4, 500004, '2019-01-01', '2019-01-07'),
	(108, 4, 500004, '2019-01-07', '2019-01-14'),
	(109, 5, 500004, '2019-01-14', '2019-01-21'),
	(110, 5, 500004, '2019-01-21', '2019-01-28'),
	(111, 6, 500004, '2019-01-28', '2019-02-04'),
	(112, 6, 500004, '2019-02-04', '2019-02-11'),
	(101, 1, 500004, '2019-02-11', '2019-02-18'),
	(102, 1, 500004, '2019-02-18', '2019-02-25'),
	(103, 2, 500004, '2019-02-25', '2019-03-04'),
	(104, 2, 500004, '2019-03-04', '2019-03-11'),
	(105, 3, 500004, '2019-03-11', '2019-03-18'),
	(106, 3, 500004, '2019-03-18', '2019-03-25'),

	--Bradley Blosser(3), Tracie Torbert(3)
	(113, 1, 500005, '2019-04-01', '2019-04-08'),
	(114, 1, 500005, '2019-04-08', '2019-04-15'),
	(115, 2, 500005, '2019-04-15', '2019-04-22'),
	(116, 5, 500006, '2019-04-22', '2019-04-29'), --today 4/29/18
	(117, 3, 500006, '2019-04-29', '2019-05-06'),
	(113, 1, 500006, '2019-04-01', '2019-04-08'),

	--Shanon Southern(3),
	(114, 1, 500007, '2019-04-08', '2019-04-15'),
	(115, 2, 500007, '2019-04-15', '2019-04-22'),
	(116, 5, 500007, '2019-04-22', '2019-04-29'), --today 4/29/18

	--Wesley Waldner
	(117, 3, 500008, '2019-04-29', '2019-05-06')
;

SELECT * FROM tbl_book_loans;

/***********************************************************************
	creation of stored procedures that will query for specific data
 ***********************************************************************/
 
/*
CREATE STORED PROCEDURES THAT WILL QUERY FOR EACH OF THE FOLLOWING QUESTIONS:
1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name 
	is "Sharpstown"?
2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?
3.) Retrieve the names of all borrowers who do not have any books checked out.
4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve 
	the book title, the borrower's name, and the borrower's address.
5.) For each library branch, retrieve the branch name and the total number of books loaned out from 
	that branch.
6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more 
	than five books checked out.
7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies 
	owned by the library branch whose name is "Central".
*/

------------------------------------------------------------------------------------------------------------------------------------------

-- 1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

CREATE PROCEDURE spNumber1
AS
SELECT
	a.book_id, b.book_title, c.branch_name, a.number_of_copies
	FROM tbl_book_copies a
	INNER JOIN tbl_books b ON a.book_id = b.book_id
	INNER JOIN tbl_library_branch c ON a.branch_id = c.branch_id
	WHERE book_title = 'The Lost Tribe' AND branch_name = 'Sharpstown';

-- Stored Procedure
EXEC spNumber1

------------------------------------------------------------------------------------------------------------------------------------------

-- 2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?

CREATE PROCEDURE spNumber2
AS
SELECT
	a.book_id, b.book_title, c.branch_name, a.number_of_copies
	FROM tbl_book_copies a
	INNER JOIN tbl_books b ON a.book_id = b.book_id
	INNER JOIN tbl_library_branch c ON a.branch_id = c.branch_id
	WHERE a.book_id = 121 AND book_title = 'The Lost Tribe'

-- Stored Procedure
EXEC spNumber2
	
------------------------------------------------------------------------------------------------------------------------------------------

-- 3.) Retrieve the names of all borrowers who do not have any books checked out.

CREATE PROCEDURE spNumber3
AS
SELECT 
	a.card_number, a.borrower_name, a.borrower_address, a.borrower_phone
	FROM tbl_borrower a
	LEFT OUTER JOIN tbl_book_loans b ON a.card_number = b.card_number
	WHERE b.book_id IS NULL

-- Stored Procedure
EXEC spNumber3

------------------------------------------------------------------------------------------------------------------------------------------

/*
4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve 
	the book title, the borrower's name, and the borrower's address.
*/

CREATE PROCEDURE spNumber4
AS
SELECT
	c.book_title, a.borrower_name, a.borrower_address
	FROM tbl_borrower a
	INNER JOIN tbl_book_loans b ON a.card_number = b.card_number
	INNER JOIN tbl_books c ON b.book_id = c.book_id
	INNER JOIN tbl_library_branch d ON b.branch_id = d.branch_id
	WHERE branch_name = 'Sharpstown' AND date_due = '2019-04-29'

-- Stored Procedure
EXEC spNumber4


------------------------------------------------------------------------------------------------------------------------------------------

-- 5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

--After running my qury below, my goal was to count the records and get the count by grouping each record by the branch name
SELECT *
	FROM tbl_library_branch a
	INNER JOIN tbl_book_loans b ON a.branch_id = b.branch_id

CREATE PROCEDURE spNumber5
AS
SELECT 
	a.branch_name, COUNT(*) AS books_loaned_out
	FROM tbl_library_branch a
	INNER JOIN tbl_book_loans b ON a.branch_id = b.branch_id
	GROUP BY branch_name

-- Stored Procedure
EXEC spNumber5

------------------------------------------------------------------------------------------------------------------------------------------

-- 6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.

SELECT *
	FROM tbl_borrower a
	INNER JOIN tbl_book_loans b ON a.card_number = b.card_number

CREATE PROCEDURE spNumber6
AS
SELECT
	a.borrower_name, a.borrower_address, a.borrower_phone, COUNT(*) AS books_loaned_out
	FROM tbl_borrower a
	INNER JOIN tbl_book_loans b ON a.card_number = b.card_number
	GROUP BY a.borrower_name, a.borrower_address, a.borrower_phone
	HAVING COUNT(*) > 5

-- Stored Procedure
EXEC spNumber6

------------------------------------------------------------------------------------------------------------------------------------------
/*
7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies 
	owned by the library branch whose name is "Central".
*/

CREATE PROCEDURE spNumber7
AS
SELECT
	a.book_title, c.number_of_copies
	FROM tbl_books a 
	INNER JOIN tbl_book_authors b ON a.book_id = b.book_id
	INNER JOIN tbl_book_copies c ON b.book_id = c.book_id
	INNER JOIN tbl_library_branch d ON c.branch_id = d.branch_id
	WHERE b.author_name = 'Stephen King' AND branch_name = 'Central'

-- Stored Procedure
EXEC spNumber7
