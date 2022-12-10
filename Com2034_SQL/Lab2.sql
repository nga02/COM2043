
--BÀI THỰC HÀNH LAB02-COM2034 LỚP IT17320 - BL1-SU2022

/*
1. Liệt kê các kiểu dữ liệu trong SQL Server
	=> Sinh viên trình bày ngay trên file này
1.BẢNG NHANVIEN	
TÊN THUỘC TÍNH         DIỄN GIẢI          KIỂU DỮ LIỆU    GHI CHÚ
HONV					......             NVARCHAR(15)		CHUỖI
TENLOT                  ......             NVARCHAR(15)		CHUỖI
TENNV					......             NVARCHAR(15)		CHUỖI
MANV,MA_NVIEN			......             NVARCHAR(9)		CHUỖI
NGSINH					......			   DATETIME			NGÀY(MM/DD/YY)
DCHI					......             NVARCHAR(30)		CHUỖI
PHAI                    ......             NVARCHAR(3)		CHUỖI
LUONG                   ......			   FLOAT			SỐ THỰC
MA_NQL                  ......             NVARCHAR(9)		CHUỖI
TENPHG                  ......			   NVARCHAR(15)		CHUỖI
PHG,MAPHG               ......             INT				SỐ NGUYÊN 
TRPHG                   ......             NVARCHAR(9)		CHUỖI
NG_NHANCHUC             ......             DATE				NGÀY
DIADIEM                 ......             NVARCHAR(15)     CHUỖI
TENTN                   ......             NVARCHAR(15)     CHUỖI
QUANHE                  ......             NVARCHAR(15)     CHUỖI
MADA,SODA               ......             INT              SỐ NGUYÊN
TENDA                   ......             NVARCHAR(15)     CHUỖI
DDIEM_DA                ......			   NVARCHAR(15)     CHUỖI
PHONG                   ......             INT              SỐ NGUYÊN
THOIGIAN                ......             FLOAT            SỐ THỰC
STT                     ......             INT              SỐ NGUYÊN 
TEN_CONG_VIEC           ......             NVARCHAR(50)     CHUỖI

*/
/*2. Tạo cơ sở dữ liệu bằng tool và bằng lệnh
	a. Tạo CSDL QLDA_LAB02
	b. Tạo các bảng cho CSDL: DEAN, PHONGBAN, DIADIEM_PHG, NHANVIEN, THANNHAN, CONGVIEC, PHANCONG
	c. Mô tả thuộc tính, kiểu dữ liệu và miền giá trị của các bảng
	d. Thực hiện nhập dữ liệu vào các bảng (lấy dữ liệu từ CSDL QLDA)
	e. Thực hiện ràng buộc khóa ngoại cho CSDL vừa tạo*/
CREATE DATABASE LAB_02
GO 
USE LAB_02
CREATE TABLE DEAN 
(
	TENDEAN nvarchar(15) NOT NULL,
	MADA int PRIMARY KEY,
	DDIEM_DA nvarchar(15) NOT NULL,
	PHONG int NULL,
)
CREATE TABLE PHONGBAN
(
	TENPHG nvarchar(15) NOT NULL,
	MAPHG int PRIMARY KEY ,
	TRPHG nvarchar(9) NULL,
	NG_NHANCHUC date NOT NULL,
)
CREATE TABLE DIADIEM_PHG
(
	MAPHG int NOT NULL,
	DIADIEM nvarchar(15) NOT NULL,
	PRIMARY KEY(MAPHG,DIADIEM)
)

CREATE TABLE NHANVIEN
(
	HONV nvarchar(15) NOT NULL,
	TENLOT nvarchar(15) NOT NULL,
	TENNV nvarchar(15) NOT NULL,
	MANV nvarchar(9)  PRIMARY KEY,
	NGSINH datetime NOT NULL,
	DCHI nvarchar(30) NOT NULL,
	PHAI nvarchar(3) NOT NULL,
	LUONG float NOT NULL,
	MA_NQL nvarchar(9) NULL,
	PHG int NULL,
)
CREATE TABLE THANNHAN
(
	MA_NVIEN nvarchar(9) NOT NULL,
	TENTN nvarchar(15) NOT NULL,
	PHAI nvarchar(3) NOT NULL,
	NGSINH date NOT NULL,
	QUANHE nvarchar(15) NOT NULL,
	PRIMARY KEY(MA_NVIEN,TENTN)
)
CREATE TABLE CONGVIEC
(
	MADA int NOT NULL,
	STT int NOT NULL,
	TEN_CONG_VIEC nvarchar(50) NOT NULL,
	PRIMARY KEY( MADA,STT)
)
CREATE TABLE PHANCONG
(
	MA_NVIEN nvarchar(9) NOT NULL,
	MADA int NOT NULL,
	STT int NOT NULL,
	THOIGIAN float NOT NULL,
	PRIMARY KEY (MA_NVIEN,MADA,STT)
)
ALTER TABLE [dbo].[DEAN]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_DeAn] FOREIGN KEY([PHONG])
REFERENCES [dbo].[PHONGBAN] ([MAPHG])
GO
ALTER TABLE [dbo].[PHONGBAN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_PhongBan] FOREIGN KEY([TRPHG])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[DIADIEM_PHG]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_DiaDiemPhg] FOREIGN KEY([MAPHG])
REFERENCES [dbo].[PHONGBAN] ([MAPHG])
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_NhanVien] FOREIGN KEY([MA_NQL])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[THANNHAN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ThanNhan] FOREIGN KEY([MA_NVIEN])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[CONGVIEC]  WITH CHECK ADD  CONSTRAINT [FK_DeAn_CongViec] FOREIGN KEY([MADA])
REFERENCES [dbo].[DEAN] ([MADA])
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_PhanCong] FOREIGN KEY([MA_NVIEN])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
INSERT INTO DEAN VALUES
	(N'Sản Phẩm x', 1, N'Vũng Tàu', 5),
	(N'Sản Phẩm Y', 2, N'Nha Trang', 5),
	(N'Sản Phẩm Z', 3, N'TP HCM', 5),
	(N'Tin Học Hóa', 10, N'Hà Nội', 4),
	(N'Cáp quang', 20, N'TP HCM', 1),
	(N'Đào tạo', 30, N'Hà Nội', 4)
INSERT INTO PHONGBAN VALUES
	 (N'Quản Lý', 1, N'006', CAST(N'1971-06-19' AS Date)),
	 (N'Điều Hành', 4, N'008', CAST(N'1985-01-01' AS Date)),
	 (N'Nghiên Cứu', 5, N'005', CAST(N'0197-05-22' AS Date)),
	 (N'IT', 6, N'008', CAST(N'1985-01-01' AS Date))
INSERT INTO DIADIEM_PHG VALUES
	(1, N'TP HCM'),
	(4, N'Hà Nội'),
	(5, N'Nha Trang'),
	(5, N'TP HCM'),
	(5, N'Vũng Tàu')
INSERT INTO NHANVIEN VALUES 
	(N'Đinh', N'Quỳnh', N'Như', N'001', CAST(N'1967-02-01T00:00:00.000' AS DateTime), N'291 Hồ Văn Huê, TP HCM', N'Nữ', 43000, N'006', 4),
	(N'Phan', N'Viet', N'The', N'002', CAST(N'1984-01-11T00:00:00.000' AS DateTime), N'778 nguyễn kiệm , TP hcm', N'', 30000, N'001', 4),
	 (N'Trần', N'Thanh', N'Tâm', N'003', CAST(N'1957-05-04T00:00:00.000' AS DateTime), N'34 Mai Thị Lự, Tp Hồ Chí Minh', N'Nam', 25000, N'005', 5),
	 (N'Nguyễn', N'Mạnh ', N'Hùng', N'004', CAST(N'1967-03-04T00:00:00.000' AS DateTime), N'95 Bà Rịa, Vũng Tàu', N'Nam', 38000, N'005', 5),
	 (N'Nguễn', N'Thanh', N'Tùng', N'005', CAST(N'1962-08-20T00:00:00.000' AS DateTime), N'222 Nguyễn Văn Cừ, Tp HCM', N'Nam', 40000, N'006', 5),
	 (N'Phạm', N'Văn', N'Vinh', N'006', CAST(N'1965-01-01T00:00:00.000' AS DateTime), N'15 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1),
	 (N'Bùi ', N'Ngọc', N'Hành', N'007', CAST(N'1954-03-11T00:00:00.000' AS DateTime), N'332 Nguyễn Thái Học, Tp HCM', N'Nam', 25000, N'001', 4),
	 (N'Trần', N'Hồng', N'Quang', N'008', CAST(N'1967-09-01T00:00:00.000' AS DateTime), N'80 Lê Hồng Phong, Tp HCM', N'Nam', 25000, N'001', 4),
	 (N'Đinh ', N'Bá ', N'Tiên', N'009', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5),
	 (N'Đinh ', N'Bá ', N'Tiên', N'017', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5)

INSERT INTO THANNHAN VALUES 
	(N'001', N'Minh', N'Nam', CAST(N'1932-02-29' AS Date), N'Vợ Chồng'),
	(N'005', N'Khang', N'Nam', CAST(N'1973-10-25' AS Date), N'Con Trai'),
	(N'005', N'Phương', N'Nữ', CAST(N'1948-05-03' AS Date), N'Vợ Chồng'),
	(N'005', N'Trinh', N'Nữ', CAST(N'1976-04-05' AS Date), N'Con Gái'),
	(N'009', N'Châu ', N'Nữ', CAST(N'1978-09-30' AS Date), N'Con Gái'),
	(N'009', N'Phương', N'Nữ', CAST(N'1957-05-05' AS Date), N'Vợ Chồng'),
	(N'009', N'Tiến ', N'Nam', CAST(N'1978-01-01' AS Date), N'Con Trai'),
	(N'017', N'Tiến ', N'Nam', CAST(N'1978-01-01' AS Date), N'Con Trai')
INSERT INTO CONGVIEC VALUES
	(1, 1, N'Thiết kế sản phẩm X'),
	(1, 2, N'Thử nghiệm sản phẩm X'),
	(2, 1, N'Sản xuất sản phẩm Y'),
	(2, 2, N'Quảng cáo sản phẩm Y'),
	(3, 1, N'Khuyến mãi sản phẩm Z'),
	(10, 1, N'Tin học hóa phòng nhân sự'),
	(10, 2, N'Tin học hóa phòng kinh doanh'),
	(20, 1, N'Lắp đặt cáp quang'),
	(30, 1, N'Đào tạo nhân viên Marketing'),
	(30, 2, N'Đào tạo nhân viên thiết kế')
INSERT INTO PHANCONG VALUES
	(N'001', 20, 1, 15.321547),
	(N'001', 30, 1, 20.5),
	(N'003', 1, 2, 20),
	(N'003', 2, 1, 20),
	(N'004', 3, 1, 40.7),
	(N'005', 3, 1, 10),
	(N'005', 10, 2, 10),
	(N'005', 20, 1, 10),
	(N'006', 20, 1, 30),
	(N'007', 10, 2, 10.7),
	(N'007', 30, 2, 30),
	(N'008', 10, 1, 35.2),
	(N'008', 30, 2, 5),
	(N'009', 1, 1, 32.54),
	(N'009', 2, 2, 8.9)
SELECT * FROM DEAN
SELECT * FROM PHONGBAN
SELECT * FROM DIADIEM_PHG
SELECT * FROM  NHANVIEN
SELECT * FROM THANNHAN
SELECT * FROM CONGVIEC
SELECT * FROM PHANCONG
---BIẾN
-- a. BIẾN VÔ HƯỚNG
-- Khai báo biến: declare @TenBien kieu_du_lieu
-- gán giá trị:
	set @TenBien = giá_trị
	select @TenBien = biểu_thức_cột
-- truy xuất:
	select @TenBien

-- b. BIẾN BẢNG 
-- khai báo:
	declare @TenBienBang table 
	(
		--giống tạo bảng
		ten_cot1 kieu_du_lieu thuoc_tinh,
		ten_cot2 kieu_du_lieu thuoc_tinh
	)
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

	-- có thể làm việc insert, update, delete, select như bảng
	-- không dùng được select into với biến bảng


----BÀI TẬP TRUY VẤN

--3. Sử dụng T-SQL thực hiện các truy vấn có dùng biến

/*	a. Sử dụng biến thể thực hiện Chương trình tính diện tích hình chữ nhật, khi biết chiều dài và chiều rộng*/
--KHAI BÁO BIẾN VÔ HƯỚNG
		DECLARE @CHIEUDAI FLOAT, @CHIEURONG FLOAT,@CHUVI FLOAT,@DIENTICH FLOAT
---GÁN GIÁ TRỊ
		SET @CHIEUDAI=35
		SET @CHIEURONG=30
		SET @CHUVI=(@CHIEUDAI+@CHIEURONG)*2  
		SET @DIENTICH=@CHIEUDAI*@CHIEURONG
---TRUY VẤN
					--CÁCH 1: 
--SELECT N'DIỆN TÍCH HÌNH CHỮ NHẬT LÀ: '+CAST(@DIENTICH AS nvarchar);
--SELECT N'CHU VI HÌNH CHỮ NHẬT LÀ: '+CAST(@CHUVI AS nvarchar);
					--CÁCH 2:
PRINT N'DIỆN TÍCH HÌNH CHỮ NHẬT LÀ:' + CONVERT(CHAR(10), @DIENTICH);
PRINT N'CHU VI HÌNH CHỮ NHẬT LÀ:' + CONVERT(CHAR(10), @CHUVI);
/*b. Dựa trên CSDL QLDA thực hiện truy vấn "Sử dụng biến"
1. Cho biêt nhân viên có lương cao nhất*/
----KHAI BÁO Biến vô hướng 
DECLARE @max FLOAT;
---TÌM MỨC LƯƠNG MAX TRONG BẢNG NHÂNVIEN
SELECT @max = MAX(LUONG)  FROM NHANVIEN;
--HIỂN THỊ NHÂN VIÊN CÓ LƯƠNG CAO NHẤT
SELECT * FROM NHANVIEN WHERE LUONG = @max
		
---2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
---KHAI BÁO biến vô hướng
DECLARE @avg FLOAT,@ma_p INT;
--Tìm mức lượng trung bình của phòng 'Nghiên Cứu'
SELECT @avg= AVG(LUONG) FROM NHANVIEN;
---TÌM PHÒNG NGHIÊN CỨU
SELECT @ma_P = MAPHG FROM dbo.PHONGBAN WHERE TENPHG = N'Nghiên Cứu';
---Tìm nhân viên có lương lớn hơn lương trung bình
SELECT HONV +''+TENLOT+''+TENNV AS [HỌ VÀ TÊN],PHG,LUONG FROM NHANVIEN WHERE PHG = @ma_p and LUONG > @avg;
	
		/*DECLARE @LUONG_TB float 

		SET @LUONG_TB = (SELECT AVG(LUONG)  AS 'LƯƠNG_TB' 
						FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG=NHANVIEN.PHG
						WHERE TENPHG = N'NGHIÊN CỨU')

		SELECT HONV +''+TENLOT+''+TENNV AS [HỌ VÀ TÊN],LUONG 
		FROM NHANVIEN 
		WHERE LUONG > @LUONG_TB*/
---3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó
	/*	USE QLDA
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
		SELECT * FROM @lietke*/
---Tính mức lương trung bình của từng phòng ban
---Liệt kê  tên phong ban và số lượng nhân viên củ phòng ban đó


---Khai báo biến bảng
DECLARE @ketqua TABLE(TENPHONGBAN NVARCHAR(15), SL_NHANVIEN INT, LUONGTB FLOAT);
--CHÈN DỮ LIỆU VÀO BIẾN BẢNG
INSERT INTO @ketqua
SELECT TENPHG, COUNT(MANV), AVG(LUONG) FROM NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
GROUP BY TENPHG
---TRUY CẬP DỮ LIỆU TỪ BIẾN BẢNG
SELECT TENPHONGBAN, SL_NHANVIEN,LUONGTB FROM @ketqua WHERE LUONGTB >30000
	---	4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
	/*	USE QLDA
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
		SELECT * FROM @lietke*/

---KHAI BÁO 
DECLARE @thongke TABLE( MAPHONG INT, SOLUONG INT);
--CHÈN DỮ LIỆU VÀO BIẾN BẢNG
INSERT INTO @thongke
SELECT PHONG, COUNT(MADA) FROM DEAN
GROUP BY PHONG;
---TRUY CẬP DỮ LIỆU TỪ BIẾN BẢNG
SELECT A.TENPHG, B.* FROM PHONGBAN A JOIN @thongke b ON A.MAPHG = B.MAPHONG

