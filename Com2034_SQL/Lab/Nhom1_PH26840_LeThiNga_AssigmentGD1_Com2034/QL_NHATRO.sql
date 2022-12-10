
create database QLTTNHATRO

create table LOAINHA(
	MaLN nvarchar(10),
	primary key (MaLN),
	TenLN nvarchar(50)
)

create table Quan(
	MaQuan nvarchar(10),
	primary key (MaQuan),
	TenQuan nvarchar(50)
)

create table NguoiDung(
	MaND nvarchar(10),
	primary key (MaND),
	TenND nvarchar(50),
	GioiTinh nvarchar(10),
	DienThoai nvarchar(15),
	DiaChi nvarchar(100),
	MaQuan nvarchar(10),
	Email nvarchar(20),
	foreign key (MaQuan) references Quan(MaQuan)
)

create table NHATRO(
	MaNhaTro nvarchar(10),
	primary key (MaNhaTro),
	MaLN nvarchar(10),
	DienTich int,
	GiaPhong int,
	DiaChi nvarchar(100),
	MaQuan nvarchar(10),
	MoTa nvarchar(100),
	NgayDang date,
	NguoiLienHe nvarchar(10),
	foreign key (MaLN) references LOAINHA(MaLN),
	foreign key (MaQuan) references Quan(MaQuan),
	foreign key (NguoiLienHe) references NguoiDung(MaND)
)

create table HOPDONGTHUE(
	MaND nvarchar(10),
	MaNhaTro nvarchar(10),
	primary key (MaND,MaNhaTro),
	NgayDen date,
	NgayDi date,
	foreign key (MaND) references NGUOIDUNG(MaND),
	foreign key (MaNhaTro) references NHATRO(MaNhaTro)
)

create table DANHGIA(
	MaDG nvarchar(10),
	primary key (MaDG),
	MAND nvarchar(10),
	MaNhaTro nvarchar(10),
	Likes bit,
	NoiDungDG nvarchar(100),
	foreign key (MaND,MaNhaTro) references HOPDONGTHUE(MaND,MaNhaTro)
)
