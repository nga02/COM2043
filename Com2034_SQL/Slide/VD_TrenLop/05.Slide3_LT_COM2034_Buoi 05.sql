/* CÁC HÀM HỆ THỐNG SQL
--1. Hàm chuyển đổi kiểu dữ liệu
--2. Hàm toán học
--3. Hàm xử lý chuỗi
--4. Hàm ngày tháng năm
*/

--I. Các hàm chuyển đổi kiểu dữ liệu:
	--Chuyển đổi ngầm (do SQL server tự thực hiện => có thứ tự ưu tiên) "Thấp => Cao"
	--Chuyển đổi tường minh: CAST, CONVERT "Cao => Thấp"
/*
1. Hàm CAST
Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác.
Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
Cú pháp: CAST(bieuthuc AS kieudulieu [(do_dai)])
Tham số:
--bieuthuc: giá trị để chuyển đổi sang kiểu dữ liệu khác,
	cũng có thể là tên của một cột trong bảng hoặc một biểu thức tính toán cần chuyển sang kiểu dữ liệu mới.
--kieudulieu: tên kiểu dữ liệu mới mà biểu thức sẽ được chuyển đổi sang.
	Có thể là một trong những kiểu như sau: bigint, int, smallint, tinyint, bit, decimal, numeric, money, smallmoney, float, real, datetime, smalldatetime, char, varchar, text, nchar, nvarchar, ntext, binary, varbinary hoặc image.
--do_dai (không bắt buộc): độ dài kiểu dữ liệu cho kết quả của char, varchar, nchar, nvarchar, binary và varbinary.
--Chú ý: Khi chuyển đổi kiểu dữ liệu float hay numeric sang số nguyên int, hàm cast sẽ cắt phần thập phân phía sau.

2. Hàm CONVERT
Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày).
Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
Cú pháp: CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
Tham số:
--kieudulieu: tên kiểu dữ liệu mới mà biểu thức sẽ được chuyển đổi sang.
	Có thể là một trong những kiểu như sau: bigint, int, smallint, tinyint, bit, decimal, numeric, money, smallmoney, float, real, datetime, smalldatetime, char, varchar, text, nchar, nvarchar, ntext, binary, varbinary hoặc image.
--do_dai (không bắt buộc): độ dài kiểu dữ liệu cho kết quả của char, varchar, nchar, nvarchar, binary và varbinary.
--bieuthuc: giá trị để chuyển đổi sang kiểu dữ liệu khác, cũng có thể là tên của một cột trong bảng hoặc một biểu thức tính toán cần chuyển sang kiểu dữ liệu mới.
--dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
	Bảng bên dưới mô tả một số định dạng thường dùng trong hàm CONVERT.

3. Xem thêm TRY_CAST, TRY_CONVERT.
*/

--1. Chuyển đổi ngầm
Select 100*0.5 as KET_QUA_VD1
Select 100*.5 as KET_QUA_VD2
-- Kết là 50.0 vì 0.5 có độ ưu tiên cao hơn

SELECT 'Today is ' + GETDATE()
-- Kết quả kiểu dữ liệu là gì?
--=> Không thể chuyển “Today is” thành kiểu DateTime
====================================================

--2. Chuyển đổi tường minh
SELECT 'Today is ' + cast(GETDATE() as varchar) as KET_QUA
SELECT N'Hôm nay là ngày:  ' + cast(GETDATE() as varchar) as NGAY_GIO_HOM_NAY
====================================================

--3. Hàm CAST

-- Cú pháp:
			CAST(bieuthuc AS kieudulieu [(do_dai)])

-- Ví dụ 01:
SELECT CAST(14.85 AS int); 
 
SELECT CAST(14.85 AS float);
 
SELECT CAST(15.6 AS varchar);

SELECT CAST(15.6 AS varchar(4)) as KET_QUA;
 
SELECT CAST('15.6' AS float);
 
SELECT CAST('2019-04-06' AS datetime);

--Ví dụ 02:
SELECT CAST('123.4' AS Decimal);

SELECT CAST(12.34 AS Decimal);

SELECT CAST(100 AS Decimal(6,2));

SELECT CAST(2.78128 AS integer);

SELECT CAST(123.78128 AS int);

SELECT CAST(2.78128 AS money);

SELECT CAST('12/15/76' AS smalldatetime);

SELECT CAST('1976-15-17 10:06:28' AS varchar);

SELECT CAST('1976-06-04 10:06:50' AS varchar);
====================================================

USE QLDA
GO
SELECT MaNV, CAST(NhanVien.MaNV as nvarchar(10)) as MA_NHAN_VIEN
from dbo.NhanVien
====================================================

-- Chuyển đổi dữ liệu khi thực hiện phép chia số nguyên

-- kết quả kiểu int
Select 50/100;

-- kết quả kiểu Dicemal
Select 50/CAST(100 as Decimal(3));

-- Câu lệnh SELECT sử dụng hàm CAST
====================================================

Use QLDA
go
Select LUONG,
CAST(NHANVIEN.LUONG as int) as IntegerLuong,
CAST(NHANVIEN.LUONG as varchar) as VarcharLuong
From dbo.NHANVIEN
====================================================

--4. Hàm CONVERT

-- Cú pháp:

			CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)

-- Ví dụ: 

Select Convert(varchar(20), 123.56);

Select Convert(int, '123');

SELECT CONVERT(int, 14.85);

SELECT CONVERT(float, 14.85);

SELECT CONVERT(varchar, 15.6);

SELECT CONVERT(varchar(4), 65.66);

SELECT CONVERT(float, '15.6');

SELECT CONVERT(datetime, '2019-05-02');

SELECT CONVERT(varchar, '05/02/2019', 101);

SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 101);

SELECT convert(varchar(25), getdate(), 120);

SELECT 'Today''s date is ' + CAST(GETDATE() as varchar) --So sánh với hàm convert
====================================================

Use QLDA
go
Select NGSINH,
cast(NGSINH as varchar) as VarcharDate,
Convert(varchar, NGSINH, 103) as VarcharVNDate,
Convert(varchar, NGSINH, 101) as VarcharForDate,
Convert(varchar, NGSINH, 105) as VarcharForDate1,
Convert(varchar, NGSINH, 110) as VarcharForDate1
From dbo.NHANVIEN
====================================================

--4. Một số hàm toán học
-- Hàm PI
--a. Tính chu vi đường tròn có bán kính là 10
Select 2*PI()*10;
--Tính diện tích hình tròn bán kính 5
Select PI()*5*5;
====================================================

--b. Hàm căn bậc 2
SELECT SQRT(25);
SELECT SQRT(2); -- trả về kiểu dữ liệu float
====================================================

--c. Hàm bình phương
SELECT SQUARE(3);
SELECT SQUARE(3.14); -- trả về kiểu dữ liệu float
====================================================

--d. Hàm Ceiling và Floor
SELECT CEILING(9/4.0); --CEILING(x): Số nguyên nhỏ nhất nhưng lớn hơn x

SELECT CEILING(1.9);

SELECT CEILING(32.65);

SELECT CEILING(32.1);

SELECT CEILING(32);

SELECT CEILING(-32.65);

SELECT CEILING(-32);

SELECT FLOOR(9/4.0); --FLOOR(x): Số nguyên lớn nhất nhưng nhỏ hơn x

SELECT FLOOR(5.1);

SELECT FLOOR(5.9);

SELECT FLOOR(5);

SELECT FLOOR(34.29);

SELECT FLOOR(-5.9);

SELECT FLOOR(-5);
====================================================

--e. Hàm ROUND:
-- Nguyên tắc làm tròn số:
-- Khi bạn làm tròn số, hệ thống sẽ kiểm tra số ở vị trí (decimal + 1):
-- Nếu số đó lớn hơn 4 thì số ở vị trí decimal sẽ cộng thêm 1. Các số ở phía sau thành 0
-- Nếu số đó nhỏ hơn 5 thì số ở vị trí decimal sẽ giữ nguyên. Các số ở phía sau thành 0

-- Ví dụ chúng ta có một số thập phân là 423.3241
-- Số:					 4  2  3  .  3  2  4  1
-- Vị trí làm tròn:		-2 -1     0  1  2  3  4
====================================================

SELECT ROUND(423.3241, -2); --có kết quả là 400.0000
SELECT ROUND(423.3241, -1); --có kết quả là 420.0000
SELECT ROUND(423.3241, 0); --có kết quả là 423.0000
SELECT ROUND(423.3241, 1); --có kết quả là 423.3000
SELECT ROUND(423.3241, 2); --có kết quả là 423.3200
SELECT ROUND(423.3241, 3); --có kết quả là 423.3240
SELECT ROUND(423.3241, 4); --có kết quả là 423.3241
====================================================

--f. Hàm ABS
use QLDA
go
Select LUONG, ABS(LUONG - 31000) MucDoChenhLenh
From dbo.NHANVIEN
-- Lương trung bình 31000 => mức độ chênh lệnh (có thể âm hoặc dường => dùng ASB)

SELECT ABS(-24);

SELECT ABS(-24.6);

SELECT ABS(-24.65);

SELECT ABS(24.65 * -1);
====================================================

--5. Các hàm xử lý chuỗi
--a. Hàm LEN:  trả về độ dài của chuỗi được chỉ định. không bao gồm các ký tự khoảng trắng ở cuối.
SELECT LEN('Quantrimang.com');

SELECT LEN('Quantrimang.com '); --Dấu cách ở cuối chuỗi không được tính vào độ dài

SELECT LEN(' Quantrimang.com'); --Dấu cách ở đầu chuỗi được tính vào độ dài

SELECT LEN(' Quantri mang.com ');

SELECT LEN(' ');

SELECT LEN(NULL);
====================================================

--b. Hàm LTRIM: Xóa tất cả các ký tự khoảng trắng khỏi vị trí đầu tiên (các vị trí bên trái) của chuỗi.
SELECT LTRIM('    Quantrimang.com');

SELECT LTRIM('    Quantrimang.com    ');

SELECT LTRIM('    Quan Tri Mang');
====================================================

--6. Các hàm ngày tháng năm
--a. Hàm GETDATE

SELECT GETDATE();

--b. Hàm DATENAME

SELECT DATENAME(year, '2019/04/28');

SELECT DATENAME(yyyy, '2019/04/28');

SELECT DATENAME(yy, '2019/04/28');

SELECT DATENAME(month, '2019/04/28');

SELECT DATENAME(day, '2019/04/28');

SELECT DATENAME(quarter, '2019/04/28');

SELECT DATENAME(hour, '2019/04/28 09:49');

SELECT DATENAME(minute, '2019/04/28 09:49');

SELECT DATENAME(second, '2019/04/28 09:49:12');

SELECT DATENAME(millisecond, '2019/04/28 09:49:12.726');
====================================================

--Ví dụ:
DECLARE @Date char(8)
set @Date='12312009'
SELECT CONVERT(datetime,RIGHT(@Date,4)+LEFT(@Date,2)+SUBSTRING(@Date,3,2));

