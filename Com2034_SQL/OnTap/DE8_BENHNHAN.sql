﻿CREATE DATABASE DE8_BENHNHAN

IF OBJECT_ID('BENHNHAN') IS NOT NULL
DROP TABLE BENHNHAN
GO 
CREATE TABLE BENHNHAN
(
	MaBN VARCHAR(10) PRIMARY KEY,
	HoTenBN NVARCHAR(50),
	GioiTinh VARCHAR(5),
	NSinh DATE, 
	DChi NVARCHAR(200)
)
IF OBJECT_ID('BACSI') IS NOT NULL 
DROP TABLE BACSI
GO
CREATE TABLE BACSI
(
	MaBS VARCHAR(10) PRIMARY KEY,
	HoTenBS NVARCHAR(50),
	ChuyenKhoa VARCHAR(10), 
	SoDienThoai VARCHAR(15)
)

IF OBJECT_ID('DIEUTRI') IS NOT NULL 
DROP TABLE DIEUTRI
GO 
CREATE TABLE DIEUTRI
(
	MaBN VARCHAR(10),
	MaBS VARCHAR(10),
	NgayDieuTri DATE,
	NgayKhoi DATE,
	PRIMARY KEY(MaBN,MaBS),
	FOREIGN KEY (MaBN) REFERENCES BENHNHAN,
	FOREIGN KEY (MaBS) REFERENCES BACSI
)

--CÂU2:
IF OBJECT_ID('sp_BENHNHAN ') IS NOT NULL
DROP PROC sp_BENHNHAN   
GO 
CREATE PROC sp_BENHNHAN 
	@MaBN VARCHAR(10),
	@HoTenBN NVARCHAR(50),
	@GioiTinh VARCHAR(5),
	@NSinh DATE, 
	@DChi NVARCHAR(200)
AS
BEGIN
	IF(@MaBN IS NULL OR @HoTenBN IS NULL OR @GioiTinh IS NULL OR @NSinh IS NULL OR @DChi IS NULL)
		PRINT N'CẦN ĐIỀN ĐẦY ĐỦ THÔNG TIN'
	ELSE IF EXISTS(SELECT * FROM BENHNHAN WHERE MaBN =@MaBN)
		PRINT N'TRÙNG KHOÁ CHÍNH'
	ELSE 
		BEGIN
			INSERT INTO BENHNHAN VALUES (@MaBN,@HoTenBN,@GioiTinh, @NSinh,@DChi)
		END
END 

EXEC sp_BENHNHAN 'N01',N'NGUYỄN VĂN A',N'NAM','1998/03/15',N'THANH XUÂN'
EXEC sp_BENHNHAN 'N02',N'HOÀNG MAI P',N'NỮ','1996/04/16',N'ĐỐNG ĐA'
EXEC sp_BENHNHAN 'N03',N'HÀ KIỀU OANH',N'NỮ','1997/05/17',N'CẦU GIẤY'


-------BẢNG BACSI------------
IF OBJECT_ID('sp_BACSI') IS NOT NULL 
DROP PROC sp_BACSI
GO
CREATE PROC sp_BACSI
	@MaBS VARCHAR(10),
	@HoTenBS NVARCHAR(50),
	@ChuyenKhoa VARCHAR(10), 
	@SoDienThoai VARCHAR(15)
AS
BEGIN
	IF(@MaBS IS NULL OR @HoTenBS IS NULL OR @ChuyenKhoa IS NULL OR @SoDienThoai IS NULL)
		PRINT N'CẦN ĐIỀN ĐẦY ĐỦ THÔNG TIN'
	ELSE IF EXISTS(SELECT * FROM BACSI WHERE MaBS =@MaBS)
		PRINT N'TRÙNG KHOÁ CHÍNH'
	ELSE 
		BEGIN
			INSERT INTO BACSI VALUES (@MaBS,@HoTenBS,@ChuyenKhoa,@SoDienThoai)
		END
END

EXEC sp_BACSI '001',N'LÊ THỊ NGA',N'NỘI', '03465767843'
EXEC sp_BACSI '002',N'LÊ THANH HƯNG',N'NGOẠI', '0456789876'
EXEC sp_BACSI '003',N'LÊ MINH THƯ',N'RĂNG HÀM MẶT', '0546789765'

-------BẢNG DIEUTRI---------
IF OBJECT_ID('sp_DIEUTRI') IS NOT NULL 
DROP PROC sp_DIEUTRI
GO 
CREATE PROC sp_DIEUTRI
	@MaBN VARCHAR(10),
	@MaBS VARCHAR(10),
	@NgayDieuTri DATE,
	@NgayKhoi DATE
AS
BEGIN
	IF(@MaBN IS NULL OR @MaBS IS NULL OR @NgayDieuTri IS NULL OR @NgayKhoi IS NULL)
		PRINT N'CẦN ĐIỀN ĐẦY ĐỦ THÔNG TIN'
	ELSE 
		BEGIN
			INSERT INTO DIEUTRI VALUES (@MaBN,@MaBS,@NgayDieuTri, @NgayKhoi)
		END
END

EXEC sp_DIEUTRI  'N01','002','2021/05/06','2021/06/06'
EXEC sp_DIEUTRI  'N02','003','2021/04/25','2021/05/14'
EXEC sp_DIEUTRI  'N03','001','2021/05/13','2021/05/28'

SELECT * FROM BENHNHAN
SELECT * FROM BACSI
SELECT * FROM DIEUTRI

--BÀI 3:
/*Viết hàm các tham số đầu vào tương ứng với các cột của
bảng BENHNHAN. Hàm này trả
về MaBN thỏa mãn các giá trị được truyền tham số*/
IF OBJECT_ID('f_MaBN') IS NOT NULL
DROP FUNCTION f_MaBN   
GO 
CREATE FUNCTION f_MaBN
(@HoTenBN NVARCHAR(50),@GioiTinh VARCHAR(5),@NSinh DATE, @DChi NVARCHAR(200)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM BENHNHAN WHERE @HoTenBN =HoTenBN AND @GioiTinh=GioiTinh AND  @NSinh=NSinh AND @DChi=DChi)
		RETURN N'KHÔNG TỒN TẠI BỆNH NHÂN NÀY'

		RETURN N'MÃ BỆNH NHÂN LÀ:' + CAST((SELECT MaBN FROM BENHNHAN WHERE @HoTenBN =HoTenBN 
		AND @GioiTinh=GioiTinh AND  @NSinh=NSinh AND @DChi=DChi) AS VARCHAR(10))
END

PRINT dbo.f_MaBN (N'NGUYỄN VĂN A',N'NAM','1998/03/15',N'THANH XUÂN')

----CÂU 4;
IF OBJECT_ID('vi_TOP2') IS NOT NULL 
DROP VIEW vi_TOP2
GO 
CREATE VIEW vi_TOP2
AS
	SELECT TOP 2 BENHNHAN.MaBN, HoTenBN, NgayDieuTri, HoTenBS, ChuyenKhoa, SoDienThoai,NgayKhoi
	FROM BENHNHAN JOIN DIEUTRI ON DIEUTRI.MaBN=BENHNHAN.MaBN
				JOIN BACSI ON BACSI.MaBS=DIEUTRI.MaBS
	ORDER BY NgayKhoi DESC

SELECT * FROM vi_TOP2 

---CÂU 5;
IF OBJECT_ID('sp_Xoa') IS NOT NULL 
DROP PROC  sp_Xoa
GO
CREATE PROC sp_Xoa @NgayKhoi DATE
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @Table TABLE(MaBS VARCHAR(10),MaBN VARCHAR(10))
			INSERT INTO @Table SELECT MaBS,MaBN FROM DIEUTRI WHERE @NgayKhoi=NgayKhoi

			DELETE FROM DIEUTRI WHERE MaBS IN(SELECT MaBS FROM @Table)
									OR MaBN IN(SELECT MaBN FROM @Table)
			DELETE FROM BACSI WHERE MaBS IN(SELECT MaBS FROM @Table)
			DELETE FROM BENHNHAN WHERE MaBN IN(SELECT MaBN FROM @Table)
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END

EXEC dbo.sp_Xoa '2021/05/14'

SELECT * FROM DIEUTRI

