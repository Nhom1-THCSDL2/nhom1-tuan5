create database TH_CSDL
go

use TH_CSDL
go

--Câu1

--Thiết lập  mối quan hệ giữa các bảng.

create table KHACHHANG
(
	MAKHACHHANG char(10) primary key,
	TENCONGTY nvarchar(100),
	TENGIAODICH nvarchar(50),
	DIACHI nvarchar(100),
	EMAIL varchar(50) unique,
	DIENTHOAI varchar(11) unique,
	FAX varchar(20),
	constraint PK_MAKHACHHANG_1 PRIMARY KEY(MAKHACHHANG),
	constraint UQ_EMAIL_1 unique(EMAIL),
	constraint UQ_SDT_1 unique(DIENTHOAI),
	constraint CK_SDT_1 check(DIENTHOAI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						or DIENTHOAI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);


create table NHACUNGCAP
(
	MACONGTY char(10) primary key,
	TENCONGTY nvarchar(100),
	TENGIAODICH nvarchar(50),
	DIACHI nvarchar(100),
	DIENTHOAI varchar(11) unique,
	FAX varchar(20),
	EMAIL varchar(50) unique,
	constraint PK_MACONGTY_4 PRIMARY KEY(MACONGTY),
	constraint UQ_DIENTHOAI_4 unique(DIENTHOAI),
	constraint UQ_EMAIL_4 unique(EMAIL)
);
create table NHANVIEN
(
	MANHANVIEN char(10) primary key,
	HO nvarchar(50),
	TEN nvarchar(50),
	NGAYSINH date,
	NGAYLAMVIEC date,
	DIACHI nvarchar(100),
	DIENTHOAI varchar(11) unique,
	LUONGCOBAN decimal(18,2) check (LUONGCOBAN>=0),
	PHUCAP decimal(18,2),
	constraint PK_MANHANVIEN_2 PRIMARY KEY(MANHANVIEN),
	constraint CK_NgaySinh_2 check(NGAYSINH < GETDATE()),
	constraint CK_NgayLamViec_2 check(NGAYLAMVIEC >= GETDATE()),
	constraint UQ_SDT_2 unique(DIENTHOAI),
	constraint CK_SDT_2 check(DIENTHOAI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						or DIENTHOAI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint CK_LUONGCOBAN_2 check(LUONGCOBAN >=0),
	constraint CK_PHUCAP_2 check(PHUCAP >=0)

)

create table LOAIHANG
(
	MALOAIMATHANG char(10) primary key,
	TENLOAIHANG nvarchar(100),
	constraint PK_MALOAIHANG_5 PRIMARY KEY(MALOAIHANG)
)

create table MATHANG
(
	MAHANG char(10) primary key,
	TENHANG nvarchar(100),
	MACONGTY char(10),
	MALOAIMATHANG char(10),
	SOLUONG int check(SOLUONG >=0),
	DONVITINH nvarchar(50),
	GIAHANG decimal(18,2),
	foreign key (MACONGTY) references NHACUNGCAP(MACONGTY),
	foreign key (MALOAIMATHANG)references LOAIHANG(MALOAIMATHANG),
	constraint PK_MAHANG_6 PRIMARY KEY(MAHANG),
	constraint PK_CONGTY_NO_6 FOREIGN KEY(CONGTY_NO) references NHACUNGCAP(MACONGTY)
									ON UPDATE CASCADE
									ON DELETE CASCADE,
	constraint PK_LOAIHANG_NO_6 FOREIGN KEY(LOAIHANG_NO) references LOAIHANG(MALOAIHANG)
									ON UPDATE CASCADE
									ON DELETE CASCADE,
	constraint CK_SOLUONG_6 check(SOLUONG >=0),
	constraint CK_GIAHANG_6 check(GIAHANG >=0)
)

create table DONDATHANG
(
	SOHOADON char(10) primary key,
	MAKHACHHANG char(10),
	MANHANVIEN char(10),
	NGAYDATHANG date,
	NGAYGIAOHANG date,z
	NGAYCHUYENHANG date,
	NOIGIAOHANG nvarchar(100),
	foreign key (MAKHACHHANG) references KHACHHANG (MAKHACHHANG),
	foreign key (MANHANVIEN) references NHANVIEN(MANHANVIEN),
	constraint PK_SOHOADON_3 PRIMARY KEY(SOHOADON),
    constraint FK_KHACHHANG_NO_3 FOREIGN KEY (KHACHHANG_NO) references KHACHHANG(MAKHACHHANG)
									ON UPDATE CASCADE
									ON DELETE CASCADE,
    constraint FK_NHANVIEN_NO_3 FOREIGN KEY (NHANVIEN_NO) references NHANVIEN(MANHANVIEN)
									ON UPDATE CASCADE
									ON DELETE CASCADE
)

create table CHITIETDATHANG
(
	SOHOADON char(10) ,
	MAHANG char(10) ,
	GIABAN decimal(18,2) check (GIABAN >=0),
	SOLUONG int check (SOLUONG >=0),
	MUCGIAMGIA decimal(18,2),
	primary key(SOHOADON,MAHANG),
	foreign key (MAHANG) references MATHANG(MAHANG),
	foreign key (SOHOADON) references DONDATHANG(SOHOADON),
	constraint PK_SHD_MH_7 PRIMARY KEY(SOHOADON, MAHANG),
	constraint PK_MAHANG_7 FOREIGN KEY(MAHANG) references MATHANG(MAHANG)
									ON UPDATE CASCADE
									ON DELETE CASCADE,
	constraint PK_SOHOADON_7 FOREIGN KEY(SOHOADON) references DONDATHANG(SOHOADON)
									ON UPDATE CASCADE
									ON DELETE CASCADE,
	constraint CK_SOLUONG_7 check(SOLUONG >=0),
	constraint CK_MUCGIAMGIA_7 check(MUCGIAMGIA >=0)
)
