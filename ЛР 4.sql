
#1 запрос для создания временной таблицы через переменную типа TABLE
DECLARE @Driver TABLE (id INT, name varchar(255))
insert into @Driver (id,name) values (1,'Петр Иванов')
insert into @Driver (id,name) values (2,'Иван Иванов')
INSERT INTO @Driver(id, name) VALUES (3,'Игорь Троцкий') 
SELECT * FROM @Driver

#2 запроса с использованием условной конструкции IF
DECLARE @volume_name INT 
DECLARE @name VARCHAR(255)
SET @volume_name = (SELECT COUNT(*) FROM Работники) 
IF @volume_name >10
BEGIN
SET @name = 'Количество работников больше 10'
SELECT @name
END ELSE BEGIN
SET @name = 'Количество работников = ' + str(@volume_name)
SELECT @name
END


DECLARE @count INT
DECLARE @brigada VARCHAR(255)
SET @count =(SELECT COUNT(*) FROM Бригады)
IF @count >3
BEGIN
SET  @brigada='Количество бригад больше 3'
SELECT  @brigada
END ELSE BEGIN
SET  @brigada ='Количество бригад =' + str(@count) 
SELECT  @brigada
END

#2 запроса с использованием цикла WHILE
DECLARE @a INT SET @a = 1 WHILE @a <50
BEGIN
PRINT @a 
iF (@a>30) AND (@a<40)
BREAK --выход и выполнение 1-й команды за циклом
ELSE
SET @a = @a+rand()*10 
CONTINUE
END
 PRINT @a


 DECLARE @b INT SET @b = 1 WHILE @b <60
BEGIN
PRINT @b
iF (@b>35) AND (@b<40)
BREAK --выход и выполнение 1-й команды за циклом
ELSE
SET @b = @b+rand()*10 
CONTINUE
END
 PRINT @b

#1 запрос для создания скалярной функции
IF OBJECT_ID (N'dbo.ISOweek', N'FN') IS NOT NULL 
DROP FUNCTION dbo.ISOweek;
go
CREATE FUNCTION dbo.ISOweek (@DATE date) RETURNS CHAR(15)
WITH EXECUTE AS CALLER AS
BEGIN
DECLARE @man int; 
DECLARE @ISOweek char(15); 
SET @man= DAY(@DATE)

IF (@man=1) SET @ISOweek='Январь'; 
IF (@man=2) SET @ISOweek='Февраль';
IF (@man=3) SET @ISOweek='Март';
IF (@man=4) SET @ISOweek='Апрель'; 
IF (@man=5) SET @ISOweek='Май';
IF (@man=6) SET @ISOweek='Июнь'; 
IF (@man=7) SET @ISOweek='Июль';
IF (@man=8) SET @ISOweek='Август';
IF (@man=9) SET @ISOweek='Сентябрь'; 
IF (@man=10) SET @ISOweek='Октябрь'; 
IF (@man=11) SET @ISOweek='Ноябрь';
IF (@man=12) SET @ISOweek='Декабрь';

RETURN(@ISOweek); 
END;
GO
SET DATEFIRST 1;
SELECT dbo.ISOweek('12.04.2004') AS 'Месяц';

#1 запрос для создания функции, которая возвращает табличное значение;

IF OBJECT_ID (N'dbo.Staj', N'IF') IS NOT NULL 
DROP FUNCTION dbo.Staj;
go
CREATE FUNCTION Staj (@s int)
RETURNS TABLE  
AS  
RETURN  
    SELECT Фамилия, Стаж  
    FROM Работники  
    WHERE [Год рождения] > @s

	go
select * from dbo.Staj(19)


#2 запроса для создания процедуры без параметров
go
CREATE PROCEDURE Count_Бригад 
AS
Select count([Номер бригады]) from Бригады
where [Номер бригады]=2 
Go
execute Count_Бригад
DROP PROCEDURE Count_Бригад

go
create procedure Count_sex
 as 
 select count (Пол) from Работники
 where Пол='мужской'
 go
 execute Count_sex
 DROP PROCEDURE Count_sex


#1 запроса для создания процедуры c входным параметром
go
CREATE PROCEDURE Count_Работников @staj as Int
AS
Select count(Фамилия) from Работники
WHERE Пол='мужской' and Стаж>=@staj
Go
exec Count_Работников 13
 DROP PROCEDURE Count_Работников


#2 запроса для создания процедуры c входными параметрами и RETURN
go
CREATE PROCEDURE check_Должность @param int AS
IF (SELECT Должность FROM Работники WHERE id = @param)
= 'Диспетчер'
RETURN 1 ELSE RETURN 2

go
DECLARE @return_status int
EXECUTE @return_status = check_Должность 2 SELECT 'Return Status' = @return_status 
 DROP PROCEDURE check_Должность

#1 запроса для создания процедуры обновления данных в таблице базы данных
go
CREATE PROCEDURE update_city AS
UPDATE Работники SET Город = 'Минск'
go
exec update_city
 DROP PROCEDURE update_city




#1 запроса для создания процедуры извлечения данных из таблиц базы данных
go
CREATE PROCEDURE select_Работника @h VARCHAR(255) AS
SELECT * FROM Работники WHERE Фамилия=@h
go
EXEC select_Работника @h='Котухов'
 DROP PROCEDURE select_Работника


 go
 CREATE FUNCTION Calculator (@Opd1 bigint,
@Opd2 bigint,
@Oprt char(1) = '*') RETURNS bigint
AS BEGIN
DECLARE @Result bigint SET @Result =
CASE @Oprt
WHEN '+' THEN @Opd1 + @Opd2 WHEN '-' THEN @Opd1 - @Opd2 
WHEN '*' THEN @Opd1 * @Opd2 WHEN '/' THEN @Opd1 / @Opd2
WHEN '/' THEN @Opd2
WHEN '^' THEN POWER (@Opd1, @Opd2) ELSE 0
END
Return @Result END
go
SELECT dbo.Calculator(4,5,'+' ),
dbo.Calculator(3, power(7,2), '*'), dbo.Calculator(64,4,'/')*2.9-11, dbo.Calculator(7, 2, '^')
DROP FUNCTION dbo.Calculator;


go
CREATE FUNCTION DYNTAB (@Sex varchar(255))
RETURNS Table AS
RETURN SELECT id,Стаж,Фамилия FROM Работники WHERE Пол = @Sex
go
SELECT * FROM DYNTAB ('мужской')
DROP FUNCTION dbo.DYNTAB;


go
CREATE FUNCTION Parse (@String varchar (255))
RETURNS @tabl TABLE
(Number int IDENTITY (1,1) NOT NULL,
Substr varchar (30)) AS
BEGIN
DECLARE @Str1 varchar (500), @Pos int SET @Str1 = @String
WHILE 1>0 BEGIN
SET @Pos = CHARINDEX('', @Str1) IF @POS>0
BEGIN
INSERT INTO @tabl
VALUES (SUBSTRING (@Str1,1,@Pos)) END
ELSE BEGIN
INSERT INTO @tabl VALUES (@Str1) BREAK
END END RETURN END
go
DECLARE @TestString varchar (255)
Set @TestString = 'SQL Server 2019' SELECT * FROM Parse (@TestString)

DROP FUNCTION dbo.Parse;
