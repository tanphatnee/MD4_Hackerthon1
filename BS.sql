CREATE DATABASE QUANLYSINHVIEN;
USE QUANLYSINHVIEN;

-- Tạo bảng dmkhoa
CREATE TABLE dmkhoa (
    makhoa VARCHAR(20) PRIMARY KEY,
    tenkhoa VARCHAR(255)
);

-- Tạo bảng dmnganh
CREATE TABLE dmnganh (
    manganh INT PRIMARY KEY,
    tennganh VARCHAR(255),
    makhoa VARCHAR(20),
    FOREIGN KEY (makhoa) REFERENCES dmkhoa(makhoa)
);

-- Tạo bảng dmlop
CREATE TABLE dmlop (
    malop VARCHAR(20) PRIMARY KEY,
    tenlop VARCHAR(255),
    manganh INT,
    khoahoc INT,
    hedt VARCHAR(255),
    namnhaphoc INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);
-- Tạo bảng sinhvien
CREATE TABLE sinhvien (
    masv INT PRIMARY KEY,
    hoten VARCHAR(255),
    malop VARCHAR(20),
    gioitinh TINYINT(1),
    ngaysinh DATE,
    diachi VARCHAR(255),
    FOREIGN KEY (malop) REFERENCES dmlop(malop)
);

-- Tạo bảng dmhocphan
CREATE TABLE dmhocphan (
    mahp INT PRIMARY KEY,
    tenhp VARCHAR(255),
    sodvht INT,
    manganh INT,
    hocky INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);

-- Tạo bảng diemhp
CREATE TABLE diemhp (
    masv INT,
    mahp INT,
    diemhp FLOAT,
    foreign key(masv) references sinhvien(masv),
    FOREIGN KEY (mahp) REFERENCES dmhocphan(mahp)
);


-- THÊM DỮ LIỆU VÀO CÁC BẢNG 
-- Thêm dữ  liệu vào bảng dmkhoa
INSERT INTO dmkhoa (makhoa,tenkhoa) VALUES
 ('CNTT','CÔNG NGHỆ THÔNG TIN'),
 ('KT','KẾ TOÁN'),
 ('SP','SƯ PHẠM');
 
 -- Thêm dữ liệu vào bảng dmnganh
INSERT INTO dmnganh (manganh, tennganh, makhoa)
VALUES
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmlop
INSERT INTO dmlop (malop, tenlop, manganh, khoahoc, hedt, namnhaphoc)
VALUES
    ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
    ('CT12', 'cao đẳng tin học', 480202, 12, 'CĐ', 2013),
    ('CT13', 'cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng dmhocphan
INSERT INTO dmhocphan (mahp, tenhp, sodvht, manganh, hocky) VALUES
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

INSERT INTO SinhVien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES
(1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       (2, 'Nguyễn Thi Cấm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       (3, 'võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
       (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
       (5, 'Tran Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạch'),
       (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù mỹ'),
       (8, 'Nguyễn Van Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
       (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài  Nhơn');

-- Thêm dữ liệu vào bảng diemhp
INSERT INTO diemhp (masv, mahp, diemhp) VALUES
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);
-- Thực hiện các câu truy vấn
-- 1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, sv.malop AS MaLop, dh.diemhp AS DiemHP, dh.mahp AS MaHP
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
WHERE dh.diemhp >= 5;
-- 2. Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. 
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, sv.malop AS MaLop, dh.mahp AS MaHP, dh.diemhp AS DiemHP
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
ORDER BY sv.malop ASC, sv.hoten ASC;
-- 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. 
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, sv.malop AS MaLop, dh.diemhp AS DiemHP, hp.hocky AS HocKy
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
JOIN dmhocphan hp ON dh.mahp = hp.mahp
WHERE dh.diemhp BETWEEN 5 AND 7 AND hp.hocky = 1;
-- 4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT 
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, sv.malop AS MaLop, lp.tenlop AS TenLop, ng.makhoa AS MaKhoa
FROM sinhvien sv
JOIN dmlop lp ON sv.malop = lp.malop
JOIN dmnganh ng ON lp.manganh = ng.manganh
JOIN dmkhoa kh ON ng.makhoa = kh.makhoa
WHERE kh.makhoa = 'CNTT';
-- 5. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): 
SELECT dmlop.malop AS MaLop, dmlop.tenlop AS TenLop, COUNT(sinhvien.masv) AS SiSo
FROM dmlop
LEFT JOIN sinhvien ON dmlop.malop = sinhvien.malop
GROUP BY dmlop.malop, dmlop.tenlop;
-- 6. Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗
select HocKy,
 hp.MaSV,
 Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC 
 from diemhp hp 
 join dmhocphan dmhp
 on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV
order by hp.MaSV;
-- 7. Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
SELECT dmlop.malop AS MaLop, dmlop.tenlop AS TenLop,
       SUM(CASE WHEN sinhvien.gioitinh = 1 THEN 1 ELSE 0 END) AS SoLuongNam,
       SUM(CASE WHEN sinhvien.gioitinh = 0 THEN 1 ELSE 0 END) AS SoLuongNu
FROM dmlop
LEFT JOIN sinhvien ON dmlop.malop = sinhvien.malop
GROUP BY dmlop.malop, dmlop.tenlop;
-- 8. Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
select  hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV;
-- 9. Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, COUNT(*) AS SoLuongHocPhanThieuDiem
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
WHERE dh.diemhp < 5
GROUP BY sv.masv, sv.hoten;
-- 10. Đếm số sinh viên có điểm HP <5 của mỗi học phần
SELECT dh.mahp AS MaHP, COUNT(*) AS SL_SV_Thieu
FROM dmhocphan hp
JOIN diemhp dh ON hp.mahp = dh.mahp
WHERE dh.diemhp < 5
GROUP BY dh.mahp, hp.tenhp;
-- 11. Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
SELECT sv.masv AS MaSV, sv.hoten AS HoTen, SUM(hp.sodvht) AS Tongdvht
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
JOIN dmhocphan hp ON dh.mahp = hp.mahp
WHERE dh.diemhp < 5
GROUP BY sv.masv, sv.hoten;
--  12. Cho biết MaLop, TenLop có tổng số sinh viên >2.
SELECT dmlop.malop AS MaLop, dmlop.tenlop AS TenLop, COUNT(sinhvien.masv) AS Siso
FROM dmlop
LEFT JOIN sinhvien ON dmlop.malop = sinhvien.malop
GROUP BY dmlop.malop, dmlop.tenlop
HAVING COUNT(sinhvien.masv) > 2;
-- 13. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. 
SELECT sv.masv, sv.hoten AS HoTen, COUNT(dh.mahp) AS SoLuong
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
WHERE dh.diemhp < 5
GROUP BY sv.masv, sv.hoten
HAVING COUNT(dh.mahp) >= 2;
-- 14. Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 
SELECT sv.hoten AS HoTen, COUNT(DISTINCT dh.mahp) AS SoLuong
FROM sinhvien sv
JOIN diemhp dh ON sv.masv = dh.masv
WHERE dh.mahp IN (1, 2, 3)
GROUP BY sv.masv, sv.hoten
HAVING COUNT(DISTINCT dh.mahp) >= 3;




 

