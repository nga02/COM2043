﻿--slide 3- COM2034
-- Bài 3: Các hàm hệ thống và xử lý chuỗi

use QLDA
go

--1. Các hàm chuyển đổi kiểu dữ liệu Slide 5-18
--a. Chuyển đổi ngầm (tự đông chuyển kiểu thấp => cao)
--b. Chuyển đổi tường minh dùng cast hoặc convert
-- * cú pháp: cast(biểu thức as kiểu_dl)
---------------------------------------------------------------
--* Convert: chuyển đổi tường minh
-- cú pháp: convert(kiểu_dữ_liệu, biểu thức [,định đạng])
-- Định dạng khi chuyển số sang chuỗi:xem link: http://msdn.microsoft.com/en-us/library/ms187928.aspx
-- VD1: dùng cast, convert=> in câu Ngày hôm này là + ngày hiện tại
	print 'To day is:' + cast( getdate() as nvarchar)
	print 'To day is:' + convert(nvarchar,getdate())
	print 'To day is:' + convert(nvarchar,getdate(),101)
	print 'To day is:' + convert(nvarchar,getdate(),103)

-- VD2: lấy thông tin Nhanvien: manv, hoten, ngaysinh, ngaysinh 
-- trong đó ngày sinh hiển thị theo các kiểu 
--'mm/dd/yyyy','dd/mm/yyyy','dd-mm-yyyy','mm-dd-yyyy'
	select MANV,HONV +' '+ TENLOT +' '+ TENNV as Hoten, NGSINH,
		  CONVERT(nvarchar,NGSINH,101)as 'mm/dd/yyyy',
		  CONVERT(nvarchar,NGSINH,103)as 'dd/mm/yyyy',
		  CONVERT(nvarchar,NGSINH,105)as 'dd-mm-yyyy',		 
		  CONVERT(nvarchar,NGSINH,110) as 'mm-dd-yyyy'
	from NHANVIEN

-- VD3: Hiển thị tiền (money) theo 1 vài kiểu định dạng convert (vD:1,2)
	Declare @Tien money
	set @Tien=17000.789
	select @Tien as cot0,--17000.789
		   convert(nvarchar,@tien,0) as cot1,--17000.79
		   convert(nvarchar,@tien,1) as cot2,--17,000.79
		   convert(nvarchar,@tien,2) as cot3---17000.7890

---------------------------------------------------------------------

-- 2. Các hàm toán học
--VD1: Thử hàm sqrt, round
	select SQRT(25) as can5,
		round(4.5678,1) as lamtron1,
		round(4.5648,2) as lamtron2

--------------------------------------
-- 3. Các hàm xử lý chuỗi (slide 21)
--a. Thực hiện các thao tác với chuỗi: ' FPT POLYTECHNIC '
-- lấy độ dài, cắt khoảng trắng thừa trái, phải, cả 2.
	select len(' FPT POLYTECHNIC ') as dodai,
		   LTRIM(' FPT POLYTECHNIC ') as catkhoangTrangTrai,
		   RTRIM(' FPT POLYTECHNIC ') as catkhoangTrangPhai,
		   RTRIM(LTRIM(' FPT POLYTECHNIC ')) as catKhoangTrang2ben

-- b. Thực hiện thử hàm left,right với chuỗi 'Ha noi'
	select LEFT('Ha noi',2) , --Ha
		   RIGHT('Ha noi',3)  --noi
-- c. Thử hàm subString với chuỗi: 'FPT POLYTECHNIC' --=> lấy chữ poly
-- SUBSTRING(string,start,length) => giống hàm mid trong excel
	select substring('FPT POLYTECHNIC',5,4)
	
-- d. Thử hàm CHARINDEX với chuỗi 'SQL Server'
--	select CHARINDEX('chuoicon','chuoicha',vitri): tim vi tri 
-- xuat hien chuoi con trong chuoi cha
	select CHARINDEX('er','SQL Server',1)
	select CHARINDEX('er','SQL Server',7)


-- e. Thử hàm REPLACE: thay thế dấu phẩy -> chấm: '456,789,456.87'
-- REPLACE(chuỗi_cha,chuỗi_con,chuỗi_thay_thế): 
--VD1: 
	select REPLACE('456,789,456.87',',','.')-- 456.789.456.87

Yêu cầu: --'456,789,456.87'  -> '456.789.456,87'
	select REPLACE(LEFT('456,789,456.87',11),',','.')+ --456.789.456
			+',' +RIGHT('456,789,456.87',2) -- 456.789.456,87


-- Ass: Chuyển giá phòng (money) -> về dạng '456.789.456,87'
--(dấu chấm phân cách phần nghìn,
--dấu phẩy phân cách phần thập phân
--có 2 chữ số sau phần thập phân)
--B1: chuyển money -> nvarchar có định dạng 1: được chuoi
--B2: REPLACE(LEFT(chuoi,len(chuoi)-3)
--B3: +',' + RIGHT(chuoi,2)


use QL_NhaTroV2
go
select MaNhaTro,Diachi,GiaPhong,		
		REPLACE(left(CONVERT(nvarchar,giaphong,1),len(CONVERT(nvarchar,giaphong,1))-3),',','.')
		+ ',' + RIGHT(CONVERT(nvarchar,giaphong,1),2)
from NhaTro


--4. Các hàm về ngày tháng

--  Lưu ý khi nhập ngày tháng: 'mm/dd/yyyy', 'mm-dd-yyyy', 'yyyy/mm/dd','yyyy-mm-dd'
