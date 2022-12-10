
=========================================================================================
-- IF <biểu thức điều kiện> {<Câu lệnh>|BEGIN...END} [ELSE {<Câu lệnh>|BEGIN...END}] 
========================================================================================
---print xếp loại
   declare @diem float = 2.5
   if (@diem<5)
		print N'Xếp loại trượt'
	else
		begin
			print N'Xếp loại:Dạt'
			print N'Chúc mừng bạn'
		end
--- lý luận miền xếp loại:
		--Nếu điểm <5: trượt
		--Nếu điểm từ 5 đến <6: Trung bình
		--Nếu điểm từ 6 đến <7: Trung bình Khá
		--Nếu điểm từ 7 đến <8: Khá
		--Nếu điểm từ 8 đến <9: Giỏi
		--còn lại: xuất sắc
go
		declare @diem float = 8
		if (@diem < 5)
			print N'Bạn đã trượt rồi!'
		else if (@diem< 6)
			print N'Xếp loại: Trung bình'
		else if (@diem< 7)
			print N'Xếp loại: Trung bình khá'
		else if (@diem< 8)
			print N'Xếp loại:Khá'
		else if (@diem< 9)
			print N'Xếp loại: Giỏi'
		else
			print N'xếp loại: Xuất Sắc'

-- VD2: Nếu tồn tại Nhân viên có lương >50000 thì xuất DS Nhân viên này.
-- Nếu không thì thông báo: Không có nhân viên có lương >50000

--CÁCH 1:
GO
    IF EXISTS( SELECT * FROM NHANVIEN WHERE LUONG >50000)
			BEGIN
			PRINT N'THÔNG TIN NHÂN VIÊN CÓ LƯƠNG >50000'
			    SELECT * FROM NHANVIEN
				WHERE LUONG > 50000
			END
	
	ELSE
	    PRINT N'KHÔNG CÓ NHÂN VIÊN CÓ LƯƠNG >50000'
-------------------------------------------------------------
--CÁCH 2:	
	DECLARE @soNV INT 
	SELECT @soNV = COUNT(MANV)
	FROM NHANVIEN
	WHERE LUONG > 50000

	IF(@soNV >0)
		BEGIN
			PRINT N'THÔNG TIN NHÂN VIÊN CÓ LƯƠNG >50000'
			SELECT * FROM NHANVIEN 
			WHERE LUONG > 50000
		END
	ELSE
	    PRINT N'KHÔNG CÓ NHÂN VIÊN CÓ LƯƠNG >50000'

----SỬ DỤNG IFF FUNCITON
-- VD3: Lấy thông tin nhân viên: MaNV, tenNV, luong, chucVu
--Trong đó: nếu luong>30000 thì chức vụ là trưởng phòng, còn lại là Nhân viên

SELECT MANV,TENNV,LUONG,
		chucvu = iif(LUONG>30000,N'Trưởng Phòng',N'Nhân Viên')
FROM NHANVIEN


---HÀM CASE TRONG SQL SEVER



--================a.CASE ĐƠN GIẢN=====================
			CASE bieu_thuc
				WHEN giatri1 THEN kq1
				WHEN giatri2 THEN kq2
				...
				ELSE kqCuoiCung
			END
---===================================================
-- VD: cho biết thông tin NV và giới tính của họ: MaNV, Phai, LienHe
-- trong đó LienHe: 
------phai là Nam thì ghi Mr. +TenNV
------phai là Nữ thì ghi Ms. +TenNV
------còn lại thì ghi Free. +TenNV
GO
SELECT MANV,TENNV,PHAI,
		CASE PHAI
			WHEN N'NAM' THEN N'MR.' + TenNV
			WHEN N'NỮ' THEN N'MS.' + TenNV
			ELSE 'FREE.'+ TENNV
		END AS LienHe
FROM NHANVIEN


--======================b.Search case:=========================
			CASE
				WHEN bieuThucDieuKien1 THEN kq1
				WHEN bieuThucDieuKien2 THEN kq2
				....
				ELSE kqCuoiCung
			END
--==============================================================
--THỰC HIỆN VD CỦA SIMPLE CASE VỚI CÚ PHÁP SEARCH CASE
SELECT MANV,TENNV,PHAI,
		CASE 
			WHEN PHAI LIKE N'NAM' THEN 'MR.' + TenNV
			WHEN PHAI LIKE N'NỮ' THEN 'MR.' + TenNV
			ELSE 'FREE.'+ TENNV
		END AS LienHe
FROM NHANVIEN


---CÁCH CỦA TRANG
SELECT MANV,PHAI, 
LienHe = case  
			WHEN PHAI = N'Nam' then 'Mr.' +TenNV
			WHEN PHAI = N'Nữ' then 'Ms.' +TENNV
			Else N'Free.' +TenNV
		END
from NHANVIEN

---CÁCH CỦA TRANG
SELECT MANV,PHAI, 
LienHe = case PHAI 
				WHEN N'Nam' then 'Mr.' +TenNV
				WHEN N'Nữ' then 'Ms.' +TENNV
				Else N'Free.' +TenNV
		END
from NHANVIEN



-----------------------------VÒNG LẶP---------------------------------------
--1.While:
    DECLARE @dem INT = 0;
	WHILE (@dem<5)
	BEGIN
	    PRINT N'Học SQL khó lắm'
		SET @dem = @dem +1
	END
	PRINT N'Học SQL cũng thường thôi'
go
-- vD1:  tính tổng các số 1->10
	DECLARE @dem int=1, @tong int =0;
	WHILE (@dem<=10)
	BEGIN
		SET @tong = @tong +@dem;
		SET @dem = @dem+1
	END 
	PRINT N'Tổng các số từ 1 đến 10 là:' + CAST (@tong as nvarchar)
go
