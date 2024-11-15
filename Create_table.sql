﻿CREATE DATABASE QLDT2;
GO
USE QLDT2
GO

CREATE TABLE KHOA (
    MaKhoa NVARCHAR(20) PRIMARY KEY,
    TenKhoa NVARCHAR(50)
);
GO

--Bảng Chương trình đào tạo
CREATE TABLE CHUONGTRINHDAOTAO(
	MaNganh VARCHAR(20) PRIMARY KEY,
	MaKhoa NVARCHAR(20),
    TenNganh NVARCHAR(30),
    TongTinChi INT,
    ThoiGianDaoTao NVARCHAR(50),
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);
GO
--Bảng Môn Học
CREATE TABLE MONHOC(
	MaMon VARCHAR(20) PRIMARY KEY,
	TenMon NVARCHAR(255),
	SoTC INT,
	MonTienQuyet NVARCHAR(30),
	SoTietLyThuyet INT,
	SoTietThucHanh INT
);
GO
--Bảng CT Môn Học
CREATE TABLE CHUONGTRINH_MONHOC (
    MaMon VARCHAR(20),
    MaNganh VARCHAR(20),
    PRIMARY KEY (MaMon, MaNganh),
    FOREIGN KEY (MaMon) REFERENCES MONHOC(MaMon),
    FOREIGN KEY (MaNganh) REFERENCES CHUONGTRINHDAOTAO(MaNganh)
);
GO
--Bảng Lớp chính quy
CREATE TABLE LOPCHINHQUY(
	MaLopChinhQuy VARCHAR(20) PRIMARY KEY,
	MaKhoa NVARCHAR(20),
    TenLopChinhQuy NVARCHAR(255),
    NamBatDau INT,
    NamKetThuc INT,
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);
GO
-- Bảng LỚP TÍN CHỈ
CREATE TABLE LOPTINCHI (
    MaLop VARCHAR(20) PRIMARY KEY,
    DanhSachSV INT,
    TienTrinhHocTap NVARCHAR(20),
    MaMon VARCHAR(20) NOT NULL													
	FOREIGN KEY(MaMon) REFERENCES MONHOC(MaMon)
);
GO
-- Bảng ĐỐI TƯỢNG 
CREATE TABLE DOITUONG (
    USER_ID VARCHAR(20) PRIMARY KEY,
    QueQuan NVARCHAR(50),
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    Ho NVARCHAR(20),
    TenDem NVARCHAR(20),
    Ten NVARCHAR(20),
    TypeUserID NVARCHAR(20) CHECK (TypeUserID IN ('SV', 'GV'))
);
GO
--Bảng DOITUONG_SĐT
CREATE TABLE DOITUONG_SDT (
    USER_ID VARCHAR(20),
    SDT NVARCHAR(15),
    PRIMARY KEY (USER_ID, SDT),
    FOREIGN KEY (USER_ID) REFERENCES DOITUONG(USER_ID)
);
GO

-- Bảng SINH VIÊN
CREATE TABLE SINHVIEN (
    MaSV VARCHAR(20) PRIMARY KEY,
    Nien_khoa NVARCHAR(10),
    GPA FLOAT,
    DiemRenLuyen FLOAT,
    HeDaoTao NVARCHAR(50),
    MaLopChinhQuy VARCHAR(20) NOT NULL, --Khóa ngoại
	USER_ID VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES DOITUONG(USER_ID),
	FOREIGN KEY(MaLopChinhQuy) REFERENCES LOPCHINHQUY(MaLopChinhQuy)
);
GO

-- Bảng GIẢNG VIÊN
CREATE TABLE GIANGVIEN (
    MaGV VARCHAR(20) PRIMARY KEY,
    Luong FLOAT,
	USER_ID VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES DOITUONG(USER_ID)
);
GO
--Bảng GIANGVIEN_BANGCAP
CREATE TABLE GIANGVIEN_BANGCAP (
    MaGV VARCHAR(20),
    BangCap NVARCHAR(255),
    PRIMARY KEY (MaGV, BangCap),
    FOREIGN KEY (MaGV) REFERENCES GIANGVIEN(MaGV)
);
GO
CREATE TABLE TIETHOC (
    MaTietHoc VARCHAR(20) PRIMARY KEY,
    ThoiGianBatDau DATETIME,
    ThoiGianKetThuc DATETIME,
    MaLopHoc VARCHAR(20) NOT NULL,                         
    MaSV VARCHAR(20),
    MaGV VARCHAR(20),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
    FOREIGN KEY (MaGV) REFERENCES GIANGVIEN(MaGV),
	FOREIGN KEY(MaLopHoc) REFERENCES LOPTINCHI(MaLop)
);
GO
--Bảng Hóa đơn điện tử
CREATE TABLE HOADON (
    LoaiHoaDon NVARCHAR(50),
    MaSV VARCHAR(20),
    SoTien FLOAT,
    GhiChu NTEXT,
    NgayThanhToan DATE,
    PRIMARY KEY (LoaiHoaDon, MaSV),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV)
);
GO
--Bảng Học Bổng
CREATE TABLE HOCBONG (
    MaSV VARCHAR(20),
    TenHocBong NVARCHAR(50),
    TienHocBong FLOAT,
    PRIMARY KEY (MaSV, TenHocBong),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV)
);
GO