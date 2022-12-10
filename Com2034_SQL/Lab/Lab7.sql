--1. TẠO HÀM GIÁ TRỊ VÔ HƯỚNG
-- cú pháp
create function ten_ham (@TS1_neu_co kieuDL= giatriMacDinh_neuco,
						 @TS2_neu_co kieuDL= giatriMacDinh_neuco,
						 ...
						)
RETURNS kieu_DL_vohuong
as
BEGIN
	-- Cac lenh
	RETURN gia_tri_vohuong
END
GO
-- Lưu ý:
--Không thể truyền tham số theo tên
--❑Truyền đầy đủ các tham số theo vị trí. Kể cả tham số
--tùy chọn, nếu muốn sử dụng giá trị mặc định, phải
--đặt từ khóa DEFAULT tại đúng vị trí tham số tùy chọn đó

select * from NHANVIEN
SELECT * FROM DEAN
GO
----------------------------------------------------------------BÀI_1:Hàm FUNCTION:----------------------------------------------------------------------------

--1. Nhập vào MaNV cho biết tuổi của nhân viên này.
IF OBJECT_ID(' fTinhTuoi') IS NOT NULL
	DROP FUNCTION fTinhTuoi
GO
CREATE FUNCTION  fTinhTuoi (@manv varchar(5) )
	RETURNS INT
AS
BEGIN
	RETURN (SELECT (YEAR(GETDATE())- YEAR(NGSINH))  FROM NHANVIEN where MANV = @manv)
END

PRINT N'Tuổi của bạn là: ' + CONVERT(NVARCHAR, dbo. fTinhTuoi('004'))
GO
-------------------------------------------------------------------------------------------------------------------------------------------

--2. Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
IF OBJECT_ID(' f_Sluong_DA') IS NOT NULL
	DROP FUNCTION f_Sluong_DA
GO
CREATE FUNCTION  f_Sluong_DA (@ma_nv varchar(5))
	RETURNS INT
AS
BEGIN
	RETURN (SELECT COUNT(PHANCONG.MADA) FROM PHANCONG JOIN DEAN ON DEAN.MADA = PHANCONG.MADA
	where MA_NVIEN = @ma_nv)
END
PRINT N'SỐ LƯỢNG ĐỀ ÁN ĐÃ THAM GIA LÀ:' + CONVERT(NVARCHAR, dbo.f_Sluong_DA('005'))
go
------------------------------------------------------------------------------------------------------------------------------------------

---3. Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
IF OBJECT_ID('F_SLuongNV_TheoPhai') IS NOT NULL
	DROP FUNCTION F_SLuongNV_TheoPhai
GO
CREATE FUNCTION F_SLuongNV_TheoPhai(@phai varchar(5))-- Hàm giá trị vô hướng trả về tổng số lượng nhân viên theo giới tính
	RETURNS INT
AS
BEGIN
	RETURN (SELECT COUNT(MANV) 
			FROM NHANVIEN 
			WHERE PHAI = @phai)--Kiểm tra PHÁI có bằng tham số truyền vào hay không
END
--Gọi hàm phái nam
PRINT N'Tổng số nhân viên theo phái Nam là: ' + CONVERT(VARCHAR, dbo.F_SLuongNV_TheoPhai(N'Nam'))
--Gọi hàm phái nữ
PRINT N'Tổng số nhân viên theo phái Nữ là: ' + CONVERT(VARCHAR, dbo.F_SLuongNV_TheoPhai(N'Nữ'))
GO
---------------------------------------------------------------------------------------------------------------------------

/* 4,Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết
họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình
của phòng đó.*/
IF OBJECT_ID ('F_LuongTb') IS NOT NULL
	DROP FUNCTION F_LuongTbinh 
GO
CREATE FUNCTION F_LuongTbinh(@tenPhong NVARCHAR(50))
	RETURNS  TABLE
	--(HONV NVARCHAR(15),TENLOT NVARCHAR(15),TENNV NVARCHAR(15),LUONG FLOAT)
AS
	
	RETURN 
	(
		SELECT HONV +' '+ TENLOT + ' ' + TENNV AS HoTen,LUONG 
		FROM NHANVIEN  
		WHERE LUONG > (SELECT AVG(LUONG) 
						FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG 
						WHERE TENPHG= @tenPhong )
	)
SELECT * FROM dbo.F_LuongTbinh(N'Điều Hành')

-----------------------------------------------------------------------------------------------------------------------------
/* 5. Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng
và số lượng đề án mà phòng ban đó chủ trì.*/
IF OBJECT_ID ('F_SlDeAn') IS NOT NULL
	DROP FUNCTION F_SlDeAn
GO
CREATE FUNCTION F_SlDeAn(@maPhong int)
	RETURNS TABLE
AS
	RETURN 
	(
		SELECT TENPHG,TRPHG ,HONV +' '+ TENLOT + ' ' + TENNV AS N'TÊN TRƯỞNG PHÒNG', COUNT(MADA) AS N'Số lượng đề án'
		FROM PHONGBAN JOIN DEAN ON PHONGBAN.MAPHG = DEAN.PHONG
				  JOIN NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
		WHERE MAPHG = @maPhong
		GROUP BY TENPHG,TRPHG,HONV ,TENLOT ,TENNV 
	)
SELECT * FROM F_SlDeAn(5)
---------------------------------------------------------------------------------------------------------------------------
--Bai2: Tạo các VIEW
---------------------------------------------------------------------------------------------------------------------------
-- Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg
IF OBJECT_ID ('Vi_PHG') IS NOT NULL
Drop view Vi_PHG
GO
CREATE VIEW Vi_PHG
AS
SELECT DISTINCT HONV,TENNV,TENPHG,DIADIEM FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG=NHANVIEN.PHG
															JOIN DIADIEM_PHG ON DIADIEM_PHG.MAPHG=PHONGBAN.MAPHG
SELECT * FROM Vi_PHG

---Hiển thị thông tin TenNv, Lương, Tuổi
IF OBJECT_ID ('Vi_Tuoi') IS NOT NULL
Drop view Vi_Tuoi
GO
CREATE VIEW Vi_Tuoi
AS
SELECT DISTINCT TENNV,LUONG, YEAR(GETDATE()) - YEAR(NGSINH) AS TUOI FROM NHANVIEN 
SELECT * FROM Vi_Tuoi

--Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất
IF OBJECT_ID ('Vi_TrPhong') IS NOT NULL
Drop view Vi_TrPhong
GO
CREATE VIEW Vi_TrPhong
AS 
	SELECT TOP 1  TENPHG ,HONV +' '+ TENLOT + ' ' + TENNV AS N'TÊN TRƯỞNG PHÒNG', COUNT(MANV) AS MaNv FROM NHANVIEN JOIN PHONGBAN  ON NHANVIEN.MANV = PHONGBAN.TRPHG																							
	GROUP BY TENPHG ,HONV +' '+ TENLOT + ' ' + TENNV 
	ORDER BY MaNv DESC
SELECT * FROM Vi_TrPhong


											--------------------------------------END-------------------------------------------------



SELECT * FROM NHANVIEN
SELECT * FROM CONGVIEC
SELECT * FROM PHONGBAN
SELECT * FROM DEAN
SELECT * FROM PHANCONG
SELECT * FROM THANNHAN
SELECT * FROM DIADIEM_PHG