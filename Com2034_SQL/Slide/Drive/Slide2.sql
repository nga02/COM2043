﻿--Buổi 3: Slide 2P1: COM2034 
use QLDA
go

--Phần I. Nhắc lại Thiết kế bảng: Design + nhập liệu
-- Phần II. Nhắc lại cú pháp câu lệnh select
-- cú pháp:
	--SELECT [distinct/ top n ]ten_Cot1,ten_cot2,...
	--FROM	bang1 inner join/left outer join/ right outer join bang2 on bang1.cotchung = bang2.cotchung
			-- phepnoi bang3 on bang3.cotchung = bang2.cotchung (vd bang2 và bang3 có ketnoi)
			--....
	--[WHERE	nơi đặt đk bình thường vd: diem >5]
	--[GROUP BY ten_cot1_can_nhom, ten_cot2_can_nhom,...]
	--[HAVING	nơi đặt điều kiện thống kê(điều kiện có sử dụng hàm thống kê) vd avg(diem)>5]
	--[ORDER BY ten_cot1_can_sap_xep asc/desc, ten_cot2_can_sap_xep asc/desc...]

--trong đó:
--	thành phần trong [] là không bắt buộc
--	distinct : loại bỏ dữ liệu trùng
--	top n: vd top 5 (lấy n dòng dữ liệu)
--	Khi nào có group by?: Nếu trong mệnh đề select có dùng các hàm thống kê (sum, count, max, min...)
--	thì chúng ta phải nhóm (group by) theo tất cả các cột không sử dụng hàm thống kê.
-- phepnoi: inner join/left outer join/ right outer join
	--inner join: phép nối bằng, đưa ra dữ liệu chung có trên cả 2 bảng
	--left outer join: ưu tiên dữ liệu của bảng bên trái
	--right outer join: ưu tiên dữ liệu của bảng bên phải

--Lưu ý: đối với cột chung phải chỉ rõ: ten_bang.ten_cot.


--I.	Slide 2(Buổi 3): sử dụng CSDL QLDA trả lời các câu hỏi sau
--1.	Cho biết thông tin về Phòng Ban
		select * 
		from PHONGBAN

--2.	Cho biết thông tin về Nhân Viên
		select *
		from NHANVIEN

--3.	Cho biết thông tin về Công việc
		select *
		from CONGVIEC

--4.	Cho  biết thông tin về Nhân Viên và phòng Ban của họ:
-- Mã NV, họ tên, ngày sinh, địa chỉ, mã phòng, tên phòng, mã trưởng phòng
--bảng: NV, PB
	select MANV,HONV +' '+ TENLOT + ' ' +TENNV as Hoten,
			NGSINH, DCHI, MAPHG,TENPHG,TRPHG
	from PHONGBAN inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG

--5.	Giống câu 4, nhưng chỉ đưa ra thông tin các nhân viên của phòng Nghiên cứu.
	select MANV,HONV +' '+ TENLOT + ' ' +TENNV as Hoten,
			NGSINH, DCHI, MAPHG,TENPHG,TRPHG
	from PHONGBAN inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
	where TENPHG like N'Nghiên Cứu'

--6.	Cho biết thông tin về nhân viên và công việc của họ:
-- MaNV, họ tên, mã phòng, Thời gian, tên công việc
--bảng: NV, PhanCong, CongViec
	select MANV,HONV +' '+ TENLOT + ' ' +TENNV as Hoten,
			PHG as maphong, THOIGIAN,TEN_CONG_VIEC
	from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN= NHANVIEN.MANV
			inner join CONGVIEC on CONGVIEC.MADA= PHANCONG.MADA


--7.	Cho biết thonong tin công việc của phòng Điều hành: 
--MaNV, họ tên, mã phòng, Thời gian, tên công việc
	select MANV,HONV +' '+ TENLOT + ' ' +TENNV as Hoten,
			PHG as maphong, THOIGIAN,TEN_CONG_VIEC
	from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN= NHANVIEN.MANV
			inner join CONGVIEC on CONGVIEC.MADA= PHANCONG.MADA
			inner join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
	where TENPHG like  N'Điều Hành'

--8.	Cho biết thông tin về Đề án của các phòng ban, 
--kể cả những phòng ban không có đề án:
-- mã phòng, tên phòng, tên đề án, địa điểm đề án.
--bảng: PhongBan,DeAn
	select MAPHG,TENPHG,TENDEAN,DDIEM_DA
	from PHONGBAN left outer join DEAN on PHONGBAN.MAPHG= DEAN.PHONG

--9.	Cho biết thông tin về số đề án của mỗi phòng, 
--kể cả những phòng không có đề án nào: Mã phòng, tên phòng, tổng số đề án.
--Bảng: PhongBan, DeAn
	select MAPHG,TENPHG, count( MADA) as TSDA
	from PHONGBAN left outer join DEAN on PHONGBAN.MAPHG= DEAN.PHONG
	group by MAPHG,TENPHG

--10.	Cho biết thông tin các phòng không có đề án nào: Mã phòng, tên phòng.
--11.	Cho biết thông tin về số nhân viên của từng phòng ban, kể cả những phòng ban không có nhân viên nào: mã phòng, tên phòng, số nhân viên.
--12.	Thêm cột quốc tịch vào bảng Nhân viên với giá trị mặc định là Việt Nam
--13.	Cập nhật giới tính của nhân viên có mã 002 là nam
--14.	Thêm Nhân thân vợ cho nhân viên 017, các thông tin tự nhập
--15.	Cho biết mức lương cao nhất của nhân viên
--16.	Cho biết mức lương trung bình của nhân viên