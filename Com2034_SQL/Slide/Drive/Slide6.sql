﻿---slide 6 -- Trigger

use QLDA
go

--Trigger là một dạng đặc biệt của thủ tục lưu trữ
--(store procedure), được thực thi một cách tự
--động khi có sự thay đổi dữ liệu (do tác động của
--câu lệnh INSERT, UPDATE, DELETE) trên một
--bảng nào đó.
--❑Không thể gọi thực hiện trực tiếp Trigger bằng
--lệnh EXECUTE

-- 1. Trigger Insert/Update/Delete. 
--cú pháp:
create Trigger tên_Trigger on Tên_bảng
for [Insert/update/Delete]
as
	Các  lệnh sql

--VD1:Ví dụ Trigger INSERT: Kiểm tra dữ liệu chèn vào
--bảng nhân viên có lương phai lớn hơn 5000

if OBJECT_ID('Tg_check_Luong') is not null
	drop trigger Tg_check_Luong
go

create trigger Tg_check_Luong on NHANVIEN
FOR INSERT
AS
	if(select LUONG from inserted)<5000
		BEGIN
			print N'Lương phải >5000'
			ROLLBACK TRAN
		END
GO

-- test:
insert into NHANVIEN
values(N'Lê',N'Ánh',N'Tuyết','018','1990-09-15',N'Hà nội',N'Nữ',3000,'001',4)


select  * from NHANVIEN
delete from NHANVIEN where MANV ='018'

--VD2: trigger cập nhật lương cho nhân viên, quy
--định lương >5000
if OBJECT_ID('Tg_check_LuongUpdate') is not null
	drop trigger Tg_check_LuongUpdate
go

create trigger Tg_check_LuongUpdate on NHANVIEN
FOR update
AS
	if(select LUONG from inserted)<5000
		BEGIN
			print N'Lương phải >5000'
			ROLLBACK TRAN
		END
GO


-- kiểm tra:
update NHANVIEN
set LUONG=2000
where MANV like '001'

--select  * from  NHANVIEN

--  VD3:Ví dụ tạo trigger Delete không cho phép xóa
--nhân viên có mã 018
if OBJECT_ID('Tg_DeleteNhanVien001') is not null
	drop trigger Tg_DeleteNhanVien001
go

create trigger Tg_DeleteNhanVien001 on NHANVIEN
FOR Delete
AS
	if exists (select * from deleted where MANV ='018')
		BEGIN
			print N'Không được phép xóa nhân viên 018'
			ROLLBACK TRAN
		END
GO

delete from NHANVIEN
where MANV like '018'

-- VD4: Viết trigger dàng buộc không được xóa các nhân viên ở TP HCM
if OBJECT_ID('Tg_xoa_NhanVienHCM') is not null
	drop trigger Tg_xoa_NhanVienHCM
go

create trigger Tg_xoa_NhanVienHCM on Nhanvien
for delete
AS

	if exists (select * from deleted where DCHI like N'%TP HCM%')
		BEGIN
			print N'Không được phép xóa nhân viên có địa chỉ TP HCM'
			ROLLBACK TRAN
		END

GO

--select * from NHANVIEN

--Test:
delete from NHANVIEN
where MANV ='019'

-----------------------------P2-----------------------------------
--2. Trigger After
--Trigger AFTER thực thi khi hoàn thành các hoạt
--động INSERT, UPDATE và DELETE.

-- cú pháp:
create trigger tên_Trigger on Tên_bảng
after [insert/update/delete]
as
	Các lệnh
go

-- VD1:Viết trigger đếm số lượng nhân viên bị xóa khi
--có câu lệnh xóa trên bảng nhân viên 

if OBJECT_ID('tg_after_xoaNV') is not null
	drop trigger tg_after_xoaNV
go

create trigger tg_after_xoaNV on Nhanvien
after delete
as
	BEGIN
		declare @num int
		select @num= count(*) from deleted
		print N'Số nhân viên bị xóa:' + cast(@num as nvarchar)
	END
go

-- test:
delete from NHANVIEN 
where MANV ='018'

delete from NHANVIEN 
where MANV ='019'


--3. Trigger Instead of được thực thi thay thế cho
--các hoạt động INSERT, UPDATE hoặc DELETE.

-- VD1: Tạo trigger sao cho khi xóa nhanvien thì tự động xóa thân nhân
if OBJECT_ID ('tg_Instedof_xoa_NhanVien') is not null
drop trigger tg_Instedof_xoa_NhanVien
go

create trigger tg_Instedof_xoa_NhanVien on NhanVien
	instead of Delete
as
BEGIN
	delete from THANNHAN
	where MA_NVIEN in (select MANV from deleted)

	delete from NHANVIEN
	where MANV in (select MANV from deleted)

END
go

select * from NHANVIEN
select * from THANNHAN
delete from NHANVIEN
where MANV ='017'