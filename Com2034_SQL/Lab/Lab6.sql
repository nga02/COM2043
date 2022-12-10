--BÀI THỰC HÀNH LAB06-COM2034
--Inserted là bảng chứa các dòng dữ liệu vừa được Insert hay Update vào bảng mà Trigger đang thực thi

--cú pháp:
create Trigger tên_Trigger on Tên_bảng
for [Insert/update/Delete]
as
	Các  lệnh sql
GO
---Baif 1:Viết trigger DML:
/*Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì
xuất thông báo “luong phải >15000*/
	IF OBJECT_ID('Insert_Luong_1500') IS NOT NULL
		DROP TRIGGER Insert_Luong_1500
	GO
	--TẠO TRIGGER
	CREATE TRIGGER trG_Insert_Luong
	ON NhanVien 
	For INSERT --KHI INSERT VÀO BẢNG NHANVIEN SẼ KIỂM TRA ĐKI
	AS
		IF(SELECT LUONG FROM inserted) < 15000 --Bảng ghi mới được ghi vào Inserted
			BEGIN
				PRINT N'Tiền lương phải lớn hơn 15000';
				ROLLBACK TRANSACTION;
			END;
	GO
	--TEST XEM TRIGGER CÓ INSERT 
	INSERT INTO NHANVIEN VALUES(N'HÀ',N'NGỌC',N'ANH',N'0585','07-06-2003',N'Hà nội',N'Nữ',35000,'006',1);
	SELECT * FROM NHANVIEN
	GO
/*Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65*/
	
	CREATE TRIGGER Trg_Insert_Age on NhanVien ---TẠO TRIGGER
	FOR INSERT 
	AS 

	DECLARE @Tuoi INT ---KHAI BÁO BIẾN 
	SET @Tuoi = YEAR(GETDATE()) - (SELECT YEAR(NGSINH) FROM INSERTED) ---tính tuổi

	--SELECT @Tuoi = DATEDIFF(YEAR,NGSINH,GETDATE()) +1 FROM INSERTED;
	---KIỂN TRA ĐIỀU KIỆN 
	IF (@Tuoi < 18 OR @Tuoi > 65)
		BEGIN 
			PRINT N'Tuổi phải nằm trong đoạn [18 ; 65]';
			ROLLBACK TRANSACTION;
		END;
	---KIỂM TRA HOẠT ĐỘNG INSERT CỦA TRIGGER
	INSERT INTO NHANVIEN VALUES(N'PHÙNG',N'MAI',N'Phương',N'0357','07-06-2009',N'Hà Nam',N'Nữ',25000,'001',1); ---lôi vì tuổi phải lớn hơn 18
	INSERT INTO NHANVIEN VALUES(N'Hoàng',N'THuý',N'Hạnh',N'0285','6-15-2002',N'Hà nội',N'Nữ',30000,'005',5);
	SELECT * FROM NHANVIEN
		
	DELETE FROM dbo.NHANVIEN WHERE MANV = N'0285'
	


/* Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM*/
	IF OBJECT_ID('Tg_CapNhat_NhanVienHCM') is not null
		DROP TRIGGER Trg_CapNhat_NhanVienHCM
	GO

	CREATE TRIGGER Trg_CapNhat_NhanVienHCM on NhanVien ---TẠO TRIGGER
	FOR UPDATE
	AS
	---KIỂN TRA ĐIỀU KIỆN 
		IF EXISTS (SELECT * FROM INSERTED WHERE DCHI LIKE N'%TP HCM%')
			BEGIN
				PRINT N'Không được cập nhật những nhân viên ở TP HCM';
				ROLLBACK TRANSACTION;
			END;
	---TEST XEM TRIGGER CÓ UPDATE KO
	UPDATE NHANVIEN
	SET HONV = 'HÀ' WHERE MANV LIKE '006' 
	SELECT * FROM NHANVIEN
go
---BÀI 2:Viết các Trigger AFTER:
/*Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
thêm mới nhân viên.*/
	CREATE TRIGGER After_Insert_NVien on NhanVien
	AFTER INSERT
	AS
--khai báo biến để lưu trữ cho câu lệnh
		DECLARE @nam int, @nu int; 
		---thực hiện câu lệnh select 
		SELECT @nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NỮ';
		SELECT @nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NAM';
--thông báo 
		print N'Tổng số nhân viên nữ:' + cast(@nu as varchar);
		print N'Tổng số nhân viên nam:' + cast(@nam as varchar);

		INSERT INTO dbo.NHANVIEN VALUES (N'Lê',N'Thanh',N'Nga',N'099','04-20-2003',N'Cầu Giấy, Hà Nội',N'Nữ',25000,N'005',1);
				SELECT * FROM dbo.NHANVIEN

	---	DELETE FROM dbo.NHANVIEN WHERE MANV = N'099'		
GO
/*Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi 
khi có hành động cập nhật phần giới tính nhân viên*/
	ALTER TRIGGER After_Update_NVien on NhanVien
	AFTER UPDATE
	AS
	IF (SELECT TOP 1 PHAI FROM deleted) != (SELECT TOP 1 PHAI FROM inserted)--lấy bản ghi đầu tiên
		BEGIN
			DECLARE @nam int, @nu int; 
			---thực hiện câu lệnh select 
			SELECT @nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NỮ';
			SELECT @nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'NAM';
	--thông báo 
			print N'Tổng số nhân viên nữ:' + cast(@nu as varchar);
			print N'Tổng số nhân viên nam:' + cast(@nam as varchar);
		END;
			UPDATE NHANVIEN
			SET PHAI = N'NỮ'
			WHERE MANV = N'006'

			SELECT * FROM NHANVIEN
GO
/*Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng
DEAN*/
	CREATE TRIGGER Trg_Delete_DeAn ON DeAn
	AFTER DELETE
	AS
		BEGIN	
			SELECT  MA_NVIEN,COUNT(MADA) AS N'Tổng số đề án: ' FROM PHANCONG 
			GROUP BY MA_NVIEN
		END
	SELECT * FROM DEAN
	
	DELETE FROM DEAN WHERE MADA LIKE N'30'

GO
---BÀI 3:Viết các Trigger INSTEAD OF
/*Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân
viên trong bảng nhân viên.*/

CREATE TRIGGER Trg_insteadOf_deleteNhanThan on NhanVien
INSTEAD OF DELETE
AS
BEGIN 
	DELETE FROM THANNHAN WHERE MA_NVIEN in (SELECT MANV FROM DELETED)
	DELETE FROM THANNHAN WHERE MA_NVIEN in (SELECT MANV FROM DELETED)
END
DELETE NHANVIEN WHERE MANV = '0590'
SELECT * FROM NHANVIEN 
GO
/*Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA
là 1*/
	CREATE TRIGGER Trg_Insert_of_NV ON NhanVien
	INSTEAD OF  INSERT
	AS
		BEGIN 
			DECLARE @manv char(5) 
			SET @manv = (SELECT MANV FROM INSERTED)
			INSERT INTO PhanCong VALUES (@maNV,1 ,1 ,15.00)
		END;
	GO
	INSERT INTO NhanVien VALUES  ( N'Nguyễn' , N'Thị' , N'Thu' ,  N'0865' , '1998-12-11' , N'Vĩnh Phúc' , N'Nu' , 19000 , null , 1 );
	GO				
	SELECT * FROM PHANCONG	
	SELECT * FROM NHANVIEN
