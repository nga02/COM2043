/*Hàm người dùng tự định nghĩa :Là một đối tượng CSDL chứa các câu lệnh SQL,
được biên dịch sẵn và lưu trữ trong CSDL*/
GO
----Ví dụ tạo view chi đọc
CREATE VIEW ThongtinNV
as
SELECT TENNV, LUONG, YEAR(GetDate())+ Year(NHANVIEN.NGSINH) as Tuoi
from NHANVIEN
WHERE YEAR(GetDate()) - Year(NHANVIEN.NGSINH) < 57

SELECT * FROM ThongtinNV
GO
---HÀM GIÁ TRI VÔ HƯỚNG
--1.
--DEMO
--1. Tạo hàm nhận tham số đầu vào là giới tính nam hoặc nữ và đếm số lượng nhân viên theo giới tính.

CREATE FUNCTION Fu_Dem_Gioitinh (@GT nvarchar(3)) -- Hàm giá trị vô hướng trả về tổng số lượng nhân viên theo giới tính
RETURNS INT
BEGIN
	RETURN (SELECT COUNT(MANV) FROM dbo.NHANVIEN
		WHERE PHAI LIKE @GT); ----Giá trị truyền vào xác định phái của nhân viên => đếm xem có báo nhiêu nhân viên theo phái được truyền vào
END;
GO
--Gọi hàm phái nam
SELECT dbo.Fu_Dem_Gioitinh(N'Nam')
PRINT N'Tổng số nhân viên theo phái Nam là: ' + CONVERT(VARCHAR, dbo.Fu_Dem_Gioitinh(N'Nam'))
SELECT dbo.Fu_Dem_Gioitinh(N'Nam')
--Gọi hàm phái nữ
SELECT dbo.Fu_Dem_Gioitinh(N'Nữ')
PRINT N'Tổng số nhân viên theo phái Nữ là: ' + CONVERT(VARCHAR, dbo.Fu_Dem_Gioitinh(N'Nữ'))
GO
--2. Tạo hàm nhận tham số đầu vào là mã phòng, trả về bảng các nhân viên thuộc mã phòng đó.

CREATE FUNCTION Fu_TimNhanVien_MaPhong (@MaP int)
RETURNS @DSNV TABLE --Tên của biến bảng
(HONV NVARCHAR(15),TENLOT NVARCHAR(15),TENNV NVARCHAR(15),MANV NVARCHAR(9),
NGSINH DATETIME,DCHI NVARCHAR(30),PHAI NVARCHAR(3),LUONG FLOAT,MA_NQL NVARCHAR(9),PHG INT)

 AS
  BEGIN
    INSERT INTO @DSNV (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG)
    SELECT HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG FROM dbo.NHANVIEN WHERE PHG = @MaP
	RETURN
   END
 GO

 --Gọi hàm
 SELECT * FROM dbo.Fu_TimNhanVien_MaPhong(5);
 
 --DEMO

--1. Tạo View hiển thị Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu một thân nhân

CREATE VIEW Vi_TrPH_TN
AS
SELECT DISTINCT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TENNV
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.MANV = PHONGBAN.TRPHG
WHERE (SELECT COUNT(THANNHAN.MA_NVIEN) FROM THANNHAN WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV) > 0

--Gọi View
SELECT * FROM Vi_TrPH_TN


