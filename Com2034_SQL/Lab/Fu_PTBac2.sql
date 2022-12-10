
CREATE FUNCTION fuPhuongTrinhBac2
(
      @a decimal(18,2),
      @b decimal(18,2),
      @c decimal(18,2)
)
RETURNS nvarchar(2000)
AS
BEGIN
      DECLARE @delta decimal(18,2)
      SET @delta=0.00
      DECLARE @Result nvarchar(2000)
      SET @Result=''
      IF @a=0
            SET @Result=N'Phương trình không phải bậc 2'
      ELSE
      BEGIN
           SET @delta=@b*@b-4*@a*@c
           IF @delta>0
           BEGIN
                SET @Result=@Result+ N'Phương trình có 2 nghiệm:
                x1='+ Cast(((-@b)+SQRT(@delta))/(2*@a) AS nvarchar(300))+';'
                SET @Result=@Result+ N'
                x2='+ Cast(((-@b)-SQRT(@delta))/(2*@a) AS nvarchar(300))+''
           END
           IF @delta=0
           BEGIN
                SET @Result=@Result+ N'Phương trình có nghiệm kép
                x ='+ Cast( ((-@b)/(2*@a)) AS nvarchar(300))+';'
           END
           IF @delta<0
               SET @Result=@Result+ N'Phương trình vô nghiệm'
            END
      RETURN @Result
END

SELECT dbo.fuPhuongTrinhBac2 (1,4,-3) AS PTB2  
--Phương trình có 2 nghiệm: x1=0.645751; x2=-4.64575
SELECT dbo.fuPhuongTrinhBac2 (1,2,-3) AS PTB2  
-- Phương trình có 2 nghiệm: x1=1; x2=-3
SELECT dbo.fuPhuongTrinhBac2 (1,4,0) AS PTB2   
-- Phương trình có 2 nghiệm: x1=0; x2=-4

