
#1 ������ ��� �������� ��������� ������� ����� ���������� ���� TABLE
DECLARE @Driver TABLE (id INT, name varchar(255))
insert into @Driver (id,name) values (1,'���� ������')
insert into @Driver (id,name) values (2,'���� ������')
INSERT INTO @Driver(id, name) VALUES (3,'����� �������') 
SELECT * FROM @Driver

#2 ������� � �������������� �������� ����������� IF
DECLARE @volume_name INT 
DECLARE @name VARCHAR(255)
SET @volume_name = (SELECT COUNT(*) FROM ���������) 
IF @volume_name >10
BEGIN
SET @name = '���������� ���������� ������ 10'
SELECT @name
END ELSE BEGIN
SET @name = '���������� ���������� = ' + str(@volume_name)
SELECT @name
END


DECLARE @count INT
DECLARE @brigada VARCHAR(255)
SET @count =(SELECT COUNT(*) FROM �������)
IF @count >3
BEGIN
SET  @brigada='���������� ������ ������ 3'
SELECT  @brigada
END ELSE BEGIN
SET  @brigada ='���������� ������ =' + str(@count) 
SELECT  @brigada
END

#2 ������� � �������������� ����� WHILE
DECLARE @a INT SET @a = 1 WHILE @a <50
BEGIN
PRINT @a 
iF (@a>30) AND (@a<40)
BREAK --����� � ���������� 1-� ������� �� ������
ELSE
SET @a = @a+rand()*10 
CONTINUE
END
 PRINT @a


 DECLARE @b INT SET @b = 1 WHILE @b <60
BEGIN
PRINT @b
iF (@b>35) AND (@b<40)
BREAK --����� � ���������� 1-� ������� �� ������
ELSE
SET @b = @b+rand()*10 
CONTINUE
END
 PRINT @b

#1 ������ ��� �������� ��������� �������
IF OBJECT_ID (N'dbo.ISOweek', N'FN') IS NOT NULL 
DROP FUNCTION dbo.ISOweek;
go
CREATE FUNCTION dbo.ISOweek (@DATE date) RETURNS CHAR(15)
WITH EXECUTE AS CALLER AS
BEGIN
DECLARE @man int; 
DECLARE @ISOweek char(15); 
SET @man= DAY(@DATE)

IF (@man=1) SET @ISOweek='������'; 
IF (@man=2) SET @ISOweek='�������';
IF (@man=3) SET @ISOweek='����';
IF (@man=4) SET @ISOweek='������'; 
IF (@man=5) SET @ISOweek='���';
IF (@man=6) SET @ISOweek='����'; 
IF (@man=7) SET @ISOweek='����';
IF (@man=8) SET @ISOweek='������';
IF (@man=9) SET @ISOweek='��������'; 
IF (@man=10) SET @ISOweek='�������'; 
IF (@man=11) SET @ISOweek='������';
IF (@man=12) SET @ISOweek='�������';

RETURN(@ISOweek); 
END;
GO
SET DATEFIRST 1;
SELECT dbo.ISOweek('12.04.2004') AS '�����';

#1 ������ ��� �������� �������, ������� ���������� ��������� ��������;

IF OBJECT_ID (N'dbo.Staj', N'IF') IS NOT NULL 
DROP FUNCTION dbo.Staj;
go
CREATE FUNCTION Staj (@s int)
RETURNS TABLE  
AS  
RETURN  
    SELECT �������, ����  
    FROM ���������  
    WHERE [��� ��������] > @s

	go
select * from dbo.Staj(19)


#2 ������� ��� �������� ��������� ��� ����������
go
CREATE PROCEDURE Count_������ 
AS
Select count([����� �������]) from �������
where [����� �������]=2 
Go
execute Count_������
DROP PROCEDURE Count_������

go
create procedure Count_sex
 as 
 select count (���) from ���������
 where ���='�������'
 go
 execute Count_sex
 DROP PROCEDURE Count_sex


#1 ������� ��� �������� ��������� c ������� ����������
go
CREATE PROCEDURE Count_���������� @staj as Int
AS
Select count(�������) from ���������
WHERE ���='�������' and ����>=@staj
Go
exec Count_���������� 13
 DROP PROCEDURE Count_����������


#2 ������� ��� �������� ��������� c �������� ����������� � RETURN
go
CREATE PROCEDURE check_��������� @param int AS
IF (SELECT ��������� FROM ��������� WHERE id = @param)
= '���������'
RETURN 1 ELSE RETURN 2

go
DECLARE @return_status int
EXECUTE @return_status = check_��������� 2 SELECT 'Return Status' = @return_status 
 DROP PROCEDURE check_���������

#1 ������� ��� �������� ��������� ���������� ������ � ������� ���� ������
go
CREATE PROCEDURE update_city AS
UPDATE ��������� SET ����� = '�����'
go
exec update_city
 DROP PROCEDURE update_city




#1 ������� ��� �������� ��������� ���������� ������ �� ������ ���� ������
go
CREATE PROCEDURE select_��������� @h VARCHAR(255) AS
SELECT * FROM ��������� WHERE �������=@h
go
EXEC select_��������� @h='�������'
 DROP PROCEDURE select_���������


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
RETURN SELECT id,����,������� FROM ��������� WHERE ��� = @Sex
go
SELECT * FROM DYNTAB ('�������')
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
