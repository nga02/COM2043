CREATE PROC SP_TONG1  @So1 INT, @So2 INT
AS 
BEGIN
	DECLARE @Tong INT;
	SET @Tong = @So1 + @So2;
	PRINT @Tong
END