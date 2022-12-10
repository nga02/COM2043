
--BÀI THỰC HÀNH LAB03-COM2034 LỚP IT17320 - BL1-SU2022
/*
Mục tiêu:
	1. Sử dụng các câu lệnh điều kiện
			Câu lệnh If….else
			Câu lệnh Case

	2. Sử dụng các câu lệnh vòng lặp
			Câu lệnh While
			Break và Continue

	3. Quản lý lỗi chương trình
			Try…Catch
			RAISERROR
*/
--BÀI 01: Sử dụng cơ sở dữ liệu QLDA. Thực hiện các câu truy vấn sau, sử dụng if…else và case
/*
1. Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là TenNV, cột thứ 2 nhận giá trị
	+ “TangLuong” nếu lương hiện tại của nhân viên nhỏ hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
	+ “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
*/
-- Tính lương trung bình của các phòng
-- Khai báo biên 'Tangluong'
-- Lấy thông tin => sử dụng hàm IIF

SELECT * FROM dbo.NHANVIEN

--Cách không khai báo biến
	SELECT HONV+' '+TENLOT+' '+TENNV AS N'Họ và tên',
	N'XEM XÉT TÌNH TRẠNG' = IIF(a.LUONG > b.LTB, N'Không được tăng lương', N'Được tăng lương')
	FROM dbo.NHANVIEN a JOIN (SELECT PHG, AVG(LUONG) AS LTB 
	FROM dbo.NHANVIEN GROUP BY PHG) b ON a.PHG = b.PHG;

--Cách khai báo biến bảng
DECLARE @Tangluong TABLE (PHG INT, LTB FLOAT);
	INSERT INTO @Tangluong
	SELECT PHG, AVG(LUONG) AS N'LƯƠNG TRUNG BÌNH' FROM dbo.NHANVIEN
	GROUP BY PHG  -- Thống kê lương trung bình của từng phòng
	SELECT HONV+' '+TENLOT+' '+TENNV AS N'Họ và tên', 
	IIF(LUONG < LTB, N'Được tăng lương', N'Không được tăng lương') AS N'XEM XÉT',
	LUONG, LTB AS N'Lương trung bình phòng'
	FROM dbo.NHANVIEN a JOIN @Tangluong b ON a.PHG = b.PHG;
/*
2. Viết chương trình phân loại nhân viên dựa vào mức lương:
	Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì xếp loại “nhanvien”,
	ngược lại xếp loại “truongphong"
*/
	DECLARE @Chucvu TABLE (PHG INT, LTB FLOAT);
	INSERT INTO @Chucvu
	SELECT PHG, AVG(LUONG) FROM dbo.NHANVIEN
	GROUP BY PHG
	SELECT HONV+' '+TENLOT+' '+TENNV AS N'Họ Và Tên', IIF(LUONG > LTB, N'Trưởng Phòng', N'Nhân Viên') AS N'Chức Vụ',
	LUONG, LTB AS N'LTB Phòng',b.PHG FROM dbo.NHANVIEN a JOIN @Chucvu b ON a.PHG = b.PHG

--3. Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên

SELECT IIF(PHAI = N'Nam', 'Mr.', 'Ms.') + TENNV AS N'TÊN NHÂN VIÊN THÊM TIỀN TỐ' FROM dbo.NHANVIEN
/*
4. Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
		+ 0<luong<25000 thì đóng 10% tiền lương
		+ 25000<luong<30000 thì đóng 12% tiền lương
		+ 30000<luong<40000 thì đóng 15% tiền lương
		+ 40000<luong<50000 thì đóng 20% tiền lương
		+ Luong>50000 đóng 25% tiền lương
*/
SELECT HONV+' '+TENLOT+' '+TENNV AS N'Họ Và Ten', LUONG AS N'Lương thực lĩnh', N'Số phải đóng Thuế' = 
	CASE
		WHEN LUONG > 0 AND LUONG < 25000 THEN LUONG*0.1
		WHEN LUONG > 25000  AND LUONG < 30000 THEN LUONG*0.12
		WHEN LUONG > 30000  AND LUONG < 40000 THEN LUONG*0.15
		WHEN LUONG > 40000  AND LUONG < 50000 THEN LUONG*0.2
		ELSE LUONG*0.25
	END
	FROM dbo.NHANVIEN;
--==================================================================================================

--BÀI 02: Sử dụng cơ sở dữ liệu QLDA. Thực hiện các câu truy vấn sau, sử dụng vòng lặp

--1. Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn
		SELECT * FROM dbo.NHANVIEN
			DECLARE @MAX INT, @Num INT;
			SELECT @MAX = MAX(CAST(MANV AS INT)) FROM dbo.NHANVIEN;
			SET @Num = 1;
				WHILE @Num <= @MAX
				BEGIN
					IF @Num % 2 = 0
						SELECT MANV, HONV+' '+TENLOT+' '+TENNV AS N'Họ Và Tên'FROM dbo.NHANVIEN
							WHERE CAST(MANV AS INT) = @Num;
					SET @Num = @Num + 1;
				END;

--2. Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng không tính nhân viên có MaNV là 4.

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

--BÀI 03: Quản lý lỗi chương trình
/*
1. Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
		+ Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
		+ Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai” từ khối Catch
2.Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng RAISERROR để thông báo lỗi.
*/

		SELECT * FROM dbo.PHONGBAN

		-- Chèn dữ liệu vào bảng
		BEGIN TRY
			INSERT INTO dbo.PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
			VALUES (N'SX4', 8, N'004', '2021-05-29');
			PRINT N'DỮ LIỆU ĐƯỢC CHÈN THÀNH CÔNG'
		END TRY

		BEGIN CATCH
			PRINT N'DỮ LIỆU ĐƯỢC CHÈN THẤT BẠI'
		END CATCH

-- Thực hiện phép chia lỗi

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

--=================================================
/*
1. Điều kiện
	a. IF /[Else] "Biểu thức điều kiện" => Thực hiện lệnh hoặc khối lệnh đúng/sai (Else có thể có hoặc không)
	b. IF Exists /[Else] "Câu lệnh Select" => Thực hiện lệnh hoặc khối lệnh đúng/sai (Else có thể có hoặc không)
	c. IIF(Biểu_thức_luận_lý, True, False) "Hàm lựa chọn"
			VD: SELECT IIF(Biểu_thức_luận_lý, True, False)
				FROM Tên_bảng
	d. Xử lý điều kiện
		a. Simple CASE (đơn giản)
			Cú pháp:
				CASE bieuthuc_dauvao
					WHEN bieuthuc_1 THEN ketqua_1
					WHEN bieuthuc_2 THEN ketqua_2
					...
					WHEN bieuthuc_n THEN ketqua_n
				ELSE ketqua_khac
				END

		b. Searched CASE (tìm kiếm)
			Cú pháp:
				CASE
					WHEN dieukien_1 THEN ketqua_1
					WHEN dieukien_2 THEN ketqua_2
					...
					WHEN dieukien_n THEN ketqua_n
				ELSE ketqua_khac
				END
Tham số:
	+. bieuthuc_dauvao:
		Biểu thức sẽ được so sánh với từng giá trị được cung cấp.
	+. bieuthuc_1, bieuthuc_2, bieuthuc_n:
		Các biểu thức sẽ được sử dụng để so sánh lần lượt với biểu thức đầu vào.
		Khi một biểu thức khớp với bieuthu_dauvao, CASE sẽ thực thi các câu lệnh tiếp đó và không so sánh thêm nữa.
	+. dieukien_1, dieukien_2, dieukien_n:
		Các điều kiện được xét, duyệt theo thứ tự liệt kê.
		Khi một điều kiện được xác định là đúng, CASE sẽ trả về kết quả và không đánh giá các điều kiện tiếp theo nữa.
		Tất cả các điều kiện phải là cùng một kiểu dữ liệu.
	+. ketqua_1, ketqua_2, ketqua_n:
		Kết quả trả về sau khi xét điều kiện là đúng.
		Tất cả các giá trị phải là cùng một kiểu dữ liệu.
Lưu ý:
	+. Nếu không tìm thấy bieuthuc hoặc dieukien nào là TRUE thì câu lệnh CASE sẽ trả về kết quả trong mệnh đề ELSE.
	+. Nếu không có mệnh đề ELSE đồng thời không có điều kiện nào là TRUE thì câu lệnh CASE sẽ trả về NULL.
	+. Điều kiện được đánh giá theo thứ tự được liệt kê. Khi một điều kiện được xác định là đúng, câu lệnh CASE sẽ trả về kết quả và không đánh giá các điều kiện tiếp theo nữa.

2. Vòng lặp: While, break, continue:
	+. Câu lệnh WHILE cho phép chúng ta thực hiện lặp lại một công việc nhiều lần
	+. Trong câu lệnh WHILE, có một số trường hợp chúng ta cần thoát ra khỏi vòng lặp, hay bỏ qua một vòng xử lý.
	+. Lúc này, break và continue sẽ hỗ trợ
*/
--=================================================

	DECLARE @TuoiLaoDong INT = 30
	SELECT IIF(@TuoiLaoDong <= 18, N'Chưa đủ tuổi lao động', 
			IIF(@TuoiLaoDong >=18 AND @TuoiLaoDong <= 60, N'Đang ở tuổi lao động', N'Hết tuổi lao động => Nghỉ hưu'))

--=================================================

	--Câu lệnh while

			DECLARE @Dem INT = 1;
				WHILE @Dem <= 10
					BEGIN
						PRINT @Dem;
						SET @Dem = @Dem + 1;
					END;

	-- Câu lệnh break.
 
			DECLARE @Dem INT = 0;
 				WHILE @Dem <= 10
					BEGIN
						SET @Dem = @Dem + 1;
						IF @Dem = 5
							BREAK; --Ngắt vòng lặp khi dòng lệnh trên thỏa mãn
						PRINT @Dem;
					END;
	-- Câu lện continue
 
			DECLARE @Dem INT = 0;
				WHILE @Dem <= 10
					BEGIN
						SET @Dem = @Dem + 1;
						IF @Dem = 5
							CONTINUE; --Chạy vòng lặp tiếp theo khi dòng lệnh trên thỏa mãn
						PRINT @Dem;
					END;
--=================================================

BEGIN TRY
	SELECT 1 + 'SQL';
END TRY

BEGIN CATCH
	SELECT
	ERROR_NUMBER() AS N'Mã lỗi',  
	ERROR_MESSAGE() AS N'Thông báo lỗi',
	ERROR_SEVERITY() AS N'Mức độ nghiêm trọng',
	ERROR_STATE() AS N'Trạng thái lỗi',
	ERROR_PROCEDURE() AS N'Thủ tục hay trigger lỗi',
	ERROR_LINE() AS N'Vị trí dòng lệnh lỗi'; 
END CATCH
--===================================================================================================================== 
            ERROR_NUMBER() AS ErrorNumber			--Trả lại mã lỗi (dưới dạng số)
            ERROR_SEVERITY() AS ErrorSeverity		--Trả lại mức độ nghiêm trọng của lỗi 
            ERROR_STATE() AS ErrorState				--Trả lại trạng thái của lỗi (dưới dạng số)
            ERROR_PROCEDURE() AS ErrorProcedure		--Trả lại tên của SP hoặc tên của Trigger đã phát sinh lỗi
            ERROR_LINE() AS ErrorLine				--Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
            ERROR_MESSAGE() AS ErrorMessage			--Trả lại thông báo lỗi dưới hình thức văn bản (text)
--=====================================================================================================================