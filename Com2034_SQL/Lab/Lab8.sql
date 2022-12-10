---Lab 8
USE DATBAO
GO
--Tạo một bản sao Full backup của CSDL AP với tên File là APFull1.bak
BACKUP DATABASE DATBAO
	TO  DISK = N'D:\Com2034_SQL\APFull1.bak'
--Thêm một bảng mới Test vào CSDL AP
CREATE TABLE NGA_LT
( 
	MAB1 VARCHAR(10), 
	TENDA1 NVARCHAR(50)
)
--Phục hồi CSDL AP sử dụng bản sao APFull1.bak
Restore database DATBAO from disk = N'D:\Com2034_SQL\APFull1.bak'
--------------------------------------------------



--BAI2:
--Tạo một bản sao Full backup của CSDL AP với tên File là APFull2.bak
BACKUP DATABASE DATBAO
	TO  DISK = N'D:\Com2034_SQL\APFull2.bak'

--Thêm một bảng mới Test23 vào CSDLAP
CREATE TABLE TEST23
(
	NGAYSX DATE,
	MANGMUA VARCHAR(10)
)
/*Tạo một bản sao Differential backup của CSDLAP vớitên File là APDiff1.bak.Bảnsao lưu này chỉ
sao phần dữ liệu bị thay đổi so với bản Full backup APFull2.bak (tức là bảng mới Test1)*/
BACKUP DATABASE DATBAO
	TO  DISK = N'D:\Com2034_SQL\APDiff011.bak'
	WITH DIFFERENTIAL;
--Thêm một bảng mới Test02 vào CSDLAP
CREATE TABLE TEST002
(	
	HangHoa VARCHAR(10)
)
/*Tạo một bản sao Differentialbackup của CSDLAP với tên File là APDiff2.bak.Bảnsao lưu này chỉ
sao phần dữ liệu bị thay đổi so với bản Full backup APFull1.bak (tức là bảng mới Test1 và Test2)*/
BACKUP DATABASE DATBAO
	TO  DISK = N'D:\Com2034_SQL\APDiff012.bak'
	WITH DIFFERENTIAL;

Restore database DATBAO from disk = N'D:\Com2034_SQL\APDiff011.bak'

/*Phục hồi CSDLsửdụng File APFull2.bak và APDiff1.bak.KiểmtrađảmbảoCSDLđã được phục về
trạng thái sau khi bảng Test23 được thêm, và trước khi bảng Test02 được thêm*/


/*Phục hồi CSDL sử dụng File APFull2.bak và APDiff2.bak. Kiểm tra đảm bảo CSDL đã được phục
về trạng thái sau khi bảng Test23 và Test02 được thêm.*/



