-- Các phím tắt cơ bản:
-- Ctrl + /: Dùng comment code
-- F5: Dùng để chạy câu lệnh SQL

-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lệnh Declare trong SQL SERVER
-- 1.1 Để khai báo biến thì các bạn sử dụng từ khóa Declare với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến

DECLARE @YEAR AS INT
DECLARE @a1 AS INT,@a2 AS VARCHAR,@a3 AS FLOAT

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022
SELECT @YEAR

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @SL_HANGTONMAX INT
SET @SL_HANGTONMAX = (SELECT MAX(SoLuongTon) FROM ChiTietSP)
--SELECT @SL_HANGTONMAX
PRINT N'Số lượng hàng tồn:' + CONVERT(VARCHAR,@SL_HANGTONMAX)

-- 1.4 Biến Bảng 
DECLARE @TB_NhanVien TABLE(Id INT,MaNV VARCHAR(50),TenNV NVARCHAR(50))
-- 1.5 Chèn dữ liệu vào biến bảng
INSERT INTO @TB_NhanVien
SELECT Id,Ma,Ten FROM NhanVien
WHERE Ten LIKE 'T%'
SELECT * FROM @TB_NhanVien

--1.6 Chèn dữ liệu vào biến bảng
DECLARE @TB_SinhVien TABLE(Id INT,Ma VARCHAR(50),Ten NVARCHAR(50))
INSERT INTO @TB_SinhVien
VALUES(1,'PH123',N'Dũng')
SELECT * FROM @TB_SinhVien
UPDATE @TB_SinhVien
SET Ten = N'Bảo'
WHERE Id = 1
SELECT * FROM @TB_SinhVien
/*
Bài tập:
1. Sử dụng biến để tính tổng 4 số trong SQL
2. Tính diện tích hình chữ nhật.
3. Sử dụng bài 1.6 triển khai insert 3 dữ liệu và áp dụng câu lệnh UPDATE và DELETE.
Bạn nào làm xong zen DB FPT SHOP ở trên Github.
*/
-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
	SELECT Id,SoLuongTon,GiaNhap
	FROM ChiTietSP
	WHERE SoLuongTon > 900

	IF @@ROWCOUNT = 0
	PRINT N'Không có sản phẩm nào tồn lớn hơn 900'
	ELSE
	PRINT N'Có dữ liệu khi truy vấn'
END
-- 1.8 Begin và End lồng nhau
BEGIN
	DECLARE @MaNV VARCHAR(MAX)
	SELECT TOP 1
		@MaNV = Ma
	FROM NhanVien
	WHERE Ten LIKE 'T%'

	IF @@ROWCOUNT <> 0
	BEGIN
		PRINT N'Có tìm thấy nhân viên có mã: ' + @MaNV
	END
	ELSE
	BEGIN
		PRINT N'Không tìm thấy nhân viên nào bắt đầu bằng chữ T'
	END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(4.9 AS INT) -- = 4
SELECT CAST(13.5 AS FLOAT)
SELECT CAST(14.9 AS VARCHAR)
SELECT CAST('14.9' AS FLOAT)
SELECT CAST('2022-05-22' AS DATETIME)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày).
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(INT,4.9)
SELECT CONVERT(VARCHAR,4.9)
SELECT CONVERT(FLOAT,'4.9')
SELECT CONVERT(DATE,'2022-05-21')

-- Các định dạng trong convert 101,102.........các tham số định dạng https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
SELECT CONVERT(VARCHAR,'05/21/2022',101)
SELECT CONVERT(DATE,'2022.05.21',102)
SELECT CONVERT(DATE,'21/05/2022',103)

--Ví dụ:  Bảng nhân viên Ngày sinh
SELECT NgaySinh AS N'Ngày Gốc',
	CAST(NgaySinh AS DATETIME) AS 'CAST',
	CONVERT(VARCHAR,NgaySinh,101) AS '101',
	CONVERT(VARCHAR,NgaySinh,102) AS '102',
	CONVERT(VARCHAR,NgaySinh,112) AS '112'
FROM NhanVien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi 2 đầu nhưng từ bản SQL 2017 trở lên mới hoạt động
*/
SELECT LEN(N'Học lại')-- =7
SELECT LTRIM(N'        Học lại')
SELECT RTRIM(N'        Học lại         ')
SELECT RTRIM(LTRIM(N'        Học lại      ')) -- Cách cũ
SELECT LEFT(N'Học Lại',3)
/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @TB_NAMES TABLE(Ten NVARCHAR(50))
INSERT INTO @TB_NAMES
VALUES(N'Dương Ngọc Bảo'),(N'Đào Văn Bảo')
SELECT Ten,
	LEN(Ten) AS N'Độ dài tên',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten) -1) AS N'Họ',
	RIGHT(Ten,LEN(Ten)- CHARINDEX(' ',Ten)) AS N'Tên' -- Ngọc Bảo
FROM @TB_NAMES
-- Tách tên đệm thành 1 cột.
-- Về Giải bài tách tên cột.

-- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 ,[  start_location ] ) = 1 số nguyên
SELECT CHARINDEX('POLY','FPT POLYTECHNIC')--= 5
SELECT CHARINDEX('POLY','FPT POLYTECHNIC',6)-- = 0 Không tìm thấy

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
SELECT SUBSTRING('FPT POLYTECHNIC',5,LEN('FPT POLYTECHNIC'))
SELECT SUBSTRING('FPT POLYTECHNIC',5,8)

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-345-678','-','_')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT REVERSE('SQL')
SELECT 'SQ' + '          ' + 'L'
SELECT 'SQ' + SPACE(30) + 'L'

-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(DATE,GETDATE())
SELECT CONVERT(TIME,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
		MONTH(GETDATE()) AS MONTH,
		DAY(GETDATE()) AS DAY

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT 
	DATENAME(YEAR,GETDATE()) AS YEAR,
	DATENAME(MONTH,GETDATE()) AS MONTH,
	DATENAME(DAY,GETDATE()) AS DAY,
	DATENAME(WEEK,GETDATE()) AS WEEK,
	DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
	DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY,
-- Truyền vào ngày tháng năm sinh lấy thông tin về thời gian.
DECLARE @NgaySinh DATE
SET @NgaySinh = '1980-07-27'
SELECT 
	DATENAME(YEAR,@NgaySinh) AS YEAR,
	DATENAME(MONTH,@NgaySinh) AS MONTH,
	DATENAME(DAY,@NgaySinh) AS DAY,
	DATENAME(WEEK,@NgaySinh) AS WEEK,
	DATENAME(DAYOFYEAR,@NgaySinh) AS DAYOFYEAR,
	DATENAME(WEEKDAY,@NgaySinh) AS WEEKDAY

-- 2.8 Câu điều kiện IF ELSE trong SQL
/* Lệnh if sẽ kiểm tra một biểu thức có đúng  hay không, nếu đúng thì thực thi nội dung bên trong của IF, nếu sai thì bỏ qua.
IF BIỂU THỨC   
BEGIN
    { statement_block }
END		  */
IF 1=2
	PRINT N'Đúng'
ELSE
	PRINT N'Sai'
-- Viết 1 chương trình đánh giá qua môn COM2034
DECLARE @DIEMTHI FLOAT
SET @DIEMTHI = 4.9
IF @DIEMTHI >= 5
	BEGIN
		PRINT N'Chúc mừng Bảo đã qua môn'
	END
ELSE
	BEGIN
		PRINT N'Chúc mừng Bảo đã đã mất 650k'
	END
-- Viết 1 chương trình đánh giá học lực 0 - 4 = Học lại, 5 - 6 = TB, 7 - 9 = Giỏi, Còn lại xuất sắc.
DECLARE @DIEMTHI FLOAT
SET @DIEMTHI = 8
IF @DIEMTHI < 5
	BEGIN
		PRINT N'Chúc mừng Bảo đã học lại'
	END
ELSE IF (@DIEMTHI >=5 AND @DIEMTHI < 7)
	BEGIN 
		PRINT N'TB'
	END
ELSE IF (@DIEMTHI >=7 AND @DIEMTHI < 9)
	BEGIN 
		PRINT N'Giỏi'
	END
-- Xem có ELSE IF HAY KHÔNG?

/*
 3.0 Hàm IIF () trả về một giá trị nếu một điều kiện là TRUE hoặc một giá trị khác nếu một điều kiện là FALSE.
IIF(condition, value_if_true, value_if_false)
*/
SELECT IIF(5>9,N'Đúng',N'Sai')

SELECT Ma,Ten,
	IIF(IdCH =1,N'Cửa Hàng 1',IIF(IdCH =2,N'Cửa Hàng 2',N'Không xác định'))
FROM NhanVien
/*
3.1 Câu lệnh CASE đi qua các điều kiện và trả về một giá trị khi điều kiện đầu tiên được đáp ứng (như câu lệnh IF-THEN-ELSE). 
Vì vậy, một khi một điều kiện là đúng, nó sẽ ngừng đọc và trả về kết quả. 
Nếu không có điều kiện nào đúng, nó sẽ trả về giá trị trong mệnh đề ELSE.
Nếu không có phần ELSE và không có điều kiện nào đúng, nó sẽ trả về NULL.
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/
SELECT Ma,
	Ten = (CASE GioiTinh
	WHEN 'Nam' THEN 'Anh. ' + Ten
	WHEN N'Nữ' THEN N'Chị. ' + Ten
	ELSE N'Không xác định'
	END),
	GioiTinh
FROM NhanVien

SELECT Ma,
	Ten = (CASE 
	WHEN GioiTinh = 'Nam' THEN 'Anh. ' + Ten
	WHEN GioiTinh = N'Nữ' THEN N'Chị. ' + Ten
	ELSE N'Không xác định'
	END),
	GioiTinh
FROM NhanVien
/*Vòng lặp WHILE (WHILE LOOP) được sử dụng nếu bạn muốn 
chạy lặp đi lặp lại một đoạn mã khi điều kiện cho trước trả về giá trị là TRUE.*/
DECLARE @DEM INT = 0
WHILE @DEM < 5
BEGIN
	PRINT N'Lần thứ: ' + CONVERT(VARCHAR,@DEM)
	PRINT N'Muốn học môn COM2034 thì phải code nhiều'
	SET @DEM = @DEM + 1
END
/*Lệnh Break (Ngắt vòng lặp)*/
/* Lệnh Continue: Thực hiện bước lặp tiếp theo bỏ qua các lệnh trong */
DECLARE @DEM INT = 0
WHILE @DEM < 5
BEGIN
	IF @DEM = 3
	BEGIN
	SET	@DEM +=1
		CONTINUE
	END
	PRINT N'Lần thứ: ' + CONVERT(VARCHAR,@DEM)
	PRINT N'Muốn học môn COM2034 thì phải code nhiều'
	SET @DEM = @DEM + 1
END

/* 3.2 Try...Catch 
SQLServer Transact-SQL cung cấp cơ chế kiểm soát lỗi bằng TRY … CATCH
như trong các ngôn ngữ lập trình phổ dụng hiện nay (Java, C, PHP, C#).
Một số hàm ERROR thường dùng
_
ERROR_NUMBER() : Trả về mã số của lỗi dưới dạng số
ERROR_MESSAGE() Trả lại thông báo lỗi dưới hình thức văn bản 
ERROR_SEVERITY() Trả lại mức độ nghiêm trọng của lỗi kiểu int
ERROR_STATE() Trả lại trạng thái của lỗi dưới dạng số
ERROR_LINE() : Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
ERROR_PROCEDURE() Trả về tên thủ tục/Trigger gây ra lỗi
*/
BEGIN TRY
	SELECT '1a' + '1'
END TRY
BEGIN CATCH
	SELECT
	ERROR_NUMBER() AS N'Trả về mã số của lỗi dưới dạng số',
	ERROR_MESSAGE() AS N'Trả lại thông báo lỗi dưới hình thức văn bản '
END CATCH

-- Ví dụ 2: RAISERROR - Nội dung ERROR, Giúp khi PRINT sẽ mất thời gian hơn.
BEGIN TRY
	INSERT INTO MauSac VALUES('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','a')
END TRY
BEGIN CATCH
	DECLARE @erERROR_SEVERITY INT, @erERROR_MESSAGE VARCHAR(MAX),@erERROR_STATE INT
	SELECT 
		@erERROR_SEVERITY = ERROR_SEVERITY(),
		@erERROR_MESSAGE = ERROR_MESSAGE(),
		@erERROR_STATE = ERROR_STATE()
	RAISERROR(@erERROR_MESSAGE,@erERROR_SEVERITY,@erERROR_STATE)
END CATCH
-- 3.4 Ý nghĩa của Replicate
DECLARE @ten1234 NVARCHAR(50)
SET @ten1234 = REPLICATE(N'Á',5)--Lặp lại số lần với String truyền vào
PRINT @ten1234

/* TỔNG KẾT STORE PROCEDURE :
 -- Là lưu trữ một tập hợp các câu lệnh đi kèm trong CSDL cho phép tái sử dụng khi cần
 -- Hỗ trợ các ứng dụng tương tác nhanh và chính xác
 -- Cho phép thực thi nhanh hơn cách viết từng câu lệnh SQL
 -- Stored procedure có thể làm giảm bớt vấn đề kẹt đường truyền mạng, dữ liệu được gởi theo gói.
 -- Stored procedure có thể sử dụng trong vấn đề bảo mật, phân quyền
 -- Có 2 loại Store Procedure chính: System stored	procedures và User stored procedures   
 
 -- Cấu trúc của Store Procedure bao hồm:
	➢Inputs: nhận các tham số đầu vào khi cần
	➢Execution: kết hợp giữa các yêu cầu nghiệp vụ với các lệnh
	lập trình như IF..ELSE, WHILE...
	➢Outputs: trả ra các đơn giá trị (số, chuỗi…) hoặc một tập kết quả.
 
 --Cú pháp:
 CREATE hoặc ALTER(Để cập nhật nếu đã tồn tại tên SP) PROC <Tên STORE PROCEDURE> <Tham số truyền vào nếu có>
 AS
 BEGIN
  <BODY CODE>
 END
 ĐỂ GỌI SP dùng EXEC hoặc EXECUTE
SPs chia làm 2 loại:
System stored procedures: Thủ tục mà những người sử dụng chỉ có quyền thực hiện, không được phép thay đổi.	
User stored procedures: Thủ tục do người sử dụng tạo và thực hiện.
 -- SYSTEM STORED PROCEDURES
 Là những stored procedure chứa trong Master Database, thường bắt đầu bằng tiếp đầu ngữ	 sp_
 Chủ yếu dùng trong việc quản lý cơ sở dữ liệu(administration) và bảo mật (security).
❑Ví dụ: sp_helptext <tên của đối tượng> : để lấy định nghĩa của đối tượng (thông số tên đối
tượng truyền vào) trong Database
 */

 --  Ví dụ cơ bản:
 GO
 CREATE PROCEDURE SP_DSNhanVienNam -- CREATE, DROP, ALTER
 AS
 SELECT * FROM NhanVien WHERE GioiTinh = 'NAM'

 GO
 CREATE PROC SP_DSNhanVienNuCH1
 AS
 SELECT * FROM NhanVien WHERE GioiTinh = N'NỮ' AND IdCH = (SELECT ID FROM CuaHang WHERE Ma = 'CH1')

 --  Thực thi Store PROC chỉ cần biết tên Store
 EXECUTE SP_DSNhanVienNam
 EXEC SP_DSNhanVienNuCH1

 -- TRIỂN KHAI STORE PROC NÂNG CAO - GIÚP QUA MÔN, HỌC JAVA3, DỰN ÁN 1 hoặc 2

 GO
 CREATE PROC SP_CRUD_TBNhaSX(@Id INT,
							@Ma VARCHAR(20),
							@Ten NVARCHAR(30),
							@SqlType VARCHAR(10))
 AS
 BEGIN
	IF @SqlType = 'SELECT'
	BEGIN
		SELECT * FROM NSX
	END
	IF @SqlType = 'INSERT'
	BEGIN
		INSERT INTO NSX VALUES(@Ma,@Ten)
	END
	IF @SqlType = 'DELETE'
	BEGIN
		DELETE NSX WHERE Id = @Id
	END
	IF @SqlType = 'UPDATE'
	BEGIN
		UPDATE NSX SET Ma = @Ma,Ten = @Ten
		WHERE Id = @Id
	END
 END

 EXEC SP_CRUD_TBNhaSX @Id = 0,@Ma = '',@Ten = '',@SqlType = 'SELECT'
 EXEC SP_CRUD_TBNhaSX @Id = 0,@Ma = 'Dungna',@Ten = 'D',@SqlType = 'INSERT'

 -- Bài Tập Viết STORE PROC CRUD BẢNG NHÂN VIÊN Không truhyền khóa phụ mà là truyền mã MÃ CỬA HÀNG, MÃ CHỨC VỤ. CÒN CÁC THAM SỐ HỢP LÝ.

 /* TRIGGER DML 
❑Các trigger DML được thực thi khi sự kiện DML	xảy ra trong các bảng hoặc VIEW.
❑Trigger DML này bao gồm các câu lệnh INSERT, UPDATE và DELETE.
❑Các trigger DML gồm ba loại chính:Trigger	INSERT, Trigger UPDATE, Trigger DELETE
Sinh ra Các bảng Inserted và Deleted
❖Các trigger DML sử dụng hai loại bảng đặc biệt để sửa đổi dữ liệu trong cơ sở dữ liệu.
❖Các bảng tạm thời lưu trữ dữ liệu ban đầu cũng như	 dữ liệu đã sửa đổi. Những bảng này gồm Inserted và	Deleted.
❖Bảng Inserted:chứa bản sao các bản ghi được sửa đổi với hoạt động INSERT và UPDATE trên bảng trigger.
Hoạt động INSERT và UPDATE sẽ tiến hành chèn các bản ghi mới vào bảng Inserted và bảng trigger.
❖Bảng Deleted:chứa bản sao của các bản ghi được sửa đổi với hoạt động DELETE và UPDATE trên bảng trigger
*/
/*
 Trigger INSERT
❖Trigger INSERT được thực thi khi một bản ghi mới được chèn vào bảng
❖Trigger INSERT đảm bảo rằng giá trị đang được nhập	phù hợp với các ràng buộc được định nghĩa trên bảng đó.
❖Bảng Inserted và Deleted về khía cạnh vật lý chúng không tồn tại trong cơ sở dữ liệu
❖Trigger INSERT được tạo ra bằng cách sử dụng từ  khóa INSERT trong câu lệnh CREATE TRIGGER và ALTER TRIGGER.
 
CREATE TRIGGER Tên_trigger ON Tên_Bảng
FOR {DELETE, INSERT, UPDATE}
AS
BEGIN
	Câu lệnh T-SQL
END 
❖tên_trigger: chỉ ra tên của trigger do người dùng tự đặt
❖Tên bảng: chỉ ra bảng mà trên đó trigger DML được tạo ra
(bảng trigger).
❖FOR : hoạt động thao tác dữ liệu.
❖Câu lệnh sql: chỉ ra các câu lệnh SQL được thực thi trong
trigger DML
 */
 -- Ví dụ 1: 
 GO
 ALTER TRIGGER TG_Insert_CheckGioiTinh ON NhanVien
 FOR INSERT
 AS
 BEGIN
	IF((SELECT GioiTinh FROM inserted) IS NULL) OR (LEN((SELECT GioiTinh FROM inserted)) < 2)
	BEGIN
		PRINT N'Không thể INSERT Giới Tính Null Hoặc độ dài bé hơn 1 ký tự'
		ROLLBACK TRANSACTION
	END
 END

INSERT INTO NhanVien
VALUES ('NV1992911a',N'Dũng',N'Anh',N'Nguyễn',NULL,'1991-05-03',N'152 Hàng Buồm Hà Nội','0988147200',1,17,null,1)

/*
 Trigger UPDATE
❖Trigger UPDATE sao chép bản ghi gốc vào bảng  Deleted và bản ghi mới vào bảng Inserted
❖Nếu các giá trị mới là hợp lệ thì bản ghi từ bảng Inserted sẽ được sao chép vào bảng dữ liệu
❖Trigger UPDATE được tạo ra bằng cách sử dụng từ khóa UPDATE trong câu lệnh CREATE TRIGGER và ALTER TRIGGER.
❖Cú pháp tương tự trigger insert
 
CREATE TRIGGER Tên_trigger ON Tên_Bảng
FOR {DELETE, INSERT, UPDATE}
AS
BEGIN
	Câu lệnh TSQL
END  
 */

 GO
 CREATE TRIGGER TG_UPDATE_CheckGioiTinh ON NhanVien
 FOR UPDATE
 AS
 BEGIN
	IF((SELECT GioiTinh FROM inserted) IS NULL) OR (LEN((SELECT GioiTinh FROM inserted)) < 2)
	BEGIN
		PRINT N'Không thể UPDATE Giới Tính Null Hoặc độ dài bé hơn 1 ký tự'
		ROLLBACK TRANSACTION
	END
 END

 UPDATE NhanVien SET GioiTinh = NULL WHERE Ma = 'NV1'

 --TRIGGER DELETE
 GO
 CREATE TRIGGER TG_DELETE_HOADON ON HoaDon
 INSTEAD OF DELETE
 AS
 BEGIN
	DELETE FROM HoaDonChiTiet WHERE IdHoaDon IN(SELECT Id FROM deleted)
	DELETE FROM HoaDon WHERE Id IN(SELECT Id FROM deleted)
 END
 DELETE FROM HoaDon WHERE Id = 1

 /*
HÀM NGƯỜI DÙNG TỰ ĐỊNH NGHĨA
❑Là một đối tượng CSDL chứa các câu lệnh SQL,
được biên dịch sẵn và lưu trữ trong CSDL.
❑Thực hiện một hành động như các tính toán
phức tạp và trả về kết quả là một giá trị.
❑Giá trị trả về có thể là:
	❖Giá trị vô hướng
	❖Một bảng
SO SÁNH HÀM VỚI THỦ TỤC
❑Tương tự như Stored Procedure
❖Là một đối tượng CSDL chứa các câu lệnh SQL, được
biên dịch sẵn và lưu trữ trong CSDL.
❑Khác với Stored Procedure
➢Các hàm luôn phải trả về một giá trị, sử dụng câu lệnh
RETURN
➢Hàm không có tham số đầu ra
➢Không được chứa các câu lệnh INSERT, UPDATE, DELETE
một bảng hoặc view đang tồn tại trong CSDL
➢Có thể tạo bảng, bảng tạm, biến bảng và thực hiện các câu
lệnh INSERT, UPDATE, DELETE trên các bảng, bảng tạm,
biến bảng vừa tạo trong thân hàm
Hàm giá trị vô hướng: Trả về giá trị đơn của mọi kiểu dữ liệu
Hàm giá trị bảng đơn giản: Trả về bảng, là kết quả của một câu SELECT đơn.
Hàm giá trị bảng nhiều câu lệnh: Trả về bảng là kêt quả của nhiều câu lệnh
*/

-- Ví dụ 1: Viết 1 Hàm tính tuổi người dùng khi họ nhập vào năm sinh
GO
ALTER FUNCTION F_TinhTuoi(@Ns Int)
RETURNS INT -- Phải sử dụng RETURNS để định nghĩa kiểu trả về của hàm
AS
BEGIN
	RETURN YEAR(GETDATE()) - @Ns
END
-- Khi sử dụng hàm bắt buộc phải có từ khóa dbo. tên hàm
PRINT dbo.F_TinhTuoi(2000)

-- Ứng dụng hàm tính tuổi vào trong câu select
SELECT Ma,Ten,NgaySinh,dbo.F_TinhTuoi(YEAR(NgaySinh)) FROM NhanVien

-- Ví dụ 2: Hàm đếm số lượng nhân viên theo giới tính
GO
create FUNCTION F_SoLuongNhanVien(@GT NVARCHAR(10))
RETURNS INT
AS 
BEGIN
	RETURN (SELECT COUNT(MANV) FROM NHANVIEN WHERE PHAI = @GT)
END
SELECT * FROM NHANVIEN
PRINT dbo.F_SoLuongNhanVien(N'Nữ')

-- Ví dụ 3: Hàm trả vè 1 bảng
GO
CREATE FUNCTION F_GetAllNV()
RETURNS TABLE
AS RETURN SELECT * FROM NhanVien

-- Khi mà hàm trả về 1 bảng thì sẽ dụng SELECT có thể sử dụng dbo. hoặc không
SELECT * FROM F_GetAllNV()

-- Ví dụ 4: Hàm trả ra các giá trị đa câu lệnh
CREATE FUNCTION F_GETALLNV_BY_GT(@GT NVARCHAR(10)) 
RETURNS @TBL_NhanVien TABLE(TenNV NVARCHAR(30),MaNV VARCHAR(20),GT NVARCHAR(10))
AS
BEGIN
	IF @GT IS NULL
	BEGIN
		INSERT INTO @TBL_NhanVien
		SELECT Ten,Ma,GioiTinh
		FROM NhanVien
		-- PRINT N'Vì giá trị giới tính truyền vào là NULL nên sẽ SELECT All'
	END
	ELSE
	BEGIN
		INSERT INTO @TBL_NhanVien
		SELECT Ten,Ma,GioiTinh
		FROM NhanVien WHERE GioiTinh = @GT
	END
	RETURN
END
/* Xóa/Sửa Nội Dung của một hàm chỉ cần dùng DROP/ALTER*/
SELECT * FROM F_GETALLNV_BY_GT(N'Nữ')


/*
VIEW là gì:
❑Che dấu và bảo mật dữ liệu
❖Không cho phép người dùng xem toàn bộ dữ liệu
chứa trong các bảng.
❖Bằng cách chỉ định các cột trong View, các dữ liệu
quan trọng chứa trong một số cột của bảng có thể
được che dấu
❑Hiển thị dữ liệu một cách tùy biến
❖Với mỗi người dùng khác nhau, có thể tạo các View
khác nhau phù hợp với nhu cầu xem thông tin của
từng người dùng
❑Lưu trữ câu lệnh truy vấn phức tạp và thường
xuyên sử dụng.
❑Thực thi nhanh hơn các câu lệnh truy vấn do đã
được biên dịch sẵn
❑Đảm bảo tính toàn vẹn dữ liệu
❖Khi sử dụng View để cập nhật dữ liệu trong các bảng
cơ sở, SQL Server sẽ tự động kiểm tra các ràng buộc
toàn vẹn trên các bản
❑Tên view không được trùng với tên bảng hoặc
view đã tồn tại
❑Câu lệnh SELECT tạo VIEW
❖Không được chứa mệnh đề INTO, hoặc ORDER BY trừ
khi chứa từ khóa TOP
❑Đặt tên cột
❖Cột chứa giá trị được tính toán từ nhiều cột khác phải
được đặt tên
❖Nếu cột không được đặt tên, tên cột sẽ được mặc
định giống tên cột của bảng cơ sở
*/
-- Ví dụ 1:
GO
CREATE VIEW View_DSNVNu
AS
SELECT * FROM NhanVien WHERE GioiTinh = N'Nữ'

/*PHÂN LOẠI VIEW
❑VIEW chỉ đọc (read-only view)
❖View này chỉ dùng để xem dữ liệu
❑VIEW có thể cập nhật (updatable view)
❖Xem dữ liệu
❖Có thể sử dụng câu lệnh INSERT, UPDATE, DELETE để
cập nhật dữ liệu trong các bảng cơ sở qua View
Yêu cầu: Câu lệnh select không được chứa
	❖Mệnh đề DISTINCT hoặc TOP
	❖Một hàm tổng hợp (Aggregate function)
	❖Một giá trị được tính toán
	❖Mệnh đề GROUP BY và HAVING
	❖Toán tử UNION
	❖Nếu câu lệnh tạo View vi phạm một trong số điều
	kiện trên. VIEW được tạo ra là VIEW chỉ đọc
*/

SELECT * FROM View_DSNVNu  WHERE IdCH = 1
-- View 1:
/*
View 1: Tạo ra 1 View báo cáo doanh số sản phẩm bao gồm các cột thông tin sau để báo cáo cho giám đốc 
của đại lý sấp xếp giảm dần theo Số lượng đã bán:
[Mã Sản Phẩm] [Tên Sản Phẩm] [Mã Dòng Sản phẩm] [Tên Dòng Sản phẩm] [Số Lượng Tồn Kho] [Số Lượng Đã Bán]
 [Số tiền lãi] 
*/
-- Store: Truyền vào mã cửa hàng trả ra được tổng tiền hàng đã bán ra trên cửa hàng đó.