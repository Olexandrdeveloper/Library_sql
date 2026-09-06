CREATE DATABASE Library
GO

USE Library
GO

CREATE TABLE Publishers
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[Location] NVARCHAR(100) NOT NULL
)

CREATE TABLE Books
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	Title NVARCHAR(200) NOT NULL,
	PublicationYear INT NOT NULL CHECK(PublicationYear BETWEEN 1500 AND 2026),
	ISBN CHAR(13) NOT NULL UNIQUE,
	CopiesAvailable INT NOT NULL CHECK(CopiesAvailable >= 0),
	PublisherID INT NOT NULL REFERENCES Publishers(ID)
)

CREATE TABLE Authors
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	BirthYear INT NOT NULL CHECK(BirthYear > 1500)
)

CREATE TABLE Readers
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	Phone CHAR(10) NOT NULL UNIQUE,
	RegistrationDate DATE NOT NULL DEFAULT CURRENT_DATE
)

CREATE TABLE Loans
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	BookID INT NOT NULL REFERENCES Books(ID),
	ReaderID INT NOT NULL REFERENCES Readers(ID),
	LoanDate DATE NOT NULL,
	ReturnDate DATE
)

CREATE TABLE Genres
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE ReaderCards
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	ReaderID INT NOT NULL REFERENCES Readers(ID),
	IssueDate DATE NOT NULL,
	ExpiryDate DATE NOT NULL
)

CREATE TABLE BookSeries
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	BooksInSeries INT NOT NULL
)

CREATE TABLE Reviews
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	BookID INT NOT NULL REFERENCES Books(ID),
	ReviewText NVARCHAR(MAX) NOT NULL,
	Rating INT NOT NULL CHECK(Rating BETWEEN 1 AND 5)
)

CREATE TABLE Shops
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL
)

CREATE TABLE ShopInventory
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	ShopID INT NOT NULL REFERENCES Shops(ID),
	BookID INT NOT NULL REFERENCES Books(ID),
	Quantity INT NOT NULL CHECK(Quantity >= 0)
)

CREATE TABLE AuthorAwards
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	AuthorID INT NOT NULL REFERENCES Authors(ID),
	AwardName NVARCHAR(200) NOT NULL,
	YearAwarded INT NOT NULL
)

CREATE TABLE Languages
(
	ID INT IDENTITY NOT NULL PRIMARY KEY,
	Language NVARCHAR(100) NOT NULL
)


DELETE FROM ShopInventory;
DELETE FROM Shops;
DELETE FROM Reviews;
DELETE FROM ReaderCards;
DELETE FROM Loans;
DELETE FROM Readers;
DELETE FROM AuthorAwards;
DELETE FROM Authors;
DELETE FROM BookSeries;
DELETE FROM Books;
DELETE FROM Genres;
DELETE FROM Languages;
DELETE FROM Publishers;

DBCC CHECKIDENT ('ShopInventory', RESEED, 0);
DBCC CHECKIDENT ('Shops', RESEED, 0);
DBCC CHECKIDENT ('Reviews', RESEED, 0);
DBCC CHECKIDENT ('ReaderCards', RESEED, 0);
DBCC CHECKIDENT ('Loans', RESEED, 0);
DBCC CHECKIDENT ('Readers', RESEED, 0);
DBCC CHECKIDENT ('AuthorAwards', RESEED, 0);
DBCC CHECKIDENT ('Authors', RESEED, 0);
DBCC CHECKIDENT ('BookSeries', RESEED, 0);
DBCC CHECKIDENT ('Books', RESEED, 0);
DBCC CHECKIDENT ('Genres', RESEED, 0);
DBCC CHECKIDENT ('Languages', RESEED, 0);
DBCC CHECKIDENT ('Publishers', RESEED, 0);

INSERT INTO Publishers ([Name], [Location]) VALUES 
('А-БА-БА-ГА-ЛА-МА-ГА', 'Київ'),
('Клуб Сімейного Дозвілля', 'Харків'),
('Видавництво Старого Лева', 'Львів'),
('Фоліо', 'Київ'),
('Наш Формат', 'Київ'),
('Vivat', 'Харків'),
('BookBook', 'Київ'),
('КСД', 'Київ');

INSERT INTO Books (Title, PublicationYear, ISBN, CopiesAvailable, PublisherID) VALUES 
('Кобзар', 2012, '9789667047001', 8, 1),
('Тіні забутих предків', 2018, '4386171200002', 3, 2),
('Захар Беркут', 2020, '0386176790003', 0, 3),
('Кайдашева сім''я', 2010, '1289660300004', 12, 2),
('Місто', 2022, '5689660388881', 6, 4),
('Тигролови', 2019, '7861778902062', 7, 5),
('Sapiens', 2021, '2961772795813', 4, 6),
('Чорна рада', 2017, '8496698200094', 2, 7),
('Інтернат', 2023, '3161773637485', 9, 8),
('Falcone', 2016, '6561775551126', 0, 1);

INSERT INTO Authors (FirstName, LastName, BirthYear) VALUES 
('Тарас', 'Шевченко', 1814),
('Іван', 'Франко', 1856),
('Сергій', 'Жадан', 1974),
('Олексій', 'Новиков', 1985),
('Максим', 'Крівцов', 1990),
('Олена', 'Захарченко', 1982),
('Андрій', 'Кокотюха', 1970),
('Світлана', 'Поваляєва', 1974),
('Макс', ' Кідрук', 1981),
('Дмитро', 'Пантюх', 1988);

INSERT INTO Readers (FirstName, LastName, Phone, RegistrationDate) VALUES 
('Олександр', 'Петренко', '0501234567', '2023-05-10'),
('Марія', 'Коваль', '0679876543', '2024-02-15'),
('Андрій', 'Шевченко', '0931112233', '2024-04-20'),
('Олена', 'Мельник', '0684445566', '2023-08-12'),
('Максим', 'Бойко', '0957778899', '2024-01-05'),
('Софія', 'Ковальчук', '0632223344', '2024-03-22'),
('Дмитро', 'Павленко', '0975556677', '2024-05-30'),
('Катерина', 'Лисенко', '0509998877', '2024-06-01'),
('Ігор', 'Василенко', '0671110099', '2024-06-15'),
('Анна', 'Ткаченко', '0932221100', '2024-07-10');

INSERT INTO Loans (BookID, ReaderID, LoanDate, ReturnDate) VALUES 
(1, 1, '2026-01-15', '2026-02-01'),
(2, 2, '2026-02-10', NULL),
(3, 3, '2026-03-01', NULL),
(4, 4, '2026-03-15', '2026-03-25'),
(5, 5, '2026-04-01', NULL),
(6, 6, '2026-04-10', '2026-04-20'),
(7, 7, '2026-05-01', NULL),
(8, 8, '2026-05-10', '2026-05-20'),
(9, 9, '2026-06-01', NULL),
(10, 10, '2026-06-05', NULL);

INSERT INTO Genres ([Name]) VALUES 
('Поезія'),
('Проза'),
('Історичний роман'),
('Наукова фантастика'),
('Детектив'),
('Фентезі'),
('Пригоди'),
('Біографія'),
('Драматична проза'),
('Сучасна література');

INSERT INTO ReaderCards (ReaderID, IssueDate, ExpiryDate) VALUES 
(1, '2023-05-10', '2028-05-10'),
(2, '2024-02-15', '2029-02-15'),
(3, '2024-04-20', '2029-04-20'),
(4, '2023-08-12', '2028-08-12'),
(5, '2024-01-05', '2029-01-05'),
(6, '2024-03-22', '2029-03-22'),
(7, '2024-05-30', '2029-05-30'),
(8, '2024-06-01', '2029-06-01'),
(9, '2024-06-15', '2029-06-15'),
(10, '2024-07-10', '2029-07-10');

INSERT INTO BookSeries ([Name], BooksInSeries) VALUES 
('Шкільна бібліотека', 50),
('Українська класика', 30),
('Вовча тропа', 5),
('Бібліотека пригод', 15),
('Сучасний бестселер', 20);

INSERT INTO Reviews (BookID, ReviewText, Rating) VALUES 
(1, 'Неймовірна книга, класика української літератури.', 5),
(2, 'Дуже атмосферний твір.', 4),
(3, 'Цікава історична розповідь.', 5),
(4, 'Класна побутова драма.', 4),
(5, 'Чудовий урбаністичний роман.', 5),
(6, 'Динамічний сюжет.', 4),
(7, 'Пізнавально та цікаво.', 5),
(8, 'Гарна класика.', 4),
(9, 'Сильна військова драма.', 5),
(10, 'Незвична історія.', 3);

INSERT INTO Shops ([Name], [Address]) VALUES 
('Книгарня Є', 'вул. Хрещатик, 10, Київ'),
('БукВА', 'вул. Дерибасівська, 5, Одеса'),
('Буклет', 'пр. Свободи, 12, Львів'),
('Книголенд', 'вул. Сумська, 25, Харків'),
('Читай-Місто', 'вул. Соборна, 45, Рівне');

INSERT INTO ShopInventory (ShopID, BookID, Quantity) VALUES 
(1, 1, 5),
(1, 2, 2),
(2, 3, 0),
(2, 4, 10),
(3, 5, 3),
(3, 6, 7),
(4, 7, 4),
(4, 8, 6),
(5, 9, 2),
(5, 10, 8);

INSERT INTO AuthorAwards (AuthorID, AwardName, YearAwarded) VALUES 
(3, 'Шевченківська премія', 2016),
(4, 'Літературний дебют', 2021),
(5, 'Нагорода за кращу поезію', 2022),
(6, 'Премія імені Олеся Гончара', 2019),
(7, 'Золотий пір''яник', 2015),
(8, 'Книга року BBC', 2020),
(9, 'Фантаст року', 2023),
(10, 'Премія за найкращий дебют', 2024);

INSERT INTO Languages ([Language]) VALUES 
('Українська'),
('Англійська'),
('Німецька'),
('Польська'),
('Французька');


-- ЗАПИТИ

-- 1
SELECT * FROM Books

-- 2
SELECT Title FROM Books

-- 3
SELECT FirstName, LastName
FROM Authors

-- 4
SELECT * FROM Readers

-- 5
SELECT [Name] FROM Genres

-- 6
SELECT [Name] FROM Publishers

-- 7
SELECT * FROM Shops

-- 8
SELECT * FROM Languages

-- 9
SELECT * FROM BookSeries

-- 10
SELECT * FROM Reviews

-- 11
SELECT * FROM Books
WHERE PublicationYear >= 2015

-- 12
SELECT * FROM Books
WHERE CopiesAvailable > 5

-- 13
SELECT * FROM Books
WHERE PublicationYear BETWEEN 2000 AND 2020

-- 14
SELECT * FROM Books
WHERE CopiesAvailable = 0

-- 15
SELECT * FROM Readers
WHERE RegistrationDate >= '2024-01-01'

-- 16 
SELECT * FROM Authors
WHERE BirthYear >= 1980

-- 17
SELECT * FROM AuthorAwards
WHERE YearAwarded >= 2015

-- 18
SELECT * FROM Reviews
WHERE Rating = 5

-- 19
SELECT * FROM Books
WHERE ISBN LIKE '978%'

-- 20
SELECT * FROM Publishers
WHERE [Location] = 'Київ'

-- 21
SELECT * FROM Books
ORDER BY Title

-- 22
SELECT * FROM Books
ORDER BY PublicationYear DESC

-- 23
SELECT * FROM Authors
ORDER BY LastName

-- 24
SELECT * FROM Readers
ORDER BY RegistrationDate

-- 25
SELECT * FROM Shops
ORDER BY [Name]

-- 26 -- ЗМІНИВ
SELECT * FROM Books
WHERE Title LIKE 'К%'

-- 27
SELECT * FROM Authors
WHERE LastName LIKE 'К%'

-- 28 
SELECT * FROM Publishers
WHERE [Name] LIKE '%Book%'	

-- 29
SELECT * FROM Readers
WHERE FirstName LIKE '%а'

-- 30
SELECT * FROM Genres
WHERE [Name] LIKE '%о%'

-- 31
SELECT * FROM Books
WHERE PublicationYear IN (2018, 2020, 2023)

-- 32
SELECT * FROM Books
WHERE PublicationYear BETWEEN 1990 AND 2010

-- 33
SELECT *
FROM Books b
JOIN Loans l ON l.BookID = b.ID
WHERE l.ReturnDate IS NULL

-- 34
SELECT *
FROM Books b
JOIN Loans l ON l.BookID = b.ID
WHERE l.ReturnDate IS NOT NULL

-- 35
SELECT * FROM Authors
WHERE BirthYear BETWEEN 1950 AND 1980

-- 36
SELECT b.Title,
	   p.[Name] AS 'Publisher'
FROM Books b
JOIN Publishers p ON p.ID = b.PublisherID

-- 37
SELECT b.Title,
	   r.ReviewText
FROM Books b
JOIN Reviews r ON r.BookID = b.ID

-- 38
SELECT b.Title,
	   si.Quantity
FROM Books b
JOIN ShopInventory si ON si.BookID = b.ID

-- 39
SELECT s.[Name] AS 'Shop',
	   b.Title AS 'Book'
FROM Shops s
JOIN ShopInventory si ON si.ShopID = s.ID
JOIN Books b ON b.ID = si.BookID

-- 40
SELECT r.FirstName AS 'Reader',
	   rd.IssueDate
FROM Readers r
JOIN ReaderCards rd ON rd.ReaderID = r.ID

-- 41
SELECT r.FirstName AS 'Reader',
	   b.Title AS 'Book'
FROM Readers r
JOIN Loans l ON l.ReaderID = r.ID
JOIN Books b ON b.ID = l.BookID

-- 42
SELECT a.FirstName AS 'Author',
	   aa.AwardName
FROM Authors a
LEFT JOIN AuthorAwards aa ON aa.AuthorID = a.ID

-- 43
SELECT b.Title AS 'Book',
	   s.[Name] AS 'Shop'
FROM Books b
JOIN ShopInventory si ON si.BookID = b.ID
JOIN Shops s ON s.ID = si.ShopID

-- 44
SELECT b.Title AS 'Book',
	   l.LoanDate
FROM Books b
JOIN Loans l ON l.BookID = b.ID

-- 45
SELECT b.Title AS 'Book',
	   r.Rating
FROM Books b
LEFT JOIN Reviews r ON r.BookID = b.ID

-- 46
INSERT INTO Authors (FirstName, LastName, BirthYear)
VALUES ('Леся', 'Українка', 1871)

-- 47
INSERT INTO Publishers ([Name], [Location])
VALUES ('ExamplePublisher', 'Рівне')

-- 48
INSERT INTO Genres ([Name])
VALUES ('Автобіографія')

-- 49
INSERT INTO Books (Title, PublicationYear, ISBN, CopiesAvailable, PublisherID)
VALUES ('Буквар', 1574, '9719767547002', 10, 9)

-- 50
INSERT INTO Readers (FirstName, LastName, Phone, RegistrationDate)
VALUES ('Олександр', 'Овчарук', '0977771111', '2026-06-14')

-- 51
INSERT INTO ReaderCards (ReaderID, IssueDate, ExpiryDate)
VALUES (11, '2025-08-29', '2029-08-29')

-- 52
INSERT INTO Loans (BookID, ReaderID, LoanDate, ReturnDate)
VALUES (11, 11, '2026-09-03', NULL)

-- 53
INSERT INTO Shops ([Name], [Address])
VALUES ('MyBook', 'вул. Степана Бандери, 1, Рівне')

-- 54
INSERT INTO ShopInventory (ShopID, BookID, Quantity)
VALUES (5, 11, 10)

-- 55
INSERT INTO Reviews (BookID, ReviewText, Rating)
VALUES (11, 'Чудова книга', 5)

-- 56
INSERT INTO BookSeries ([Name], BooksInSeries)
VALUES ('Моя Збірка', 1)

-- 57
INSERT INTO AuthorAwards (AuthorID, AwardName, YearAwarded)
VALUES (12, 'Нобелівська Премія', 2026)

-- 58
INSERT INTO Languages ([Language])
VALUES ('Іспанська')

-- 59
INSERT INTO Books (Title, PublicationYear, ISBN, CopiesAvailable, PublisherID) VALUES
('Твір1', 1919, '9719555747002', 15, 4),
('Твір2', 1929, '9719555747004', 7, 4),
('Твір3', 1939, '9719555747006', 4, 4)

-- 60
INSERT INTO Readers (FirstName, LastName, Phone, RegistrationDate) VALUES
('Микола', 'Бабич', '0977773333', '2022-12-20'),
('Павло', 'Ліпінський', '0977774444', '2025-08-22')

-- 61
UPDATE Books
SET Title = 'MyLife'
WHERE ID = 14

-- 62
UPDATE Books
SET PublicationYear = 2000
WHERE ID = 13

-- 63
UPDATE Books
SET CopiesAvailable = 20
WHERE ID = 12

-- 64
UPDATE Books
SET CopiesAvailable = 9
WHERE ID = 11

-- 65
UPDATE Readers
SET Phone = '0986451020'
WHERE ID = 13

-- 66
UPDATE Shops
SET [Address] = 'вул. Невідома, 99, Луцьк'
WHERE ID = 6

-- 67
UPDATE Genres
SET [Name] = 'Нестандартика'
WHERE ID = 11

-- 68
UPDATE Reviews
SET ReviewText = 'Чудова книга для саморозвитку'
WHERE BookID = 11

-- 69
UPDATE Reviews
SET Rating = '4'
WHERE BookID = 10

-- 70
UPDATE Loans
SET ReturnDate = '2026-09-06'
WHERE ID = 11

-- 71
UPDATE Publishers
SET [Location] = 'Луцьк'
WHERE ID = 9

-- 72
UPDATE ReaderCards
SET ExpiryDate = '2030-08-29'
WHERE ID = 11

-- 73
UPDATE ShopInventory
SET Quantity = 5
WHERE ShopID = 6 AND BookID = 11

-- 74
UPDATE Books
SET ISBN = '0000000000000'
WHERE Title = 'Буквар'

-- 75
UPDATE BookSeries
SET [Name] = 'Збірка Лесі'
WHERE [Name] = 'Моя Збірка'

-- 76
DELETE FROM Reviews
WHERE ID = 11

-- 77
DELETE FROM BookSeries
WHERE ID = 6

-- 78
DELETE FROM Languages
WHERE [Language] = 'Французька'

-- 79
DELETE FROM AuthorAwards
WHERE ID = 10

-- 80
DELETE FROM Genres
WHERE ID = 11

-- 81
DELETE FROM Shops
WHERE [Name] = 'MyBook'

-- 82
DELETE FROM ShopInventory
WHERE ID = 11

-- 83
DELETE FROM ReaderCards
WHERE ID = 11

-- 84
DELETE FROM Loans
WHERE ReaderID = 11

-- 85
DELETE FROM Readers
WHERE ID = 11

-- 86
DELETE FROM Authors
WHERE BirthYear = 1871

-- 87
DELETE FROM Books
WHERE Title = 'Твір1'

-- 88
UPDATE Books
SET PublisherID = 8
WHERE PublisherID = 9

DELETE FROM Publishers
WHERE [Name] = 'ExamplePublisher'

-- 89
TRUNCATE TABLE Reviews

-- 90
TRUNCATE TABLE ShopInventory

-- 91
INSERT INTO Loans (BookID, ReaderID, LoanDate, ReturnDate)
VALUES (1, 13, '2020-01-09', NULL)

UPDATE Books
SET CopiesAvailable = (CopiesAvailable - 1)
WHERE ID = 1

-- 92
UPDATE Loans
SET ReturnDate = '2020-02-08'
WHERE ID = 14

UPDATE Books
SET CopiesAvailable = (CopiesAvailable + 1)
WHERE ID = 1

-- 93
INSERT INTO Books (Title, PublicationYear, ISBN, CopiesAvailable, PublisherID)
VALUES ('MyBook', 2026, '1111111111111', 40, 2)

UPDATE Books
SET CopiesAvailable = (CopiesAvailable - 25)
WHERE Title = 'MyBook'

-- 94
INSERT INTO Readers (FirstName, LastName, Phone, RegistrationDate)
VALUES ('Олександр', 'Овчарук', '0987654321', '2026-04-01')

INSERT INTO ReaderCards (ReaderID, IssueDate, ExpiryDate)
VALUES (14, '2026-04-01', '2031-04-01')

-- 95
INSERT INTO Shops ([Name], [Address])
VALUES ('MyShop', 'Online')

INSERT INTO ShopInventory (ShopID, BookID, Quantity) VALUES
(7, 1, 3),
(7, 8, 4),
(7, 5, 1)

-- 96
DELETE FROM ShopInventory
WHERE ID = 3

INSERT INTO ShopInventory (ShopID, BookID, Quantity)
VALUES (7, 5, 1)

-- 97
UPDATE Books
SET Title = 'Змінена Книга'
WHERE Title = 'MyBook'

SELECT * FROM Books
WHERE Title = 'Змінена Книга'

-- 98
INSERT INTO Reviews (BookID, ReviewText, Rating) VALUES
(1, 'Чудова книга', 5),
(1, 'Гарний сюжет', 4)

SELECT * FROM Reviews
WHERE BookID = 1

-- 99
UPDATE Readers
SET Phone = '0981234567'
WHERE Phone = '0987654321'

SELECT * FROM Readers

-- 100
SELECT * FROM Books

INSERT INTO Books (Title, PublicationYear, ISBN, CopiesAvailable, PublisherID)
VALUES ('EXAMPLE BOOK', 2026, '5555555555555', 11, 1)

SELECT * FROM Books

UPDATE Books
SET CopiesAvailable = CopiesAvailable - 5
WHERE ID = 16

SELECT * FROM Books

DELETE FROM Books
WHERE ID = 16

SELECT * FROM Books


-- 101
SELECT b.Title, b.PublicationYear, p.[Name] AS 'Publisher'
FROM Books b
JOIN Publishers p ON p.ID = b.PublisherID
ORDER BY PublicationYear

-- 102
SELECT b.Title
FROM Books b
JOIN Loans l ON l.BookID = b.ID
WHERE l.ReturnDate IS NULL

-- 103
SELECT b.Title
FROM Books b
LEFT JOIN Loans l ON l.BookID = b.ID
WHERE l.ID IS NULL

-- 104
SELECT r.FirstName, r.LastName
FROM Readers r
LEFT JOIN Loans l ON l.ReaderID = r.ID
WHERE l.ID IS NULL

-- 105
SELECT a.FirstName, a.LastName, a.BirthYear
FROM Authors a
LEFT JOIN AuthorAwards aa ON aa.AuthorID = a.ID
WHERE aa.ID IS NOT NULL

-- 106
SELECT a.FirstName, a.LastName, a.BirthYear
FROM Authors a
LEFT JOIN AuthorAwards aa ON aa.AuthorID = a.ID
WHERE aa.ID IS NULL

-- 107
SELECT b.Title
FROM Books b
LEFT JOIN ShopInventory sh ON sh.BookID = b.ID
WHERE sh.ID IS NOT NULL

-- 108
SELECT b.Title
FROM Books b
LEFT JOIN ShopInventory sh ON sh.BookID = b.ID
WHERE sh.ID IS NULL

-- 109
SELECT s.[Name]
FROM Shops s
JOIN ShopInventory sh ON sh.ShopID = s.ID
JOIN Books b ON b.ID = sh.BookID
JOIN Publishers p ON p.ID = b.PublisherID
WHERE p.[Name] = 'Фоліо'

-- 110
SELECT b.Title,
	   s.[Name] AS 'Shop'
FROM Books b
LEFT JOIN ShopInventory sh ON sh.BookID = b.ID
LEFT JOIN Shops s ON s.ID = sh.ShopID

-- 111
SELECT DISTINCT b.Title
FROM Books b
JOIN Reviews r ON r.BookID = b.ID

-- 112
SELECT DISTINCT b.Title
FROM Books b
LEFT JOIN Reviews r ON r.BookID = b.ID
WHERE r.ID IS NULL

-- 113
ALTER TABLE Books
ADD LanguageID INT NULL

ALTER TABLE Books 
ADD CONSTRAINT FK_Books_Languages 
FOREIGN KEY (LanguageID) 
REFERENCES Languages(ID)

UPDATE Books
SET LanguageID = 1
WHERE ID BETWEEN 1 AND 7

UPDATE Books
SET LanguageID = 2
WHERE ID BETWEEN 8 AND 20

SELECT b.Title, l.[Language]
FROM Books b
JOIN Languages l ON l.ID = b.LanguageID

-- 114
SELECT b1.Title
FROM Books b1
JOIN Books b2 ON b1.PublisherID = b2.PublisherID
WHERE b2.ID = 5

-- 115
SELECT b1.Title
FROM Books b1
JOIN Books b2 ON b1.PublicationYear > b2.PublicationYear
WHERE b2.Title = 'Кобзар'

-- 116
SELECT b1.Title
FROM Books b1
JOIN Books b2 ON LEFT(b1.ISBN, 3) = LEFT(b2.ISBN, 3) 
WHERE b1.ID != b2.ID

-- 117
SELECT TOP 5 *
FROM Books
ORDER BY PublicationYear DESC

-- 118
SELECT TOP 10 *
FROM Readers
ORDER BY RegistrationDate DESC

-- 119
SELECT DISTINCT PublicationYear
FROM Books

-- 120
SELECT DISTINCT BirthYear
FROM Authors




SELECT * FROM Publishers
SELECT * FROM Books
SELECT * FROM Authors
SELECT * FROM Readers
SELECT * FROM Loans
SELECT * FROM Genres
SELECT * FROM ReaderCards
SELECT * FROM BookSeries
SELECT * FROM Reviews
SELECT * FROM Shops
SELECT * FROM ShopInventory
SELECT * FROM AuthorAwards
SELECT * FROM Languages