﻿-- slide 5: Store Procedure - Thủ tục
use QLDA
go

--1. Cú pháp Store Procedure
Create Proc Ten_Thủ_tuc
	@Tham_so1 kieu_DL, -- Tham số đầu vào (nếu có) ko ghi chữ input
	@Tham_so2 kieu_DL output -- Tham số đầu ra (nếu có) ghi chữ output\
As
	BEGIN
		-- Các lệnh
	END
ĐỂ GỌI SP dùng EXEC hoặc EXECUTE


-- Lưu ý: 
-- Đầu ra có 2 cách:
-- C1: dùng tham số output
-- C2: Dùng Return <số nguyên> trong thân thủ tục

-- Tham số đầu vào: Tham số bắt buộc phải truyền giá trị khi gọi thủ tục
-- Tham số tuỳ chọn: 
    -- khi xây dựng thủ tục ta gán giá trị mặc định: VD @Tham_so1 kiểu_DL = giá trị
	-- khi gọi thủ tục:ta có thể dùng giá trị mặc định (đã gán) nếu ko truyền giá trị.

-- VD1: Xây dựng thủ tục tính tổng 2 số nguyên: có 2 tham số đầu vào, ko có đầu ra
-- Kiểm tra nếu thủ tục tồn tại => xóa
if OBJECT_ID('sp_Tinhtong') is not null
	drop proc sp_Tinhtong
go

-- Tạo thủ tục
Create Proc sp_Tinhtong
	@so1 int,  -- Tham số đầu vào
	@so2 int   -- Tham số đầu vào
As
	BEGIN
		Declare @tong int
		set @tong= @so1+ @so2
		print N'Tổng là:' + Cast(@tong as nvarchar)
	END
go

-- gọi thủ tục không output:
exec ten_thu_tuc giá_tri1_truyền_vào_nếu_có , giá_tri2_truyền_vao_neu_có ...

-- gọi thủ tục có giá trị mặc định, không có output:
exec ten_thu_tuc -- không điền giá trị, dùng giá trị mặc định
exec ten_thu_tuc giá_tri1_truyền_vào_nếu_có , giá_tri2_truyền_vao_neu_có ...

-- Gọi thủ tục có output:
-- khai báo 1 biến có kiểu dữ liệu giống của output để nhận kết quả
declare @kq kiểu_dl_của_tham_số_output
exec ten_thu_tuc giá_tri1_truyền_vào_nếu_có, .., @kq output-- @kq đặt đúng vị trí của tham số output
select @kq

-- gọi thủ tục có return:
	declare @kq int
	exec @kq =ten_thu_tuc giá_tri1_truyền_vào_nếu_có , giá_tri2_truyền_vao_neu_có ...
	select @kq

-- Gọi thủ tục trong VD1:
-- c1:truyên theo vị trí
	exec sp_Tinhtong 4,5

-- c2: truyền theo tham số
	exec sp_Tinhtong @so1=4,@so2=5
	exec sp_Tinhtong @so2=5,@so1=4

----------------------------------------------------------------------------------------
-- VD2: Tính tổng 2 số: 2 tham số đầu vào, dùng output
if OBJECT_ID('sp_Tinhtong2') is not null
	drop proc sp_Tinhtong2
go
-- Tạo thủ tục
Create Proc sp_Tinhtong2
	@so1 int,  -- Tham số đầu vào
	@so2 int,  -- Tham số đầu vào
	@tong int output -- tham số đầu ra
As
	BEGIN	
		set @tong= @so1+ @so2		
	END
go
-- gọi thủ tục: 
--c1: truyền theo vị trí
declare @kq int
exec sp_Tinhtong2  4,6, @kq output -- @kq đặt đúng vị trí của tham số output
select @kq
-- c2: Truyền theo tham số
declare @kq int
exec sp_Tinhtong2  @so1=4,@so2=6, @tong=@kq output 
select @kq

----------------------------------------------------------------------------------------
-- VD3: Tính tổng 2 số: 2 tham số đầu vào dùng return
if OBJECT_ID('sp_Tinhtong3') is not null
	drop proc sp_Tinhtong3
go
-- Tạo thủ tục
Create Proc sp_Tinhtong3
	@so1 int,  -- Tham số đầu vào
	@so2 int  -- Tham số đầu vào	
As
	BEGIN	
		return @so1+ @so2		
	END
go

--- Gọi thủ tục:
-- C1: truyền theo vị trí
	declare @kq int
	exec @kq =sp_Tinhtong3 7,8
	select @kq

-- C2: Truyền theo tham số
	declare @kq int
	exec @kq =sp_Tinhtong3 @so1=7,@so2=8
	select @kq
----------------------------------------------------------------------------------------
-- VD4: tính tổng 2 số có dùng tham số mặc định
if OBJECT_ID('sp_Tinhtong4') is not null
	drop proc sp_Tinhtong4
go
-- Tạo thủ tục
Create Proc sp_Tinhtong4
	@so1 int =10,  -- Tham số đầu vào
	@so2 int  =9 -- Tham số đầu vào
As
	BEGIN
		Declare @tong int
		set @tong= @so1+ @so2
		print N'Tổng là:' + Cast(@tong as nvarchar)
	END
go
-- gọi thủ tục:
exec sp_Tinhtong4 -- dùng tham số mặc định
exec sp_Tinhtong4 6,8 -- không dùng tham số mặc định

----------------------------------------------------------------------------------------
-- VD5: 
-- Tạo thủ tục: Đầu vào maNV. Thủ tục truy xuất thông tin nhân viên theo Mã nhân viên 
if OBJECT_ID('sp_ThongTinVN') is not null
	drop proc sp_ThongTinVN
go

create proc sp_ThongTinVN
	@MaNV nvarchar(9)
As
	BEGIN
		select *
		from NHANVIEN
		where MANV like @MaNV
	END
go

-- gọi thủ tục: 
-- c1: truyền theo vị trí
	exec sp_ThongTinVN '001'
-- c2: truyền theo tham số
	exec sp_ThongTinVN @MaNV ='001'

-------------------------------------------------------------
-- VD6: Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó 
-- C1: output
	if OBJECT_ID('sp_tongSoNV_DA') is not null
		drop proc sp_tongSoNV_DA
	go

	create proc sp_tongSoNV_DA
		@MaDA int,
		@TongNV int output
	As
		BEGIN
			select @TongNV =count(MA_NVIEN)
			from PHANCONG
			where MADA = @MaDA
		END
	go

-- gọi thủ tục:
-- : truyền theo vị trí:
		declare @kq int
		exec sp_tongSoNV_DA 1,@kq output
		select @kq as soNV
--: Truyền theo tham số:
		declare @kq int
		exec sp_tongSoNV_DA @MaDA=1,@TongNV=@kq output
		select @kq as soNV
--------------------------------------------------------------

-- C2: return
if OBJECT_ID('sp_tongSoNV_DAC2') is not null
		drop proc sp_tongSoNV_DAC2
	go

	create proc sp_tongSoNV_DAC2
		@MaDA int		
	As
		BEGIN
			Declare @TongNV int

			select @TongNV =count(MA_NVIEN)
			from PHANCONG
			where MADA = @MaDA

			return @TongNV
		END
	go
-- gọi thủ tục:
--: truyền theo vị trí
	declare @kq int
	exec @kq=sp_tongSoNV_DAC2 1
	select @kq as tongsoNV
--: truyền theo tham số
	declare @kq int
	exec @kq=sp_tongSoNV_DAC2 @MaDA=1
	select @kq as tongsoNV

-- C3: dùng tham số mặc định

select * from DEAN

--------------------------------------------P2---------------------------------------------------
--1. Cập nhật thủ tục: thay lệnh create thành alter
--2. Các thủ tục hệ thống: SYSTEM STORED PROCEDURES
--=> Là những stored procedure chứa trong Master Database,

VD:
use QLDA
go
sp_helptext sp_TinhTong:Xem nội dung thủ tục

-- 3. Thủ tục thêm dữ liệu vào bảng
use QL_NhaTroV2
go


--VD1: Tạo thủ tục:thực hiện chèn dữ liệu vào bảng NGUOIDUNG:
--Kiểm tra null với cột không chấp nhận thuộc tính null
--kiểm tra khóa chính
--kiểm tra khóa ngoại
-- 2 lời gọi: thành công, thất bại

if OBJECT_ID('sp_InsertNguoiDung') is not null
	drop proc sp_InsertNguoiDung
go

create proc sp_InsertNguoiDung
		   @MaND nvarchar(10)=null, -- gán giá trị mặc định null cho những cột bắt buộc nhập
           @TenND nvarchar(50)=null,
           @Gioitinh nvarchar(5)=null,
           @DienThoai nvarchar(12)=null,
           @Diachi nvarchar(50)=null,
           @MaQuan nvarchar(10)=null,
           @email nvarchar(50)=null
As
	BEGIN
	 
	if(@MaND is null or @TenND is null or @MaQuan is null)--Kiểm tra null
		print N'Vui lòng nhập MaND, TenND, MaQuan'
	
	else if exists (select * from NguoiDung where MaND = @MaND)--kiểm tra khóa chính
		print N'Khóa chính trùng, không thêm được'
	else if not exists(select * from Quan where MaQuan = @MaQuan)--kiểm tra khóa ngoại
		print N'Lỗi Khóa Ngoại, không thêm được'
	else
		BEGIN
			insert into NguoiDung
			values (
					   @MaND , 
					   @TenND ,
					   @Gioitinh ,
					   @DienThoai ,
					   @Diachi ,
					   @MaQuan ,
					   @email 
					)
			print N'Thêm thành công'
		END
	END
go
-- 2 lời gọi: thành công, thất bại
-- gọi thành công:
	exec sp_InsertNguoiDung 'ND018',N'Trần Thị Hiếu',N'nữ',N'0989456789',N'Bắc Giang','Q01',N'HieuTT@gmail.com'
-- gọi thất bại:
	exec sp_InsertNguoiDung 'ND001',N'Trần Thị Hiếu',N'nữ',N'0989456789',N'Bắc Giang','Q01',N'HieuTT@gmail.com'
--gọi thất bại:
	exec sp_InsertNguoiDung
--select * from NguoiDung
--delete from NguoiDung where MaND ='ND018'

------------------------------------------------------------
lưu ý: 
-- Bạn Khá: nếu làm tốt thì nên bổ try..catch trong thủ tục
-- Bạn yếu: 
if OBJECT_ID('sp_InsertNguoiDung') is not null
	drop proc sp_InsertNguoiDung
go

create proc sp_InsertNguoiDung
		   @MaND nvarchar(10)=null, -- gán giá trị mặc định null cho những cột bắt buộc nhập
           @TenND nvarchar(50)=null,
           @Gioitinh nvarchar(5)=null,
           @DienThoai nvarchar(12)=null,
           @Diachi nvarchar(50)=null,
           @MaQuan nvarchar(10)=null,
           @email nvarchar(50)=null
As
	BEGIN
	 BEGIN TRY
		if(@MaND is null or @TenND is null or @MaQuan is null)--Kiểm tra null
			print N'Vui lòng nhập MaND, TenND, MaQuan'	
		else
			BEGIN
				insert into NguoiDung
				values (
						   @MaND , 
						   @TenND ,
						   @Gioitinh ,
						   @DienThoai ,
						   @Diachi ,
						   @MaQuan ,
						   @email 
						)
				print N'Thêm thành công'
			END
	 END TRY
	 BEGIN CATCH
		print N'Gặp lỗi:' + Error_message()
	 END CATCH
	
	END
go



