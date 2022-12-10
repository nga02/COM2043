					---******Lab 5:Stored procedures*********---

--Bài 1:Viết stored-procedure:
/*➢ In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của
bạn. Gợi ý:
o sử dụng UniKey để gõ Tiếng Việt ♦
o chuỗi unicode phải bắt đầu bởi N (vd: N’Tiếng Việt’) ♦
o dùng hàm cast (<biểuThức> as <kiểu>) để đổi thành kiểu <kiểu> của<biểuThức>.*/

CREATE PROC sp_Ngalt 
			@ten NVARCHAR(50)
AS
BEGIN
	PRINT 'HELLO' +  @ten
END;

EXEC sp_Ngalt N'Nga';
GO
/*➢ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.*/
CREATE PROC sp_TinhTong
		@s1 INT,@s2 INT
AS
BEGIN
	DECLARE @tong INT;
	SET @tong = @s1+@s2;
	PRINT N'Tổng là: ' + CAST(@tong AS VARCHAR);
END; 
EXEC sp_TinhTong 5, 6;
go
/*➢ Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.*/
CREATE PROC sp_Sum
		@n int
AS 
BEGIN 
	--khai báo
	DECLARE @sum int, @i int;
	--gán
	set @sum=0;
	set @i=1;
	WHILE @i <=@n
	begin 
		if @i % 2 =0
		begin 
			set @sum = @sum+@i;
		end;
		set @i=@i+1;
	end;
	print N'Tong cac so chan: ' + cast(@sum as varchar);
end;

exec sp_Sum 10
go
/*➢ Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây:*/

create proc sp_UCMax
	@so1 int,@so2 int
as
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

exec sp_UCMax 21, 7
go
---Bài 2:Sử dụng cơ sở dữ liệu QLDA, Viết các Proc:
--- Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create proc sp_timTheoMaNV
	@MaNV nvarchar(10)
as
begin
	select *from NHANVIEN where MANV=@MaNV;
end;

exec sp_timTheoMaNV  '008'
go

---Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
CREATE PROC sp_soluongNVTtrongDA @mada int
	AS
	BEGIN
		SELECT COUNT(MA_NVIEN) AS N'Số lượng nhân viên tham gia vào đề án' FROM DEAN a
		INNER JOIN PHANCONG b ON a.MADA = b.MADA
		WHERE a.MADA = @mada
		GROUP BY a.MADA
	END

	EXEC sp_soluongNVTtrongDA 1
/*Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham
gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA*/

/*Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là
@Trphg và các nhân viên này không có thân nhân.*/

/*Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có
mã @Mapb hay không*/


CREATE PROCEDURE sp_Tong3 
	@So1 int =1, @So2 int=2 
	AS
	Begin 
	Declare @Tong int 
	SET @Tong = @So1 + @So2;
	Print @Tong 
	End 

Exec sp_Tong3

go

CREATE PROC spud_TinhTong_Bien 
@s1 int,@s2 int 
AS 
DECLARE @tg int
Begin 
	set @tg=@s1+@s2;
	print N'Tong là:' + @tg AS varchar
End 

EXEC spud_TinhTong_Bien 1,3