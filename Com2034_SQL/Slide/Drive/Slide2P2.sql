﻿--Slide2_COM2033:
-- Tạo CSDL Quan hệ và Ngôn ngữ truy vấn T-SQL

--I. Phần I.
-- 1. Giới thiệu: slide 2,3
-- 2. Kiểu dữ liệu Slide 5-> 12
-- 3. Lưu ý về tạo CSDL: slide 13
-- 4. Cách tạo CSDL slide 14,15
-- 5. Cách tạo bảng: slide 16-20
-- 6. Demo việc tạo bảng, tạo CSDL bằng thiết kế.

create database Slide2_COM203
go

use Slide2_COM203
go

create table PHONGBAN
(
	MaPhg nvarchar(10) not null,
	TenPhg nvarchar(30) not null,
	primary key(MaPhg)
)
go

create table NHANVIEN
(
	Manv nvarchar(7) not null,
	HoNV nvarchar(15) not null,
	Tenlot nvarchar(30) not null,
	TenNV nvarchar(15) not null,
	MaPhg nvarchar(10) not null,
	primary key(manv),
	foreign key(MaPhg) references PHONGBAN(MaPhg)
)
GO

--II. Phần II. Ngôn Ngữ truy vấn T-SQL
-- 1. Biến Slide 23,24
-- a. Biến vô hướng
-- Khai báo biến: declare @TenBien kieu_du_lieu
-- gán giá trị:
	set @TenBien = giá_trị
	select @TenBien = biểu_thức_cột
-- truy xuất:
	select @TenBien

--VD1: Tính chu vi HCN
	declare @chieu_dai int, @chieu_rong int, @chu_vi int
	set @chieu_dai=9
	select @chieu_rong=3
	set @chu_vi= (@chieu_dai + @chieu_rong) *2
	
	select @chu_vi as chuvi

	--print 'Chu vi: ' + cast( @chu_vi as nvarchar(10))

-- VD2: cho biết Tổng số nhân viên
	declare @tong int
	select @tong = count(manv)
	from NHANVIEN

	print 'Tong so nhan vien la:' + cast (@tong as varchar(10))

	--select *
	--from NHANVIEN

-- b. Biến bảng - slide 27 -> 29
-- khai báo:
	declare @TenBienBang table 
	(
		--giống tạo bảng
		ten_cot1 kieu_du_lieu thuoc_tinh,
		ten_cot2 kieu_du_lieu thuoc_tinh
	)

	-- có thể làm việc insert, update, delete, select như bảng
	-- không dùng được select into với biến bảng

-- VD1: Tạo biến bảng chứa các nhân viên nữ
use QLDA
go

	declare @NhanVienNu table
	(
		Manv nvarchar(15) not null,
		HoTen nvarchar(50) not null
	)

	insert into @NhanVienNu
	select MANV,HONV+' '+TENLOT +' '+TENNV
	from NHANVIEN
	where PHAI like N'Nữ'

	-- truy xuất:
	select * from @NhanVienNu

	--Truy xuất nối  @NhanVienNu với bảng PHanCong
	select *
	from  @NhanVienNu NV inner join PHANCONG on NV.Manv= PHANCONG.MA_NVIEN

	-- Thêm vào bảng @NhanVienNu 1 Nhân viên có tên là tên mình
	insert into @NhanVienNu
	values('NV009',N'Lê Xuân Lý')

	-- Truy xuất sau khi thêm:
	select *
	from  @NhanVienNu

	-- Cập nhật tên của Nhân viên có mã số 001 thành người yêu mình
	update @NhanVienNu
	set HoTen=N'Trần Thu Hà'
	where Manv like '001'
	-- Truy xuất sau khi sửa:
	select *
	from  @NhanVienNu

--select * from NHANVIEN

-- Phần III. Giới thiệu Transact-SQL (còn gọi là T-SQL) - slide 30