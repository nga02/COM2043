---Slide 4:ĐIỀU KIỆN VÀ VÒNG LẶP
---ĐIỀU KIỆN
---=============1.CÂU LỆNH IF-ELSE====================
		IF<BIEU THUC DIEU KIEN>
			{<CAU LENH>|BEGIN...END}
		ELSE
			{<CAU LENH>|BEGIN...END}
---===========2.LỆNH IF EXISTS============================
		IF EXISTS(CÂU_LỆNH_SELECT)
			CÂU_LỆNH1 | KHỐI_LỆNH1
		ELSE
			CÂU_LỆNH2 | KHỐI_LỆNH2
---===========3.IIF FUNCTION==========================
		IIF(ĐIỀU_KIỆN, EXPR_TRUE,EXPR_FALSE);

----------HÀM XỬ LÝ ĐIỀU KIỆN---------------------
--===================HÀM CASE=====================
/*Simple CASE là so sánh một biểu thức với một bộ các biểu
thức đơn giản để xác định kết quả*/
		CASE bieu_thuc
			WHEN giatri1 THEN kq1
			WHEN giatri2 THEN kq2
			...
			ELSE kqCuoiCung
		END

/*Searched CASE là đánh giá một bộ các biểu thức Boolean để
xác định kết quả*/
		CASE
			WHEN bieuThucDieuKien1 THEN kq1
			WHEN bieuThucDieuKien2 THEN kq2
			....
			ELSE kqCuoiCung
		END
		
-------------------VÒNG LẶP------------------------
	WHILE<BIỂU THỨC ĐIỀU KIỆN>
		{<câu lệnh>|BEGIN...END}
		[BREAK]
		[CONTINUE]

----------------------LỖI--------------------------
---XỬ LÝ LỖI TRY...CATCH
	/*Thực hiện các lệnh trong khối TRY, nếu gặp lỗi sẽ
	chuyển qua xử lý bằng các lệnh trong khối CATCH*/
	BEGIN TRY
		{<CÂU LỆNH SQL> | <KHỐI CÂU LỆNH>}
	END TRY
	BEGIN CATCH
		{<CÂU LỆNH SQL>| <KHỐI CÂU LỆNH>}
	END CATCH


	SELECT @@VERSION
---VD VỀ IF...ELSE
			IF 1=1
				BEGIN 
					PRINT N' 1=1 LÀ ĐÚNG'
				END 
			ELSE 
				BEGIN
					PRINT 'SAI'
				END

--Điểm trung bình
			Declare @DTB float;
			Set @DTB = 6.5;
			IF @DTB < 5
				PRINT N'Yếu';
			Else
				IF @DTB <6.5
					PRINT N'Trung Bình';
				ELSE
					PRINT N'Khá';
-- Kiểm tra phương trình bậc 1-2
			Declare @a int = 1;
			Declare @b int = 4;
			Declare @c int = 2;
			Declare @Delta float;
			Set @Delta=@b*@b-4*@a*@c

			if @a=0
				Print N'Phương trình bậc 1';
			else
				Print N'Phương trình bậc 2';
--Kiểm tra nghiệm của phương trình bậc 2
			Declare @a int = 3;
			Declare @b int = 4;
			Declare @c int = 2;
			Declare @Delta float;
			Set @Delta=@b*@b-4*@a*@c

			If @Delta < 0
				Print N'Phương Trình Vô Nghiệm';
			else 
	
				Print N'Phương trình có nghiệm';

USE QLDA
GO
--Kiểm tra Trưởng phòng hay Nhân viên
			DECLARE @NhanVien INT;
			SET @NhanVien = 15000000;
			IF @NhanVien > 10000000
				Begin
					PRINT N'Trưởng Phòng';
				End
			ELSE
				Begin
					PRINT N'Chuyên Viên';
				End
---DS NHÂN VIÊN CÓ LƯƠNG > 30000
SELECT * FROM dbo.NHANVIEN
			If(select COUNT(*) from dbo.NHANVIEN where LUONG > 30000) > 0
				Begin
					Print N'Danh sách nhân viên IT có lương > 30000'
					Select HONV, TENLOT, TENNV, LUONG
					From dbo.NHANVIEN
					Where LUONG > 30000
				End
			Else
				Print N'Không có ai làm IT mà lương > 30000'
---
--Dùng IF lồng nhau
			Declare @DTB float
			Set @DTB = 7.5
			If @DTB < 5
				Print N' Học lực yếu';
			Else
				Begin
					If @DTB < 6.5
						Print N'Học lực trung bình';
					Else
						Print N'Học lực khá - giỏi';
				End

---DÙNG IF EXISTS
			If Exists(Select * From dbo.NHANVIEN Where LUONG > 3330000)
			Begin
				Print N'Danh sách nhân IT có lương > 30000'
				Select HONV, TENLOT, TENNV, LUONG
				From dbo.NHANVIEN
				Where LUONG > 30000 
			End
			Else
				Print N'Không có ai làm IT mà lương > 30000'
----3.CÂU LỆNH IIF
SELECT IIF(11 < 10, 'TRUE', 'FALSE' );
SELECT IIF(LUONG>30000,N'Trưởng phòng', N'Nhân viên') AS N'Chức vụ', 
HONV, TENLOT, TENNV, LUONG FROM  dbo.NHANVIEN
-=======================================================================

---DÙNG BIẾN VÔ HƯỚNG VÀ IIF
DECLARE @DTB AS float = 4;
SELECT IIF(@DTB >= 8, N'Học lực gỏi', IIF(@DTB <= 5, N'Học lực yếu',
        IIF(@DTB >= 6.5 AND @DTB < 8, N'Học lực Khá', N'Học lực trung bình')));

----VD VỀ CASE
--VD1
Select TENNV =  case PHAI
	When N'Nam' then 'Mr. '+[TENNV]
	When N'Nữ' then 'Ms. '+[TENNV]
	Else N'FreeSex. '+[TENNV]
	end
	From dbo.NHANVIEN

--VD2
DECLARE @SanPham INT
SET @SanPham = 1
SELECT 
	CASE @SanPham
		WHEN 1 THEN N'BÁNH MÌ VÀ BÁNH QUY'
		WHEN 2 THEN N'BÁNH BAO'
		WHEN 3 THEN N'HOA '
		ELSE N'KHÔNG CÓ SẢN PHẨM NÀO'
	END

---VD3
Declare @NguoiYeu INT;
Set @NguoiYeu = 1
	Select
	Case @NguoiYeu
	When 1 Then N'Nhà giàu, ,...=> Làm người yêu thì được'
	When 2 Then N'Học gỏi, ngoan hiền,...=> Làm vợ thì tốt'
	When 3 Then N'Học bình thường, ...=> Làm bạn thì được'
	Else N'Nên tránh thật xa không thì khổ'
	End as KET_QUA_THONG_KE

--==============5.CÂU LỆNH SEARCHED CASE
--Tạo thêm cột  thuế dựa vào mức lương
Use QLDA
go
Select HONV, TENLOT, TENNV,LUONG, THUE = Case
	When LUONG between 0 and 25000 then LUONG*0.1
	When LUONG between 25000 and 30000 then LUONG*0.12
	When LUONG between 30000 and 40000 then LUONG*0.15
	When LUONG between 40000 and 50000 then LUONG*0.2
	else LUONG*0.25
End
FROM NHANVIEN
--------------------------------------
Declare @Diem FLOAT;
Set @Diem = 9.5
Select 
	CASE
		WHEN @Diem >= 5 AND @Diem < 6.5 THEN N'Học lực trung bình'
		WHEN @Diem >= 6.5 AND @Diem < 8 THEN N'Học lực trung bình khá'
		WHEN @Diem >= 8 AND @Diem < 9 THEN N'Học lực giỏi'
		WHEN @Diem >= 9 AND @Diem <= 10 THEN N'Học lực xuất sắc'
		Else N'Học lực yếu'
	END AS N'Kết quả học lực';

--===================6.BÀI TẬP=============================
/*A.Viết câu truy vấn đếm số lượng nhân viên trong từng phòng ban, nếu số lượng nhân viên
nhỏ hơn 3 ➔hiển thị “Thiếu nhân viên”, ngược lại <5 hiển thị “Đủ Nhan Vien”, ngược lại
hiển thị”Đông nhân viên”*/
SELECT PHG, COUNT(MANV) AS N'Số nhân viên trong phòng',
'TRẠNG THÁI' = IIF(COUNT(MANV)<3,N'Thiếu nhân viên',
IIF(COUNT(MANV)<5,N'Đủ nhân viên', N'Đông nhân viên'))
FROM dbo.NHANVIEN GROUP BY PHG;


/*Viết câu truy vấn hiển thị TenNV và thêm cột thuế dựa vào mức lương: trong khoảng 0
and 25000 thì Thuế= LUONG*0.1, trong khoảng 25000 and 30000 thì LUONG*0.12, trong
khoảng 30000 and 40000 thì LUONG *0.15, trong khoảng 40000 and 50000 thì LUONG
*0.2, còn lại LUONG*0.25*/

Select HONV, TENLOT, TENNV, THUE = Case
	When LUONG < 25000  then LUONG*0.1
	When LUONG >= 25000 and LUONG< 30000 then LUONG*0.12
	When LUONG >= 30000 and LUONG< 40000 then LUONG*0.15
	When LUONG >= 40000 and LUONG<50000 then LUONG*0.2
	else LUONG*0.25
	End
FROM NHANVIEN
--7. So sánh câu lệnh Simple CASE và Searched CASE (sử dụng toán tử)

 --Sử dụng Simple CASE "Biểu thức"
Select TENNV =  case PHAI
	When N'Nam' then 'Mr. '+TENNV
	When N'Nữ' then 'Ms. '+TENNV
	Else N'FreeSex. '+TENNV
	end
	From dbo.NHANVIEN;

--===========================================================
--Sử dụng Searched CASE " Biểu thực điều kiện"

SELECT TENNV = CASE
	WHEN PHAI LIKE 'Nam' THEN 'Mr. '+ TENNV
	WHEN PHAI LIKE 'Nữ' THEN 'Ms. '+ TENNV
	ELSE
	'FreeSex ' + TENNV --Sử dụng với else
	END
FROM dbo.NHANVIEN;
--b. Viết câu truy vấn hiển thị TenNV và thêm cột thuế dựa vào mức lương:
	--	trong khoảng 0 and 25000 thì Thuế= LUONG*0.1, trong khoảng 25000 and 30000 thì LUONG*0.12,
	--	trong khoảng 30000 and 40000 thì LUONG *0.15, trong khoảng 40000 and 50000 thì LUONG *0.2, còn lại LUONG*0.25

SELECT * FROM dbo.NHANVIEN
SELECT HONV, TENLOT, TENNV, LUONG, N'THUẾ' = CASE
	WHEN LUONG < 25000 THEN LUONG*0.1
	WHEN LUONG >= 25000 AND LUONG < 30000 THEN LUONG*0.12
	WHEN LUONG >= 30000 AND LUONG < 40000 THEN LUONG*0.15
	WHEN LUONG >= 40000 AND LUONG <= 50000 THEN LUONG*0.2
	ELSE LUONG*0.25
	END
FROM dbo.NHANVIEN;
-----------------------------------------------------------
DECLARE @dem INT = 0;
		WHILE @dem < 5
		BEGIN
			PRINT N'Quan trọng là phương pháp học';
			SET @dem = @dem + 1;
		END;
		PRINT N'Học lập trình thì ra cũng dễ'
--================================================
--8. Câu lệnh vòng lặp WHILE
--Cú Pháp:
	WHILE<BIỂU THỨC ĐIỀU KIỆN>
		{<CÂU LỆNH> | BEGIN...END}
		[BREAK]
		[CONTINUE]
--===============================================
--Vòng lặp sẽ không thực hiện lần nào nếu ngay từ đầu @Number > 10,
--nó chỉ thực hiện và duy trì khi biến < = 10.
--Đến khi vượt quá điều kiện (> 10), vòng lặp sẽ kết thúc và tiếp tục thực thi các câu lệnh tiếp theo
DECLARE @Number INT = 1 ;
DECLARE @Total INT = 0 ;
		WHILE @Number < = 10
		BEGIN
			 SET @Total = @Total + @Number;
			 SET @Number = @Number + 1 ;
		END

		PRINT @Total;
		GO
--=============================================================
DECLARE @cnt INT = 0 ;
		WHILE @cnt <  10
		BEGIN
			 PRINT N'FPOLY'
			 SET @cnt = @cnt + 1 ;
		END

		PRINT 'KẾT THÚC VÒNG LẶP FOR';
		GO
--===============================================================
-- Câu lệnh BREAK này, vòng lặp WHILE sẽ kết thúc khi @Number đạt đến giá trị 5
		DECLARE @Number INT = 1 ;
		DECLARE @Total INT = 0 ;
 
		WHILE @Number < = 10
		BEGIN
		IF @Number = 5
		BREAK;
		ELSE
		 SET @Total = @Total + @Number;
		 SET @Number = @Number + 1 ;
		END

		PRINT @Total;
		GO
--=================================================================
--Câu lệnh CONTINUE này, chúng ta sẽ khởi động lại vòng lặp WHILE nếu biến @NUMBER có giá trị khác 5
	--Có sử dụng Continue
	DECLARE @Number INT = 1 ;
	DECLARE @Total INT = 0 ;

	WHILE @Number < = 10
	BEGIN
	IF @NUMBER = 5
	BREAK;

	ELSE
	SET @Total = @Total + @Number;
	SET @Number = @Number + 1 ;
	CONTINUE;

	END;
	PRINT @Total;
	GO
---==================================================================
--Không sử dụng Continue
	DECLARE @Number int = 1;
	DECLARE @Total int = 0;
	While @Number <= 10
	Begin
		If @Number = 5
		Break;
		Else
		Set @Total = @Total + @Number;
		Set @Number = @Number + 1;
	End
	Print @Total
--======================================================================
Declare @DemVong int = 0
		While @DemVong < 5
		Begin
			Print N' Học sql khó lắm'
			Set @DemVong = @DemVong + 1;
		End;
		Print N'Học CSDL SQL SERVER kể ra cũng không khó'
---=====================================================================
--a. Viết chương trình tính tổng các số chẵn từ 1 tới 10.
			DECLARE @num INT, @sum INT;

				SET @num = 1;
				SET @sum = 0;
	
			WHILE @num <= 10
				BEGIN
					IF @num % 2 = 0
						SET @sum = @sum + @num;
						SET @num = @num + 1;
				END;
			PRINT N'Tổng các số lẻ từ 1-10 là: ' + CAST(@sum AS VARCHAR);
--========================================================================
--b. Viết chương trình tính tổng các số chẵn từ 1 tới 10 nhưng bỏ số 4.

			DECLARE @num INT, @sum INT;
				SET @num = 1;
				SET @sum = 0;
			WHILE @num <= 10
				BEGIN
						IF @num = 4
						BEGIN
							SET @num = @num + 1;
							CONTINUE;
						END;

					IF @num % 2 = 0
						SET @sum = @sum + @num;
						SET @num = @num + 1;
				END;
			PRINT N'Tổng các số chẵn từ 1-10 bỏ 4 là: ' + CAST(@sum AS VARCHAR);
--==================================================================================
--Cách khác		
		DECLARE @Number INT = 2 ;
		DECLARE @Total INT = 0 ;
 
		WHILE @Number <= 10
		BEGIN
		   SET @Total = @Total + @Number;
		   SET @Number = @Number + 2 ;
		END
		PRINT @Total - 4;
----================================================================================
--Gộp cả 2 bài a và b

			DECLARE @num INT, @sum INT;

				SET @num = 1;
				SET @sum = 0;
	
			WHILE @num <= 10
				BEGIN
					IF @num % 2 = 0
						SET @sum = @sum + @num;
						SET @num = @num + 1;
				END;
			PRINT N'Tổng các số chẵn từ 1-10 là: ' + CAST(@sum AS VARCHAR);

				SET @num = 1;
				SET @sum = 0;
			WHILE @num <= 10
				BEGIN
						IF @num = 4
						BEGIN
							SET @num = @num + 1;
							CONTINUE;
						END;

					IF @num % 2 = 0
						SET @sum = @sum + @num;
						SET @num = @num + 1;
				END;
			PRINT N'Tổng các số chẵn từ 1-10 bỏ 4 là: ' + CAST(@sum AS VARCHAR);
--===================================================================================
-- Số lẻ
		DECLARE @counter INT = 1;
  
		WHILE @counter <= 99
		BEGIN
			PRINT @counter;
			SET @counter = @counter + 2;
		END;
---===================================================================================
-- Số chẵn
		DECLARE @counter INT = 2;
  
		WHILE @counter <= 99
		BEGIN
			PRINT @counter;
			SET @counter = @counter + 2;
		END;
--==================================================================================
--10. Xử lý lỗi TRY…CATCH

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

---===============================================================
     ERROR_NUMBER() AS ErrorNumber			--Trả lại mã lỗi (dưới dạng số)
     ERROR_SEVERITY() AS ErrorSeverity		--Trả lại mức độ nghiêm trọng của lỗi 
     ERROR_STATE() AS ErrorState				--Trả lại trạng thái của lỗi (dưới dạng số)
     ERROR_PROCEDURE() AS ErrorProcedure		--Trả lại tên của SP hoặc tên của Trigger đã phát sinh lỗi
     ERROR_LINE() AS ErrorLine				--Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
     ERROR_MESSAGE() AS ErrorMessage			--Trả lại thông báo lỗi dưới hình thức văn bản (text)
--=================================================
--Bắt và xử lý lỗi chèn dữ liệu vào bảng phòng ban		
		USE QLDA
		Begin Try
			Insert dbo.PHONGBAN
			Values (799, 'ZXK-799', '2008-07-01', '0197-05-22')
--Nếu thực thi thành công thì in ra dòng bên dưới
			Print 'SUCCESS: Record was not inserted.'
		End TRY
--Nếu có lỗi xảy ra khi chèn dữ liệu thì in ra dòng thông báo lỗi        
		Begin Catch
			Print 'FAILURE: Record was not inserted'
			Print 'ERROR ' + convert(nvarchar, error_number(),1) + ':' + error_message()
		End CATCH
---==================================================================
USE QLDA
		Begin Try
			Insert dbo.PHONGBAN
			Values (799, 'ZXK-799', '2008-07-01', '0197-05-22')
--Nếu thực thi thành công thì in ra dòng bên dưới
			Print 'SUCCESS: Record was not inserted.'
		End TRY
--Nếu có lỗi xảy ra khi chèn dữ liệu thì in ra dòng thông báo lỗi        
		Begin Catch
			SELECT
				ERROR_NUMBER() AS N'Mã lỗi',  
				ERROR_MESSAGE() AS N'Thông báo lỗi',
				ERROR_SEVERITY() AS N'Mức độ nghiêm trọng',
				ERROR_STATE() AS N'Trạng thái lỗi',
				ERROR_PROCEDURE() AS N'Thủ tục hay trigger lỗi',
				ERROR_LINE() AS N'Vị trí dòng lệnh lỗi'; 
		End Catch
----====================================================================
--11. Thủ tục RAISERROR
--Không dùng RAISERROR

		Begin Try
			Declare @result int
			Set @result = 55/0
		End TRY
		Begin Catch
			Declare
				@ErMessage Nvarchar(2048),
				@ErServerity int,
				@ErState int
			SELECT
				@ErMessage = ERROR_MESSAGE(),
				@ErServerity = ERROR_SEVERITY(),
				@ErState = ERROR_STATE()
		End Catch
---===============================================================
-- Sử dụng dùng RAISERROR
		BEGIN Try
			Declare @result int
			Set @result = 55/0
		End Try
		Begin Catch
			Declare
				@ErMessage Nvarchar(2048),
				@ErServerity int,
				@ErState int
			SELECT
				@ErMessage = ERROR_MESSAGE(),
				@ErServerity = ERROR_SEVERITY(),
				@ErState = ERROR_STATE()
		RAISERROR (	@ErMessage,
					@ErServerity,
					@ErState)
		End Catch
-----=================================================
--DEMO:
BEGIN TRY
			DECLARE @so INT;
			SET @so = 55/0;
		END TRY

		BEGIN CATCH
			DECLARE @ThongBaoLoi NVARCHAR(2048),
					@MucDoNghiemTrong INT,
					@TrangThaiLoi INT;

			SELECT
					@ThongBaoLoi = ERROR_NUMBER(),
					@MucDoNghiemTrong = ERROR_SEVERITY(),
					@TrangThaiLoi = ERROR_STATE();
			PRINT N'Thông báo lỗi cho tôi: ' + @ThongBaoLoi;

			RAISERROR (@ThongBaoLoi, @MucDoNghiemTrong, @TrangThaiLoi);
		END CATCH;

		PRINT N'Hoàn Thành Bài Demo';
--================================================================
BEGIN TRY
		DECLARE @result INT;
		SET @result = 55/0;
END TRY

BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(2048),
				@ErrorServerity INT,
				@ErrorState INT;

		SELECT
				@ErrorMessage = ERROR_NUMBER(),
				@ErrorServerity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();
		PRINT N'Thông báo lỗi cho tôi: ' + @ErrorMessage;

		RAISERROR (@ErrorMessage, @ErrorServerity, @ErrorState);
END CATCH;

	PRINT N'Hoàn Thành Bài Demo';