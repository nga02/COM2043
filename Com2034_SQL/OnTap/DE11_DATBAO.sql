﻿CREATE DATABASE DE011_DATBAO


------2Them thong tin
--BẢNG BAO
IF OBJECT_ID('insert_BAO') IS NOT NULL
	DROP PROC insert_BAO
GO
CREATE PROC insert_BAO
		@MATOBAO varchar(10),
		@TENBAO nvarchar(50),
		@DIACHI nvarchar(200)
AS
 BEGIN 
	IF(@MATOBAO IS NULL OR @TENBAO IS NULL OR @DIACHI IS NULL )
		PRINT N'Khong duoc de trong'
	 ELSE IF EXISTS(SELECT * FROM BAO WHERE MATOBAO=@MATOBAO)--KIỂM TRA KHOÁ CHÍNH
		PRINT N'MÃ NHÀ TRỌ ĐÃ TỒN TẠI'
	 ELSE
		BEGIN 
			INSERT INTO BAO  VALUES(@MATOBAO,@TENBAO,@DIACHI) 
		END
 END 

 EXEC insert_BAO 'LT1',N'BÁO NHÂN DÂN ',N'QUẬN 1'
 EXEC insert_BAO 'LT2',N'BÁO KINH TẾ', N' QUẬN 5'
 EXEC insert_BAO 'LT3',N'BÁO LAO ĐỘNG', N' QUẬN 4'


 -----------BẢNG DOCGIA
IF OBJECT_ID('insert_DOCGIA') IS NOT NULL
	DROP PROC insert_DOCGIA
GO
CREATE PROC insert_DOCGIA
	@MADG VARCHAR(10),
	@HOTEN NVARCHAR(50),
	@NGAYSINH DATE,
	@GIOITINH VARCHAR(5),
	@DCHI NVARCHAR(200)
AS
BEGIN 
	IF(@MADG IS NULL OR @HOTEN IS NULL OR @NGAYSINH IS NULL OR @GIOITINH IS NULL OR @DCHI IS NULL )
			PRINT N'THIẾU THÔNG TIN ĐẦU VÀO'
	ELSE IF EXISTS (SELECT * FROM DOCGIA WHERE MADG=@MADG)
			PRINT N'MÃ ĐỘC GIẢ ĐÃ TỒN TẠI'
	ELSE
		BEGIN 
			INSERT INTO DOCGIA VALUES (@MADG , @HOTEN, @NGAYSINH, @GIOITINH, @DCHI)
		END	
END

EXEC insert_DOCGIA '001',N'LÊ THỊ NGA','2003/04/20',N'NỮ',N'HÀ NỘI'
EXEC insert_DOCGIA '002',N'HÀ THỊ THUỶ','1999/05/15',N'NỮ',N'ĐÀ NẴNG'
EXEC insert_DOCGIA '003',N'HÀ MINH HIẾU','1998/09/25',N'NAM',N'ĐỒNG NAI'

-----BẢNG DATMUA
IF OBJECT_ID('insert_DATMUA') IS NOT NULL
	DROP PROC insert_DATMUA
GO
CREATE PROC insert_DATMUA
		@MADG VARCHAR(10),
		@MATOBAO VARCHAR(10),
		@QUY INT,
		@NAM INT,
		@SOLUONG INT,
		@DONGIA FLOAT
AS
BEGIN
		IF(	@MADG IS NULL OR @MATOBAO IS NULL OR @QUY IS NULL OR @NAM IS NULL OR @SOLUONG IS NULL OR @DONGIA IS NULL )
				PRINT N'PHẢI NHẬP ĐỦ THÔNG TIN'
		ELSE IF EXISTS(SELECT * FROM DATMUA WHERE MADG=@MADG AND MATOBAO=@MATOBAO)
				PRINT N'KHÔNG TRÙNG KHỚP THÔNG TIN'
		ELSE
			BEGIN 
				INSERT INTO DATMUA VALUES (@MADG, @MATOBAO, @QUY,@NAM,@SOLUONG, @DONGIA)
			END 
		
END
GO

EXEC insert_DATMUA '001','LT3',1,2022,20,500
EXEC insert_DATMUA '002','LT1',3,2020,30,800
EXEC insert_DATMUA '003','LT2',2,20219,35,1000


SELECT * FROM BAO
SELECT * FROM DOCGIA
SELECT * FROM DATMUA


/*3.Viết hàm các tham số đầu vào tương ứng với các cột của bảng Docgia.
Hàm này trả về mã độc giả (giá trị của cột khóa chính của bảng Docgia) 
thỏa mãn các giá trị được truyền tham số*/
IF OBJECT_ID ('f_DocGia') IS NOT NULL
	DROP FUNCTION f_DocGia 
GO
CREATE FUNCTION f_DocGia 
	(
		@HOTEN NVARCHAR(50),
		@NGAYSINH DATE  ,
		@GIOITINH VARCHAR(5),
		@DCHI NVARCHAR(200)		
	)
RETURNS NVARCHAR(100)
AS 	
BEGIN
	IF(@HOTEN IS NULL OR @NGAYSINH IS NULL OR @DCHI IS NULL)
		RETURN N'KHÔNG KHỚP DỮ LIỆU'
		
		RETURN N'Mã độc giả là:'+ CAST((SELECT MADG FROM DOCGIA 
										WHERE  HOTEN=@HOTEN AND NGAYSINH=@NGAYSINH AND DCHI=@DCHI) 
										AS VARCHAR(10))				
END	
PRINT dbo.f_DocGia (N'LÊ THỊ NGA','2003/04/20',N'NỮ',N'HÀ NỘI')

/*-4.Tạo View lưu thông tin của TOP 2 độc giả có số lượng báo lớn nhất
gồm: Madg, Hoten, Tenbao, soluong.*/
IF OBJECT_ID ('vi_Top2') IS NOT NULL
	DROP VIEW vi_Top2 
GO
CREATE VIEW vi_Top2
AS
	SELECT TOP 2 DOCGIA.MADG,HOTEN,TENBAO,SOLUONG 
	FROM DOCGIA JOIN DATMUA ON DATMUA.MADG = DOCGIA.MADG
				JOIN BAO ON DATMUA.MATOBAO=BAO.MATOBAO
	ORDER BY SOLUONG DESC
SELECT * FROM vi_Top2

/*5.Viết một SP nhận hai tham số đầu vào là khoảng thời gian đặt mua
báo. SP này thực hiện thao tác XOÁ thông tin những tờ báo được 
đăng trong khoảng thời gian được truyền vào qua các tham số.*/
IF OBJECT_ID('sp_Xoa') IS NOT NULL 
DROP PROC sp_Xoa
GO 
CREATE PROC sp_Xoa @Min INT , @Max INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRAN
			DECLARE @Table TABLE(MATOBAO VARCHAR(10))
			INSERT INTO @Table SELECT BAO.MATOBAO FROM BAO JOIN DATMUA ON DATMUA.MATOBAO=BAO.MATOBAO
			WHERE NAM BETWEEN @Min AND @Max

			DELETE FROM DATMUA WHERE MATOBAO IN(SELECT MATOBAO FROM @Table)
			DELETE FROM BAO WHERE MATOBAO IN(SELECT MATOBAO FROM @Table)
		COMMIT TRAN 
	END TRY 
	BEGIN CATCH 
		ROLLBACK TRAN 
	END CATCH 
END  

EXEC sp_Xoa 2021,2023

SELECT * FROM DATMUA
