
--I. YÊU CẦU THIẾT KẾ VÀ CÀI ĐẶT CSDL
/*
1. Đặt vấn đề
2. Phân tích bài toán
3. Thiết kế CSDL
	a. Xác định thực thể, tập thực thể và các thuộc tính
	b. Xác định mối quan hệ giữa các thực thể, tập thực thể
	c. Sơ đồ ERD
		Tập thực thể				Thuộc tính				Kiểu dữ liệu			Mô tả
		LOAINHA
									MaLoaiNha				int						Mã loại nhà Khóa chính
									TenLoaiNha				nvarchar(50)			Tên loại nhà
									.......

		NGUOIDUNG					
---------------------------------------------------------------------------------------------------

4. Thiết kế CSDL và các bảng (mức vật lý)
	a. Mô hình quan hệ
		LOAINHA(MaLoaiNha, TenLoaiNha, ThongTinLoaiNha)

	b. Database Diagrams
.........
*/

use master
go
drop database QLNHATRO_LongTT
go
-- Tạo database
create database QLNHATRO_LongTT
go

use QLNHATRO_LongTT
go

-- Tạo các bảng trong database
	-- Bảng LoaiNha
create table LOAINHA
(
	MaLoaiNha int primary key,
	TenLoaiNha nvarchar(50),
	ThongTinLoaiNha nvarchar(50)
)
go
	-- Bảng	NguoiDung
create table  NGUOIDUNG
(
	MaNguoiDung int IDENTITY(1,1) primary key,
	TenNguoiDung nvarchar(50),
	GioiTinh bit,
	DienThoai char(50),
	DiaChi nvarchar(50),
	Quan nvarchar(50),
	Email char(50)
)
go
	-- Bảng NhaTro
create table NHATRO
(
	MaNhaTro int IDENTITY(1,1) PRIMARY KEY,
	MaLoaiNha int,
	DienTich real ,
	GiaPhong money,
	DiaChi nvarchar(50),
	Quan nvarchar(50),
	ThongTinNhaTro nvarchar(50),
	NgayDang date,
	foreign key(MaLoaiNha) references LOAINHA(MaLoaiNha)
)
go
	-- Bảng DanhGia
 create table DANHGIA
(
	MaNhaTro int,
	MaNguoiDung int,
	DanhGia bit,
	ThongTinDanhGia nvarchar(50),
	PRIMARY KEY (Manhatro, Manguoidung),
	foreign key(MaNhaTro) references NHATRO(MaNhaTro),
	foreign key(MaNguoiDung) references NGUOIDUNG(MaNguoiDung)
)
GO


--II. YÊU CẦU VỀ BỘ DỮ LIỆU MẪU

/* Sinh viên tiến hành nhập liệu cho các bảng.
	Yêu cầu về số lượng bản ghi:
		Bảng LOAINHA phải có tối thiểu 5 bản ghi
		Các bảng còn lại phải có tối thiểu 10 bản ghi
			Lưu ý:	Dữ liệu nhập vào các bảng phải có ý nghĩa thực tế, logic, đúng quy định về kiểu dữ liệu
					và đảm bảo có thể sử dụng để chạy thử tất cả các yêu cầu bên dưới đều trả về kết quả
Sinh viên tạo ra bảng dữ liệu trên Excel hoặc Word (mô tả trên đây nữa) => sau đó thực hiện
*/

--III. CÁC YÊU CẦU VỀ CHỨC NĂNG

--1. Thêm thông tin vào các bảng
	--Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.

					/*	Ví dụ: 

						PROC [dbo].[sp_SV] @MaSV INT,
									  @HoTenSV NVARCHAR(20),
									  @GioiTinh NVARCHAR(5),
									  @NSinh DATE,
									  @DChi NVARCHAR(20),
									  @SDT VARCHAR(15)
					AS
					  BEGIN
  						IF (@MaSV IS NULL OR 
							@HoTenSV IS NULL OR 
							@GioiTinh IS NULL OR 
							@NSinh IS NULL OR 
							@DChi IS NULL OR 
							@SDT IS NULL )
						  BEGIN
	  						 PRINT N'Phải điền đầy đủ thông tin'
						  END

						  ELSE 
							INSERT SINHVIEN VALUES (@MaSV, @HoTenSV, @GioiTinh, @NSinh, @DChi, @SDT)
					  END
					*/

/* SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG */
	-- drop sp_insert_NguoiDung 

create proc sp_insert_NguoiDung 
@TenNguoiDung nvarchar(50) , 
@GioiTinh bit ,
@DienThoai char(50) , 
@DiaChi nvarchar(50) , 
@Quan nvarchar(50) , 
@Email char(50) 
as
if
(@TenNguoiDung is null) or 
(@GioiTinh is null) or 
(@DienThoai is null) or 
(@DiaChi is null) or 
(@Quan is null)
begin
	Print N'Không có dữ liệu. Nhập lại đi'
end
else
begin
	insert into nguoidung
		values(@TenNguoiDung, @GioiTinh, @DienThoai, @DiaChi, @Quan, @Email) 
end

-- Chạy procedure (thêm dữ liệu bảng người dùng)
exec sp_insert_NguoiDung
@TenNguoiDung=N'Trần Thanh Long',
@GioiTinh=true, @DienThoai='0988526759',
@DiaChi=N'123-C5 Tô Hiệu, Nghĩa Tân', @Quan=N'Cầu Giấy', @Email='longtt3@fpt.edu.vn'
go

exec sp_insert_NguoiDung	
@TenNguoiDung=N'Bùi Thị Kim Hà',
@GioiTinh=false, @DienThoai='0930000000',
@DiaChi=N'170 Nguyễn Duy Trinh, Bình TrưngTây',
@Quan=N'Quận 2', @Email='HaKim@yahoo.com.vn'
go

select * from dbo.NGUOIDUNG

/* SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO */
	-- drop proc sp_insert_NhaTro

create proc sp_insert_NhaTro 
@MaLoaiNha int = null, 
@DienTich real = null, 
@GiaPhong money = null, 
@DiaChi nvarchar(50) = null,
@Quan nvarchar(50) = null,
@ThongTinNhaTro nvarchar(50) = null, 
@MaNguoiDung int = null,
@kt1 int = 0

as
--Kiểm tra thông tin đầu vào
if (@MaLoaiNha is null) or 
	(@DienTich is null) or 
	(@GiaPhong is null) or 
	(@DiaChi is null) or 
	(@Quan is null)
	begin
		print N'Lỗi:'
		print N'Thiếu thông tin đầu vào'
	end 
else 
	begin
		--Kiểm tra mã loại nhà có tồn tại hay không
		if not exists (select * from LoaiNha where MaLoaiNha = @MaLoaiNha ) 
			begin
				set @kt1 = 1
				print N'Loại nhà này không tồn tại'
			end
		if @kt1 = 0
			begin
				insert into NhaTro
				values (@MaLoaiNha, @DienTich, @GiaPhong, @DiaChi, @Quan, @ThongTinNhaTro, GETDATE())
				print N'Thêm thông tin thành công'
			END
	end
go
-- Chạy procedure (thêm dữ liệu bảng nhà trọ)
exec sp_insert_NhaTro	
@MaLoaiNha = 1,
@DienTich = 39,
@GiaPhong = 1000000,
@DiaChi = N'41b Tôn Thất Tùng, Phạm Ngũ Lão', @Quan = N'Quận 1',
@ThongTinNhaTro = N'Giá cả phải chăng'

exec sp_insert_NhaTro	
@MaLoaiNha = 2,
@DienTich = 60.7,
@GiaPhong = 5000000,
@DiaChi = N'170 Nguyễn Duy Trinh, Bình Trưng Tây', @Quan = N'Quận 2',
@ThongTinNhaTro = N'Cho thuê làm cửa hàng'

exec sp_insert_NhaTro	@MaLoaiNha = 4,
@DienTich = 60,
@GiaPhong = 10000000,
@DiaChi = N'Nam Kỳ Khởi Nghĩa, P4', @Quan = N'Quận 3',
@ThongTinNhaTro = N'Ngõ rộng'
go

select * from dbo.NHATRO

/* SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA */
	-- drop proc sp_insert_DanhGia

create proc sp_insert_DanhGia 
@MaNhaTro int = null, 
@MaNguoiDung int = null, 
@DanhGia bit = true,
@ThongTinDanhGia nvarchar(50) = null, 
@kt1 int = 0,
@kt2 int = 0, 
@kt3 int = 0
as
if (@MaNhaTro is null) or (@MaNguoiDung is null) 
	begin
		print N'Lỗi:'
		print N'Thiếu thông tin đầu vào'
	end
else 
	begin
		--Kiểm tra mã nhà trọ có tồn tại hay không
		if not exists (select * from NhaTro where MaNhaTro = @MaNhaTro ) 
			begin
				set @kt1 = 1
				print N'Nhà trọ này không tồn tại'
			end
		--Kiểm tra người dùng tồn tại hay không
		if not exists (select * from NguoiDung	where MaNguoiDung	= @MaNguoiDung )
		begin
			set @kt2 = 1
			print N'Người dùng này không tồn tại'
		end
		--Kiểm tra xem người dùng đã đánh giá nhà trọ hay chưa
		if exists (select * from DanhGia where MaNguoiDung = @MaNguoiDung and MaNhaTro = @MaNhaTro)
		begin
			set @kt3 = 1
		print N'Người dùng này đã đánh giá nhà trọ này'
		end
		if @kt1 = 0 and @kt2 = 0 and @kt3 = 0 
		begin
			insert into DanhGia
				values (@MaNhaTro , @MaNguoiDung , @DanhGia , @ThongTinDanhGia) 
				print N'Thêm thông tin thành công'
		end
	end

-- Chạy procedure (thêm dữ liệu bảng đánh giá)
exec sp_insert_DanhGia	
@MaNhaTro = 1,
@MaNguoiDung = 2, @DanhGia = true,
@ThongTinDanhGia = N'Nhà trọ tốt'

exec sp_insert_DanhGia	
@MaNhaTro = 1,
@MaNguoiDung = 3, @DanhGia = true,
@ThongTinDanhGia = N'Giá tốt'

go

insert into loainha
	values(1,N'Nhà trọ bình dân',N'Nhà trọ giá rẻ cho sinh viên,học sinh')
insert into loainha
	values(2,N'Cho thuê phòng',N'Nhà trọ giá rẻ cho người đi làm,sv')
insert into loainha
	values(3,N'Nhà cho thuê nguyên căn',N'Dành cho hộ kinh doanh hoặc gia đình')
insert into loainha
	values(4,N'Cho thuê căn hộ',N'Căn hộ')
go

select * from dbo.LOAINHA

--2. Truy vấn thông tin
	--a. Viết một SP với các tham số đầu vào phù hợp => Tìm theo quận
		-- drop procedure sp_quan
create procedure sp_quan @Quan nvarchar(50)
as
begin
select (N'Cho thuê phòng trọ tại ' + nhatro.Diachi +' ' + nhatro.Quan),
			(replace(cast(dientich as varchar),'.',',')+'m2') as N'Diện tích',
			(replace(convert(varchar,giaphong,103),',','.')) as N'Giá Phòng',
			ThongTinNhaTro,
			convert(varchar,ngaydang,105) as N'Ngày đăng tin',
			case gioitinh 
			when 1 then 'A.' + reverse(substring((reverse(TenNguoiDung)),0,charindex(' ',(reverse(tennguoidung)))))
			when 0 then 'C. ' + reverse(substring((reverse(TenNguoiDung)),0,charindex(' ',(reverse(tennguoidung)))))
			end as N'Tên người dùng',
			dienthoai as N'Số điệnt thoại liên hệ',
			nguoidung.diachi as N'Địa chỉ liên hệ'
	 from nhatro inner join danhgia on nhatro.MaNhaTro=danhgia.MaNhaTro
				 inner join nguoidung on danhgia.MaNguoiDung=nguoidung.MaNguoiDung
where nhatro.quan = @quan
end

Exec sp_quan N'Quận 3'
go

	--b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng NGUOIDUNG. 
		--Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng NGUOIDUNG) 
		--thỏa mãn các giá trị được truyền vào tham số
		--drop function sp_caub
create function sp_caub
(@tennguoidung nvarchar(50),@gioitinh bit,
@dienthoai nvarchar(50),@diachi nvarchar(50),
@quan nvarchar(50),@email char(50))
returns int
begin
	return(select manguoidung from nguoidung
			where tennguoidung=@tennguoidung and gioitinh=@gioitinh and dienthoai=@dienthoai and
				  DiaChi=@diachi and quan = @quan and email =@email
			)
end
go
--Thi hành hàm
print cast(dbo.sp_caub(N'Trần Thanh Long',1,'0988526759',N'Tô Hiệu, Nghĩa Tân',N'Cầu Giấy','longtt3@fpt.edu.vn')
as varchar(50))
go

--Câu c
--Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng NHATRO). 
--Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.
--drop function sp_cauc

select * from danhgia
go

--drop function sp_cauc
create function sp_cauc (@manhatro int)
returns @table table
(
	sodislike varchar,
	solike varchar 
)
begin
		
		insert into @table
		values((select  count(*)	from danhgia where manhatro = @manhatro and danhgia = 0),
		(select  count(*) 	from danhgia where manhatro = @manhatro and danhgia = 1))
		return;	
end
go
--Thực thi
select * from sp_cauc(3)
go

--Cau d
--.Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm các thông tin sau:
---Diện tích
---Giá
---Mô tả
---Ngày đăng tin
---Tên người liên hệ
---Địa chỉ
---Điện thoại
---Email
-- drop view sp_caud

Create view sp_caud
as
select 
TenNguoiDung as N'Tên người liên hệ',
dientich as N'Diện tích',
GiaPhong as N'Giá',
ThongTinDanhGia as N'Mô tả',
NgayDang as N'Ngày Đăng Tin',
nhatro.DiaChi as N'Địa chỉ',
Dienthoai as N'Điện Thoại',
Email, nhatro.MaNhaTro
from danhgia, nguoidung, nhatro
where nguoidung.MaNguoiDung = danhgia.MaNguoiDung
	and danhgia.MaNhaTro = nhatro.MaNhaTro
	and nhatro.manhatro in 
(select top10 from (select  top 10 manhatro as top10, count(*) as abc from danhgia where danhgia = 1 
 group by manhatro order by abc desc)as temp)
go

-- Thực thi
select * from sp_caud
go

--Câu e
--Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của bảng NHATRO).
--SP này trả về tập kết quả gồm các thông tin sau:
	---Mã nhà trọ
	---Tên người đánh giá
	---Trạng thái LIKE hay DISLIKE
	---Nội dung đánh giá
	-- drop procedure sp_caue
create procedure sp_caue @manhatro int
as
begin
	select nhatro.manhatro as N'Mã Nhà Trọ',
	tennguoidung as N'Tên người đánh giá',
	case danhgia 
	when 1 then 'Like'
	when 0 then 'Dislike'
	end as N'Trạng thía Like hay dislike',
	thongtindanhgia as N'Nội dung đánh giá'
	from danhgia 
	inner join nguoidung on nguoidung.MaNguoiDung=danhgia.MaNguoiDung
	inner join nhatro on danhgia.MaNhaTro=nhatro.MaNhaTro
	where nhatro.manhatro = @manhatro
end
--Thực thi
Exec sp_caue 2
go

-- 3. Xóa thông tin
-- a. Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện thao tác xóa thông tin của các nhà trọ 
 -- và thông tin đánh giá của chúng, nếu tổng số lượng DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.

CREATE PROC sp_xoa @SLDislike INT
 AS
  BEGIN
  -- tạo biến bảng lưu trữ mã nhà trọ có lượt dislike lớn hơn số lg tham số truyền vào
    DECLARE @MaNhaTro TABLE (MaNhaTro VARCHAR(10))
	INSERT INTO @MaNhaTro
	SELECT MaNhaTro FROM dbo.DANHGIA WHERE DanhGia = 0 
    GROUP BY MaNhaTro 
	HAVING COUNT([DanhGia])>@SLDislike
	
	BEGIN TRANSACTION
		 DELETE FROM dbo.DANHGIA WHERE MaNhaTro IN (SELECT MaNhaTro FROM @MaNhaTro) 
		 DELETE FROM dbo.NHATRO WHERE MaNhaTro IN (SELECT MaNhaTro FROM @MaNhaTro)
		 -- sử dụng giao dịch để đảm bảo tính toàn vẹn dữ liệu
		 ROLLBACK TRAN 
  END

-- thực thi 
  SELECT * FROM dbo.DANHGIA
  SELECT * FROM dbo.NHATRO
  EXEC dbo.sp_xoa @SLDislike = 0
  GO 

  -- b. Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện thao tác xóa thông tin những nhà trọ 
  --   được đăng trong khoảng thời gian được truyền vào qua các tham số.
  --   Lưu ý: SP cũng phải thực hiện xóa thông tin đánh giá của các nhà trọ này.


CREATE PROC sp_ThoiGian @Start DATE, @Finish DATE
  AS
    BEGIN
	-- tạo biến bảng lưu trữ mã nhà trọ có thời gian đăng tin trong khoảng thời gian được truyền vào qua các tham số.
	  DECLARE @ThoiGian TABLE (MaNhaTro VARCHAR(10))
	  INSERT INTO @ThoiGian
      SELECT MaNhaTro FROM dbo.NHATRO
	  WHERE NgayDang BETWEEN @Start AND @Finish

		  BEGIN TRANSACTION
		    DELETE FROM dbo.DANHGIA WHERE MaNhaTro IN (SELECT MaNhaTro FROM @ThoiGian) -- bắt buộc phải xóa ở bảng đánh giá trước vì có mối quan hệ FK
		  	DELETE FROM dbo.NHATRO WHERE MaNhaTro IN (SELECT MaNhaTro FROM @ThoiGian)
		  -- sử dụng giao dịch để đảm bảo tính toàn vẹn dữ liệu
		  ROLLBACK TRAN
    END

-- thực thi 
SELECT * FROM dbo.NHATRO
EXEC dbo.sp_ThoiGian @Start = '2022-07-11', 
                     @Finish = '2023-08-11' 

SELECT * FROM dbo.NHATRO
EXEC dbo.sp_ThoiGian @Start = '2009-07-11', 
                     @Finish = '2009-08-11' 


/*
IV. YÊU CẦU QUẢN TRỊ CSDL => Sinh viên tham khảo video để thực hiện

-	Tạo hai người dùng CSDL.
		+ Một người dùng với vai trò nhà quản trị CSDL. Phân quyền cho người dùng này chỉ được phép thao tác trên CSDL quản lý nhà trọ cho thuê và có toàn quyền thao tác trên CSDL đó
		+ Một người dùng thông thường. Phân cho người dùng này toàn bộ quyền thao tác trên các bảng của CSDL và quyền thực thi các SP và các hàm được tạo ra từ các yêu cầu trên
-	Kết nối tới Server bằng tài khoản của người dùng thứ nhất. Thực hiện tạo một bản sao CSDL.
*/
