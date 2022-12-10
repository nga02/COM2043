USE QLDA
---1.	Tìm các nhân viên làm việc ở phòng số 4
SELECT * FROM NHANVIEN
WHERE PHG = 4 

----2.	Tìm các nhân viên có mức lương trên 30000
SELECT * FROM NHANVIEN
WHERE LUONG > 30000

-----3.	Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5
SELECT * FROM NHANVIEN 
WHERE (LUONG > 25000 and PHG = 4)  OR (LUONG > 30000 and PHG = 5)

-----4.	Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
SELECT HONV+''+TENLOT+''+TENNV AS [HO_VA_TEN],DCHI
FROM NHANVIEN
WHERE DCHI LIKE N'%Tp HCM'

---5.Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
SELECT HONV+''+TENLOT+''+TENNV AS [HO_VA_TEN]
FROM NHANVIEN
WHERE HONV LIKE N'N%'
---6.	Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien.
SELECT HONV+''+TENLOT+''+TENNV AS [HO_VA_TEN],day(NGSINH) as Ngay_Sinh,DCHI
FROM NHANVIEN 
WHERE HONV+''+TENLOT+''+TENNV LIKE N'ĐINH BÁ TIÊN'
---1 tinh nang
---setup
---attach,detach
---phongban, nhanvien,nhap du lieu
---6 cau truy van

