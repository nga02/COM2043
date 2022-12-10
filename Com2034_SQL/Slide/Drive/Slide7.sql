﻿-- Buổi LT7:
-- Lưu ý:
Thủ tục thêm dữ liệu/Insert, nếu không bắt kiểm tra thì làm đơn giản

create proc ten_tt
			@TS1 kieuDL= null,
			@TS2 KieuDL=null
			...
as
BEGIN
	BEGIN TRY
		-- lenh insert into...
		print N'Thêm thành công'
	END TRY

	BEGIN CATCH
		print N'Lỗi thêm dữ liệu:' + Error_Message()
	END CATCH
END



---------------------------------------------------------------------------------------------
-- Bài 7. Hàm do người dùng định nghĩa, view
use QLDA
go
--I. Hàm do người dùng định nghĩa (function)
--Hàm Khác với Stored Procedure
--➢Các hàm luôn phải trả về một giá trị, sử dụng câu lệnh
--RETURN
--➢Hàm không có tham số đầu ra
--➢Không được chứa các câu lệnh INSERT, UPDATE, DELETE
--một bảng hoặc view đang tồn tại trong CSDL
--➢Có thể tạo bảng, bảng tạm, biến bảng và thực hiện các câu
--lệnh INSERT, UPDATE, DELETE trên các bảng, bảng tạm,
--biến bảng vừa tạo trong thân hàm

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

-- Lưu ý:
--Không thể truyền tham số theo tên
--❑Truyền đầy đủ các tham số theo vị trí. Kể cả tham số
--tùy chọn, nếu muốn sử dụng giá trị mặc định, phải
--đặt từ khóa DEFAULT tại đúng vị trí tham số tùy chọn đó

-- VD1: Xây dựng hàm tính tuổi: Đầu vào: năm sinh.
if OBJECT_ID ('fn_TinhTuoi') is not null
	drop function fn_TinhTuoi
go

create function fn_TinhTuoi (@NamSinh int=1990)
	RETURNS int
as
BEGIN
	return (year(getdate())-@NamSinh)
END


-- gọi hàm:
print N'Tuổi:' + cast( dbo.fn_TinhTuoi(2000) as nvarchar)
print N'Tuổi:' + cast(dbo.fn_TinhTuoi(default) as nvarchar) -- dùng mặc định

--c2:
Declare @kq int 
select @kq = dbo.fn_TinhTuoi(2000)
select @kq

-- VD2:  Xây dựng hàm trả về tổng số lượng nhân viên.
if OBJECT_ID ('fn_TongNV') is not null
	drop function fn_TongNV
go

create function fn_TongNV ()
	RETURNS int
as
BEGIN
	return (select count(*) from NHANVIEN)
END

-- gọi hàm:
print N'Tổng NV là:' + cast (dbo.fn_TongNV() as nvarchar)

--c2:
declare @kq int
select @kq=dbo.fn_TongNV()
select @kq

-- VD3: Đếm số lượng nhân viên theo phái: 
-- gợi ý: Đầu vào là phái, nên mặc định là Nam



-----------------------------------------------------------------------------
	--2. Hàm giá trị bảng đơn giản 
	create function ten_ham ( @TS1_neu_co kieuDL= giatriMacDinh_neuco,
							  @TS2_neu_co kieuDL= giatriMacDinh_neuco,
							  ...
							 )
	RETURNS TABLE [....]
	AS
		RETURN (câu lệnh select)


-- VD1: Tạo hàm: đầu vào MaPhong. Hàm trả về thông tin nhân viên của phòng truyền vào.
-- thông tin: maNV, hoten, phai

if OBJECT_ID ('fn_TTNV') is not null
	drop function fn_TTNV
go

create function fn_TTNV (@MaPhong int=5)
	RETURNS TABLE
as
	return (select MANV, HONV+' '+ TENLOT+' '+TENNV as hoten, phai
			from NHANVIEN
			where PHG=@MaPhong
			)


-- gọi hàm:
select * from fn_TTNV(4)
select * from dbo.fn_TTNV(4)
select * from fn_TTNV(default)

---------------------------------------------------------------------
--3. Hàm giá trị bảng đa câu lệnh
create function ten_ham (@TS1_neu_co kieuDL= giatriMacDinh_neuco,
						 @TS2_neu_co kieuDL= giatriMacDinh_neuco,
						 ...
						)
RETURNS @Bien_bang TABLE
				(
					-- giống tạo bảng
					tencot1 kieuDL,
					tencot2 kieuDL,
					...
				)
as
BEGIN
	-- Các lệnh. Nên có lệnh đổ dữ liệu vào @Bien_bang
	RETURN
END
-- VD1:làm lại VD trên, dùng hàm giá trị bảng đa câu lệnh


if OBJECT_ID ('fn_TTNVPhong') is not null
	drop function fn_TTNVPhong
go

create function fn_TTNVPhong (@MaPhong int=5)
	RETURNS @NVPhong TABLE
				(
					MaNV nvarchar(9),
					HoTen nvarchar(50),
					Phai nvarchar(3)
				)
as
BEGIN
	insert into @NVPhong
	select MANV, HONV+' '+ TENLOT+' '+TENNV , phai
	from NHANVIEN
	where PHG=@MaPhong
	
	RETURN		
END

-- goi hàm:
select * from fn_TTNVPhong(4)
select * from dbo.fn_TTNVPhong(4)
select * from fn_TTNVPhong(default)


------------------------------------------ PHẦN II: VIEW ------------------------------------

-- cú pháp:
create view Vw_Ten_view
as
	<câu lệnh select>

-- gọi 
select * Vw_Ten_view

-- Lưu ý: 
-- + Không được chứa mệnh đề INTO, hoặc ORDER BY trừ khi chứa từ khóa TOP
-- + Cột chứa giá trị được tính toán từ nhiều cột khác phải được đặt tên

-- VD1: Tạo view chứa thông tin các nhân viên Nam

select * 
from NHANVIEN



-- chữa Ass View, Hàm