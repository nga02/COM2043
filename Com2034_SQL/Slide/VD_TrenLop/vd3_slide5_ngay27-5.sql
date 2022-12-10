---THỰC THI THỦ TỤC
DECLARE @tongso Int
EXEC @tongso = DemNv 'TP HCM'
SELECT @tongso
GO

---HIỂN THỊ NHANVIEN CÓ DCHI Ở TP.HCM
SELECT * FROM NHANVIEN WHERE DCHI LIKE N'%TP HCM'

--Truy xuất thông tin nhân viên theo Mã nhân viên


exec sp_ThongtinNV '005'

--Demo
--Viết store procedure nhận vào tham số là năm sinh, xuất ra tên các nhân viên
CREATE PROC sp_NamSinh
				@namsinh INT
			AS
			BEGIN
				SELECT * FROM dbo.NHANVIEN
					WHERE DATENAME(YEAR, NGSINH) = @namsinh
			END;

	select * from NHANVIEN
	EXEC sp_NamSinh 1967
--Viết store procedure đếm số lượng thân nhân của nhân viên có mã nhân viên được nhập từ người dùng
CREATE PROC sp_SLNhanthan
				@manv NVARCHAR(9)
			AS
			BEGIN
				SELECT MA_NVIEN, COUNT(MA_NVIEN) AS N'Số lượng' FROM dbo.THANNHAN
				WHERE MA_NVIEN = @manv
				GROUP BY MA_NVIEN
			END;
	exec dbo.sp_SLNhanthan '005'
	select*from THANNHAN

---lệnh điều kiện trong store procedure

/*Viết store proceducre nhập vào một số nguyên @n,
In ra tổng và số lượng các số chẵn từ 1 đến @n*/

CREATE PROC sp_TongChan
 @N INT 
 AS 
 BEGIN 
 --khai báo
	DECLARE @sum int, @count int, @i int;
	--gán
	set @sum=0;
	set @count=0;
---xét đki while
	WHILE @i <= @n
	BEGIN 
		IF @i % 2 = 0
		BEGIN 
			SET @sum = @sum + @i;
			SET @count=@count+1;
		END
		SET @i=@i+1;
	END
	PRINT N'TỔNG CÁC SỐ CHẴN LÀ: ' + CAST(@sum AS VARCHAR);
	PRINT N'ĐẾM CÁC SỐ CHẴN LÀ: ' + CAST(@count AS VARCHAR);
END;
 EXEC dbo.sp_TongChan 2003

CREATE PROC sp_TongLe
 @n INT 
 AS 
 BEGIN 
 --khai báo
	DECLARE @sum int, @count int, @i int;
	--gán
	set @sum=0;
	set @count=0;
---xét đki while
	WHILE @i <= @n
	BEGIN 
		IF @i % 2 != 0
		BEGIN 
			SET @sum = @sum + @i;
			SET @count=@count+1;
		END
		SET @i=@i+1;
	END
	PRINT N'TỔNG CÁC SỐ LẺ LÀ: ' + CAST(@sum AS VARCHAR);
	PRINT N'ĐẾM CÁC SỐ LE LÀ: ' + CAST(@count AS VARCHAR);
END;

