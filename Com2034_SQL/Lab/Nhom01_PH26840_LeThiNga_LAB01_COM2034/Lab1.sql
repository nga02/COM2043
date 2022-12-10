
CREATE DATABASE LAB01
GO 

CREATE TABLE NHANVIEN
(
	HONV nvarchar(15) NOT NULL,
	TENLOT nvarchar(15) NOT NULL,
	TENNV nvarchar(15) NOT NULL,
	MANV nvarchar(9)  PRIMARY KEY,
	NGSINH datetime NOT NULL,
	DCHI nvarchar(30) NOT NULL,
	PHAI nvarchar(3) NOT NULL,
	LUONG float NOT NULL,
	MA_NQL nvarchar(9) NULL,
	PHG int NULL,
)


---BANG PHONGBAN
CREATE TABLE PHONGBAN
(
	TENPHG nvarchar(15) NOT NULL,
	MAPHG int PRIMARY KEY ,
	TRPHG nvarchar(9) NULL,
	NG_NHANCHUC date NOT NULL,
)
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_NhanVien] FOREIGN KEY([MA_NQL])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[PHONGBAN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_PhongBan] FOREIGN KEY([TRPHG])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
INSERT INTO NHANVIEN VALUES 
	(N'Đinh', N'Quỳnh', N'Như', N'001', CAST(N'1967-02-01T00:00:00.000' AS DateTime), N'291 Hồ Văn Huê, TP HCM', N'Nữ', 43000, N'006', 4),
	(N'Phan', N'Viet', N'The', N'002', CAST(N'1984-01-11T00:00:00.000' AS DateTime), N'778 nguyễn kiệm , TP hcm', N'', 30000, N'001', 4),
	 (N'Trần', N'Thanh', N'Tâm', N'003', CAST(N'1957-05-04T00:00:00.000' AS DateTime), N'34 Mai Thị Lự, Tp Hồ Chí Minh', N'Nam', 25000, N'005', 5),
	 (N'Nguyễn', N'Mạnh ', N'Hùng', N'004', CAST(N'1967-03-04T00:00:00.000' AS DateTime), N'95 Bà Rịa, Vũng Tàu', N'Nam', 38000, N'005', 5),
	 (N'Nguễn', N'Thanh', N'Tùng', N'005', CAST(N'1962-08-20T00:00:00.000' AS DateTime), N'222 Nguyễn Văn Cừ, Tp HCM', N'Nam', 40000, N'006', 5),
	 (N'Phạm', N'Văn', N'Vinh', N'006', CAST(N'1965-01-01T00:00:00.000' AS DateTime), N'15 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1),
	 (N'Bùi ', N'Ngọc', N'Hành', N'007', CAST(N'1954-03-11T00:00:00.000' AS DateTime), N'332 Nguyễn Thái Học, Tp HCM', N'Nam', 25000, N'001', 4),
	 (N'Trần', N'Hồng', N'Quang', N'008', CAST(N'1967-09-01T00:00:00.000' AS DateTime), N'80 Lê Hồng Phong, Tp HCM', N'Nam', 25000, N'001', 4),
	 (N'Đinh ', N'Bá ', N'Tiên', N'009', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5),
	 (N'Đinh ', N'Bá ', N'Tiên', N'017', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5)
INSERT INTO PHONGBAN VALUES
	 (N'Quản Lý', 1, N'006', CAST(N'1971-06-19' AS Date)),
	 (N'Điều Hành', 4, N'008', CAST(N'1985-01-01' AS Date)),
	 (N'Nghiên Cứu', 5, N'005', CAST(N'0197-05-22' AS Date)),
	 (N'IT', 6, N'008', CAST(N'1985-01-01' AS Date))

SELECT * FROM NHANVIEN
SELECT * FROM PHONGBAN
