
/*Bài 1: Sử dụng if...else
---------------------------------------
Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là
TenNV, cột thứ 2 nhận giá trị
	_“TangLuong” nếu lương hiện tại của nhân viên nhỏ hơn trung bình lương trong
	 phòng mà nhân viên đó đang làm việc.
	_ “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương
	 trong phòng mà nhân viên đó đang làm việc
*/
--Khai báo biến
DECLARE @tangluong TABLE(MaPB INT, LuongTB FLOAT)
	INSERT INTO @tangluong
	SELECT PHG,AVG(LUONG) AS N'Lương trung bình' FROM NHANVIEN 
	GROUP BY PHG --Thống kê lương trung bình của từng phòng

	SELECT TENNV,PHG,LUONG,LuongTB,
	TRANGTHAI = CASE
				WHEN LUONG >LuongTB THEN 'KHONG TANG LUONG'
				ELSE 'TANG LUONG'
			END
	FROM NHANVIEN a INNER JOIN @tangluong b on a.PHG = b.MaPB
GO
-----------------------------------------------------------------
/* Viết chương trình phân loại nhân viên dựa vào mức lương.
o Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì
xếp loại “nhanvien”, ngược lại xếp loại “truongphong”*/
DECLARE @thongke TABLE(MaPB INT, LuongTB FLOAT)
INSERT INTO @thongke
SELECT PHG,AVG(LUONG) FROM NHANVIEN GROUP BY PHG 

SELECT TENNV,LUONG,LUONGTB,
CHUCVU = CASE
			WHEN LUONG > LuongTB THEN 'TRUONG PHONG'
			ELSE 'NHAN VIEN'
		END
FROM NHANVIEN a INNER JOIN @thongke b on a.PHG = b.MaPB
GO
---------------------------------------------------------------
/*Viết chương trình hiển thị TenNV như hình bên dưới, 
tùy vào cột phái của nhân viên*/
SELECT TENNV = CASE 
		WHEN PHAI = 'NAM' THEN 'MR. ' + TENNV
		WHEN PHAI = N'Nữ' THEN 'MS. ' + TENNV
		ELSE N'FreeSex. '+TENNV
		END
FROM NHANVIEN
GO
/*Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
	o 0<luong<25000 thì đóng 10% tiền lương
	o 25000<luong<30000 thì đóng 12% tiền lương
	o 30000<luong<40000 thì đóng 15% tiền lương
	o 40000<luong<50000 thì đóng 20% tiền lương
	o Luong>50000 đóng 25% tiền lương
*/
select * from NHANVIEN
SELECT TENNV,LUONG,N'Thuế phải đóng' = CASE
		When LUONG > 0 and LUONG < 25000 then LUONG*0.1
		When LUONG > 25000 and LUONG < 30000 then LUONG*0.12
		When LUONG > 30000 and LUONG < 40000 then LUONG*0.15
		When LUONG > 40000 and LUONG < 50000 then LUONG*0.2
		else LUONG*0.25
		END
FROM NHANVIEN
GO
---------------------------------------------------------------
--BÀI 2:SỬ DỤNG VÒNG LẶP
--Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
DECLARE @dem INT,@i INT 
SELECT @dem = (SELECT COUNT(*) FROM NHANVIEN) 
SET @i=1;
WHILE (@i <= @dem) 
	BEGIN 
		IF (@i % 2=0)
			SELECT MANV,HONV,TENLOT,TENNV FROM NHANVIEN WHERE CAST(MANV AS INT) = @i;		
			SET @i=@i+1;
	END;
GO
/*Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng
không tính nhân viên có MaNV là 4.*/
DECLARE @MAX INT, @Num INT;
			SELECT @MAX = MAX(CAST(MANV AS INT)) FROM dbo.NHANVIEN;
			SET @Num = 1;
				WHILE @Num <= @MAX
				BEGIN
					IF @Num = 4
						BEGIN
							SET @Num = @Num + 1;
							CONTINUE;
						END
					IF @Num % 2 = 0
						SELECT MANV, HONV+' '+TENLOT+' '+TENNV AS N'Họ Và Tên'FROM dbo.NHANVIEN
							WHERE CAST(MANV AS INT) = @Num;
					SET @Num = @Num + 1;
				END;
-----------------------------------------------------------------
--BÀI 3:Quản lý lỗi chương trình
/*
1.Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
	o Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
	o Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai”
	từ khối Catch
*/
BEGIN TRY 
	INSERT PHONGBAN(TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
	VALUES (N'Ph4',9,N'011','2022-05-25')
	PRINT 'THÊM DỮ LIỆU THÀNH CÔNG'
END TRY

BEGIN CATCH
	PRINT N'THÊM DỮ LIỆU THẤT BẠI'
	PRINT 'ERROR' + convert(nvarchar, error_number(),1) + ':' + error_message()
END CATCH

/*Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng
RAISERROR để thông báo lỗi.*/
	BEGIN TRY
			DECLARE @chia INT;
			SET @chia = 28/0;
		END TRY

		BEGIN CATCH
			DECLARE @ErrMess NVARCHAR(2048), @ErrSever INT, @ErrState INT;
			SELECT	@ErrMess = ERROR_MESSAGE(),
					@ErrSever = ERROR_SEVERITY(),
					@ErrState = ERROR_STATE();
			PRINT N'Thông báo lỗi cho tôi: ' + @ErrMess;

			RAISERROR (@ErrMess, @ErrSever, @ErrState);
		END CATCH;
		PRINT N'Hoàn thành kiểm tra lỗi';
