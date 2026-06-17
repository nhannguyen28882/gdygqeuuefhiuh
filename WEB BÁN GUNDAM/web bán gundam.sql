USE master
GO

DROP DATABASE GundamShop
GO

CREATE DATABASE GundamShop
GO

USE GundamShop
GO

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    PasswordHash NVARCHAR(256),
    FullName NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(500),
    Role NVARCHAR(50) DEFAULT 'User',
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    ProductName NVARCHAR(200),
    Description NVARCHAR(1000),
    Price DECIMAL(18,2),
    ImageURL NVARCHAR(500),
    Stock INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE CartItems (
    CartItemID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(18,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(500),
    TotalAmount DECIMAL(18,2),
    Status NVARCHAR(50) DEFAULT 'Pending',
    OrderDate DATETIME DEFAULT GETDATE()
);

-- 6. BẢNG CHI TIẾT ĐƠN HÀNG (OrderDetails)
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(18,2)
);
GO

INSERT INTO Categories (CategoryName, Description) VALUES  
(N'MG', 'Master Grade Gundam tỷ lệ 1/100'), 
(N'RG', 'Real Grade tỷ lệ 1/144 siêu chi tiết'), 
(N'HG', 'High Grade tỷ lệ 1/144 phổ thông'),
(N'TRƯƠNG VÂN','Trương Vân series - Mecha phong cách Trung Hoa'), 
(N'MA LỄ THANH','Ma Lễ Thanh fantasy phong cách thần thoại'),
(N'AOBING','Nezha Reborn - Ngao Bính Long Thần'), 
(N'DAYTIME MAYTOR','Mecha Trung Quốc hiện đại hầm hố'),
(N'NATRA','Natra Ma Đồng Giáng Thế series'), 
(N'CÂN TƯƠNG','Cân Thương cặp song kiếm huyền thoại'), 
(N'LŨ BỐ','Tam Quốc Chí Mecha chiến thần'),
(N'YINGLONG','Ứng Long Hoàng Đế rồng thần'), 
(N'TIÊU ĐÀO TỬ','Tiêu Dao Tử phong cách tu tiên hiệp');
GO


INSERT INTO Products (CategoryID, ProductName, Description, Price, ImageURL, Stock) VALUES  

(1, N'MG Unicorn Gundam', 'Destroy Mode tích hợp khung xương phát quang full nháy LED', 2500000, 'unicorn.jpg', 10),
(1, N'MG Nu Gundam Ver.Ka', 'Phiên bản thiết kế của Hajime Katoki đi kèm hiệu ứng Funnel', 2800000, 'nu-gundam.jpg', 8),


(2, N'RG RX-93-v2 Hi-Nu Gundam', 'Mô hình tỷ lệ 1/144 biên độ chuyển động cực đỉnh, chi tiết sắc nét', 1250000, 'rg-hi-nu.jpg', 15),
(2, N'RG MSN-04 Sazabi', 'Quái vật tỷ lệ 1/144, kích thước đồ sộ, giáp ngoài mở rộng linh hoạt', 1150000, 'rg-sazabi.jpg', 9),
(2, N'RG GAT-X105B/FP Build Strike Exceed', 'Dòng Gundam Build Metaverse mới nhất, hệ khung xương tân tiến', 850000, 'rg-build-strike.jpg', 20),


(3, N'HGCE RX-105 Xi Gundam', 'Mô hình HG siêu to khổng lồ bước ra từ phần phim Hathaway Flash', 1450000, 'hg-xi-gundam.jpg', 7),
(3, N'HG Aerial Gundam', 'Nhân vật chính trong phần phim The Witch from Mercury, nhựa dạ quang độc đáo', 450000, 'hg-aerial.jpg', 30),
(3, N'HG Moon Gundam', 'Đỉnh cao của dòng HG với chi tiết tiệm cận RG, đi kèm cụm phao lưng độc lạ', 750000, 'hg-moon.jpg', 12),


(4, N'Trương Vân Sword Saint', 'Kiếm thánh phân khúc MG 1/100, trang bị full giáp trụ hoàng kim', 3200000, 'truong-van-sword.jpg', 12),
(4, N'Trương Vân Dual Blade', 'Phiên bản Song kiếm linh hoạt, phụ kiện hiệu ứng chém kích thước lớn', 3500000, 'truong-van-dual.jpg', 8),


(5, N'Ma Lễ Thanh Magic', 'Pháp sư tối cao đi kèm hiệu ứng LED quyền trượng thần thoại', 4200000, 'ma-le-thanh.jpg', 15),


(6, N'Aobing Dragon Spear', 'Nezha Reborn bộ chiến tướng thương rồng uốn lượn cực đẹp', 2900000, 'aobing.jpg', 20),


(7, N'Daytime Maytor Gunner', 'Cỗ máy hỏa lực hạng nặng trang bị hai đại pháo plasma', 4800000, 'daytime-maytor.jpg', 6),


(8, N'Natra Wind Blade', 'Chiến binh tốc độ điều khiển phong ba bão tố', 2200000, 'natra.jpg', 18),
(9, N'Cân Tương Halberd', 'Thần binh sở hữu cặp đại kích hạng nặng khổng lồ', 1800000, 'can-tuong.jpg', 25),
(10, N'Lữ Bố Fang Tian', 'Chiến thần sở hữu Phương thiên họa kích đỉnh cao Tam Quốc', 3400000, 'lu-bo.jpg', 11),
(11, N'Yinglong Emperor', 'Ứng long hoàng đế trang bị bộ phản lực cánh rồng full LED', 5800000, 'yinglong.jpg', 2),
(12, N'Tiêu Dao Tử Flying', 'Kiếm sĩ ngự kiếm phi hành mang đậm chất tiên hiệp Trung Hoa', 3900000, 'tieu-dao.jpg', 14);
GO


INSERT INTO Users (Username, Email, PasswordHash, FullName, Phone, Address, Role, IsActive) VALUES  
('customer1', 'customer@gmail.com', '123456', N'Nguyễn Văn A', '0123456789', N'Hà Nội, Việt Nam', 'User', 1),
('admin', 'admin@gundam.vn', 'admin123', N'Quản Trị Viên', '0987654321', N'TP. Hồ Chí Minh', 'Admin', 1);
GO

SELECT * FROM dbo.Users
SELECT * FROM dbo.Products