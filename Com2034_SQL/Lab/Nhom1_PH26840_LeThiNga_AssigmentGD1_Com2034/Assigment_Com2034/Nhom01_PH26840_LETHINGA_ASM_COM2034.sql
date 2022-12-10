												-- *** Assignment Com2034 *** ---
--Tạo database 
CREATE DATABASE QL_NHATRO
GO
USE QL_NHATRO

--Tạo bảng LOAINHA
IF OBJECT_ID('LOAINHA') IS NOT NULL
DROP TABLE LOAINHA
CREATE TABLE LOAINHA (
	MALOAINHA VARCHAR(5) NOT null,
	TENLOAINHA NVARCHAR(50)
)
GO

--Tạo bảng NGUOIDUNG
IF OBJECT_ID('NGUOIDUNG') IS NOT null
DROP TABLE NGUOIDUNG
CREATE TABLE NGUOIDUNG(
	MANGDUNG VARCHAR(5) NOT NULL,
	TENNGDUNG NVARCHAR(50),
	GIOITINH NVARCHAR(3),
	SDT VARCHAR(13),
	DCHI NVARCHAR(50),
	QUAN NVARCHAR(50),
	EMAIL NVARCHAR(30)
)
GO
--Tạo bảng NHATRO
IF OBJECT_ID('NHATRO') IS NOT NULL
DROP TABLE NHATRO
CREATE TABLE NHATRO(
	MANHATRO VARCHAR(5) NOT NULL,
	MALOAINHA VARCHAR(5) NOT NULL,
	MANGDUNG VARCHAR(5) NOT NULL,
	DIENTICH FLOAT ,
	GIAPHONG DECIMAL(10,2),
	DCHI NVARCHAR(30) NOT NULL,
	QUAN NVARCHAR(20),
	TRANGTHAI NVARCHAR(20),
	NGAYDANGTIN DATETIME
)
GO
--Tạo bảng DANHGIA
IF OBJECT_ID('DANHGIA') IS NOT NULL
DROP TABLE DANHGIA
CREATE TABLE DANHGIA(
	MANHATRO VARCHAR(5) NOT NULL,
	MANGDUNG VARCHAR(5) NOT NULL,
	TRANGTHAI NVARCHAR(20),
	NOIDUNG NVARCHAR(250)
)

--Tạo các ràng buộc giữa các bảng
ALTER TABLE LOAINHA ADD CONSTRAINT PK_LN PRIMARY KEY(MALOAINHA)
ALTER TABLE NGUOIDUNG ADD CONSTRAINT PK_ND PRIMARY KEY(MANGDUNG)
ALTER TABLE NHATRO ADD CONSTRAINT PK_NT PRIMARY KEY(MANHATRO)
ALTER TABLE DANHGIA ADD CONSTRAINT PK_DG PRIMARY KEY(MANHATRO,MANGDUNG)

ALTER TABLE NHATRO ADD CONSTRAINT FK_NT_LN FOREIGN KEY(MALOAINHA) REFERENCES LOAINHA
ALTER TABLE NHATRO ADD CONSTRAINT FK_NT_NG FOREIGN KEY(MANGDUNG) REFERENCES NGUOIDUNG
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_NT FOREIGN KEY(MANHATRO) REFERENCES NHATRO
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_ND FOREIGN KEY(MANGDUNG) REFERENCES NGUOIDUNG

--Các ràng buộc cho các cột 
ALTER TABLE NGUOIDUNG ADD CONSTRAINT UC_ND UNIQUE(SDT,EMAIL) 
ALTER TABLE NHATRO ADD CONSTRAINT CK_NT CHECK(DIENTICH > 0 AND GIAPHONG > 0)

--Chèn dữ liệu vào các bảng

--BẢNG LOAINHA
DELETE FROM LOAINHA
INSERT INTO LOAINHA VALUES
						('L1',N'Căn hộ trung cư'),
						('L2',N'NHÀ RIÊNG'),
						('L3',N'PHÒNG KHÉP KÍN')
---BANG	NGUOIDUNG
DELETE FROM NGUOIDUNG
INSERT INTO NGUOIDUNG VALUES
						('N1',N'LE THI NGA',N'NỮ','0335188503',N'THANH HOÁ',N'QUẬN 1',N'nga@gmail.com'),
						('N2',N'NGUYỄN TỬ HOÀNG',N'NAM','0335679864',N'HÀ NỘI',N'QUẬN 2',N'hoang@gmail.com'),
						('N3',N'PHAN MINH TIẾN',N'NAM','0335467986',N'NINH BÌNH',N'QUẬN 3',N'tien@gmail.com'),
						('N4',N'TRẦN THANH LONG',N'NAM','0336423978',N'HÀ NỘI',N'QUẬN 4',N'long@gmail.com'),
						('N5',N'LÊ NGỌC MAI',N'NỮ','0335185684',N'LẠNG SƠN',N'QUẬN 5',N'mai@gmail.com'),
						('N6',N'NGUYỄN ANH MINH',N'NAM','0339876535',N'HOÀ BÌNH',N'QUẬN 4',N'tuyen@gmail.com'),
						('N7',N'NGUYỄN KIM NHƯ',N'NỮ','0335987665',N'THÁI BÌNH',N'QUẬN 1',N'nhu0@gmail.com'),
						('N8',N'NGUYỄN ANH THƯ',N'NỮ','0333456876',N'NINH BÌNH',N'QUẬN 5',N'thu@gmail.com'),
						('N9',N'PHAN MINH DŨNG',N'NAM','0339087664',N'QUẢNG BÌNH',N'QUẬN 3',N'dung@gmail.com'),
						('N10',N'PHAN TÙNG',N'NAM','0335768986',N'NAM ĐỊNH',N'QUẬN 2',N'tung@gmail.com')

---BANG	NHATRO
DELETE FROM NHATRO
INSERT INTO NHATRO VALUES
						('T1','L2','N1',4.2,52000,N'73 ĐỨC DIỄN',N'QUẬN 3',N'CÒN PHÒNG','2022/06/22'),
						('T12','L1','N10',3.5,63000,N'99 CẦU DIỄN',N'QUẬN 2',N'HẾT PHÒNG','2022/05/25'),
						('T13','L3','N2',2.3,33000,N'123 PHÚ DIỄN',N'QUẬN 1',N'CÒN PHÒNG','2022/05/15'),
						('T14','L1','N4',2.5,43000,N'45 TRỊNH VĂN BÔ',N'QUẬN 3',N'HẾT PHÒNG','2022/04/10'),
						('T15','L3','N6',4.3,56000,N'52 TỐ HỮU',N'QUẬN 5',N'CÒN PHÒNG','2022/3/15'),
						('T16','L2','N3',3.6,38000,N'23 NGUYỄN TRÃI',N'QUẬN 4',N'CÒN PHÒNG','2022/5/27'),
						('T17','L2','N9',2.4,47000,N'34 HỒ TÙNG MẬU',N'QUẬN 3',N'HẾT PHÒNG','2022/5/20'),
						('T18','L3','N8',2.3,35000,N'47 BA ĐÌNH',N'QUẬN 2',N'CÒN PHÒNG','2022/5/18'),
						('T19','L1','N5',4.4,60000,N'28 MINH KHAI',N'QUẬN 1',N'HẾT PHÒNG','2022/01/07'),
						('T11','L2','N7',3.8,58000,N'65 HỒ TÙNG MẬU',N'QUẬN 5',N'CÒN PHÒNG','2022/09/20')
---BANG	DANHGIA
DELETE FROM DANHGIA
INSERT INTO DANHGIA VALUES
						('T1','N1',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T12','N10',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T13','N2',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T14','N4',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T15','N6',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T16','N3',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T17','N9',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T18','N8',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T19','N5',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T11','N7',N'DISLIKE',N'CHẤT LƯỢNG KÉM')

SELECT * FROM LOAINHA
SELECT * FROM NGUOIDUNG
SELECT * FROM NHATRO
SELECT * FROM DANHGIA
GO
---Y3. CÁC YÊU CẦU VỀ CHỨC NĂNG
-------------------------------------------------------1. THÊM CÁC THÔNG TIN VÀO BẢNG -----------------------------------------------

---Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
IF OBJECT_ID('insert_NguoiDung')  IS NOT NULL
	DROP PROC insert_NguoiDung
GO
---- SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNGIF
CREATE PROC insert_NguoiDung
	@MANGDUNG varchar(5)=NULL, 
	@TENNGDUNG nvarchar(50)=NULL,
	@GIOITINH nvarchar(3)=NULL,
	@SDT nvarchar(13)=NULL,
	@DCHI nvarchar(30)=NULL,
	@QUAN nvarchar(20)=NULL,
	@EMAIL varchar(30)=NULL
AS
BEGIN
	BEGIN TRY
		if(@MANGDUNG IS NULL )
			PRINT N'KHÔNG ĐƯỢC ĐỂ TRỐNG'	
		else
			BEGIN
				INSERT INTO NGUOIDUNG
					VALUES (@MANGDUNG,	@TENNGDUNG,@GIOITINH,@SDT,@DCHI,@QUAN,@EMAIL) 
				PRINT N'THÊM THÀNH CÔNG'
			END
	END TRY
	--BẮT LỖI
	BEGIN CATCH
		PRINT N'Lỗi:' + Error_message()
	END CATCH
END
--GỌI THỦ TỤC
--gọi thành công
EXEC insert_NguoiDung 'N11',N'HOÀNG ANH THƯ',N'NỮ','0335764328',N'ĐÀ LẠT',N'QUẬN 4',N'thuhn@gmail.com'
SELECT * FROM NGUOIDUNG
--gọi không  thành công
EXEC insert_NguoiDung 
EXEC insert_NguoiDung 'N1',N'HOÀNG ANH THƯ',N'NỮ','0335764328',N'ĐÀ LẠT',N'QUẬN 4',N'thuhn@gmail.com'

GO
--- SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
IF OBJECT_ID('insert_NhaTro')  IS NOT NULL
	DROP PROC insert_NhaTro
GO
CREATE PROC insert_NhaTro
	@MANHATRO varchar(5)= NULL,
	@MALOAINHA varchar(5)= NULL,
	@MANGDUNG varchar(5) =NULL,
	@DIENTICH float= NULL,
	@GIAPHONG decimal(10, 2)= NULL,
	@DCHI nvarchar(30) =NULL,
	@QUAN nvarchar(20) =NULL,
	@TRANGTHAI nvarchar(20) =NULL,
	@NGAYDANGTIN datetime =NULL,
	@kt1 int = 0

AS
BEGIN
	BEGIN TRY
			IF(@MANHATRO IS NULL or @MALOAINHA IS NULL or @MANGDUNG IS NULL )
				
								PRINT N' KHÔNG ĐƯỢC ĐỂ TRỐNG'

			ELSE IF  EXISTS(SELECT * FROM NHATRO WHERE MANHATRO=@MANHATRO)--KIỂM TRA KHOÁ CHÍNH
								PRINT N'MÃ NHA TRO ĐÃ TỒN TẠI'
							
			ELSE IF NOT EXISTS(SELECT * FROM LOAINHA WHERE MALOAINHA=@MALOAINHA)--KIỂM TRA KHOÁ NGOẠI
								PRINT N'MÃ LOẠI NHÀ KHÔNG TỒN TẠI'
			ELSE IF NOT EXISTS(SELECT * FROM NGUOIDUNG WHERE MANGDUNG=@MANGDUNG)--KIỂM TRA KHOÁ NGOẠI
								PRINT N'MÃ NGƯỜI DÙNG KHÔNG TỒN TẠI'
		ELSE
			BEGIN
				INSERT INTO NHATRO 
					VALUES (@MANHATRO , @MALOAINHA ,@MANGDUNG ,@DIENTICH ,@GIAPHONG ,@DCHI ,@QUAN ,@TRANGTHAI ,@NGAYDANGTIN)
				PRINT N'THÊM THÀNH CÔNG'
			END
	END TRY

	BEGIN CATCH
		PRINT N'Lỗi:' + Error_message()
	END CATCH
END
--GỌI THỦ TỤC
--gọi thành công
EXEC insert_NhaTro 'T0049','L3','N10',3.8,58000,N'65 HỒ TÙNG MẬU',N'QUẬN 5',N'CÒN PHÒNG','2022/09/20'
--gọi không thành công
EXEC insert_NhaTro 'T58','L8','N10',3.8,58000,N'65 HỒ TÙNG MẬU',N'QUẬN 5',N'CÒN PHÒNG','2022/09/20'
select * from NHATRO

GO 
----SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
IF OBJECT_ID('insert_DanhGia1')  IS NOT NULL
	DROP PROC insert_DanhGia1
GO
CREATE PROC insert_DanhGia1
	@MANHATRO varchar(5) = NULL,
	@MANGDUNG varchar(5)= NULL,
	@TRANGTHAI nvarchar(10) = NULL,
	@NOIDUNG nvarchar(250)= NULL,
	@check1 int =0,
	@check2 int =0,
	@check3 int =0
AS
BEGIN
	BEGIN TRY
			IF(@MANHATRO  IS NULL OR @MANGDUNG  IS NULL)
							BEGIN	
								PRINT N'KHÔNG ĐƯỢC ĐỂ TRỐNG '
							END
			 IF NOT  EXISTS(SELECT * FROM NHATRO WHERE MANHATRO=@MANHATRO)--KIỂM TRA KHOÁ NGAOIJ
							BEGIN
								SET @check1 = 1
								PRINT N'MÃ NHÀ TRỌ ĐÃ TỒN TẠI'
							END
			IF  NOT EXISTS(SELECT * FROM NGUOIDUNG WHERE MANGDUNG=@MANGDUNG)--KIỂM TRA KHOÁ NGOẠI
							BEGIN 
								SET @check2 = 1
								PRINT N'MÃ NGƯỜI DÙNG ĐÃ TỒN TẠI'
							END
			IF   EXISTS(SELECT * FROM DANHGIA WHERE MANGDUNG=@MANGDUNG AND MANHATRO=@MANHATRO)--KIỂM TRA KHOÁ CHÍNH
							BEGIN
								SET @check3 = 1
								PRINT N'NGƯỜI DÙNG NÀY ĐÃ ĐÁNH GIÁ CHO NHÀ TRỌ NÀY'
							END
			IF  @check1 = 0 and @check2 = 0 and @check3 = 0 
				BEGIN
					INSERT INTO DANHGIA 
						VALUES(@MANHATRO,@MANGDUNG ,@TRANGTHAI,@NOIDUNG)
					PRINT N'THÊM THÀNH CÔNG'
				END
	END TRY

	BEGIN CATCH
		PRINT N'Lỗi:' + Error_message()
	END CATCH
END
--GỌI THỦ TỤC
--gọi KHÔNG thành công
EXEC insert_DanhGia1 'T456','N346',1
EXEC insert_DanhGia1
SELECT * FROM DANHGIA
GO
---------------------------------------------------2.TRUY VẤN THÔNG TIN --------------------------------------------------------------


/*A. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các
phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
tin, khoảng giá tiền, loại hình nhà trọ*/
IF OBJECT_ID ('sp_TimKiemTro') IS NOT NULL
	DROP PROC sp_TimKiemTro  
GO
CREATE PROC sp_TimKiemTro  
		@quan nvarchar(50) = '%',
		@LoaiNha nvarchar(50) = '%',
		@DienTichMin float =null,
		@DienTichMax float =null,
		@GiaPhongMin money =null,
		@GiaPhongMax money =null,
		@NgayDangMin date = null,
		@NgayDangMax date = null	
		
		

AS
BEGIN
	IF(@DienTichMin IS NULL) SELECT @DienTichMin = MIN(DIENTICH) FROM NHATRO
	IF(@DienTichMax IS NULL) SELECT @DienTichMax = MAX(DIENTICH) FROM NHATRO
	IF(@GiaPhongMin IS NULL) SELECT @GiaPhongMin = MIN(GIAPHONG) FROM NHATRO
	IF(@GiaPhongMax IS NULL) SELECT @GiaPhongMax = MAX(GIAPHONG) FROM NHATRO
	IF(@NgayDangMin IS NULL) SELECT @NgayDangMin = MIN(NGAYDANGTIN) FROM NHATRO
	IF(@NgayDangMax IS NULL) SELECT @NgayDangMax= MAX(NGAYDANGTIN) FROM NHATRO
	SELECT (N'Cho thuê tại ' + NHATRO.DCHI + ' ' + NHATRO.QUAN) AS N'Địa chỉ thuê', --CỘT 1
			(REPLACE(CAST(DIENTICH AS VARCHAR),'.',',') + 'm2') AS N'Diện tích',--CỘT 2
			(REPLACE(CONVERT(VARCHAR,GIAPHONG,103),',','.')) AS N'Giá phòng',	--CỘT 3
			NHATRO.TRANGTHAI,													--CỘT 4
			CONVERT(NVARCHAR,NGAYDANGTIN,105) AS N'Ngày đăng tin',				--CỘT 5
			CASE GIOITINH														--CỘT 6
				WHEN  N'NỮ' THEN 'A. ' + TENNGDUNG
				WHEN  N'NAM' THEN 'C. ' +TENNGDUNG 
			END AS N'Người liên hệ',
			SDT AS N'Số điện thoại liên hệ',									---CỘT 7
			NGUOIDUNG.DCHI AS N'Địa chỉ liên hệ'								---CỘT 8
	FROM NHATRO JOIN NGUOIDUNG ON NGUOIDUNG.MANGDUNG = NHATRO.MANGDUNG
				JOIN LOAINHA ON LOAINHA.MALOAINHA=NHATRO.MALOAINHA
	WHERE (NHATRO.QUAN like @quan)
			AND(LOAINHA.TENLOAINHA=@LoaiNha) 
			AND (DIENTICH >= @DienTichMin AND DIENTICH <= @DienTichMax)
			AND (NGAYDANGTIN BETWEEN @NgayDangMin AND @NgayDangMax)
END

EXEC sp_TimKiemTro N'QUẬN 3',N'NHÀ RIÊNG'
GO
-----------------------------------------------------------------------------------------------------
/*B.. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng
NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng
NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số*/
IF OBJECT_ID ('f_NguoiDung') IS NOT NULL
	DROP FUNCTION f_NguoiDung 
GO
CREATE FUNCTION  f_NguoiDung 
	(@TENNGDUNG nvarchar(50),@GIOITINH nvarchar(3),
	 @SDT varchar(13),@DCHI nvarchar(50),@QUAN nvarchar(50),@EMAIL nvarchar(30))
RETURNS TABLE
AS	
		RETURN 
		(
			SELECT MANGDUNG FROM NGUOIDUNG
			WHERE ( TENNGDUNG = @TENNGDUNG AND GIOITINH = @GIOITINH   AND 
					SDT = @SDT   AND DCHI   = @DCHI AND QUAN  = @QUAN  AND EMAIL  = @EMAIL)
		)

SELECT * FROM f_NguoiDung(N'LE THI NGA',N'NỮ','0335188503',N'THANH HOÁ',N'QUẬN 1',N'nga@gmail.com')
------------------------------------------------------------------------------------------------------------------
/*c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng
NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này*/
IF OBJECT_ID ('f_DanhGia') IS NOT NULL
	DROP FUNCTION f_DanhGia 
GO
CREATE FUNCTION f_DanhGia(@manhatro varchar(5))
RETURNS INT
AS
BEGIN
	RETURN(SELECT COUNT(TRANGTHAI) FROM DANHGIA WHERE MANHATRO = @manhatro)
END

PRINT N'Tổng số Like và Dislike của nhà trọ la : '+CAST(dbo.f_DanhGia('T13') AS VARCHAR(10))

GO

----------------------------------------------------------------------------------------
/*d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm
các thông tin sau:*/
IF OBJECT_ID ('Vi_Top10') IS NOT NULL
Drop view Vi_Top10
GO
CREATE VIEW Vi_Top10 
AS  
	SELECT TOP 3 DIENTICH ,GIAPHONG, DANHGIA.TRANGTHAI,NGAYDANGTIN,TENNGDUNG,NGUOIDUNG.DCHI,SDT,EMAIL 
	FROM NGUOIDUNG JOIN NHATRO ON NGUOIDUNG.MANGDUNG = NHATRO.MANGDUNG
					JOIN DANHGIA ON DANHGIA.MANHATRO = NHATRO.MANHATRO
	ORDER BY (TRANGTHAI) DESC

SELECT * FROM Vi_Top10 
GO
/*e. : Viết Store Procedure nhận tham số là mã nhà trọ . Trả về các thông tin(mã nhà trọ,tên người đnáh giá,trạng thái,nd)*/
IF OBJECT_ID ('sp_DanhGia') IS NOT NULL
Drop view sp_DanhGia
GO
CREATE PROC sp_DanhGia @manhatro varchar(5)
	AS
	BEGIN
		SELECT MANHATRO,TENNGDUNG,TRANGTHAI,NOIDUNG 
		FROM DANHGIA  JOIN NGUOIDUNG ON DANHGIA.MANGDUNG = NGUOIDUNG.MANGDUNG
		WHERE MANHATRO = @manhatro
	END

	EXEC sp_DanhGia 'T16'

---------------------------------3.XOÁ THÔNG TIN-------------------------------------------
/*Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.*/


 -----------------------------------------------------------------------------
 IF OBJECT_ID('xoa_thongtin1') IS NOT NULL
DROP PROC xoa_thongtin1
GO
 CREATE PROC xoa_thongtin1 @count_dislike int
	AS
	BEGIN
		DECLARE @danhgia table( manhatro varchar(5))
		---lấy thông tin manhatro thoa man yeu cau dua vao bang tam
		INSERT INTO @danhgia 
			SELECT MANHATRO FROM DANHGIA WHERE TRANGTHAI = 'DISLIKE' 
			GROUP BY MANHATRO 
			HAVING COUNT(TRANGTHAI) > @count_dislike
		----thực hiện xoá thông tin theo yêu cầu XOÁ DÁNH GIÁ, NGƯỜi DÙNG, NGƯỜI ĐI THUÊ ,nhatro
		BEGIN TRANSACTION
			--xoá thông tin đánh giá cấc manhatro  có mặt trong @danhgia
			DELETE FROM DANHGIA WHERE MANHATRO IN (SELECT * FROM @danhgia)
			DELETE FROM NHATRO WHERE MANHATRO IN (SELECT * FROM @danhgia)
			print N'Xoá thành công'
		ROLLBACK TRAN
	END

	EXEC xoa_thongtin1 1
	SELECT * FROM dbo.DANHGIA
	SELECT * FROM dbo.NHATRO
----------------------------------------------------------------------------------------------------------------------------
---YC3.3.2:Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện
 --thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào qua các tham số.
	IF OBJECT_ID('xoa_thongtin2') IS NOT NULL
		DROP PROC xoa_thongtin2
	GO
	CREATE PROC xoa_thongtin2 @tgianbdau date,@tgiankthuc date
	AS
	BEGIN
		DECLARE @nhatro table (manhatro varchar(5))
			INSERT INTO @nhatro SELECT MANHATRO FROM NHATRO WHERE NGAYDANGTIN BETWEEN @tgianbdau AND @tgiankthuc
		BEGIN TRANSACTION
			DELETE FROM DANHGIA WHERE MANHATRO IN (SELECT manhatro FROM @nhatro) 
			DELETE FROM NHATRO WHERE MANHATRO IN (SELECT manhatro FROM @nhatro) 
			print N'Xoá thành công';
		ROLLBACK TRAN 
	END

SELECT * FROM NHATRO
EXEC xoa_thongtin2 @tgianbdau = '2022/05/25', 
                     @tgiankthuc ='2022/09/25' 


 --------------------
 


			
-------------------------------------------------
SELECT * FROM LOAINHA
SELECT * FROM NGUOIDUNG
SELECT * FROM NHATRO
SELECT * FROM DANHGIA















/*IF OBJECT_ID('sp_Sluong_Dislike') IS NOT NULL
DROP PROC sp_Sluong_Dislike
GO
CREATE PROC sp_Sluong_Dislike @slDislike INT
AS
 BEGIN 
	DECLARE @MaNhaTro TABLE (MANT VARCHAR(10))
	INSERT INTO @MaNhaTro
	---lấy thông tin manhatro thoa man yeu cau dua vao bang tam 
	SELECT MANHATRO,COUNT(TRANGTHAI) AS TongDisLike FROM DANHGIA WHERE TRANGTHAI = 'DisLike'
    GROUP BY MANHATRO 
	HAVING COUNT(TRANGTHAI)> @slDislike
	----thực hiện xoá thông tin theo yêu cầu XOÁ DÁNH GIÁ, NGƯỜi DÙNG, NGƯỜI ĐI THUÊ ,nhatro
	BEGIN TRANSACTION
	--xoá thông tin đánh giá cấc manhatro  có mặt trong @manhatro cua bảng tạm
		DELETE FROM DANHGIA WHERE MANHATRO IN (SELECT MANT FROM @MaNhaTro)
		DELETE FROM NHATRO WHERE MANHATRO IN (SELECT MANT FROM @MaNhaTro)
	print N'Xoá thành công'
	 -- sử dụng giao dịch để đảm bảo tính toàn vẹn dữ liệu
	ROLLBACK TRAN 
 END*/
