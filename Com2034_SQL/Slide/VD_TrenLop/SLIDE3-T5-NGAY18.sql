---Các hàm chuyển đổi kiểu dữ liệu
--Hai loại chuyển đổi 
	--Chuyển đổi ngầm (do SQL server tự thực hiện) chuyển đổi từ thấp---> cao
select 100*.5 
select 'Today is' + cast(GETDATE() as varchar)

  --Chuyển đổi tường minh (sử dụng các hàm thư viện)
--Hàm CAST 
--Cú pháp:
	CAST (<BIỂU THỨC> AS <KIỂU DỮ LIỆU> [(LENGTH)])
--VD:
select cast(123 as decimal(10,4))
--Hàm CONVERT
--Cú pháp:
	CONVERT(<Kiểu dữ liệu>[(length)], <Biểu thức>[,<Tham số định dạng>])

SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 101)
SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 102)
SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 103)
SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 104)
SELECT 'Today''s date is ' + CONVERT(VARCHAR, GETDATE(), 110)


--PI:TRẢ VỀ SỐ PI
---VD: TÍNH CHU VI ĐƯỜNG TRÒN CÓ BÁN KÍNH 10
select 2*pi()*10
 
---SQRT TRẢ VỀ DỮU LIỆU SỐ THỰC
select SQRT(36)
---SQUARE: 
select SQUARE(4)--BÌNH PHƯƠNG 
----CEILING AND  FLOOR
SELECT CEILING(9/3.1) --=3
SELECT FLOOR(9/3.9)

---ROUND:LÀM TRÒN GIÁ TRỊ THEO VỊ TRÍ THẬP PHÂN XÁC ĐỊNH
SELECT ROUND(5.153745,0)
SELECT ROUND(5.153745,1)

---CÁC HÀM XỬ LÝ CHUỖI
SELECT LEN('. .') -- TRẢ VỀ SỐ LƯỢNG CHUỖI KĨ TỰ
SELECT LTRIM(' NCJ ') --CÁC KÍ TỰ TRẮNG ĐẦU CHUỖI BỊ LOẠI BỎ
SELECT RTRIM(' NCJ ')
SELECT LEFT('SQL SERVER',3)
SELECT RIGHT('SQL SERVER',3)


---HÀM SUBSTRING 
SELECT SUBSTRING('SQL SERVER',5,3)  --- LẤY 3 KÍ TỰ  TỪ VỊ TRÍ THỨ 5

---HÀM REPLACE 
SELECT REPLACE('THICH-MOT-MINH','-','.') --BỎ (-) THÀNH (.)
SELECT REPLACE('0973-456-226','-','.')

---CÁC HÀM NGÀY THÁNG NĂM

SELECT GETDATE()

--DATENAME: truy cập tới các thành phần liên quan ngày tháng

