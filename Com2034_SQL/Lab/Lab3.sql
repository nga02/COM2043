﻿i--1. Thực hiện chuyển đổi ngầm (ít nhất 5 chuyển đổi, giải thích mức độ ưu tiên) ----Chuyển đổi ngầm (do SQL server tự thực hiện) SELECT 100 * .5  SELECT 2134.8765*3 SELECT 10.5*5.0 SELECT 3567*.655 SELECT 1.0*.10  --2. Thực hiện chuyển đổi từng minh sử dụng hàm CAST: Cú pháp, giải thích tham số, ít nhất 5 chuyển đổi --Cú pháp:  	CAST(bieuthuc AS kieudulieu [(do_dai)]) --VÍ DỤ SELECT CAST(74.78575 AS INT);--CHUYỂN VỀ KIỂU SỐ NGUYÊN  SELECT CAST(12.2 as FLOAT);--CHUYỂN VỀ KIỂU SỐ THỰC  SELECT CAST('12.786' AS varchar(4))--chuyển về kiểu chuỗi VỚI ĐỘ DÀI LÀ 4 KÍ TỰ  SELECT CAST('2022-05-19' AS DATETIME)-- CHUYỂN VỀ ĐỊNH DẠNG THỜI GIAN KIỂU NGÀY GIỜ YYYY-MM-DD HH:MI:SS  SELECT CAST(100 AS Decimal(6,2));---CHUYỂN VỀ KIỂU CHUỖI  CHO PHÉP 1 DẤU THẬP PHÂN CỐ ĐỊNH  --3. Thực hiện chuyển đổi từng minh sử dụng hàm CONVERT: Cú pháp, giải thích tham số, ít nhất 5 chuyển đổi -- Cú pháp: 			CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang) 	Trong đó:  		type: Kiểu dữ liệu mà bạn muốn chuyển đổi biểu thức thành 		length: Không bắt buộc. Độ dài của kiểu dữ liệu kết quả cho char, varchar, nchar, nvarchar, binary và varbinary. 		expression: Biểu thức để chuyển đổi sang kiểu dữ liệu khác. 		style: Không bắt buộc. Định dạng được sử dụng để chuyển đổi giữa các kiểu dữ liệu --VÍ DỤ SELECT CONVERT(INT,12.75) --KQ=12: CẮT BỎ PHẦN THẬP PHÂN SELECT CONVERT(FLOAT,'12.75') --CHUYỂN VỀ ĐỊNH DẠNG KIỂU SỐ THỰC SELECT CONVERT(VARCHAR(4),'12.75')--CHUYỂN VỀ 1 CHUỖI  SELECT CONVERT(DATETIME,'2022-05-19')--CHYỂN VỀ ĐỊNH DẠNG KIỂU NGÀY GIỜ YYYY-MM-DD HH:MI:SS SELECT CONVERT(varchar, '05/02/2019', 101);--CHUYỂN VỀ ĐỊNH DẠNG NGÀY THÁNG NĂM --4. Thực hiện các hàm toán học (mỗi hàm ít nhất 3 bài): PI, SQRT, SQUARE, CEILING, FLOOR, ROUND, ABS,... ---Hàm PI SELECT 2*PI()*10; --CHU VI HÌNH TRÒN SELECT PI()  SELECT PI()*5*5;--DIỆN TÍCH HÌNH TRÒN --Hàm SQRT:tính căn bậc 2 của 1 số or 1 biểu thức SELECT SQRT(9) SELECT SQRT(25-6) SELECT SQRT(5*7)---- trả về kiểu dữ liệu float ---Hàm SQUARE:tính bình phương của một số SELECT SQUARE(5) SELECT SQUARE(5.343) SELECT SQUARE(-6) ---HÀM POWER():TÍNH LUỸ THỪA SELECT POWER(3,2)--KQ=9 SELECT POWER(5-7,3)--KQ=-8 ---Hàm CEILING: lấy cận trên của 1 só SELECT CEILING(5.678) --KQ=6 SELECT CEILING(-5.678) --KQ=-5 SELECT CEILING(5) ---KQ=5 ---Hàm FLOOR:lấy  cận dưới của 1 sso SELECT FLOOR(34/8) SELECT FLOOR(-5.678) SELECT FLOOR(27.45-12.156) ---Hàm ROUND: làm tròn SELECT ROUND(25.45578,3)--ĐỘ CHÍNH XÁC TỚI 3 CON SỐ SAU DẤU CHẤM SELECT ROUND(256.45578,-2)--KQ=300.00000 ĐỘ CHÍNH XÁC TỚI 3 CON SỐ TRƯỚC DẤU CHẤM SELECT ROUND(256.45578,0)--KQ=256.00000 ---HÀM ABS:Lấy giá trị tuyệt đối của biểu thức or số SELECT ABS(5) SELECT ABS(3-45) SELECT ABS(-25) /*5. Thực hiện các hàm sử lý chuỗi (mỗi hàm ít nhất 3 bài): LEN, LTRIM, RTRIM, LEFT, RIGHT, SubString, REPLACE, REVERSE, LOWER, UPPER, SPACE, CHARINDEX, GETDATE, DATENAME,...*/ --Hàm LEN:ĐỘ DÀI CHUỖI SELECT LEN('FPOLY') --kq=5 SELECT LEN(' ')--kq=0 SELECT LEN(NULL)--kq=NULL SELECT LEN(' FPOLY')----Dấu cách ở ĐẦU chuỗi  được tính vào độ dài SELECT LEN(' FPOLY ')----Dấu cách ở CUỐI chuỗi KHÔNG  được tính vào độ dài --Hàm LTRIM:xoá các ký tự trắng ở đầu chuỗi SELECT LTRIM('  FPOLY') SELECT LTRIM('  FPOLY   ') SELECT LTRIM('  FPOLY HA NOI  ') --Hàm RTRIM:xoá kí tự trắng ở cuối chuỗi SELECT RTRIM('  FPOLY   ') SELECT RTRIM('FPOLY   ') SELECT RTRIM('  FPOLY HA NOI  ') --Hàm LEFT Lấy 1 số kí tự đầu tiên từ bên trái của chuỗi SELECT LEFT('FPOLY',2)--kq= 'FP'  --Hàm RIGHT Lấy 1 số kí tự đầu tiên từ bên phải của chuỗi SELECT RIGHT('FPOLY',3)--kq='OLY'  --Hàm SUBSTRING('CHUỖI', vỊ_TRÍ,SỐ_LƯỢNG) SELECT SUBSTRING('FPOLY',2,3) --kq='POL' SELECT SUBSTRING('FPOLY HANOI',4,5) --kq='LY HA' SELECT SUBSTRING('FPOLY HANOI',6,6) --Hàm REPLICATE:lặp chuỗi SELECT REPLICATE('FPOLY',0) --kq=RỖNG SELECT REPLICATE('FPOLY',-2) --kq=NULL SELECT  REPLICATE('FPOLY',2)--kq=FPOLYFPOLY --Hàm REVERSE:đảo ngược chuỗi SELECT REVERSE('FPOLY') SELECT REVERSE(NULL)  --Hàm LOWER: chuyển thành chữ thường SELECT LOWER('FPOLY') SELECT LOWER('Fpoly HaNoi') SELECT LOWER('  Fpoly HaNoi') --Hàm UPPER:chuyển thành chữ hoa SELECT UPPER('Fpoly HaNoi')  --Hàm SPACE:Hàm này trả về số khoảng trống tương ứng với giá trị đầu vào. SELECT ('SQL') + SPACE(0) + ('TUTORIALS') -- giá trị trả về = SQLTUTORIALS SELECT ('SQL') + SPACE(1) + ('TUTORIALS') -- giá trị trả về = SQL TUTORIALS  --Hàm CHARINDEX:trả về ví trí được tìm thấy của một “chuỗi con” trong “chuỗi cha”. SELECT CHARINDEX('F','CHÀO MỪNG BẠN ĐẾN VỚI FPOLY HA NOI') SELECT CHARINDEX('n', 'Quantrimang.com', 2);--KQ=4 SELECT CHARINDEX('n', 'Quantrimang.com', 6);--KQ=10  --6. Thực hiện các hàm về thời gian --Hàm GETDATE SELECT GETDATE() AS THOIGIAN_HIENTAI  --Hàm DATENAME SELECT DATENAME(YEAR,'2022/05/19') Ket qua: '2022' SELECT DATENAME(YYYY,'2022/05/19') SELECT DATENAME(DAY,'2022/05/19') SELECT DATENAME(quarter, '2022/05/19'); Ket qua: '2' SELECT DATENAME(hour, '2022/05/19 4:28'); Ket qua: '4' --HÀM DATEDIFF(DATEPART,DATE1,DATE2) SELECT DATEDIFF(DAY,'2022/04/20','2022/05/19')--kq=30 ngày SELECT DATEDIFF(YEAR,'2003/04/20','2022/04/20')--KQ=19 NĂM SELECT DATEDIFF(MONTH,'2022/04/20','2022/05/19')--KQ=19 NĂM ---Lab 3: ---Bài 1: ---dùng cast  SELECT * FROM PHANCONG; SELECT MA_NVIEN,MADA,STT, CAST (THOIGIAN AS DECIMAL(5,2)) as THOIGIAN  FROM PHANCONG  ---dùng hàm convert SELECT MA_NVIEN,MADA,STT,  CONVERT(DECIMAL(5,2), THOIGIAN) AS THOIGIAN  FROM PHANCONG /*Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một  tuần của tất cả các nhân viên tham dự đề án đó.*/  ---1.Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân  ---Khai báo biến bảng DECLARE @thongke TABLE( MaDa int, ThoiGian float) ---Chèn dữ liệu insert into @thongke SELECT MADA,SUM(THOIGIAN) as TongThoiGian from PHANCONG GROUP BY MADA ---truy cập dữ liệu từ biến bảng SELECT TENDEAN, CAST(ThoiGian as decimal(5,2)) as TongThoiGian ---dùng CAST from @thongke a join DEAN b ON a.MaDa=b.MADA SELECT TENDEAN, CONVERT(decimal(5,2),a.ThoiGian) as TongThoiGian ----dùng CONVERT from @thongke a join DEAN b ON a.MaDa=b.MADA SELECT TENDEAN, CAST(ThoiGian as varchar(15)) as TongThoiGian ---dùng CAST from @thongke a join DEAN b ON a.MaDa=b.MADA SELECT TENDEAN, CONVERT(varchar(15),ThoiGian) as TongThoiGian ----dùng CONVERT from @thongke a join DEAN b ON a.MaDa=b.MADA  ---2.Định dạng “tổng số giờ làm việc” kiểu varchar ---Khai báo biến bảng declare @thke TABLE( MaDa int, ThoiGian float) ---Chèn dữ liệu insert into @thke SELECT MADA,SUM(THOIGIAN) as TongThoiGian from PHANCONG GROUP BY MADA ---truy cập dữ liệu từ biến bảng SELECT TENDEAN, CAST(ThoiGian as varchar(15)) as TongThoiGian ---dùng CAST from @thke a join DEAN b ON a.MaDa=b.MADA SELECT TENDEAN, CONVERT(varchar(15),ThoiGian) as TongThoiGian ----dùng CONVERT from @thke a join DEAN b ON a.MaDa=b.MADA  /*3.Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình  của những nhân viên làm việc cho phòng ban đó.*/  /*---Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân*/ SELECT PHG, CONVERT(DECIMAL(10,2), AVG(LUONG),1) AS LUONGTB FROM NHANVIEN GROUP BY PHG SELECT PHG, FORMAT(CONVERT(DECIMAL(10,2), AVG(LUONG),1),'N','vi-VN')AS LUONGTB FROM NHANVIEN GROUP BY PHG  /*Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace*/ SELECT PHG, CONVERT(VARCHAR(50),CAST(AVG(LUONG) AS MONEY),1) FROM NHANVIEN GROUP BY PHG  ---BÀI 2:Sử dụng các hàm toán học /*Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó*/  ---CEILING: làm tròn lên SELECT TENDEAN, SUM(THOIGIAN) AS 'Tong giờ', CEILING(SUM(THOIGIAN)) AS 'Tong giờ mới' FROM DEAN JOIN CONGVIEC ON CONGVIEC.MADA=DEAN.MADA 		  JOIN PHANCONG ON PHANCONG.MADA=CONGVIEC.MADA GROUP BY TENDEAN  ---FLOOR: làm tròn xuống SELECT TENDEAN, SUM(THOIGIAN) AS 'Tong giờ', FLOOR(SUM(THOIGIAN)) AS 'Tong giờ mới' FROM DEAN JOIN CONGVIEC ON CONGVIEC.MADA=DEAN.MADA 		  JOIN PHANCONG ON PHANCONG.MADA=CONGVIEC.MADA GROUP BY TENDEAN  ---làm tròn tới 2 chữ số thập phân SELECT TENDEAN,SUM(THOIGIAN) AS 'Tong giờ', CAST(SUM(THOIGIAN) AS DECIMAL(6,2)) AS 'TỔNG GIỜ MỚI' FROM DEAN JOIN CONGVIEC ON CONGVIEC.MADA=DEAN.MADA 		  JOIN PHANCONG ON PHANCONG.MADA=CONGVIEC.MADA GROUP BY TENDEAN   /*Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu*/   SELECT HONV + '' + TENLOT +'' + TENNV AS HOVATEN,ROUND(LUONG,2)AS LUONG  FROM NHANVIEN WHERE LUONG >(SELECT ROUND(AVG(LUONG),2) AS LƯƠNGTB  			  FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG=NHANVIEN.PHG 			  WHERE TENPHG = N'NGHIÊN CỨU')  ---BÀI 3:Sử dụng các hàm xử lý chuỗi  /*1.Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu*/ --1.1.Dữ liệu cột HONV được viết in hoa toàn bộ SELECT UPPER(HONV) AS HONV,TENLOT,TENNV,DCHI  FROM NHANVIEN --1.2 Dữ liệu cột TENLOT được viết chữ thường toàn bộQuản trị cơ sở dữ liệu với SQL Server SELECT UPPER(HONV) AS HONV,LOWER(TENLOT) AS TENLOT,TENNV,DCHI  FROM NHANVIEN /*1.3 Dữ liệu cột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh)*/ SELECT UPPER(HONV) AS HONV,LOWER(TENLOT) AS TENLOT,LOWER(LEFT(TENNV,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV))),DCHI  FROM NHANVIEN  /*1.4 Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố.*/ SELECT HONV,TENLOT,TENNV,DCHI,CHARINDEX(' ',DCHI),CHARINDEX(',',DCHI),SUBSTRING(DCHI,CHARINDEX(' ',DCHI)+1,LEN(DCHI)) FROM NHANVIEN  /*2.Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất, hiển thị thêm một cột thay thế tên trưởng phòng bằng tên “Fpoly*/ DECLARE @tke TABLE (MaP INT,MATP INT, TK INT); INSERT INTO @tke SELECT PHG,MA_NQL, COUNT(MANV) FROM NHANVIEN GROUP BY PHG  DECLARE @Max int SELECT @Max = MAX(TK) FROM @tke SELECT TENPHG,HONV + '' + TENLOT +'' + TENNV AS HOVATEN FROM PHONGBAN a INNER JOIN(SELECT * FROM @tke where TK = @Max) b ON a.MAPHG=b.MaP 								JOIN NHANVIEN c ON c.MANV = B.MANVTP;    ---BÀI 4:Sử dụng các hàm ngày tháng năm  ---Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965. SELECT * FROM NHANVIEN WHERE YEAR(NGSINH) >= 1960 AND YEAR(NGSINH) <=1965 ---Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại. SELECT HONV,TENLOT,TENNV,YEAR(GETDATE())-YEAR(NGSINH) AS TUOI FROM NHANVIEN  --- Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy. SELECT HONV,TENLOT,TENNV,DATENAME(WEEKDAY,NGSINH) AS THU FROM NHANVIEN  /* Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức  trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy*/ SELECT TENPHG,TRPHG,NG_NHANCHUC,COUNT(MANV) AS 'SL' FROM NHANVIEN JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG GROUP BY TENPHG,TRPHG,NG_NHANCHUC    