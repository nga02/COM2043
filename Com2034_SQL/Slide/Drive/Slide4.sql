-- Slide4_COM2034: Bài 4: Điều kiện và vòng lặp
use QLDA
GO

-- Giới thiệu nội dung: slide 3,4
-- I. Các xử lý Điều kiện: slide 5 -> 17
-- 1. if (slide 5->12)
-- IF <biểu thức điều kiện> {<Câu lệnh>|BEGIN...END} [ELSE {<Câu lệnh>|BEGIN...END}] 
	declare @diem float =8.5
	declare @xeploai nvarchar(30)
	if(@diem<5)
		set @xeploai=N'Trượt'
	else if (@diem<7)
		set @xeploai=N'Trung bình'
	else if(@diem<9)
		begin
			set @xeploai=N'Giỏi'
			print N'Chúc mừng'
		end
	else
		set @xeploai=N'Xuất sắc'

	print N'Xếp loại:' + @xeploai
go

-- VD2:
	if exists (select * from NHANVIEN where LUONG>50000)
	begin
		print 'DS  Nhan vien luong >50000'
		select *
		from NHANVIEN
		where LUONG>50000
	end
	else
		print' Khong có nhan vien co luong >50000'
-- select iif(45>30,'Đúng','sai') as result
	select Manv,TenNV,luong, 
		   iif(luong>30000,N'Trưởng Phòng',N'Nhân viên') as ChucVu
	from NHANVIEN

--2. case: slide 13 ->16
-- a. Case đơn giản: slide 14
	case <biểu thức>
		when <biểu thức 1> then <kq1>
		when <biểu thức 2> then <kq2>
		else <kqn>
	end

-- VD:
	Select MANV,phai,
			case phai
				when 'Nam' then N'Mr.'+TENNV
				when N'Nữ' then N'Mrs.'+ TENNV
				else
					N'Free Sex' + TENNV
			end as N'Tên'
	from NHANVIEN

-- b. Search case:slide 15
	case
		when <bt_điều kiện 1> then <kq1>
		when <bt_điều kiện 2> then <kq2>
		else <kqn>
	end

-- VD:
	Select MANV,phai,
			case 
				when PHAI= 'Nam' then N'Mr.'+TENNV
				when phai =N'Nữ' then N'Mrs.'+ TENNV
				else
					N'Free Sex' + TENNV
			end as N'Tên'
	from NHANVIEN

-- c. So sánh simple case với search case: slide 17

/* ------------------------------------------------------------------------------------*/

-- II. Vòng lặp: slide 19
-- 1. While : slide 20 -> 23
	while(điều kiện)
	Begin
		-- các lệnh
	end
-- vD1:
	declare @tong int =0, @i int =0
	while(@i<=10)
		BEGIN		
			set @tong= @tong+@i
			set @i= @i+1
		END
	select @tong
go
-- vD2:
	declare @tong int =0, @i int =0
	while(@i<=10)
		BEGIN
			if(@i=5) break
			set @tong= @tong+@i
			set @i= @i+1
		END
	select @tong

-- III. Dùng Try...catch để xử lý lỗi: slide 24
-- a. Cú pháp
	BEGIN TRY 
		--<câu lệnh SQL>|<Khối câu lệnh> 
	END TRY 
	BEGIN CATCH 
		--<Câu lệnh SQL>|<Khối câu lệnh xử lý lỗi>
	END CATCH

-- VD1:
	BEGIN TRY
		print N'Điểm của bạn là' + 10
	END TRY
	BEGIN CATCH
		print N'Gặp lỗi: '  
				+ cast(Error_number() as nvarchar) 
				+ ' '+ Error_message()
	END CATCH

-- VD2: Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước  
--o Nhận thông báo “ thêm dư lieu thành cong” từ khối Try 
--o Chèn sai dữ liệu có thông báo “Them dư lieu that bai” từ khối Catch

BEGIN TRY
	insert into PHONGBAN(TENPHG,MAPHG,TRPHG,NG_NHANCHUC)
	values('HC',7,'001','1990-03-05')
	print 'Them du lieu thanh cong'
END TRY
BEGIN CATCH
	print  N'Thông báo thất bại: ' + Error_message()
END CATCH

-- b. Raiserror: slide 27
raiserror('Thong bao','muc do','Trang thai')

if(3>5)
	print 'dung'
else
	Begin		
		raiserror(N'Sai rồi',1,1)
	end
		