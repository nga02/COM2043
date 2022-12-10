
--BÀI THỰC HÀNH LAB06-COM2034 LỚP IT17320 - BL1-SU2022

	DROP DATABASE QLDA

--HƯỚNG DẪN THỰC HÀNH LAB06-COM2034
--GIẢNG VIÊN: TRẦN THANH LONG

--BÀI 01: Viết trigger DML:

--1. Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì xuất thông báo “luong phải >15000’

		CREATE TRIGGER TR_Insert_Update_LUONG_15000
		ON NhanVien
		FOR INSERT, UPDATE -- 2 hành động cho trigger: insert, update
		AS 
		IF (SELECT LUONG FROM inserted) < 15000
		BEGIN
			PRINT N'Lương phải lớn hơn 15000.';
			ROLLBACK TRANSACTION;
		END

			-- Kiểm tra trigger có hoạt động hay không?
			INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2021',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);

			SELECT * FROM dbo.NHANVIEN

			DELETE FROM dbo.NHANVIEN WHERE MANV = N'098'

--2. Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.

			CREATE TRIGGER TR_Insert_Tuoi_18_65
			ON NhanVien
			FOR INSERT 
			AS 

			DECLARE @Tuoi INT
			--ALTER
			SELECT @Tuoi = DATEDIFF(YEAR,NGSINH,GETDATE()) + 1 FROM inserted;
			IF @Tuoi < 18 OR @Tuoi > 65

			BEGIN

			PRINT N'Tuổi của nhân viên không hợp lệ 18 <= Tuổi >= 65.';
			ROLLBACK TRANSACTION;

			END

				--Kiểm tra hoạt động của trigger
				SELECT * FROM dbo.NHANVIEN
				SELECT NGSINH = DATEDIFF(YEAR,NGSINH,GETDATE()) FROM dbo.NHANVIEN

				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2004',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);
				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2003',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);

--3. Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM

				CREATE TRIGGER TR_Update_DCHI_HCM
				ON NhanVien
				FOR UPDATE
				AS 

				IF EXISTS (SELECT DCHI FROM inserted WHERE DCHI LIKE N'%HCM%')

				BEGIN
					PRINT N'Không thể cập nhật nhân viên ở HCM';
					ROLLBACK TRANSACTION;
				END;

				--Kiểm tra hoạt động của trigger
				SELECT * FROM dbo.NHANVIEN

				UPDATE NHANVIEN
				   SET PHAI = N'Nam'
					WHERE MANV = N'001'


--BÀI 02: Viết các Trigger AFTER:
--1. Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động thêm mới nhân viên.

			CREATE TRIGGER TR_Insert_Sum_Nu_Nam
			ON NhanVien
			AFTER INSERT

			AS 

			DECLARE @Nam INT, @Nu INT;

			SELECT @Nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nữ';
			SELECT @Nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nam';

			PRINT N'Tổng số nhân viên giới tính Nữ là: ' + CAST(@Nu AS NVARCHAR);
			PRINT N'Tổng số nhân viên giới tính Nam là: ' + CAST(@Nam AS NVARCHAR);

				-- Kiểm tra trigger
				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2004',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);
				SELECT * FROM dbo.NHANVIEN

--2. Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động cập nhật phần giới tính nhân viên

			CREATE TRIGGER TR_Update_Sum_Nu_Nam
			ON NhanVien
			AFTER UPDATE
			AS 

			IF (SELECT TOP 1 PHAI FROM deleted) != (SELECT TOP 1 PHAI FROM inserted)
			BEGIN
					DECLARE @Nu INT, @Nam INT;
					SELECT @Nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nữ';
					SELECT @Nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nam';

					PRINT N'Tổng số nhân viên giới tính Nữ là: ' + CAST(@Nu AS NVARCHAR);
					PRINT N'Tổng số nhân viên giới tính Nam là: ' + CAST(@Nam AS NVARCHAR);
			END;

					--Kiểm tra hoạt động của Trigger
					SELECT * FROM dbo.NHANVIEN

						UPDATE NHANVIEN
						   SET PHAI = N'Nam'
							WHERE MANV = N'001'


--3. Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng DEAN

					CREATE TRIGGER TR_Sum_Delete_DEAN
					ON DeAn
					AFTER DELETE
					AS 

					SELECT MA_NVIEN, COUNT(MADA) AS N'Tổng số đề án nhân viên đã làm: ' FROM dbo.PHANCONG
					GROUP BY MA_NVIEN

					--Kiểm tra trigger (chú ý: Do ràng buộc => báo lỗi)

					DELETE FROM dbo.DEAN WHERE MADA LIKE N'30'

					SELECT * FROM dbo.PHANCONG
					SELECT * FROM dbo.DEAN

--BÀI 03: Viết các Trigger INSTEAD OF

--1. Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên
--Sinh viên thao khảo bài lý thuyết thầy đã thực hiện

--2. Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1

		CREATE TRIGGER TR_Insert_Instead_of_NV
		ON NhanVien
		Instead of INSERT
		AS
		 BEGIN
			DECLARE @maNV CHAR(5)= (SELECT Inserted.MaNV FROM Inserted)
			INSERT INTO PhanCong( MaNV, MaDA, STT, ThoiGian ) VALUES (@maNV,1 ,1 ,15.00)
		 END
		GO

		INSERT INTO dbo.NhanVien VALUES  ( N'Nguyễn' , N'Thị' , N'Thu' ,  N'019' , '1998-12-11' , N'Vĩnh Phúc' , N'Nu' , 19000 , null , 1 );
		GO
		 SELECT * FROM dbo.PhanCong





