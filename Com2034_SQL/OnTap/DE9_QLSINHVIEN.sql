﻿CREATE DATABASE DE9_QLSV

IF OBJECT_ID('SINHVIEN') IS NOT NULL
DROP TABLE SINHVIEN
GO 
CREATE TABLE SINHVIEN
(
	MaSV VARCHAR(5) PRIMARY KEY, 
	HoTen NVARCHAR(50), 
	NgaySinh DATE, 
	GioiTinh VARCHAR(5), 
	Lop VARCHAR(20)
)
------------------------------------
IF OBJECT_ID('MONHOC') IS NOT NULL
DROP TABLE MONHOC
GO 
CREATE TABLE MONHOC
(
	MaMonHoc VARCHAR(5) PRIMARY KEY, 
	TenMonHoc NVARCHAR(50), 
	SoTinChi INT
)

IF OBJECT_ID('DIEM') IS NOT NULL
DROP TABLE DIEM
GO 
CREATE TABLE DIEM
(
	MaSV VARCHAR(5), 
	MaMonHoc VARCHAR(5),
	DiemLan1 FLOAT,
	DiemLan2 FLOAT,
	PRIMARY KEY(MaSV,MaMonHoc),
	FOREIGN KEY (MaSV) REFERENCES  SINHVIEN,
	FOREIGN KEY (MaMonHoc) REFERENCES MONHOC
)
---------bài 2:
---bảng SINHVIEN
IF OBJECT_ID('sp_SINHVIEN') IS NOT NULL
DROP PROC sp_SINHVIEN
GO 
CREATE PROC sp_SINHVIEN
	@MaSV VARCHAR(5), 
	@HoTen NVARCHAR(50), 
	@NgaySinh DATE, 
	@GioiTinh VARCHAR(5), 
	@Lop VARCHAR(20)
AS
BEGIN
	IF(@MaSV IS NULL OR  @HoTen IS NULL OR @NgaySinh IS NULL OR @GioiTinh IS NULL OR @Lop IS NULL )
		PRINT N'THIẾU THÔNG TIN  ĐẦU VÀO'
	ELSE IF EXISTS (SELECT * FROM SINHVIEN WHERE @MaSV=MaSV)
		PRINT N'TRÙNG KHOÁ CHÍNH'
	ELSE 
		BEGIN
			INSERT INTO SINHVIEN VALUES(@MaSV,@HoTen,@NgaySinh,@GioiTinh, @Lop)	
		END
END
------------
--Bảng MONHOC
IF OBJECT_ID('sp_MONHOC') IS NOT NULL
DROP PROC sp_MONHOC
GO 
CREATE PROC sp_MONHOC
	@MaMonHoc VARCHAR(5), 
	@TenMonHoc NVARCHAR(50), 
	@SoTinChi INT
AS
BEGIN
	IF(@MaMonHoc IS NULL OR  @TenMonHoc IS NULL OR @SoTinChi IS NULL )
		PRINT N'THIẾU THÔNG TIN  ĐẦU VÀO'
	ELSE IF EXISTS (SELECT * FROM MONHOC WHERE @MaMonHoc=MaMonHoc)
		PRINT N'TRÙNG KHOÁ CHÍNH'
	ELSE 
		BEGIN
			INSERT INTO MONHOC VALUES(@MaMonHoc,@TenMonHoc,@SoTinChi)	
		END
END
----------------------\
---BẢNG DIEM
IF OBJECT_ID('sp_DIEM') IS NOT NULL
DROP PROC sp_DIEM
GO 
CREATE PROC sp_DIEM
	@MaSV VARCHAR(5), 
	@MaMonHoc VARCHAR(5),
	@DiemLan1 FLOAT,
	@DiemLan2 FLOAT
AS
BEGIN
	IF(@MaSV IS NULL OR  @MaMonHoc IS NULL OR @DiemLan1 IS NULL OR @DiemLan2 IS NULL)
		PRINT N'THIẾU THÔNG TIN  ĐẦU VÀO'
	ELSE 
		BEGIN
			INSERT INTO DIEM VALUES(@MaSV,@MaMonHoc ,@DiemLan1,@DiemLan2)	
		END
END

EXEC sp_SINHVIEN 'N01',N'LÊ THỊ NGA','2003/04/20',N'NỮ',N'LỚP 1'
EXEC sp_SINHVIEN 'N02',N'LÊ THỊ MAI','2003/05/21',N'NỮ',N'LỚP 2'
EXEC sp_SINHVIEN 'N03',N'LÊ THỊ NAM','2003/06/22',N'NAM',N'LỚP 3'

EXEC sp_MONHOC '001',N'SQL',3
EXEC sp_MONHOC '002',N'JAVA',4
EXEC sp_MONHOC '003',N'WEB',5

EXEC sp_DIEM 'N01','002',8.5,9
EXEC sp_DIEM 'N02','003',8,7
EXEC sp_DIEM 'N03','001',6.5,8.5

SELECT * FROM SINHVIEN
SELECT * FROM MONHOC
SELECT * FROM DIEM


--CÂU 3:
/*Viết hàm các tham số đầu vào tương ứng với các cột của bảng 
Sinhvien. Hàm này trả về
mã sinh viên, thỏa mãn các giá trị được truyền tham số.*/
IF OBJECT_ID('f_MaSV') IS NOT NULL
DROP FUNCTION f_MaSV
GO 
CREATE FUNCTION f_MaSV
(
	@HoTen NVARCHAR(50), 
	@NgaySinh DATE, 
	@GioiTinh VARCHAR(5), 
	@Lop VARCHAR(20)
	
)
RETURNS NVARCHAR(100)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM SINHVIEN WHERE @HoTen =HoTen AND @NgaySinh =NgaySinh AND @GioiTinh=GioiTinh AND @Lop =Lop)
		RETURN N'KHÔNG TÌM THẤY SV NÀO NÀO'
		
		RETURN N'MÃ SV LÀ:' + CAST((SELECT MaSV FROM SINHVIEN 
		WHERE @HoTen =HoTen AND @NgaySinh =NgaySinh AND @GioiTinh=GioiTinh AND @Lop =Lop) 
		AS VARCHAR(10))
END

PRINT dbo.f_MaSV (N'LÊ THỊ NAM','2003/06/22',N'NAM',N'LỚP 3')

---Câu 4:View
IF OBJECT_ID('vi_Top2') IS NOT NULL
DROP VIEW vi_Top2
GO 
CREATE VIEW vi_Top2
AS
	SELECT TOP 2 SINHVIEN.MaSV, HoTen,MONHOC.TenMonHoc, DiemLan1, DiemLan2, SUM(DIEM.DiemLan1 + DIEM.DiemLan2) AS N'Tổng điểm'
	FROM SINHVIEN JOIN DIEM ON DIEM.MaSV=SINHVIEN.MaSV 
				  JOIN MONHOC ON MONHOC.MaMonHoc=DIEM.MaMonHoc
	GROUP BY SINHVIEN.MaSV, HoTen,MONHOC.TenMonHoc, DiemLan1, DiemLan2
	ORDER BY SUM(DIEM.DiemLan1 + DIEM.DiemLan2)  DESC 

SELECT * FROM vi_Top2	

--Bài 5:
/*Viết một SP nhận một tham số đầu vào kiểu int là số DIEM. SP này thực hiện thao tác xóa
thông tin của các sinh viên và thông tin điểm thi của chúng, nếu điểm tương ứng của sinh
viên này lớn hơn điểm được truyền vào.*/

IF OBJECT_ID('sp_Xoa') IS NOT NULL 
DROP PROC  sp_Xoa
GO 
CREATE PROC sp_Xoa @DIEM INT
AS
BEGIN

	BEGIN TRY
		BEGIN TRAN
			DECLARE @Table TABLE(MaSV VARCHAR(5))
			INSERT INTO @Table SELECT SINHVIEN.MaSV FROM SINHVIEN JOIN DIEM ON DIEM.MaSV = SINHVIEN.MaSV 
			WHERE ((DiemLan1+DiemLan2)/2) >@DIEM

			DELETE FROM DIEM WHERE MaSV IN (SELECT MaSV FROM @Table)
			DELETE FROM SINHVIEN WHERE MaSV IN (SELECT MaSV FROM @Table)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		PRINT N'LỖI'
		ROLLBACK TRAN
	END CATCH
	
END

EXEC dbo.sp_Xoa 8

SELECT * FROM SINHVIEN