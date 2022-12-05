USE [train_station_3]
--PART 1
/*CREATE TABLE [dbo].[statement](
	[id] [int] NOT NULL,
	[data] varchar(20) NULL,
	[number_train_run]varchar(20) NULL,
	[name]varchar(20) NULL,
	[date_sale] varchar(20) NULL,
	[q_tickets] [int] NULL,
 CONSTRAINT [PK_statement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

insert into statement values
(1,'12.09.2022', 'number_train_1', 'David', '02.09.2022', 11),
(2,'12.09.2022', 'number_train_2', 'Vasya', '05.07.2022', 3),
(3,'12.09.2022', 'number_train_3', 'Dima', '22.08.2022', 2),
(4,'12.09.2022', 'number_train_4', 'Nekit', '12.08.2022', 14),
(5,'12.09.2022', 'number_train_5', 'Denis', '04.09.2022', 5)

CREATE TABLE [dbo].[Timetable](
	[id_timetable] [int] NOT NULL,
	[id_train] [int] NOT NULL,
	[departure_date] [datetime] NOT NULL,
	[departure_place] [datetime] NOT NULL,
	[destination_date] [datetime] NOT NULL,
	[destination_place] [nchar](10) NOT NULL,
	[route] [nchar](10) NOT NULL,
	[ticket_cost] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Timetable] PRIMARY KEY CLUSTERED 
(
	[id_timetable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

insert into Timetable values
(1,2, getdate(), getdate(), getdate(), 'a', 'something1', '3$'),
(2,1, getdate(), getdate(), getdate(), 'b', 'something2', '4$'),
(3,3, getdate(), getdate(), getdate(), 'c', 'something3', '3$'),
(4,4, getdate(), getdate(), getdate(), 'd', 'something4', '12$')

CREATE TABLE [dbo].[train_crew](
	[id] [int] NOT NULL,
	[id_workeres] [int] NULL,
	[id_train] [int] NULL,
	[number] [nchar](10) NULL,
	
 CONSTRAINT [PK_train_crew] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

insert into train_crew values
(1,2,1,5),
(2,1,3,3),
(3,2,2,2)

CREATE TABLE [dbo].[Trains](
	[id_train] [int]  NOT NULL,
	[number] [nchar](10) NULL,
	[year] [int] NULL,
	[quantity] [int] NULL,
	[type] [nchar](10) NULL,
 CONSTRAINT [PK_Trains] PRIMARY KEY CLUSTERED 
(
	[id_train] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

insert into Trains values 
(1,'number1', 5, 12, 'super'),
(2,'number2', 2, 12, 'ne super'),
(3,'number3', 3, 12, 'klassss')

CREATE TABLE [dbo].[Workers](
	[id_worker] [int] NOT NULL,
	[name] [nchar](10) NOT NULL,
	[surname] [nchar](10) NOT NULL,
	[third_name] [nchar](10) NOT NULL,
	[date_of_birth] varchar(20) NOT NULL,
	[entrance_year] [int] NOT NULL,
	[experience] [int] NOT NULL,
	[position] varchar(20) NOT NULL,
	[gender] [nchar](10) NOT NULL,
	[address]varchar(20) NOT NULL,
	[city] varchar(20) NOT NULL,
	[phone] varchar(20) NOT NULL,
 CONSTRAINT [PK_Workers] PRIMARY KEY CLUSTERED 
(
	[id_worker] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

insert into Workers values 
(1,'Alesha', 'Radionov', 'Who', '01-12-2001' ,1 , 6, '1221-4-21', 'M', 'izba 5', 'Minck', '10-00-00'),
(2,'Dobryna', 'Nikitich', 'Who','12-11-1981', 3, 6,  '1203-12-21', 'M', 'izba 7', 'Kiev', '99-99-96'),
(3,'Baba', 'Yaga', 'Who','14-09-1975',  3 , 6,  '1203-12-21', 'F', 'movable izba', 'Minck', '99-99-97'),
(4,'Tugarin', 'Zmei', 'Who','15-02-1977', 4,  2,  '1203-12-21', 'M', 'movable palatka', 'Kiev', '99-99-98'),
(5,'Solovei', 'Razboinik', 'Who', '104-07-1988', 1, 2,  '1203-12-21', 'M', 'everywhere', 'Minck','99-99-99')


update workers
set [position] = '2022-2-29'
where name = 'Alesha'

--
*/
USE [train_station_3]
--использование операторов сравнения;

SELECT *
FROM Workers
WHERE Name LIKE 'D%' and Name Not IN ('David');

SELECT *
FROM Trains
WHERE year = 3;

SELECT *
FROM statement
WHERE q_tickets > 3;

SELECT * 
FROM Trains
WHERE quantity < 10;

--использование логических операторов AND, OR и NOT

SELECT * 
FROM Workers
WHERE Gender = 'M' OR City = 'Minck';

--Проверка на принадлежность множеству
SELECT * 
FROM Workers
WHERE  City NOT  IN ('Минск'); 

SELECT * 
FROM Workers
WHERE  position  IN ('221-4-21', '1203-12-21');  


--Проверка на принадлежность диапазону значений/использование комбинации логических операторов
SELECT *
From statement
WHERE q_tickets BETWEEN 20 AND 30;

--Проверка на соответствие шаблону



--Проверка на принадлежность диапазону значений/Использование выражений над столбцами
SELECT Surname, Name FROM Workers
WHERE experience BETWEEN 1 AND 3;

--Проверка на неопределенное значение
SELECT *
FROM Workers
WHERE Third_name IS NOT Null;

--Декартово произведение таблиц
SELECT *
FROM statement, Workers

SELECT Workers.name, Workers.id_worker,  statement.id, statement.name
FROM	Workers, statement;

--Соединение таблиц по равенству

SELECT Workers.name, train_crew.number    FROM	Workers, train_crew
WHERE Workers.id_worker = train_crew.id_workeres;


--СOUNT/SUM/UPPER/LOWER
Select count(*) AS 'Количество рабочих'
From Workers

Select SUM(experience)
From Workers

SELECT UPPER(name) AS 'Большие буквы'
From Workers;

SELECT LOWER(Surname) AS 'Маленькие буквы'
From Workers;


--Группировки по одному столбцу
SELECT City AS 'Город',
count(*) AS "K-вo workers" FROM Workers
GROUP BY City;


--HAVING

select sum(q_tickets) from statement
having sum(q_tickets) < 10
-- сортировкa по столбцу
Select *
FROM Workers
Order BY name DESC;



--обновление существующих данных в таблице
UPDATE Workers
SET name = 'David' WHERE Surname ='Radionov';

UPDATE statement
SET name = 'Oleg' WHERE data = '05.07.2022';


