
--BÀI THỰC HÀNH LAB02-COM2034 LỚP IT17320 - BL1-SU2022

/*
1. Liệt kê các kiểu dữ liệu trong SQL Server
	=> Sinh viên trình bày ngay trên file này*/
	1.Chuỗi:+ char
			+varchar
			+nchar
			+nvarchar
	2.Kiểu số: int,float, money...
	3.Kiểu thời gian: date, datetime, time
	4.Kiểu khác:
/*2. Tạo cơ sở dữ liệu bằng tool và bằng lệnh
	a. Tạo CSDL QLDA_LAB02
	b. Tạo các bảng cho CSDL: DEAN, PHONGBAN, DIADIEM_PHG, NHANVIEN, THANNHAN, CONGVIEC, PHANCONG
	c. Mô tả thuộc tính, kiểu dữ liệu và miền giá trị của các bảng
	d. Thực hiện nhập dữ liệu vào các bảng (lấy dữ liệu từ CSDL QLDA)
	e. Thực hiện ràng buộc khóa ngoại cho CSDL vừa tạo*/
/*
3. Sử dụng T-SQL thực hiện các truy vấn có dùng biến
	a. Sử dụng biến thể thực hiện
		+. Chương trình tính diện tích hình chữ nhật, khi biết chiều dài và chiều rộng*/
		DECLARE @CHIEUDAI INT, @CHIEURONG INT,@CHUVI INT,@DIENTICH INT
		SET @CHIEUDAI=35
		SET @CHIEURONG=30
		SET @CHUVI=(@CHIEUDAI+@CHIEURONG)*2  
		SET @DIENTICH=@CHIEUDAI*@CHIEURONG
		SELECT @CHUVI AS 'CHUVI', @DIENTICH AS 'DIENTICH'
		/*+. Chương trình tính chu vi hình chữ nhật, khi biết chiều dài và chiều rộng*/
	/*b. Dựa trên CSDL QLDA thực hiện truy vấn "Sử dụng biến"
		1. Cho biêt nhân viên có lương cao nhất*/
		use QLDA
		DECLARE @Max_luong float
		SELECT @Max_luong=MAX(LUONG)
		FROM NHANVIEN
		SELECT @Max_luong AS 'LUONG_MAX'
		SELECT * FROM NHANVIEN WHERE LUONG = @Max_luong

		---2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
		USE QLDA
		DECLARE @LUONG_TB float 

		SET @LUONG_TB = (SELECT AVG(LUONG)  AS 'LƯƠNG_TB' 
						FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG=NHANVIEN.PHG
						WHERE TENPHG = N'NGHIÊN CỨU')

		SELECT HONV +''+TENLOT+''+TENNV AS [HỌ VÀ TÊN],LUONG 
		FROM NHANVIEN 
		WHERE LUONG > @LUONG_TB
		---3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó
		USE QLDA
		GO
		DECLARE @lietke TABLE 
		(
			TENPB NVARCHAR(20),
			SOLUONG int,
			LUONGTB int
		)
		INSERT INTO @lietke

		SELECT TENPHG, COUNT(MANV) AS 'SOLUONG', AVG(LUONG) AS 'LUONGTB'
		FROM NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
		GROUP BY TENPHG
		HAVING AVG(LUONG) > 31000
		SELECT * FROM @lietke
	---	4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
		USE QLDA
		GO
		DECLARE @lietke TABLE
		(
				TENTB NVARCHAR(20),
				SOLUONG INT
		)
		INSERT INTO @lietke

		SELECT TENPHG, COUNT(MADA) 
		FROM DEAN JOIN PHONGBAN ON PHONGBAN.MAPHG = DEAN.PHONG
		GROUP BY PHONG, TENPHG
		SELECT * FROM @lietke

