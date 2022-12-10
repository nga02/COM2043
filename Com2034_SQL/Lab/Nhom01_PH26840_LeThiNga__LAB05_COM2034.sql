								-- *** LAB 5 ** --

-- BAI 1 : Viết store procedure
	-- In ra dòng "Xin chào" + @ten là tham số đầu vào và là tên Tiếng Việt

	USE QLDA
	--Câu lệnh , cú pháp tạo store procedure
	CREATE PROC sp_Xinchao @ten nvarchar(50)
	AS
	BEGIN
		PRINT N'Xin chào : '+ @ten
	END
	--Câu lệnh xóa store procedure
	DROP PROC sp_Xinchao
	--Câu lệnh gọi store procedure
	EXEC sp_Xinchao N'Cơ sở dữ liệu nâng cao'

	--1B : Nhập vào 2 số. In ra tổng 2 số vừa nhâp
	
	CREATE PROC sp_tinhTong @so1 int , @so2 int
	AS
	BEGIN
		DECLARE @sum int
		SET @sum = @so1 + @so2;
		PRINT N'Tổng là : ' + CAST(@sum as Varchar)
	END
	EXEC sp_tinhTong 5,10
	--store procedure có trả về
	CREATE PROC sp_tinhTong1 @so1 int , @so2 int
	AS
	BEGIN
		DECLARE @sum int
		SET @sum = @so1 + @so2;
		RETURN @sum
	END

	DECLARE @tong int
	
	--Goi lại store procedure tinhtong
	EXEC @tong =  sp_tinhTong1 5,10;
	PRINT N'Tổng là : ' +CAST(@tong as varchar)

	--Nhập vào số nguyên @n.In ra tổng các số chẵn từ 1 đến @n
	CREATE PROC sp_tinhTongChan @n int,@i int
	AS
	BEGIN
		DECLARE @sum int = 0;
		WHILE @i <= @n
		BEGIN
			IF @i % 2 = 0
			SET @sum = @sum + @i
			SET @i = @i + 1
		END
		PRINT N'Tong cac so chan tu ' +CAST(@i as varchar) + N' đến '+CAST(@n as varchar)
			+N' là : '+CAST(@sum as varchar)
	END

	--Gọi lại store tinhTongchan
	EXEC sp_tinhTongChan 10,1

	--Nhập vào 2 số. In ra ước chung lớn nhất của chúng
	CREATE PROC sp_timUCLN @so1 int,@so2 int
	AS
	BEGIN
		WHILE (@so1 != @so2)
		BEGIN
			IF(@so1 > @so2)
				SET @so1 = @so1 - @so2
			ELSE
				SET @so2 = @so2 - @so1
		END
		PRINT N'UCLN là : '+CAST(@so1 as varchar)
	END

	EXEC sp_timUCLN 25,45

	--BÀI 2 : SỬ DỤNG CƠ SỞ DỮ LIỆU QLDA .Viết các PROC
	--2A : Nhập vào @MaNV , xuất thông tin nhân viên theo mã

	CREATE PROC sp_xuatthongtinNV @manv nvarchar(9)
	AS
	BEGIN
		SELECT * FROM NHANVIEN WHERE MANV  = @manv
	END
	
	EXEC sp_xuatthongtinNV '011'

	--2B : Nhập vào mã đề án , cho biết số lượng nhân viên tham gia đề án đó

	CREATE PROC sp_soluongNVTtrongDA @mada int
	AS
	BEGIN
		SELECT COUNT(MA_NVIEN) AS N'Số lượng nhân viên tham gia vào đề án' FROM DEAN a
		INNER JOIN PHANCONG b ON a.MADA = b.MADA
		WHERE a.MADA = @mada
		GROUP BY a.MADA
	END

	EXEC sp_soluongNVTtrongDA 1

	--2C : Nhập vào MADA và DDIEM_DA , cho biết số lượng nhân viên tham gia
	--có mã đề án là MADA và địa điểm đề án = DDIEM_DA

	CREATE PROC sp_soluongnv_mada @mada int , @ddiem_da nvarchar(20)
	AS
	BEGIN
		SELECT COUNT(MA_NVIEN) AS N'Số lượng nhân viên' FROM DEAN a
		INNER JOIN PHANCONG b ON a.MADA = b.MADA
		WHERE a.MADA = @mada AND DDIEM_DA = @ddiem_da
		GROUP BY a.MADA
	END

	SELECT * FROM DEAN 
	EXEC sp_soluongnv_mada 10 ,N'Hà Nội'

	--2D : Nhập vào mã trưởng phòng ,xuất thông tin các nhân viên có mã nhân viên 
	-- là mã trưởng phòng nhập vào và các nhân viên này không có nhân thân

	CREATE PROC sp_timtruongphong @trphg nvarchar(9)
	AS
	BEGIN
		SELECT * FROM NHANVIEN WHERE MA_NQL = @trphg and
		MA_NQL not in (Select MA_NVIEN from THANNHAN WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV)
	END

	EXEC sp_timtruongphong '001'

	--2C : Nhập vào mã nv và mã phòng ban. Kiểm tra nhân viên có mã vừa nhập có thuộc phòng ban 
	CREATE PROC sp_kiemtra @manv nvarchar(9) , @mapb int
	AS
	BEGIN 
		IF EXISTS(SELECT * FROM NHANVIEN WHERE PHG = @mapb AND MANV = @manv)
			PRINT N'Nhân viên có trong phòng ban'
		ELSE 
			PRINT N'Nhân viên không có trong phòng ban'
	END

	EXEC sp_kiemtra '001',4

	--BÀI 3 : Viết các store procedure
	--3A : Thêm phòng ban có tên CNTT vào  csdl QLDA , các giá trị được thêm tham số đầu vào
	--Kiểm tra nếu trùng thì thông báo thêm thất bại

	CREATE PROC sp_themdulieu @tenphg nvarchar(50) , @maphg int , @trphg nvarchar(9) ,@ng_nhanchuc datetime
	AS
	BEGIN
		IF EXISTS(SELECT * FROM PHONGBAN WHERE @maphg = MAPHG)
			PRINT N'Thêm thất bại'
		ELSE
		INSERT INTO PHONGBAN VALUES (@tenphg,@maphg,@trphg,@ng_nhanchuc)
	END

	EXEC sp_themdulieu N'CNTT',10,'001','1965-12-01'

	--3B : Cập nhật phòng ban có tên là CNTT thành IT
	CREATE PROC sp_updatephongban
	AS
	BEGIN
		UPDATE PHONGBAN SET TENPHG = 'IT' WHERE TENPHG = 'CNTT'
	END
	
	EXEC sp_updatephongban

	--3C : Thêm 1 nhân viên vào bảng Nhân viên , tất cả giá trị đều truyền dưới dạng tham số đầu vào
	--Điều kiện : Nhân viên thuộc phòng IT
	-- Nhận @luong làm tham số đầu vào cho cột lương, nếu @luong < 25000 thì nhân viên này do 009 quản lý
	--Ngược lại do 005 quản lý
	--Nếu là nhân viên nam thì độ tuổi phải nằm trong 18-65,nếu là nữ thì 18-60

	CREATE PROC sp_themNhanvien @honv nvarchar(15),@tenlot nvarchar(15),@tennv nvarchar(15),
	@manv nvarchar(9),@ngaysinh datetime,@dchi nvarchar(30),@phai nvarchar(3),
	@luong float,@ma_nql nvarchar(9),@phg int
	AS
	BEGIN
		DECLARE @tuoi int
		SET @tuoi = YEAR(GETDATE()) - YEAR(@ngaysinh)
		IF EXISTS(SELECT * FROM NHANVIEN WHERE MANV = @manv)
			PRINT N'Thêm thất bại'
		ELSE
			IF @phg = (SELECT MAPHG FROM PHONGBAN WHERE TENPHG = 'IT')
				BEGIN
					IF @luong < 25000
						SET @ma_nql = '009'
					ELSE
						SET @ma_nql = '005'

					IF	(@phai = 'Nam' and @tuoi between 18 and 65) or (@phai = N'Nữ'and @tuoi between 16 and 60)
						BEGIN
							INSERT INTO NHANVIEN VALUES (@honv,@tenlot,@tennv,@manv,@ngaysinh,@dchi,@phai,@luong,@ma_nql,@phg)
						END
					ELSE
						PRINT N'Độ tuổi không hợp lệ'
				END
			ELSE
				PRINT N'Không thuộc phòng ban IT'
	END

	DROP PROC sp_themNhanvien
	EXEC sp_themNhanvien N'Lê',N'Thành',N'Thông','012','2002/07/20',N'Ninh Bình','Nam',35000,'001',8


