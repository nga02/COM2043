﻿								-- *** Assignment Com2034 *** ---
--Tạo database 
CREATE DATABASE QLNHATRO1
GO
USE QLNHATRO1

IF OBJECT_ID('LOAINHA') IS NOT NULL
DROP TABLE LOAINHA
--Tạo bảng LOAINHA
CREATE TABLE LOAINHA (
	MALOAINHA VARCHAR(5) NOT NULL,
	TENLOAI NVARCHAR(20)
)
GO
IF OBJECT_ID('NGUOIDUNG') IS NOT NULL
DROP TABLE NGUOIDUNG
--Tạo bảng NGUOIDUNG
CREATE TABLE NGUOIDUNG(
	MANGDUNG VARCHAR(5) NOT NULL,
	TENNGDUNG NVARCHAR(50),
	GIOITINH NVARCHAR(3),
	SDT NVARCHAR(13),
	DCHI NVARCHAR(30),
	QUAN NVARCHAR(20),
	EMAIL VARCHAR(30)
)
GO
IF OBJECT_ID('NHATRO') IS NOT NULL
DROP TABLE NHATRO
--Tạo bảng NHATRO
CREATE TABLE NHATRO(
	MANHATRO VARCHAR(5) NOT NULL,
	MALOAINHA VARCHAR(5) NOT NULL,
	MANGDUNG VARCHAR(5) NOT NULL,
	DIENTICH FLOAT,
	GIAPHONG DECIMAL(10,2),
	DCHI NVARCHAR(30),
	QUAN NVARCHAR(20),
	TRANGTHAI NVARCHAR(20),
	NGAYDANGTIN DATETIME
)
GO
IF OBJECT_ID('DANHGIA') IS NOT NULL
DROP TABLE DANHGIA
CREATE TABLE DANHGIA(
	MANHATRO VARCHAR(5) NOT NULL,
	MANGDUNG VARCHAR(5) NOT NULL,
	TRANGTHAI NVARCHAR(10),
	NOIDUNG NVARCHAR(250)
)

--Tạo các ràng buộc giữa các bảng
ALTER TABLE LOAINHA ADD CONSTRAINT PK_LN PRIMARY KEY(MALOAINHA)
ALTER TABLE NGUOIDUNG ADD CONSTRAINT PK_ND PRIMARY KEY(MANGDUNG)
ALTER TABLE NHATRO ADD CONSTRAINT PK_NT PRIMARY KEY(MANHATRO)
ALTER TABLE DANHGIA ADD CONSTRAINT PK_DG PRIMARY KEY(MANHATRO,MANGDUNG)

ALTER TABLE NHATRO ADD CONSTRAINT FK_NT_LN FOREIGN KEY(MALOAINHA) REFERENCES LOAINHA
ALTER TABLE NHATRO ADD CONSTRAINT FK_NT_NG FOREIGN KEY(MANGDUNG) REFERENCES NGUOIDUNG
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_NT FOREIGN KEY(MANHATRO) REFERENCES NHATRO
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_ND FOREIGN KEY(MANGDUNG) REFERENCES NGUOIDUNG

--Các ràng buộc cho các cột 
ALTER TABLE NGUOIDUNG ADD CONSTRAINT UC_ND UNIQUE(SDT,EMAIL) 
ALTER TABLE NHATRO ADD CONSTRAINT CK_NT CHECK(DIENTICH > 0 AND GIAPHONG > 0)

--Chèn dữ liệu vào các bảng

INSERT INTO LOAINHA VALUES
						('L1',N'Căn hộ trung cư'),
						('L2',N'NHÀ RIÊNG'),
						('L3',N'PHÒNG KHÉP KÍN')
---BANG	NGUOIDUNG
DELETE FROM NGUOIDUNG
INSERT INTO NGUOIDUNG VALUES
						('N1',N'LE THI NGA',N'NỮ','0335188503',N'THANH HOÁ',N'QUẬN 1',N'nga@gmail.com'),
						('N2',N'NGUYỄN TỬ HOÀNG',N'NAM','0335679864',N'HÀ NỘI',N'QUẬN 2',N'hoang@gmail.com'),
						('N3',N'PHAN MINH TIẾN',N'NAM','0335467986',N'NINH BÌNH',N'QUẬN 3',N'tien@gmail.com'),
						('N4',N'TRẦN THANH LONG',N'NAM','0336423978',N'HÀ NỘI',N'QUẬN 4',N'long@gmail.com'),
						('N5',N'LÊ NGỌC MAI',N'NỮ','0335185684',N'LẠNG SƠN',N'QUẬN 5',N'mai@gmail.com'),
						('N6',N'NGUYỄN ANH MINH',N'NAM','0339876535',N'HOÀ BÌNH',N'QUẬN 4',N'tuyen@gmail.com'),
						('N7',N'NGUYỄN KIM NHƯ',N'NỮ','0335987665',N'THÁI BÌNH',N'QUẬN 1',N'nhu0@gmail.com'),
						('N8',N'NGUYỄN ANH THƯ',N'NỮ','0333456876',N'NINH BÌNH',N'QUẬN 5',N'thu@gmail.com'),
						('N9',N'PHAN MINH DŨNG',N'NAM','0339087664',N'QUẢNG BÌNH',N'QUẬN 3',N'dung@gmail.com'),
						('N10',N'PHAN TÙNG',N'NAM','0335768986',N'NAM ĐỊNH',N'QUẬN 2',N'tung@gmail.com')

---BANG	NHATRO
DELETE FROM NHATRO
INSERT INTO NHATRO VALUES
						('T1','L2','N1',4.2,52000,N'73 ĐỨC DIỄN',N'QUẬN 3',N'CÒN PHÒNG','2022/06/22'),
						('T12','L1','N10',3.5,63000,N'99 CẦU DIỄN',N'QUẬN 2',N'HẾT PHÒNG','2022/05/25'),
						('T13','L3','N2',2.3,33000,N'123 PHÚ DIỄN',N'QUẬN 1',N'CÒN PHÒNG','2022/05/15'),
						('T14','L1','N4',2.5,43000,N'45 TRỊNH VĂN BÔ',N'QUẬN 3',N'HẾT PHÒNG','2022/04/10'),
						('T15','L3','N6',4.3,56000,N'52 TỐ HỮU',N'QUẬN 5',N'CÒN PHÒNG','2022/3/15'),
						('T16','L2','N3',3.6,38000,N'23 NGUYỄN TRÃI',N'QUẬN 4',N'CÒN PHÒNG','2022/5/27'),
						('T17','L2','N9',2.4,47000,N'34 HỒ TÙNG MẬU',N'QUẬN 3',N'HẾT PHÒNG','2022/5/20'),
						('T18','L3','N8',2.3,35000,N'47 BA ĐÌNH',N'QUẬN 2',N'CÒN PHÒNG','2022/5/18'),
						('T19','L1','N5',4.4,60000,N'28 MINH KHAI',N'QUẬN 1',N'HẾT PHÒNG','2022/01/07'),
						('T11','L2','N7',3.8,58000,N'65 HỒ TÙNG MẬU',N'QUẬN 5',N'CÒN PHÒNG','2022/09/20')
---BANG	DANHGIA
DELETE FROM DANHGIA
INSERT INTO DANHGIA VALUES
						('T1','N1',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T12','N10',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T13','N2',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T14','N4',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T15','N6',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T16','N3',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T17','N9',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T18','N8',N'DISLIKE',N'CHẤT LƯỢNG KÉM'),
						('T19','N5',N'LIKE',N'CHẤT LƯỢNG TỐT'),
						('T11','N7',N'DISLIKE',N'CHẤT LƯỢNG KÉM')

select * from LOAINHA
SELECT * FROM NGUOIDUNG
SELECT * FROM NHATRO
SELECT * FROM DANHGIA